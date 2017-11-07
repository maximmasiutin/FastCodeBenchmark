unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TMainForm = class(TForm)
    FunctionExtendedSelectionRadioGroup: TRadioGroup;
    ReportRichEdit: TRichEdit;
    Set8087PrecisionRadioGroup: TRadioGroup;
    SetRoundModeRadioGroup: TRadioGroup;
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
    ClearButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    XEdit: TEdit;
    IEdit: TEdit;
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
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
  private
    function BenchmarkExtended : Double;
    function BenchmarkDouble : Double;
    function BenchmarkSingle : Double;
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
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, CeilDKCUnit, CeilJOHUnit, Ceil_JOH, CeilRefUnit;

const
 NOOFLOOPS : Cardinal = 1;
 BENCHRANGESTART : Single = 1E-5;
 BENCHRANGEEND : Single = $7FFFFFFFFFFFFFFF;    //MaxInt64;
 BENCHXSTEPSIZE : Single = 1.000005;
 SCALE : Double = 100;

type
 TCeil64SingleFunction = function (const X : Single) : Int64;
 TCeil64DoubleFunction = function (const X : Double) : Int64;
 TCeil64ExtendedFunction = function (const X : Extended) : Int64;

 TCeil64ExtendedTestSet = record
  Input : Extended;
  CorrectResult : Int64;
 end;

 TCeil64DoubleTestSet = record
  Input : Double;
  CorrectResult : Int64;
 end;

 TCeil64SingleTestSet = record
  Input : Single;
  CorrectResult : Int64;
 end;

var
 Ceil64SingleFunction : TCeil64SingleFunction;
 Ceil64DoubleFunction : TCeil64DoubleFunction;
 Ceil64ExtendedFunction : TCeil64ExtendedFunction;
 ExtendedTestSetArray : array of TCeil64ExtendedTestSet;
 DoubleTestSetArray : array of TCeil64DoubleTestSet;
 SingleTestSetArray : array of TCeil64SingleTestSet;

procedure InitExtendedTestSetArray;
begin
 SetLength(ExtendedTestSetArray, 5);
 ExtendedTestSetArray[0].Input := 0;
 ExtendedTestSetArray[0].CorrectResult := 0;
 ExtendedTestSetArray[1].Input := 0.1;
 ExtendedTestSetArray[1].CorrectResult := 1;
 ExtendedTestSetArray[2].Input := 1;
 ExtendedTestSetArray[2].CorrectResult := 1;
 ExtendedTestSetArray[3].Input := 100.00001;
 ExtendedTestSetArray[3].CorrectResult := 101;
 ExtendedTestSetArray[4].Input := -100.00001;
 ExtendedTestSetArray[4].CorrectResult := -100;
end;

procedure InitDoubleTestSetArray;
begin
 SetLength(DoubleTestSetArray, 5);
 DoubleTestSetArray[0].Input := 0;
 DoubleTestSetArray[0].CorrectResult := 0;
 DoubleTestSetArray[1].Input := 0.1;
 DoubleTestSetArray[1].CorrectResult := 1;
 DoubleTestSetArray[2].Input := 1;
 DoubleTestSetArray[2].CorrectResult := 1;
 DoubleTestSetArray[3].Input := 100.00001;
 DoubleTestSetArray[3].CorrectResult := 101;
 DoubleTestSetArray[4].Input := -100.00001;
 DoubleTestSetArray[4].CorrectResult := -100;
end;

procedure InitSingleTestSetArray;
begin
 SetLength(SingleTestSetArray, 5);
 SingleTestSetArray[0].Input := 0;
 SingleTestSetArray[0].CorrectResult := 0;
 SingleTestSetArray[1].Input := 0.1;
 SingleTestSetArray[1].CorrectResult := 1;
 SingleTestSetArray[2].Input := 1;
 SingleTestSetArray[2].CorrectResult := 1;
 SingleTestSetArray[3].Input := 100.00001;
 SingleTestSetArray[3].CorrectResult := 101;
 SingleTestSetArray[4].Input := -100.00001;
 SingleTestSetArray[4].CorrectResult := -100;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 Set8087PrecisionRadioGroupClick(nil);
 SetRoundModeRadioGroupClick(nil);
 XEdit.Text := FloatToStr(65541 + 5/7);
 IEdit.Text := '';
 ErrorEdit.Text := '';
 BenchEdit.Text := '';
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 1;
 ReportRichEdit.Paragraph.Tab[0] := 130;
 InitExtendedTestSetArray;
 InitDoubleTestSetArray;
 InitSingleTestSetArray;
 FunctionExtendedSelectionRadioGroupClick(nil);
 FunctionDoubleSelectionRadioGroupClick(nil);
 FunctionSingleSelectionRadioGroupClick(nil);
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
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

function TMainForm.BenchmarkExtended : Double;
var
 X : Extended;
 I1, I2 : Int64;
 StartTime, EndTime, RunTime : TDateTime;

begin
 try
  I1 := 1; //To satisfy compiler
  I2 := 2; //To satisfy compiler
  X := BENCHRANGESTART;
  StartTime := Time;
  while X < BENCHRANGEEND do
   begin
    I1 := Ceil64ExtendedFunction(X);
    I2 := Ceil64ExtendedFunction(-X);
    X := X * BENCHXSTEPSIZE;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  Result := SCALE * RunTime *24*60*60;
  IEdit.Text := IntToStr(I1 div I2);
 except
  Result := 9999;
 end;
end;

function TMainForm.BenchmarkDouble : Double;
var
 X : Double;
 I1, I2 : Int64;
 StartTime, EndTime, RunTime : TDateTime;

begin
 try
  I1 := 1; //To satisfy compiler
  I2 := 2; //To satisfy compiler
  X := BENCHRANGESTART;
  StartTime := Time;
  while X < BENCHRANGEEND do
   begin
    I1 := Ceil64DoubleFunction(X);
    I2 := Ceil64DoubleFunction(-X);
    X := X * BENCHXSTEPSIZE;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  Result := SCALE * RunTime *24*60*60;
  IEdit.Text := IntToStr(I1 div I2);
 except
  Result := 9999;
 end;
end;

function TMainForm.BenchmarkSingle : Double;
var
 X : Single;
 I1, I2 : Int64;
 StartTime, EndTime, RunTime : TDateTime;

begin
 try
  I1 := 1; //To satisfy compiler
  I2 := 2; //To satisfy compiler
  X := BENCHRANGESTART;
  StartTime := Time;
  while X < BENCHRANGEEND do
   begin
    I1 := Ceil64SingleFunction(X);
    I2 := Ceil64SingleFunction(-X);
    X := X * BENCHXSTEPSIZE;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  Result := SCALE * RunTime *24*60*60;
  IEdit.Text := IntToStr(I1 div I2);
 except
  Result := 9999;
 end;
end;

//*****************************************************************************
//Validation Functions
//*****************************************************************************

//Validates against the RTL Ceil which returns an Integer.
//Validates the ranges [Xmin; Xmax] and [-Xmax; -Xmin]

function TMainForm.ValidateExtended1 : Boolean;
var
 X : Extended;
 I1, I2 : Int64;
const
 XMIN : Extended = 1E-64;
 XMAX : Extended = 1E9;
 XSTEPSIZE : Extended = 1.0001;

begin
 try
  X := XMIN;
  Result := True;
  while X <= XMAX do
   begin
    I1 := Ceil(X);
    I2 := Ceil64ExtendedFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Ceil(-X);
    I2 := Ceil64ExtendedFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X * XSTEPSIZE;
   end;
 except
  Result := False;
 end;
end;

//Validates against the RTL Ceil which returns an Integer.
//Validates the ranges [Xmin; Xmax] and [-Xmax; -Xmin]

function TMainForm.ValidateExtended2 : Boolean;
var
 X : Extended;
 I1, I2 : Int64;
const
 XMIN : Extended = 0;
 XMAX : Extended = 1E7;
 XSTEPSIZE : Extended = 0.5;

begin
 try
  X := XMIN;
  Result := True;
  while X < XMAX do
   begin
    I1 := Ceil(X);
    I2 := Ceil64ExtendedFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Ceil(-X);
    I2 := Ceil64ExtendedFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X + XSTEPSIZE;
   end;
 except
  Result := False;
 end;
end;

//Validates against the Reference Ceil64 function.
//Validates the ranges [Xmin; Xmax] and [-Xmax; -Xmin]

function TMainForm.ValidateExtended3 : Boolean;
var
 X : Extended;
 I1, I2 : Int64;
const
 XMIN : Extended = MinExtended;
 XMAX : Extended = $7FFFFFFFFFFFFFFF;    //MaxInt64
 XSTEPSIZE : Extended = 1.001;

begin
 try
  X := XMIN;
  Result := True;
  while X <= XMAX do
   begin
    I1 := Ceil64Ref(X);
    I2 := Ceil64ExtendedFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Ceil64Ref(-X);
    I2 := Ceil64ExtendedFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X * XSTEPSIZE;
   end;
 except
  Result := False;
 end;
end;

function TMainForm.ValidateExtended4 : Boolean;
var
 X : Extended;
 I : Int64;
 J : Integer;

begin
 try
  Result := True;
  for J := 0 to Length(ExtendedTestSetArray)-1 do
   begin
    X := ExtendedTestSetArray[J].Input;
    I := Ceil64ExtendedFunction(X);
    if I <> ExtendedTestSetArray[J].CorrectResult then
     begin
      Result := False;
      Exit;
     end;
   end;
 except
  Result := False;
 end;
end;

function TMainForm.ValidateExtended5 : Boolean;
var
 X : Extended;
 I : Int64;

begin
 try
  Result := True;
  X := MaxExtended;
  I := Ceil64ExtendedFunction(X);
  //Result undefined
  //But use result for something
  if I <> 0 then
   begin
    Result := False;
    Exit;
   end;
 except
  Result := True;
 end;
end;

function TMainForm.ValidateExtended6 : Boolean;
var
 X : Extended;
 J1, J2 : Cardinal;
 I : Int64;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;

begin
 try
  Result := True;
  PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
  RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
  for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
   begin
    Set8087PrecisionRadioGroup.ItemIndex := J1;
    for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
     begin
      SetRoundModeRadioGroup.ItemIndex := J2;
      Update;
      Sleep(1000);
      X := 0;
      ControlWordBefore := Get8087CW;
      I := Ceil64ExtendedFunction(X);
      ControlWordAfter := Get8087CW;
      IEdit.Text := IntToStr(I);
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
 except
  Result := False;
 end;
end;

//Validates against the RTL Ceil which returns an Integer.
//Validates the ranges [Xmin; Xmax] and [-Xmax; -Xmin]

function TMainForm.ValidateDouble1 : Boolean;
var
 X : Double;
 I1, I2 : Int64;
const
 XMIN : Double = 1E-64;
 XMAX : Double = 1E9;
 XSTEPSIZE : Double = 1.0001;

begin
 try
  X := XMIN;
  Result := True;
  while X < XMAX do
   begin
    I1 := Ceil(X);
    I2 := Ceil64DoubleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Ceil(-X);
    I2 := Ceil64DoubleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X * XSTEPSIZE;
   end;
 except
  Result := False;
 end;
end;

//Validates against the RTL Ceil which returns an Integer.
//Validates the ranges [Xmin; Xmax] and [-Xmax; -Xmin]

function TMainForm.ValidateDouble2 : Boolean;
var
 X : Double;
 I1, I2 : Int64;
const
 XMIN : Double = 0;
 XMAX : Double = 1E7;
 XSTEPSIZE : Double = 0.5;

begin
 try
  X := XMIN;
  Result := True;
  while X < XMAX do
   begin
    I1 := Ceil(X);
    I2 := Ceil64DoubleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Ceil(-X);
    I2 := Ceil64DoubleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X + XSTEPSIZE;
   end;
 except
  Result := False;
 end;
end;

//Validates against the Reference Ceil64 function.
//Validates the ranges [Xmin; Xmax] and [-Xmax; -Xmin]

function TMainForm.ValidateDouble3 : Boolean;
var
 X : Double;
 I1, I2 : Int64;
const
 XMIN : Double = MinDouble * 10;
 XMAX : Double = $7FFFFFFFFFFFFFFF;    //MaxInt64
 XSTEPSIZE : Double = 1.1;

begin
 try
  X := XMIN;
  Result := True;
  while X <= XMAX do
   begin
    I1 := Ceil64Ref(X);
    I2 := Ceil64DoubleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Ceil64Ref(-X);
    I2 := Ceil64DoubleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X * XSTEPSIZE;
   end;
 except
  Result := False;
 end;
end;

function TMainForm.ValidateDouble4 : Boolean;
var
 X : Double;
 I : Int64;
 J : Integer;

begin
 try
  Result := True;
  for J := 0 to Length(DoubleTestSetArray)-1 do
   begin
    X := DoubleTestSetArray[J].Input;
    I := Ceil64DoubleFunction(X);
    if I <> DoubleTestSetArray[J].CorrectResult then
     begin
      Result := False;
      Exit;
     end;
   end;
 except
  Result := False;
 end;
end;

function TMainForm.ValidateDouble5 : Boolean;
var
 X : Double;
 I : Int64;

begin
 try
  Result := True;
  X := MaxDouble;
  I := Ceil64DoubleFunction(X);
  //Result undefined
  //But use result for something
  if I <> 0 then
   begin
    Result := False;
    Exit;
   end;
 except
  Result := True;
 end;
end;

function TMainForm.ValidateDouble6 : Boolean;
var
 X : Double;
 J1, J2 : Cardinal;
 I : Int64;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;

begin
 try
  Result := True;
  PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
  RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
  for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
   begin
    Set8087PrecisionRadioGroup.ItemIndex := J1;
    for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
     begin
      SetRoundModeRadioGroup.ItemIndex := J2;
      Update;
      Sleep(1000);
      X := 0;
      ControlWordBefore := Get8087CW;
      I := Ceil64DoubleFunction(X);
      ControlWordAfter := Get8087CW;
      IEdit.Text := IntToStr(I);
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
 except
  Result := False;
 end;
end;

//Validates against the RTL Ceil which returns an Integer.
//Validates the ranges [Xmin; Xmax] and [-Xmax; -Xmin]

function TMainForm.ValidateSingle1 : Boolean;
var
 X : Single;
 I1, I2 : Int64;
const
 VALIDATESINGLE1MIN : Single = 1E-40;
 VALIDATESINGLE1MAX : Single = 1E9;
 VALIDATESINGLE1STEPSIZE : Single = 1E9;

begin
 try
  X := VALIDATESINGLE1MIN;
  Result := True;
  while X < VALIDATESINGLE1MAX do
   begin
    I1 := Ceil(X);
    I2 := Ceil64SingleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Ceil(-X);
    I2 := Ceil64SingleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X * 1.0001;
   end;
 except
  Result := False;
 end;
end;

//Validates against the RTL Ceil which returns an Integer.
//Validates the ranges [Xmin; Xmax] and [-Xmax; -Xmin]

function TMainForm.ValidateSingle2 : Boolean;
var
 X : Single;
 I1, I2 : Int64;
const
 VALIDATESINGLE2MAX : Single = 1E5;

begin
 try
  X := 0;
  Result := True;
  while X < VALIDATESINGLE2MAX do
   begin
    I1 := Ceil(X);
    I2 := Ceil64SingleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Ceil(-X);
    I2 := Ceil64SingleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X + 0.5;
   end;
 except
  Result := False;
 end;
end;

//Validates against the Reference Ceil64 function.
//Validates the ranges [Xmin; Xmax] and [-Xmax; -Xmin]

function TMainForm.ValidateSingle3 : Boolean;
var
 X : Single;
 I1, I2 : Int64;
const
 XMIN : Single = MinSingle*10;
 XMAX : Single = $7FFFFFFFFFFFFFFF;    //MaxInt64
 XSTEPSIZE : Single = 1.1;

begin
 try
  X := XMIN;
  Result := True;
  while X <= XMAX do
   begin
    I1 := Ceil64Ref(X);
    I2 := Ceil64SingleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Ceil64Ref(-X);
    I2 := Ceil64SingleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X * XSTEPSIZE;
   end;
 except
  Result := False;
 end;
end;

function TMainForm.ValidateSingle4 : Boolean;
var
 X : Single;
 I : Int64;
 J : Integer;

begin
 try
  Result := True;
  for J := 0 to Length(SingleTestSetArray)-1 do
   begin
    X := SingleTestSetArray[J].Input;
    I := Ceil64SingleFunction(X);
    if I <> SingleTestSetArray[J].CorrectResult then
     begin
      Result := False;
      Exit;
     end;
   end;
 except
  Result := False;
 end;
end;

function TMainForm.ValidateSingle5 : Boolean;
var
 X : Single;
 I : Int64;

begin
 try
  Result := True;
  X := MaxSingle;
  I := Ceil64SingleFunction(X);
  //Result undefined
  //But use result for something
  if I <> 0 then
   begin
    Result := False;
    Exit;
   end;
 except
  Result := True;
 end;
end;

function TMainForm.ValidateSingle6 : Boolean;
var
 X : Single;
 J1, J2 : Cardinal;
 I : Int64;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;

begin
 try
  Result := True;
  PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
  RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
  for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
   begin
    Set8087PrecisionRadioGroup.ItemIndex := J1;
    for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
     begin
      SetRoundModeRadioGroup.ItemIndex := J2;
      Update;
      Sleep(1000);
      X := 0;
      ControlWordBefore := Get8087CW;
      I := Ceil64SingleFunction(X);
      ControlWordAfter := Get8087CW;
      IEdit.Text := IntToStr(I);
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
 except
  Result := False;
 end;
end;

procedure TMainForm.ValidateExtendedButtonClick(Sender: TObject);
begin
 ValidateExtendedButton.Caption := 'Running';
 Update;
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
 ValidateExtendedButton.Caption := 'Validate Extended'; 
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog1.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog1.FileName := 'Ceil64BenchReport.Txt';
 SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
 if SaveDialog1.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('Ceil64 Report');
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 Update;
 for I1 := 0 to FunctionExtendedSelectionRadioGroup.Items.Count-1 do
  begin
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
  end;
 for I2 := 0 to FunctionDoubleSelectionRadioGroup.Items.Count-1 do
  begin
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
  end;
 for I3 := 0 to FunctionSingleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSingleSelectionRadioGroup.ItemIndex := I3;
   if ValidateSingle1 and
      ValidateSingle2 and
      ValidateSingle3 and
      ValidateSingle4 and
      ValidateSingle5 and
      ValidateSingle6 then
    ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Passed')
   else
    ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
   Update;
  end;
 ValidateAllButton.Caption := 'Validate All';
end;

procedure TMainForm.FunctionExtendedSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionExtendedSelectionRadioGroup.ItemIndex+1 of
  1 : Ceil64ExtendedFunction := Ceil64ExtendedDKC2;
  2 : Ceil64ExtendedFunction := CeilExtendedJOH;
  3 : Ceil64ExtendedFunction := Ceil64ExtendedDKCPas1;
  4 : Ceil64ExtendedFunction := Ceil64ExtendedDKCPas3;
  5 : Ceil64ExtendedFunction := Ceil64ExtendedDKCPas4;
  6 : Ceil64ExtendedFunction := Ceil64ExtendedDKCPas5;
  7 : Ceil64ExtendedFunction := Ceil64ExtendedDKCSSE3;
  8 : Ceil64ExtendedFunction := CeilExtendedJOH2;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.FunctionDoubleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionDoubleSelectionRadioGroup.ItemIndex+1 of
  1 : Ceil64DoubleFunction := Ceil64DoubleDKC2;
  2 : Ceil64DoubleFunction := CeilDoubleJOH;
  3 : Ceil64DoubleFunction := Ceil64DoubleDKCPas1;
  4 : Ceil64DoubleFunction := Ceil64DoubleDKCPas3;
  5 : Ceil64DoubleFunction := Ceil64DoubleDKCPas4;
  6 : Ceil64DoubleFunction := Ceil64DoubleDKCPas5;
  7 : Ceil64DoubleFunction := Ceil64DoubleDKCSSE3;
  8 : Ceil64DoubleFunction := CeilDoubleJOH2;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.FunctionSingleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSingleSelectionRadioGroup.ItemIndex+1 of
  1 : Ceil64SingleFunction := Ceil64SingleDKC2;
  2 : Ceil64SingleFunction := CeilSingleJOH;
  3 : Ceil64SingleFunction := Ceil64SingleDKCPas1;
  4 : Ceil64SingleFunction := Ceil64SingleDKCPas3;
  5 : Ceil64SingleFunction := Ceil64SingleDKCPas4;
  6 : Ceil64SingleFunction := Ceil64SingleDKCPas5;
  7 : Ceil64SingleFunction := Ceil64SingleDKCSSE3;
  8 : Ceil64SingleFunction := CeilSingleJOH2;
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
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

procedure TMainForm.BenchmarkSingleButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
 Bench := BenchmarkSingle;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

procedure TMainForm.ValidateDoubleButtonClick(Sender: TObject);
begin
 ValidateDoubleButton.Caption := 'Running';
 Update;
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
 ValidateDoubleButton.Caption := 'Validate Double';
end;

procedure TMainForm.ValidateSingleButtonClick(Sender: TObject);
begin
 ValidateSingleButton.Caption := 'Running';
 Update;
 if ValidateSingle1 and
    ValidateSingle2 and
    ValidateSingle3 and
    ValidateSingle4 and
    ValidateSingle5 and
    ValidateSingle6 then
  begin
   ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Passed');
   ErrorEdit.Color := clGreen;
  end
 else
  begin
   ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
   ErrorEdit.Color := clRed;
  end;
 ValidateSingleButton.Caption := 'Validate Single';
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;
 FunctionName : AnsiString;
 Bench : Double;

begin
 BenchmarkAllButton.Caption := 'Running';
 Update;
 for I1 := 0 to FunctionExtendedSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionExtendedSelectionRadioGroup.ItemIndex := I1;
   FunctionName := FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex];
   Bench := BenchmarkExtended;
   BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
   ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   Update;
  end;
 for I2 := 0 to FunctionDoubleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionDoubleSelectionRadioGroup.ItemIndex := I2;
   FunctionName := FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex];
   Bench := BenchmarkDouble;
   BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
   ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   Update;
  end;
 for I3 := 0 to FunctionSingleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSingleSelectionRadioGroup.ItemIndex := I3;
   FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
   Bench := BenchmarkSingle;
   BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
   ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   Update;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

end.
