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
    function BenchmarkExtended : Double;
    function BenchmarkDouble : Double;
    function BenchmarkSingle : Double;
    function BenchmarkRTLExtended : Double;
    function BenchmarkRTLDouble : Double;
    function BenchmarkRTLSingle : Double;
    function ValidateExtended1 : Boolean;
    function ValidateExtended2 : Boolean;
    function ValidateExtended3 : Boolean;
    function ValidateDouble1 : Boolean;
    function ValidateDouble2 : Boolean;
    function ValidateDouble3 : Boolean;
    function ValidateSingle1 : Boolean;
    function ValidateSingle2 : Boolean;
    function ValidateSingle3 : Boolean;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, FloorUnit, FloorJOHUnit;

const
 NOOFLOOPS : Cardinal = 1;
 BENCHRANGESTART : Single = 1E-35;
 BENCHRANGEEND : Single = 1E9;
 BENCHXSTEPSIZE : Single = 1.000005;
 SCALE : Double = 100;

type
 TFloorSingleFunction = function (const X : Single) : Int64;
 TFloorDoubleFunction = function (const X : Double) : Int64;
 TFloorExtendedFunction = function (const X : Extended) : Int64;

var
 FloorSingleFunction : TFloorSingleFunction;
 FloorDoubleFunction : TFloorDoubleFunction;
 FloorExtendedFunction : TFloorExtendedFunction;

procedure TMainForm.DevelopButtonClick(Sender: TObject);
var
 X : Extended;
 I : Int64;

begin
 X := StrToFloat(XEdit.Text);
 I := FloorExtendedFunction(X);
 IEdit.Text := IntToStr(I);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 Set8087PrecisionRadioGroupClick(nil);
 SetRoundModeRadioGroupClick(nil);
 FloorExtendedFunction := FloorExtendedDKC1;
 FloorDoubleFunction := FloorDoubleDKC1;
 FloorSingleFunction := FloorSingleDKC1;
 XEdit.Text := FloatToStr(65541 + 5/7);
 IEdit.Text := '';
 ErrorEdit.Text := '';
 BenchEdit.Text := '';
 ReportRichEdit.Clear;
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
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

function TMainForm.BenchmarkRTLExtended : Double;
var
 X : Extended;
 I1, I2 : Int64;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X := BENCHRANGESTART;
 StartTime := Time;
 while X < BENCHRANGEEND do
  begin
   I1 := Floor(X);
   I2 := Floor(-X);
   X := X * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkExtended : Double;
var
 X : Extended;
 I1, I2 : Int64;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X := BENCHRANGESTART;
 StartTime := Time;
 while X < BENCHRANGEEND do
  begin
   I1 := FloorExtendedFunction(X);
   I2 := FloorExtendedFunction(-X);
   X := X * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkDouble : Double;
var
 X : Double;
 I1, I2 : Int64;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X := BENCHRANGESTART;
 StartTime := Time;
 while X < BENCHRANGEEND do
  begin
   I1 := FloorDoubleFunction(X);
   I2 := FloorDoubleFunction(-X);
   X := X * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkRTLDouble : Double;
var
 X : Double;
 I1, I2 : Int64;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X := BENCHRANGESTART;
 StartTime := Time;
 while X < BENCHRANGEEND do
  begin
   I1 := Floor(X);
   I2 := Floor(-X);
   X := X * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkSingle : Double;
var
 X : Single;
 I1, I2 : Int64;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X := BENCHRANGESTART;
 StartTime := Time;
 while X < BENCHRANGEEND do
  begin
   I1 := FloorSingleFunction(X);
   I2 := FloorSingleFunction(-X);
   X := X * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkRTLSingle : Double;
var
 X : Single;
 I1, I2 : Int64;
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 X := BENCHRANGESTART;
 StartTime := Time;
 while X < BENCHRANGEEND do
  begin
   I1 := Floor(X);
   I2 := Floor(-X);
   X := X * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);//Just to satisfy compiler
end;

function TMainForm.ValidateExtended1 : Boolean;
var
 X : Extended;
 I1, I2 : Int64;

begin
 X := 1E-64;
 Result := True;
 while X < 1E9 do
  begin
   I1 := Floor(X);
   I2 := FloorExtendedFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Floor(-X);
   I2 := FloorExtendedFunction(-X);
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
 I1, I2 : Int64;

begin
 X := 0;
 Result := True;
 while X < 1E7 do
  begin
   I1 := Floor(X);
   I2 := FloorExtendedFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Floor(-X);
   I2 := FloorExtendedFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 0.5;
  end;
end;

function TMainForm.ValidateExtended3 : Boolean;
var
 X : Extended;
 J1, J2 : Cardinal;
 I : Int64;
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
     Update;
     Sleep(1000);
     X := 0;
     ControlWordBefore := Get8087CW;
     I := FloorExtendedFunction(X);
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
end;

function TMainForm.ValidateDouble1 : Boolean;
var
 X : Double;
 I1, I2 : Int64;

begin
 X := 1E-64;
 Result := True;
 while X < 1E9 do
  begin
   I1 := Floor(X);
   I2 := FloorDoubleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Floor(-X);
   I2 := FloorDoubleFunction(-X);
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
 I1, I2 : Int64;

begin
 X := 0;
 Result := True;
 while X < 1E7 do
  begin
   I1 := Floor(X);
   I2 := FloorDoubleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Floor(-X);
   I2 := FloorDoubleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 0.5;
  end;
end;

function TMainForm.ValidateDouble3 : Boolean;
var
 X : Double;
 J1, J2 : Cardinal;
 I : Int64;
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
     Update;
     Sleep(1000);
     X := 0;
     ControlWordBefore := Get8087CW;
     I := FloorDoubleFunction(X);
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
end;

function TMainForm.ValidateSingle1 : Boolean;
var
 X : Single;
 I1, I2 : Int64;

begin
 X := 1E-40;
 Result := True;
 while X < 1E9 do
  begin
   I1 := Floor(X);
   I2 := FloorSingleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Floor(-X);
   I2 := FloorSingleFunction(-X);
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
 I1, I2 : Int64;

begin
 X := 0;
 Result := True;
 while X < 1E5 do
  begin
   I1 := Floor(X);
   I2 := FloorExtendedFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Floor(-X);
   I2 := FloorExtendedFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 0.5;
  end;
end;

function TMainForm.ValidateSingle3 : Boolean;
var
 X : Single;
 J1, J2 : Cardinal;
 I : Int64;
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
     Update;
     Sleep(1000);
     X := 0;
     ControlWordBefore := Get8087CW;
     I := FloorSingleFunction(X);
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
end;

procedure TMainForm.ValidateExtendedButtonClick(Sender: TObject);
begin
 if ValidateExtended1 and
    ValidateExtended2 and
    ValidateExtended3 then
  begin
   ErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Passed')
  end
 else
  begin
   ErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
  end;
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog1.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog1.FileName := 'FloorBenchReportPX.Txt';
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
   FunctionExtendedSelectionRadioGroup.ItemIndex := I1;
   if ValidateExtended1 and
      ValidateExtended2 and
      ValidateExtended3 then
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
      ValidateDouble3 then
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
      ValidateSingle3 then
    ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Passed')
   else
    ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
   Update;
  end;
end;

procedure TMainForm.FunctionExtendedSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionExtendedSelectionRadioGroup.ItemIndex+1 of
  1 : FloorExtendedFunction := FloorExtendedDKC1;
  2 : FloorExtendedFunction := FloorExtendedDKCPas1;
  3 : FloorExtendedFunction := FloorExtendedJOH;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.FunctionDoubleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionDoubleSelectionRadioGroup.ItemIndex+1 of
  1 : FloorDoubleFunction := FloorDoubleDKC1;
  2 : FloorDoubleFunction := FloorDoubleDKCPas1;
  3 : FloorDoubleFunction := FloorDoubleJOH;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.FunctionSingleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSingleSelectionRadioGroup.ItemIndex+1 of
  1 : FloorSingleFunction := FloorSingleDKC1;
  2 : FloorSingleFunction := FloorSingleDKCPas1;
  3 : FloorSingleFunction := FloorSingleJOH;
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
 if ValidateDouble1 and
    ValidateDouble2 and
    ValidateDouble3 then
  begin
   ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Passed');
   ErrorEdit.Color := clGreen;
  end
 else
  begin
   ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
   ErrorEdit.Color := clRed;
  end;
end;

procedure TMainForm.ValidateSingleButtonClick(Sender: TObject);
begin
 if ValidateSingle1 and
    ValidateSingle2 and
    ValidateSingle3 then
  begin
   ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Passed');
   ErrorEdit.Color := clGreen;
  end
 else
  begin
   ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
   ErrorEdit.Color := clRed;
  end;
end;

procedure TMainForm.BenchExtendedRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'FloorExtendedRTL';
 Bench := BenchmarkRTLExtended;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

procedure TMainForm.BenchDoubleRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'FloorDoubleRTL';
 Bench := BenchmarkRTLDouble;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

procedure TMainForm.BenchSingleRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'FloorSingleRTL';
 Bench := BenchmarkRTLSingle;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;
 FunctionName : AnsiString;
 Bench : Double;

begin
 BenchExtendedRTLButtonClick(nil);
 Update;
 BenchDoubleRTLButtonClick(nil);
 Update;
 BenchSingleRTLButtonClick(nil);
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
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

end.
