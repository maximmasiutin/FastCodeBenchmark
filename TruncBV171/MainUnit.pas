unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'Trunc';

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
    procedure FormDestroy(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
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
    function ValidateDouble1 : Boolean;
    function ValidateDouble2 : Boolean;
    function ValidateDouble3 : Boolean;
    function ValidateSingle1 : Boolean;
    function ValidateSingle2 : Boolean;
    function ValidateSingle3 : Boolean;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, FastcodeCPUID, SysteminfoUnit, TruncUnit, TruncJOHUnit, TruncPLRUnit;

const
 NOOFLOOPS : Cardinal = 1;
 BENCHRANGESTART : Single = 1E-35;
 BENCHRANGEEND : Single = 1E17;
 BENCHXSTEPSIZE : Single = 1.000005;
 SCALE : Double = 100;

type
 TTruncSingleFunction = function (const X : Single) : Int64;
 TTruncDoubleFunction = function (const X : Double) : Int64;
 TTruncExtendedFunction = function (const X : Extended) : Int64;

var
 TruncSingleFunction : TTruncSingleFunction;
 TruncDoubleFunction : TTruncDoubleFunction;
 TruncExtendedFunction : TTruncExtendedFunction;
 //Benchmark variables are global to ensure same alignment for all runs
 Xs : Single;
 Xd : Double;
 Xe : Extended;
 I1, I2 : Int64;

//Finds a character in a sourcestring as pos does
//but can find occurence 1,2,...n of the character
//Returns 0 if character is not found

function CharPosEY(SourceString : AnsiString;
                   SearchCharacter : Char;
                   Occurrence : Cardinal) : Integer;
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
   end;
 until(not Swapped);
end;


procedure TMainForm.DevelopButtonClick(Sender: TObject);
var
 X : Extended;
 I : Int64;

begin
 X := StrToFloat(XEdit.Text);
 I := TruncExtendedFunction(X);
 IEdit.Text := IntToStr(I);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 Set8087PrecisionRadioGroupClick(nil);
 SetRoundModeRadioGroupClick(nil);
 TruncExtendedFunction := TruncExtended_DKC_IA32_1;
 TruncDoubleFunction := TruncDouble_DKC_IA32_1;
 TruncSingleFunction := TruncSingle_DKC_PAS_1;
 XEdit.Text := FloatToStr(65541 + 5/7);
 IEdit.Text := '';
 ErrorEdit.Text := '';
 BenchEdit.Text := '';
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 1;
 ReportRichEdit.Paragraph.Tab[0] := 130;

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

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(FResultList);
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
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

function TMainForm.BenchmarkRTLExtended : Double;
var
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 Xe := BENCHRANGESTART;
 StartTime := Time;
 while Xe < BENCHRANGEEND do
  begin
   I1 := Trunc(Xe);
   I2 := Trunc(-Xe);
   Xe := Xe * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkExtended : Double;
var
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 Xe := BENCHRANGESTART;
 StartTime := Time;
 while Xe < BENCHRANGEEND do
  begin
   I1 := TruncExtendedFunction(Xe);
   I2 := TruncExtendedFunction(-Xe);
   Xe := Xe * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);

 SortRichEditFP;
 SortRichEdit1;
end;

function TMainForm.BenchmarkDouble : Double;
var
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 Xd := BENCHRANGESTART;
 StartTime := Time;
 while Xd < BENCHRANGEEND do
  begin
   I1 := TruncDoubleFunction(Xd);
   I2 := TruncDoubleFunction(-Xd);
   Xd := Xd * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);

 SortRichEditFP;
 SortRichEdit1;
end;

function TMainForm.BenchmarkRTLDouble : Double;
var
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 Xd := BENCHRANGESTART;
 StartTime := Time;
 while Xd < BENCHRANGEEND do
  begin
   I1 := Trunc(Xd);
   I2 := Trunc(-Xd);
   Xd := Xd * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);
end;

function TMainForm.BenchmarkSingle : Double;
var
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 Xs := BENCHRANGESTART;
 StartTime := Time;
 while Xs < BENCHRANGEEND do
  begin
   I1 := TruncSingleFunction(Xs);
   I2 := TruncSingleFunction(-Xs);
   Xs := Xs * BENCHXSTEPSIZE;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 Result := SCALE * RunTime *24*60*60;
 IEdit.Text := IntToStr(I1 div I2);

 SortRichEditFP;
 SortRichEdit1;
end;

function TMainForm.BenchmarkRTLSingle : Double;
var
 StartTime, EndTime, RunTime : TDateTime;

begin
 I1 := 1; //To satisfy compiler
 I2 := 2; //To satisfy compiler
 Xs := BENCHRANGESTART;
 StartTime := Time;
 while Xs < BENCHRANGEEND do
  begin
   I1 := Trunc(Xs);
   I2 := Trunc(-Xs);
   Xs := Xs * BENCHXSTEPSIZE;
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
 try
  X := 1E-64;
  Result := True;
  while X < 1E17 do
   begin
    I1 := Trunc(X);
    I2 := TruncExtendedFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Trunc(-X);
    I2 := TruncExtendedFunction(-X);
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

function TMainForm.ValidateExtended2 : Boolean;
var
 X : Extended;
 I1, I2 : Int64;

begin
 try
  X := 0;
  Result := True;
  while X < 1E7 do
   begin
    I1 := Trunc(X);
    I2 := TruncExtendedFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Trunc(-X);
    I2 := TruncExtendedFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X + 1;
   end;
 except
  Result := False;
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
      I := TruncExtendedFunction(X);
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

function TMainForm.ValidateDouble1 : Boolean;
var
 X : Double;
 I1, I2 : Int64;

begin
 try
  X := 1E-64;
  Result := True;
  while X < 1E17 do
   begin
    I1 := Trunc(X);
    I2 := TruncDoubleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Trunc(-X);
    I2 := TruncDoubleFunction(-X);
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

function TMainForm.ValidateDouble2 : Boolean;
var
 X : Double;
 I1, I2 : Int64;

begin
 try
  X := 0;
  Result := True;
  while X < 1E7 do
   begin
    I1 := Trunc(X);
    I2 := TruncDoubleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Trunc(-X);
    I2 := TruncDoubleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X + 1;
   end;
 except
  Result := False;
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
      I := TruncDoubleFunction(X);
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

function TMainForm.ValidateSingle1 : Boolean;
var
 X : Single;
 I1, I2 : Int64;

begin
 try
  X := 1E-40;
  Result := True;
  while X < 1E17 do
   begin
    I1 := Trunc(X);
    I2 := TruncSingleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Trunc(-X);
    I2 := TruncSingleFunction(-X);
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

function TMainForm.ValidateSingle2 : Boolean;
var
 X : Single;
 I1, I2 : Int64;

begin
 try
  X := 0;
  Result := True;
  while X < 1E7 do
   begin
    I1 := Trunc(X);
    I2 := TruncExtendedFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    I1 := Trunc(-X);
    I2 := TruncExtendedFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      Break;
     end;
    X := X + 1;
   end;
 except
  Result := False;
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
      I := TruncSingleFunction(X);
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

procedure TMainForm.FunctionExtendedSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionExtendedSelectionRadioGroup.ItemIndex+1 of
  1 : TruncExtendedFunction := TruncExtended_DKC_IA32_1;
  2 : TruncExtendedFunction := TruncExtended_DKC_IA32_2;
  3 : TruncExtendedFunction := TruncExtended_JOH_IA32_1;
  4 : TruncExtendedFunction := TruncExtended_RTL_IA32_1;
  5 : TruncExtendedFunction := TruncExtended_DKC_SSE3_1;
  6 : TruncExtendedFunction := TruncExtended_PLR_IA32_1;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog1.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog1.FileName := FResultsFileName;
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
 ValidateAllButton.Caption := 'Running';
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

 ValidateAllButton.Caption := 'Validate All';

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.FunctionSingleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSingleSelectionRadioGroup.ItemIndex+1 of
  1 : TruncSingleFunction := TruncSingle_DKC_PAS_1;
  2 : TruncSingleFunction := TruncSingle_DKC_IA32_2;
  3 : TruncSingleFunction := TruncSingle_DKC_IA32_3;
  4 : TruncSingleFunction := TruncSingle_JOH_IA32_1;
  5 : TruncSingleFunction := TruncSingle_DKC_SSE3_1;
  6 : TruncSingleFunction := TruncSingle_PLR_IA32_1;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.FunctionDoubleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionDoubleSelectionRadioGroup.ItemIndex+1 of
  1 : TruncDoubleFunction := TruncDouble_DKC_IA32_1;
  2 : TruncDoubleFunction := TruncDouble_DKC_IA32_2;
  3 : TruncDoubleFunction := TruncDouble_JOH_IA32_1;
  4 : TruncDoubleFunction := TruncDouble_DKC_SSE3_1;
  5 : TruncDoubleFunction := TruncDouble_PLR_IA32_1;
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
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
end;

procedure TMainForm.BenchmarkSingleButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
 Bench := BenchmarkSingle;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + FloatToStrF(Bench, ffFixed, 9, 0))
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
 FunctionName := 'TruncExtended_RTL_IA32_1';
 Bench := BenchmarkRTLExtended;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));

 SortRichEditFP;
 SortRichEdit1;
end;

procedure TMainForm.BenchDoubleRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'TruncDouble_RTL_IA32_1';
 Bench := BenchmarkRTLDouble;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));

 SortRichEditFP;
 SortRichEdit1;
end;

procedure TMainForm.BenchSingleRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'TruncSingle_RTL_IA32_1';
 Bench := BenchmarkRTLSingle;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));

 SortRichEditFP;
 SortRichEdit1;
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
   FunctionExtendedSelectionRadioGroup.ItemIndex := I1;
   FunctionName := FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex];
   try
    Bench := BenchmarkExtended;
    BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   except
    BenchEdit.Text := FloatToStrF(99999, ffFixed, 9, 0);
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(99999, ffFixed, 9, 0));
   end;
   Update;
  end;
 for I2 := 0 to FunctionDoubleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionDoubleSelectionRadioGroup.ItemIndex := I2;
   FunctionName := FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex];
   try
    Bench := BenchmarkDouble;
    BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   except
    BenchEdit.Text := FloatToStrF(99999, ffFixed, 9, 0);
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(99999, ffFixed, 9, 0));
   end;
   Update;
  end;
 for I3 := 0 to FunctionSingleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSingleSelectionRadioGroup.ItemIndex := I3;
   FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
   try
    Bench := BenchmarkSingle;
    BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   except
    BenchEdit.Text := FloatToStrF(99999, ffFixed, 9, 0);
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + FloatToStrF(99999, ffFixed, 9, 0));
   end;
   Update;
  end;

 SortRichEditFP;
 SortRichEdit1;

 BenchmarkAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);

end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
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
