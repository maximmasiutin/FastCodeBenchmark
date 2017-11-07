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
  private
    procedure SortRichEdit1;
    procedure SortRichEditFP;
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
    function ValidateExtended5 : Boolean;
    function ValidateExtended6 : Boolean;
    function ValidateDouble1 : Boolean;
    function ValidateDouble2 : Boolean;
    function ValidateDouble3 : Boolean;
    function ValidateDouble4 : Boolean;
    function ValidateDouble5 : Boolean;
    function ValidateDouble6 : Boolean;
    function ValidateSingle1 : Boolean;
    function ValidateSingle2 : Boolean;
    function ValidateSingle3 : Boolean;
    function ValidateSingle4 : Boolean;
    function ValidateSingle5 : Boolean;
    function ValidateSingle6 : Boolean;
    function ValidateSingle7 : Boolean;    
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, Trunc32JOHUnit, Trunc32DKCUnit, Trunc32DFLUnit;

const
 NOOFLOOPS : Cardinal = 1;
 BENCHRANGESTART : Single = 1E-35;
 BENCHRANGEEND : Single = MAXINT;
 BENCHXSTEPSIZE : Single = 1.000003;
 SCALE : Double = 30;
 VALIDATEEXTENDED1STEPSIZE : Extended = 1.00001;
 VALIDATEEXTENDED6STEPSIZE : Extended = 1.0001;
 VALIDATEDOUBLE1STEPSIZE : Double = 1.00001;
 VALIDATEDOUBLE7STEPSIZE : Double = 1.0001;
 VALIDATESINGLE1STEPSIZE : Single = 1.00001;
 VALIDATESINGLE7STEPSIZE : Single = 1.0001;

type
 TTrunc32SingleFunction = function (const X : Single) : Integer;
 TTrunc32DoubleFunction = function (const X : Double) : Integer;
 TTrunc32ExtendedFunction = function (const X : Extended) : Integer;

var
 Trunc32SingleFunction : TTrunc32SingleFunction;
 Trunc32DoubleFunction : TTrunc32DoubleFunction;
 Trunc32ExtendedFunction : TTrunc32ExtendedFunction;
 X1e, X2e, X3e, X4e, X5e, X6e, X7e : Extended;
 X1d, X2d, X3d, X4d, X5d, X6d, X7d : Double;
 X1s, X2s, X3s, X4s, X5s, X6s, X7s : Single;
//Finds a character in a sourcestring as pos does
//but can find occurence 1,2,...n of the character
//Returns 0 if character is not found

function CharPosEY(SourceString : AnsiString; SearchCharacter : Char; Occurrence : Cardinal) : Integer;
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
    if Index >= SourceStringSize then
     begin
      Result := -1;
      Finished := True;
     end;
   end;
  Inc(Index);
 until(Finished);
end;

procedure TMainForm.DevelopButtonClick(Sender: TObject);
var
 X : Extended;
 I : Integer;

begin
 X := StrToFloat(XEdit.Text);
 I := Trunc32ExtendedFunction(X);
 IEdit.Text := IntToStr(I);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 Set8087PrecisionRadioGroupClick(nil);
 SetRoundModeRadioGroupClick(nil);
 Trunc32ExtendedFunction := Trunc32ExtendedDKC1;
 Trunc32DoubleFunction := Trunc32DoubleDKC1;
 Trunc32SingleFunction := Trunc32SingleDKC1;
 XEdit.Text := FloatToStr(65541 + 5/7);
 IEdit.Text := '';
 ErrorEdit.Text := '';
 BenchEdit.Text := '';
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 120;
 ReportRichEdit.Paragraph.Tab[1] := 170;
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

procedure TMainForm.SortRichEdit1;
var
 I2, I3, LineNo, X1, X2, Col2Start1, Col3Start1, Col2Start2, Col3Start2,
 Col2Size1, Col2Size2 : Integer;
 S1, S2, Bench1String, Bench2String, Precision1String, Precision2String : AnsiString;
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
      Col2Start1 := CharPosEY(S1, #9, 1);
      Col3Start1 := CharPosEY(S1, #9, 2);
      Col2Start2 := CharPosEY(S2, #9, 1);
      Col3Start2 := CharPosEY(S2, #9, 2);
      Col2Size1 := Col3Start1 - Col2Start1 - 1;
      Col2Size2 := Col3Start2 - Col2Start2 - 1;
      Precision1String := Copy(S1, Col2Start1+1, Col2Size1);
      Precision2String := Copy(S2, Col2Start2+1, Col2Size2);
      if Precision1String = Precision2String then
       begin
        Swapped := True;
        ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
       end;
     end;
   end;
 until(not Swapped);
end;

procedure TMainForm.SortRichEditFP;
var
 LineNo, Col2Start1, Col3Start1, Col2Start2, Col3Start2, Col2Size1, Col2Size2 : Integer;
 S1, S2, Precision1String, Precision2String : AnsiString;
 Swapped : Boolean;

begin
 repeat
  Swapped := False;
  for LineNo := 0 to ReportRichEdit.Lines.Count-2 do
   begin
    S1 := ReportRichEdit.Lines[LineNo];
    S2 := ReportRichEdit.Lines[LineNo+1];
    Col2Start1 := CharPosEY(S1, #9, 1);
    Col3Start1 := CharPosEY(S1, #9, 2);
    Col2Start2 := CharPosEY(S2, #9, 1);
    Col3Start2 := CharPosEY(S2, #9, 2);
    Col2Size1 := Col3Start1 - Col2Start1 - 1;
    Col2Size2 := Col3Start2 - Col2Start2 - 1;
    Precision1String := Copy(S1, Col2Start1+1, Col2Size1);
    Precision2String := Copy(S2, Col2Start2+1, Col2Size2);
    if ((Precision1String = 'Single') and (Precision2String = 'Extended')) then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
    if ((Precision1String = 'Double') and (Precision2String = 'Extended')) then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
    if ((Precision1String = 'Single') and (Precision2String = 'Double')) then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
    if (Precision1String = 'Failed') and (Precision2String <> 'Failed')then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

procedure TMainForm.BenchmarkExtendedButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 try
  FunctionName := FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex];
  Bench := BenchmarkExtended;
  BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '999')
 end;
end;

function TMainForm.BenchmarkRTLExtended : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X1e := BENCHRANGESTART;
 X2e := BENCHRANGESTART;
 X3e := BENCHRANGESTART;
 X4e := BENCHRANGESTART;
 X5e := BENCHRANGESTART;
 X6e := BENCHRANGESTART;
 X7e := BENCHRANGESTART;
 StartTime := Time;
 while X1e < BENCHRANGEEND do
  begin
   I1 := Trunc(X1e);
   I2 := Trunc(-X1e);
   X1e := X1e * BENCHXSTEPSIZE;
  end;
 while X2e < BENCHRANGEEND do
  begin
   I1 := Trunc(X2e);
   I2 := Trunc(-X2e);
   X2e := X2e * BENCHXSTEPSIZE;
  end;
 while X3e < BENCHRANGEEND do
  begin
   I1 := Trunc(X3e);
   I2 := Trunc(-X3e);
   X3e := X3e * BENCHXSTEPSIZE;
  end;
 while X4e < BENCHRANGEEND do
  begin
   I1 := Trunc(X4e);
   I2 := Trunc(-X4e);
   X4e := X4e * BENCHXSTEPSIZE;
  end;
 while X5e < BENCHRANGEEND do
  begin
   I1 := Trunc(X5e);
   I2 := Trunc(-X5e);
   X5e := X5e * BENCHXSTEPSIZE;
  end;
 while X6e < BENCHRANGEEND do
  begin
   I1 := Trunc(X6e);
   I2 := Trunc(-X6e);
   X6e := X6e * BENCHXSTEPSIZE;
  end;
 while X7e < BENCHRANGEEND do
  begin
   I1 := Trunc(X7e);
   I2 := Trunc(-X7e);
   X7e := X7e * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkExtended : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X1e := BENCHRANGESTART;
 X2e := BENCHRANGESTART;
 X3e := BENCHRANGESTART;
 X4e := BENCHRANGESTART;
 X5e := BENCHRANGESTART;
 X6e := BENCHRANGESTART;
 X7e := BENCHRANGESTART;
 StartTime := Time;
 while X1e < BENCHRANGEEND do
  begin
   I1 := Trunc32ExtendedFunction(X1e);
   I2 := Trunc32ExtendedFunction(-X1e);
   X1e := X1e * BENCHXSTEPSIZE;
  end;
 while X2e < BENCHRANGEEND do
  begin
   I1 := Trunc32ExtendedFunction(X2e);
   I2 := Trunc32ExtendedFunction(-X2e);
   X2e := X2e * BENCHXSTEPSIZE;
  end;
 while X3e < BENCHRANGEEND do
  begin
   I1 := Trunc32ExtendedFunction(X3e);
   I2 := Trunc32ExtendedFunction(-X3e);
   X3e := X3e * BENCHXSTEPSIZE;
  end;
 while X4e < BENCHRANGEEND do
  begin
   I1 := Trunc32ExtendedFunction(X4e);
   I2 := Trunc32ExtendedFunction(-X4e);
   X4e := X4e * BENCHXSTEPSIZE;
  end;
 while X5e < BENCHRANGEEND do
  begin
   I1 := Trunc32ExtendedFunction(X5e);
   I2 := Trunc32ExtendedFunction(-X5e);
   X5e := X5e * BENCHXSTEPSIZE;
  end;
 while X6e < BENCHRANGEEND do
  begin
   I1 := Trunc32ExtendedFunction(X6e);
   I2 := Trunc32ExtendedFunction(-X6e);
   X6e := X6e * BENCHXSTEPSIZE;
  end;
 while X7e < BENCHRANGEEND do
  begin
   I1 := Trunc32ExtendedFunction(X7e);
   I2 := Trunc32ExtendedFunction(-X7e);
   X7e := X7e * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkDouble : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X1d := BENCHRANGESTART;
 X2d := BENCHRANGESTART;
 X3d := BENCHRANGESTART;
 X4d := BENCHRANGESTART;
 X5d := BENCHRANGESTART;
 X6d := BENCHRANGESTART;
 X7d := BENCHRANGESTART;
 StartTime := Time;
 while X1d < BENCHRANGEEND do
  begin
   I1 := Trunc32DoubleFunction(X1d);
   I2 := Trunc32DoubleFunction(-X1d);
   X1d := X1d * BENCHXSTEPSIZE;
  end;
 while X2d < BENCHRANGEEND do
  begin
   I1 := Trunc32DoubleFunction(X2d);
   I2 := Trunc32DoubleFunction(-X2d);
   X2d := X2d * BENCHXSTEPSIZE;
  end;
 while X3d < BENCHRANGEEND do
  begin
   I1 := Trunc32DoubleFunction(X3d);
   I2 := Trunc32DoubleFunction(-X3d);
   X3d := X3d * BENCHXSTEPSIZE;
  end;
 while X4d < BENCHRANGEEND do
  begin
   I1 := Trunc32DoubleFunction(X4d);
   I2 := Trunc32DoubleFunction(-X4d);
   X4d := X4d * BENCHXSTEPSIZE;
  end;
 while X5d < BENCHRANGEEND do
  begin
   I1 := Trunc32DoubleFunction(X5d);
   I2 := Trunc32DoubleFunction(-X5d);
   X5d := X5d * BENCHXSTEPSIZE;
  end;
 while X6d < BENCHRANGEEND do
  begin
   I1 := Trunc32DoubleFunction(X6d);
   I2 := Trunc32DoubleFunction(-X6d);
   X6d := X6d * BENCHXSTEPSIZE;
  end;
 while X7d < BENCHRANGEEND do
  begin
   I1 := Trunc32DoubleFunction(X7d);
   I2 := Trunc32DoubleFunction(-X7d);
   X7d := X7d * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkRTLDouble : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X1d := BENCHRANGESTART;
 X2d := BENCHRANGESTART;
 X3d := BENCHRANGESTART;
 X4d := BENCHRANGESTART;
 X5d := BENCHRANGESTART;
 X6d := BENCHRANGESTART;
 X7d := BENCHRANGESTART;
 StartTime := Time;
 while X1d < BENCHRANGEEND do
  begin
   I1 := Trunc(X1d);
   I2 := Trunc(-X1d);
   X1d := X1d * BENCHXSTEPSIZE;
  end;
 while X2d < BENCHRANGEEND do
  begin
   I1 := Trunc(X2d);
   I2 := Trunc(-X2d);
   X2d := X2d * BENCHXSTEPSIZE;
  end;
 while X3d < BENCHRANGEEND do
  begin
   I1 := Trunc(X3d);
   I2 := Trunc(-X3d);
   X3d := X3d * BENCHXSTEPSIZE;
  end;
 while X4d < BENCHRANGEEND do
  begin
   I1 := Trunc(X4d);
   I2 := Trunc(-X4d);
   X4d := X4d * BENCHXSTEPSIZE;
  end;
 while X5d < BENCHRANGEEND do
  begin
   I1 := Trunc(X5d);
   I2 := Trunc(-X5d);
   X5d := X5d * BENCHXSTEPSIZE;
  end;
 while X6d < BENCHRANGEEND do
  begin
   I1 := Trunc(X6d);
   I2 := Trunc(-X6d);
   X6d := X6d * BENCHXSTEPSIZE;
  end;
 while X7d < BENCHRANGEEND do
  begin
   I1 := Trunc(X7d);
   I2 := Trunc(-X7d);
   X7d := X7d * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkSingle : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X1s := BENCHRANGESTART;
 X2s := BENCHRANGESTART;
 X3s := BENCHRANGESTART;
 X4s := BENCHRANGESTART;
 X5s := BENCHRANGESTART;
 X6s := BENCHRANGESTART;
 X7s := BENCHRANGESTART;
 StartTime := Time;
 while X1s < BENCHRANGEEND do
  begin
   I1 := Trunc32SingleFunction(X1s);
   I2 := Trunc32SingleFunction(-X1s);
   X1s := X1s * BENCHXSTEPSIZE;
  end;
 while X2s < BENCHRANGEEND do
  begin
   I1 := Trunc32SingleFunction(X2s);
   I2 := Trunc32SingleFunction(-X2s);
   X2s := X2s * BENCHXSTEPSIZE;
  end;
 while X3s < BENCHRANGEEND do
  begin
   I1 := Trunc32SingleFunction(X3s);
   I2 := Trunc32SingleFunction(-X3s);
   X3s := X3s * BENCHXSTEPSIZE;
  end;
 while X4s < BENCHRANGEEND do
  begin
   I1 := Trunc32SingleFunction(X4s);
   I2 := Trunc32SingleFunction(-X4s);
   X4s := X4s * BENCHXSTEPSIZE;
  end;
 while X5s < BENCHRANGEEND do
  begin
   I1 := Trunc32SingleFunction(X5s);
   I2 := Trunc32SingleFunction(-X5s);
   X5s := X5s * BENCHXSTEPSIZE;
  end;
 while X6s < BENCHRANGEEND do
  begin
   I1 := Trunc32SingleFunction(X6s);
   I2 := Trunc32SingleFunction(-X6s);
   X6s := X6s * BENCHXSTEPSIZE;
  end;
 while X7s < BENCHRANGEEND do
  begin
   I1 := Trunc32SingleFunction(X7s);
   I2 := Trunc32SingleFunction(-X7s);
   X7s := X7s * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1);
 IEdit.Text := IntToStr(I2);
end;

function TMainForm.BenchmarkRTLSingle : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X1s := BENCHRANGESTART;
 X2s := BENCHRANGESTART;
 X3s := BENCHRANGESTART;
 X4s := BENCHRANGESTART;
 X5s := BENCHRANGESTART;
 X6s := BENCHRANGESTART;
 X7s := BENCHRANGESTART;
 StartTime := Time;
 while X1s < BENCHRANGEEND do
  begin
   I1 := Trunc(X1s);
   I2 := Trunc(-X1s);
   X1s := X1s * BENCHXSTEPSIZE;
  end;
 while X2s < BENCHRANGEEND do
  begin
   I1 := Trunc(X2s);
   I2 := Trunc(-X2s);
   X2s := X2s * BENCHXSTEPSIZE;
  end;
 while X3s < BENCHRANGEEND do
  begin
   I1 := Trunc(X3s);
   I2 := Trunc(-X3s);
   X3s := X3s * BENCHXSTEPSIZE;
  end;
 while X4s < BENCHRANGEEND do
  begin
   I1 := Trunc(X4s);
   I2 := Trunc(-X4s);
   X4s := X4s * BENCHXSTEPSIZE;
  end;
 while X5s < BENCHRANGEEND do
  begin
   I1 := Trunc(X5s);
   I2 := Trunc(-X5s);
   X5s := X5s * BENCHXSTEPSIZE;
  end;
 while X6s < BENCHRANGEEND do
  begin
   I1 := Trunc(X6s);
   I2 := Trunc(-X6s);
   X6s := X6s * BENCHXSTEPSIZE;
  end;
 while X7s < BENCHRANGEEND do
  begin
   I1 := Trunc(X7s);
   I2 := Trunc(-X7s);
   X7s := X7s * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1);
 IEdit.Text := IntToStr(I2);
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
   I1 := Trunc(X);
   I2 := Trunc32ExtendedFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Trunc(-X);
   I2 := Trunc32ExtendedFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X * VALIDATEEXTENDED1STEPSIZE;
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
   I1 := Trunc(X);
   I2 := Trunc32ExtendedFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Trunc(-X);
   I2 := Trunc32ExtendedFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 100;
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
  I := Trunc32ExtendedFunction(X);
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
  I := Trunc32ExtendedFunction(X);
  IEdit.Text := IntToStr(I);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateExtended5 : Boolean;
var
 X : Extended;
 I : Integer;
 J1, J2 : Cardinal;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;

begin
 Result := True;
 PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
 RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
 for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
  begin
   Set8087PrecisionRadioGroup.ItemIndex := J1;
   for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
    begin
     SetRoundModeRadioGroup.ItemIndex := J2;
     Sleep(400);
     Update;
     X := 1;
     ControlWordBefore := Get8087CW;
     I := Trunc32ExtendedFunction(X);
     ControlWordAfter := Get8087CW;
     if ControlWordBefore <> ControlWordAfter then
      begin
       Result := False;
       Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
       SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
       Exit;
      end;
    end;
  end;
 Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
 SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
end;

function TMainForm.ValidateExtended6 : Boolean;
var
 X : Extended;
 I1, I2 : Integer;
 J1, J2 : Cardinal;
 PrecisionIndex, RoundModeIndex : Integer;

begin
 Result := True;
 PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
 RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
 for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
  begin
   Set8087PrecisionRadioGroup.ItemIndex := J1;
   for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
    begin
     SetRoundModeRadioGroup.ItemIndex := J2;
     Sleep(400);
     Update;
     X := 1E-64;
     Result := True;
     while X < MAXINT do
      begin
       I1 := Trunc(X);
       I2 := Trunc32ExtendedFunction(X);
       if I1 <> I2 then
        begin
         Result := False;
         Exit;
        end;
       I1 := Trunc(-X);
       I2 := Trunc32ExtendedFunction(-X);
       if I1 <> I2 then
        begin
         Result := False;
         Exit;
        end;
       X := X * VALIDATEEXTENDED6STEPSIZE;
      end;
    end;
  end;
 Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
 SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
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
   I1 := Trunc(X);
   I2 := Trunc32DoubleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Trunc(-X);
   I2 := Trunc32DoubleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X * VALIDATEDOUBLE1STEPSIZE;
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
   I1 := Trunc(X);
   I2 := Trunc32DoubleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Trunc(-X);
   I2 := Trunc32DoubleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 100;
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
  I := Trunc32DoubleFunction(X);
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
  I := Trunc32DoubleFunction(X);
  IEdit.Text := IntToStr(I);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateDouble5 : Boolean;
var
 X : Double;
 I : Integer;
 J1, J2 : Cardinal;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;

begin
 Result := True;
 PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
 RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
 for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
  begin
   Set8087PrecisionRadioGroup.ItemIndex := J1;
   for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
    begin
     SetRoundModeRadioGroup.ItemIndex := J2;
     Sleep(400);
     Update;
     X := 1;
     ControlWordBefore := Get8087CW;
     I := Trunc32DoubleFunction(X);
     ControlWordAfter := Get8087CW;
     if ControlWordBefore <> ControlWordAfter then
      begin
       Result := False;
       Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
       SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
       Exit;
      end;
    end;
  end;
 Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
 SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
end;

function TMainForm.ValidateDouble6 : Boolean;
var
 X : Double;
 I1, I2 : Integer;
 J1, J2 : Cardinal;
 PrecisionIndex, RoundModeIndex : Integer;

begin
 Result := True;
 PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
 RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
 for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
  begin
   Set8087PrecisionRadioGroup.ItemIndex := J1;
   for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
    begin
     SetRoundModeRadioGroup.ItemIndex := J2;
     Sleep(400);
     Update;
     X := 1E-64;
     Result := True;
     while X < MAXINT do
      begin
       I1 := Trunc(X);
       I2 := Trunc32DoubleFunction(X);
       if I1 <> I2 then
        begin
         Result := False;
         Exit;
        end;
       I1 := Trunc(-X);
       I2 := Trunc32DoubleFunction(-X);
       if I1 <> I2 then
        begin
         Result := False;
         Exit;
        end;
       X := X * VALIDATEDOUBLE7STEPSIZE;
      end;
    end;
  end;
 Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
 SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
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
   I1 := Trunc(X);
   I2 := Trunc32SingleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Trunc(-X);
   I2 := Trunc32SingleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X * VALIDATESINGLE1STEPSIZE;
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
   I1 := Trunc(X);
   I2 := Trunc32SingleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Trunc(-X);
   I2 := Trunc32SingleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 100;
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
   I1 := Trunc(X);
   I2 := Trunc32SingleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Trunc(-X);
   I2 := Trunc32SingleFunction(-X);
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
  I := Trunc32SingleFunction(X);
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
  I := Trunc32SingleFunction(X);
  IEdit.Text := IntToStr(I);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateSingle6 : Boolean;
var
 X : Single;
 I : Integer;
 J1, J2 : Cardinal;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;

begin
 Result := True;
 PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
 RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
 for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
  begin
   Set8087PrecisionRadioGroup.ItemIndex := J1;
   for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
    begin
     SetRoundModeRadioGroup.ItemIndex := J2;
     Sleep(400);
     Update;
     X := 1;
     ControlWordBefore := Get8087CW;
     I := Trunc32SingleFunction(X);
     ControlWordAfter := Get8087CW;
     if ControlWordBefore <> ControlWordAfter then
      begin
       Result := False;
       Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
       SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
       Exit;
      end;
    end;
  end;
 Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
 SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
end;

function TMainForm.ValidateSingle7 : Boolean;
var
 X : Single;
 I1, I2 : Integer;
 J1, J2 : Cardinal;
 PrecisionIndex, RoundModeIndex : Integer;

begin
 Result := True;
 PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
 RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
 for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
  begin
   Set8087PrecisionRadioGroup.ItemIndex := J1;
   for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
    begin
     SetRoundModeRadioGroup.ItemIndex := J2;
     Sleep(400);
     Update;
     X := 1E-40;
     Result := True;
     while X < MAXINT do
      begin
       I1 := Trunc(X);
       I2 := Trunc32SingleFunction(X);
       if I1 <> I2 then
        begin
         Result := False;
         Exit;
        end;
       I1 := Trunc(-X);
       I2 := Trunc32SingleFunction(-X);
       if I1 <> I2 then
        begin
         Result := False;
         Exit;
        end;
       X := X * VALIDATESINGLE7STEPSIZE;
      end;
    end;
  end;
 Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
 SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
end;

procedure TMainForm.ValidateExtendedButtonClick(Sender: TObject);
begin
 try
  if ValidateExtended1 and
     ValidateExtended2 and
     ValidateExtended3 and
     ValidateExtended4 and
     ValidateExtended5 and
     ValidateExtended6 then
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
  1 : Trunc32ExtendedFunction := Trunc32ExtendedDKC1;
  2 : Trunc32ExtendedFunction := Trunc32ExtendedJOH;
  3 : Trunc32ExtendedFunction := Trunc32ExtendedDFLSSE3_1;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog1.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog1.FileName := 'Trunc32BenchReport.Txt';
 if SaveDialog1.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('Trunc Report');
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
       ValidateExtended4 and
       ValidateExtended5 and
       ValidateExtended6 then
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
       ValidateDouble4 and
       ValidateDouble5 and
       ValidateDouble6 then
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
       ValidateSingle5 and
       ValidateSingle6 and
       ValidateSingle7 then
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
  1 : Trunc32SingleFunction := Trunc32SingleDKC1;
  2 : Trunc32SingleFunction := Trunc32SingleJOH;
  3 : Trunc32SingleFunction := Trunc32SingleDKCSSE_2;
  4 : Trunc32SingleFunction := Trunc32SingleDFL1SSE3;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.FunctionDoubleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionDoubleSelectionRadioGroup.ItemIndex+1 of
  1 : Trunc32DoubleFunction := Trunc32DoubleDKC1;
  2 : Trunc32DoubleFunction := Trunc32DoubleJOH;
  3 : Trunc32DoubleFunction := Trunc32DoubleDKCSSE2_2;
  4 : Trunc32DoubleFunction := Trunc32DoubleDFLSSE3;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.BenchmarkDoubleButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 try
  FunctionName := FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex];
  Bench := BenchmarkDouble;
  BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '999')
 end;
end;

procedure TMainForm.BenchmarkSingleButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 try
  FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
  Bench := BenchmarkSingle;
  BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '999')
 end;
end;

procedure TMainForm.ValidateDoubleButtonClick(Sender: TObject);
begin
 try
  if ValidateDouble1 and
     ValidateDouble2 and
     ValidateDouble3 and
     ValidateDouble4 and
     ValidateDouble5 and
     ValidateDouble6 then
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
     ValidateSingle5 and
     ValidateSingle6 and
     ValidateSingle7 then
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
 FunctionName := 'TruncExtendedRTL';
 Bench := BenchmarkRTLExtended;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

procedure TMainForm.BenchDoubleRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'TruncDoubleRTL';
 Bench := BenchmarkRTLDouble;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

procedure TMainForm.BenchSingleRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'TruncSingleRTL';
 Bench := BenchmarkRTLSingle;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;
 FunctionName : AnsiString;
 Bench : Double;

begin
 BenchmarkAllButton.Caption := 'Running';
 BenchExtendedRTLButtonClick(nil);
 Update;
 BenchDoubleRTLButtonClick(nil);
 Update;
 BenchSingleRTLButtonClick(nil);
 Update;
 for I1 := 0 to FunctionExtendedSelectionRadioGroup.Items.Count-1 do
  begin
   try
    FunctionExtendedSelectionRadioGroup.ItemIndex := I1;
    FunctionName := FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex];
    Bench := BenchmarkExtended;
    BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
    SortRichEditFP;
    SortRichEdit1;
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '999');
    Update;
   end;
  end;
 for I2 := 0 to FunctionDoubleSelectionRadioGroup.Items.Count-1 do
  begin
   try
    FunctionDoubleSelectionRadioGroup.ItemIndex := I2;
    FunctionName := FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex];
    Bench := BenchmarkDouble;
    BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
    SortRichEditFP;
    SortRichEdit1;
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '999');
    Update;
   end;
  end;
 for I3 := 0 to FunctionSingleSelectionRadioGroup.Items.Count-1 do
  begin
   try
    FunctionSingleSelectionRadioGroup.ItemIndex := I3;
    FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
    Bench := BenchmarkSingle;
    BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
    SortRichEditFP;
    SortRichEdit1;
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '999');
    Update;
   end;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

end.
