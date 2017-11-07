unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'Floor32';

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
    SaveDialog1: TSaveDialog;
    FunctionDoubleSelectionRadioGroup: TRadioGroup;
    FunctionSingleSelectionRadioGroup: TRadioGroup;
    ValidateAllButton: TButton;
    BenchmarkAllButton: TButton;
    BenchmarkDoubleButton: TButton;
    BenchmarkSingleButton: TButton;
    ValidateDoubleButton: TButton;
    ValidateSingleButton: TButton;
    ClearButton: TButton;
    Bench1Edit: TEdit;
    Bench2Edit: TEdit;
    FunctionNameEdit: TEdit;
    MaxSpreadBenchPercentageEdit: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    BenchmarkTestButton: TButton;
    IEdit: TEdit;
    ShowErrorDialogCheckBox: TCheckBox;
    AboutSpeedButton: TSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure BenchmarkTestButtonClick(Sender: TObject);
    procedure SortRichEdit1;
    procedure SortRichEditFP;
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
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure BenchmarkTest;
    procedure ClearAllEditBoxes;
    function BenchmarkExtended : Double;
    function BenchmarkDouble : Double;
    function BenchmarkSingle : Double;
    function ValidateExtended1 : Boolean;
    function ValidateExtended2 : Boolean;
    function ValidateExtended3 : Boolean;
    function ValidateExtended4 : Boolean;
    function ValidateExtended5 : Boolean;
    function ValidateExtended6 : Boolean;
    function ValidateExtended7 : Boolean;
    function ValidateDouble1 : Boolean;
    function ValidateDouble2 : Boolean;
    function ValidateDouble3 : Boolean;
    function ValidateDouble4 : Boolean;
    function ValidateDouble5 : Boolean;
    function ValidateDouble6 : Boolean;
    function ValidateDouble7 : Boolean;
    function ValidateSingle1 : Boolean;
    function ValidateSingle2 : Boolean;
    function ValidateSingle3 : Boolean;
    function ValidateSingle4 : Boolean;
    function ValidateSingle5 : Boolean;
    function ValidateSingle6 : Boolean;
    function ValidateSingle7 : Boolean;
  public
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, FastcodeCPUID, SystemInfoUnit, Floor32RefUnit, Floor32DKCUnit, AboutUnit, Floor32PLRUnit,
  Floor32JOHUnit;

const
 NOOFRERUNS : Cardinal = 6;
 RUNNOMAX : Cardinal = 40000;
 BENCHRANGESTART : Single = 1E-3;
 BENCHRANGEEND : Single = 2E9;
 BENCHXSTEPSIZE : Single = 1.01;
 BENCHSCALE : Cardinal = 100;
 BENCHARRAYSIZE : Integer = 2000;

type
 TFloor32SingleFunction = function (const X : Single) : Integer;
 TFloor32DoubleFunction = function (const X : Double) : Integer;
 TFloor32ExtendedFunction = function (const X : Extended) : Integer;

 TExtended = record
   X : Extended;
   Pad1, Pad2, Pad3, Pad4, Pad5, Pad6 : Byte;
  end;

 TExtendedArray = array[0..1000000] of TExtended;
 PExtendedArray = ^TExtendedArray;

var
 Floor32SingleFunction : TFloor32SingleFunction;
 Floor32DoubleFunction : TFloor32DoubleFunction;
 Floor32ExtendedFunction : TFloor32ExtendedFunction;
 NoOfTicksArray : array of Int64;
 lpFrequency : Int64;
 BenchArraySingle : array of Single;
 BenchArrayDouble : array of Double;
 BenchArrayExtended :  PExtendedArray;
 EnableCMOV : Boolean = False;
 EnableMMX : Boolean = False;
 SSESupported : Boolean = False;
 SSE2Supported : Boolean = False;
 Enable3DNow : Boolean = False;
 EnableExt3DNow : Boolean = False;

procedure GetCPUFeatures; {Called Once by Unit Initialisation}
asm
  push   ebx
  pushfd
  pop    eax
  mov    edx, eax
  xor    edx, $200000
  push   eax
  popfd
  pushfd
  pop    eax
  cmp    eax, edx
  jz     @Exit {No CPUID Support}
  mov    eax, 0 {Check for Get Fetures Support}
  cpuid {Get highest supported cpuid fuction into eax}
  jz     @Exit {No support for getting CPU features}
  mov    eax, 1
  cpuid {Get feature bits into edx}
  test   edx, (1 shl 15) {Test for CMOV Support}
  setnz  EnableCMOV
  test   edx, (1 shl 23) {Test for MMX Support}
  setnz  EnableMMX
  test   edx, (1 shl 25) {Test for SSE Support}
  setnz  SSESupported
  test   edx, (1 shl 26) {Test for SSE2 Support}
  setnz  SSE2Supported
  mov    eax, $80000000 {Test for AMD Specific Features}
  cpuid {Get Max Extended CPUID Level}
  cmp    eax, $80000001
  jl     @Exit {Type/Family/Model/Stepping/Flags Unavailable}
  mov    eax, $80000001
  cpuid {Get Extended CPU Features}
  test   edx, (1 shl 31) {Test for 3DNow! Support}
  setnz  Enable3DNow
  test   edx, (1 shl 30) {Test for Extended 3DNow! Support}
  setnz  EnableExt3DNow
@Exit:
  pop     ebx
end; {GetCPUFeatures}

procedure SetMXCSR(MXCSRValue : Cardinal);
asm
 sub     esp, 4
 mov     [esp], MXCSRValue
 ldmxcsr [esp]
 add     esp,4
end;

function GetMXCSR : Cardinal;
asm
 sub     esp, 4
 stmxcsr [esp]
 mov     eax,[esp]
 add     esp,4
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

procedure ErrorTrapExtended(ValidateNo : Integer; X : Extended);
//var
 //I : Integer;
begin
 //I := Floor32ExtendedFunction(X);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate ' + IntToStr(ValidateNo) + ' X: ' + FloatToStr(X)), 'Error');
end;

procedure ErrorTrapDouble(ValidateNo : Integer; X : Double);
//var
 //I : Integer;
begin
 //I := Floor32DoubleFunction(X);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate ' + IntToStr(ValidateNo) + ' X: ' + FloatToStr(X)), 'Error');
end;

procedure ErrorTrapSingle(ValidateNo : Integer; X : Single);
//var
 //I : Integer;
begin
 //I := Floor32SingleFunction(X);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate ' + IntToStr(ValidateNo) + ' X: ' + FloatToStr(X)), 'Error');
end;

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
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2, Col2Start1, Col3Start1,
 Col2Start2, Col3Start2, Col2Size1, Col2Size2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2,
 Precision1String, Precision2String : AnsiString;
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
     Col2Start1 := CharPosEY(S1, #9, 1);
     Col3Start1 := CharPosEY(S1, #9, 2);
     Col2Start2 := CharPosEY(S2, #9, 1);
     Col3Start2 := CharPosEY(S2, #9, 2);
     Col2Size1 := Col3Start1 - Col2Start1 - 1;
     Col2Size2 := Col3Start2 - Col2Start2 - 1;
     Precision1String := Copy(S1, Col2Start1+1, Col2Size1);
     Precision2String := Copy(S2, Col2Start2+1, Col2Size2);
     if (Precision1String = 'Extended') or
        (Precision1String = 'Double') or
        (Precision1String = 'Single') then
      begin
       FunctionName1 := FunctionName1 + Precision1String;
       FunctionName2 := FunctionName2 + Precision2String;
      end;
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

procedure TMainForm.BenchmarkTestButtonClick(Sender: TObject);
var
 I: Integer;

begin
 BenchmarkTestButton.Caption := 'Running';
 Update;
 for I := 1 to 3 do
  begin
   BenchmarkAllButtonClick(nil);
  end;
 BenchmarkTestButton.Caption := 'Benchmark Test';
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

procedure TMainForm.FormCreate(Sender: TObject);
var
 Succes: Boolean;
 I1: Integer;
 X: extended;
 CpuString : string;
begin
 GetCPUFeatures;
 ClearAllEditBoxes;
 ReportRichEdit.Clear;
 Set8087PrecisionRadioGroupClick(nil);
 SetRoundModeRadioGroupClick(nil);
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 90;
 ReportRichEdit.Paragraph.Tab[1] := 150;
 FunctionExtendedSelectionRadioGroupClick(nil);
 FunctionDoubleSelectionRadioGroupClick(nil);
 FunctionSingleSelectionRadioGroupClick(nil);
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 X := BENCHRANGESTART;
 GetMem(BenchArrayExtended, BENCHARRAYSIZE * SizeOf(TExtended));
 SetLength(BenchArraySingle, BENCHARRAYSIZE);
 SetLength(BenchArrayDouble, BENCHARRAYSIZE);
 for I1 := 1 to BENCHARRAYSIZE do
  begin
   if Random(MaxInt) mod 2 = 0 then
    begin
     BenchArrayExtended[I1-1].X := -X;
     BenchArrayDouble[I1-1] := -X;
     BenchArraySingle[I1-1] := -X;
    end
   else
    begin
     BenchArrayExtended[I1-1].X := X;
     BenchArrayDouble[I1-1] := X;
     BenchArraySingle[I1-1] := X;
    end;
   X := X * BENCHXSTEPSIZE;
  end;

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
 BenchmarkExtendedButton.Caption := 'Running';
 FunctionName := FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex];
 Bench := BenchmarkExtended;
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
 SortRichEdit1;
 SortRichEditFP;
 BenchmarkTest;
 BenchmarkExtendedButton.Caption := 'BenchmarkExtended';
end;

function TMainForm.BenchmarkExtended : Double;
var
 I1 : Integer;
 Succes: Boolean;
 lpPerformanceCount: Int64;
 StartCount: Int64;
 EndCount: Int64;
 NoOfTicks: Int64;
 MinNoOfTicks: Int64;
 I4, ReRunNo: Integer;
 RunTimeSec: Double;
  RunNo: Integer;
  I: Integer;

begin
 try
  I1 := 1; //To satisfy compiler
  StartCount := 0;
  EndCount := 0;
  for ReRunNo := 1 to NOOFRERUNS do
   begin
    Succes := QueryPerformanceCounter(lpPerformanceCount);
    if Succes then
     StartCount := lpPerformanceCount
    else
     raise Exception.Create('QueryPerformanceCounter failed');
    for RunNo := 1 to RUNNOMAX do
     for I := 0 to BENCHARRAYSIZE-1 do
      I1 := Floor32ExtendedFunction(BenchArrayExtended[I].X);
    Succes := QueryPerformanceCounter(lpPerformanceCount);
    if Succes then
     EndCount := lpPerformanceCount
    else
     raise Exception.Create('QueryPerformanceCounter failed');
    NoOfTicks := EndCount - StartCount;
    if NoOfTicks < 0 then
     raise Exception.Create('Tick counter wrapped around');
    NoOfTicksArray[ReRunNo-1] := NoOfTicks;
   end;
  //Get fastest run
  MinNoOfTicks := NoOfTicksArray[0];
  for I4 := 1 to NOOFRERUNS-1 do
   begin
    if NoOfTicksArray[I4] < MinNoOfTicks then
     MinNoOfTicks := NoOfTicksArray[I4];
   end;
  RunTimeSec := MinNoOfTicks / lpFrequency;
  Result := Round(RunTimeSec * BENCHSCALE);
  IEdit.Text := IntToStr(I1);
 except
  Result := 9999;
 end;
end;

function TMainForm.BenchmarkDouble : Double;
var
 I1 : Integer;
 Succes: Boolean;
 lpPerformanceCount: Int64;
 StartCount: Int64;
 EndCount: Int64;
 NoOfTicks: Int64;
 MinNoOfTicks: Int64;
 I4, ReRunNo: Integer;
 RunTimeSec: Double;
  RunNo: Integer;
  I: Integer;

begin
 try
  I1 := 1; //To satisfy compiler
  StartCount := 0;
  EndCount := 0;
  for ReRunNo := 1 to NOOFRERUNS do
   begin
    Succes := QueryPerformanceCounter(lpPerformanceCount);
    if Succes then
     StartCount := lpPerformanceCount
    else
     raise Exception.Create('QueryPerformanceCounter failed');
    for RunNo := 1 to RUNNOMAX do
     for I := 0 to BENCHARRAYSIZE-1 do
      I1 := Floor32DoubleFunction(BenchArrayDouble[I]);
    Succes := QueryPerformanceCounter(lpPerformanceCount);
    if Succes then
     EndCount := lpPerformanceCount
    else
     raise Exception.Create('QueryPerformanceCounter failed');
    NoOfTicks := EndCount - StartCount;
    if NoOfTicks < 0 then
     raise Exception.Create('Tick counter wrapped around');
    NoOfTicksArray[ReRunNo-1] := NoOfTicks;
   end;
  //Get fastest run
  MinNoOfTicks := NoOfTicksArray[0];
  for I4 := 1 to NOOFRERUNS-1 do
   begin
    if NoOfTicksArray[I4] < MinNoOfTicks then
     MinNoOfTicks := NoOfTicksArray[I4];
   end;
  RunTimeSec := MinNoOfTicks / lpFrequency;
  Result := Round(RunTimeSec * BENCHSCALE);
  IEdit.Text := IntToStr(I1);
 except
  Result := 9999;
 end;
end;

function TMainForm.BenchmarkSingle : Double;
var
 I1 : Integer;
 Succes: Boolean;
 lpPerformanceCount: Int64;
 StartCount: Int64;
 EndCount: Int64;
 NoOfTicks: Int64;
 MinNoOfTicks: Int64;
 I4, ReRunNo: Integer;
 RunTimeSec: Double;
 RunNo: Integer;
 I: Integer;

begin
 try
  I1 := 1; //To satisfy compiler
  StartCount := 0;
  EndCount := 0;
  for ReRunNo := 1 to NOOFRERUNS do
   begin
    Succes := QueryPerformanceCounter(lpPerformanceCount);
    if Succes then
     StartCount := lpPerformanceCount
    else
     raise Exception.Create('QueryPerformanceCounter failed');
    for RunNo := 1 to RUNNOMAX do
     for I := 0 to BENCHARRAYSIZE-1 do
      I1 := Floor32SingleFunction(BenchArraySingle[I]);
    Succes := QueryPerformanceCounter(lpPerformanceCount);
    if Succes then
     EndCount := lpPerformanceCount
    else
     raise Exception.Create('QueryPerformanceCounter failed');
    NoOfTicks := EndCount - StartCount;
    if NoOfTicks < 0 then
     raise Exception.Create('Tick counter wrapped around');
    NoOfTicksArray[ReRunNo-1] := NoOfTicks;
   end;
  //Get fastest run
  MinNoOfTicks := NoOfTicksArray[0];
  for I4 := 1 to NOOFRERUNS-1 do
   begin
    if NoOfTicksArray[I4] < MinNoOfTicks then
     MinNoOfTicks := NoOfTicksArray[I4];
   end;
  RunTimeSec := MinNoOfTicks / lpFrequency;
  Result := Round(RunTimeSec * BENCHSCALE);
  IEdit.Text := IntToStr(I1);
 except
  Result := 9999;
 end;
end;

//*****************************************************************************
//Validation Functions
//*****************************************************************************

//Validation of basic functionality for positive and negative numbers

function TMainForm.ValidateExtended1 : Boolean;
var
 X : Extended;
 I1, I2 : Integer;
const
 VALIDATENO : Integer = 1;
 MINX : Extended = 1E-64;
 MAXX : Extended = MaxInt;
 XSTEPSIZE : Extended = 1.0001;

begin
 X := MINX;
 try
  Result := True;
  while X < MAXX do
   begin
    I1 := Floor(X);
    I2 := Floor32ExtendedFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapExtended(VALIDATENO, X);
      Break;
     end;
    I1 := Floor(-X);
    I2 := Floor32ExtendedFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapExtended(VALIDATENO, X);
      Break;
     end;
    X := X * XSTEPSIZE;
   end;
 except
  Result := False;
  ErrorTrapExtended(VALIDATENO, X);
 end;
end;

//Validation of basic functionality for positive and negative numbers

function TMainForm.ValidateExtended2 : Boolean;
var
 X : Extended;
 I1, I2 : Integer;
const
 VALIDATENO : Integer = 2;
 MINX : Extended = 0;
 MAXX : Extended = MaxInt;
 XSTEPSIZE : Extended = 25.5;

begin
 X := MINX;
 try
  Result := True;
  while X < MAXX do
   begin
    I1 := Floor(X);
    I2 := Floor32ExtendedFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapExtended(VALIDATENO, X);
      Break;
     end;
    I1 := Floor(-X);
    I2 := Floor32ExtendedFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapExtended(VALIDATENO, X);
      Break;
     end;
    X := X + XSTEPSIZE;
   end;
 except
  Result := False;
  ErrorTrapExtended(VALIDATENO, X);
 end;
end;

//Validates that the function does not change the FPU controlword

function TMainForm.ValidateExtended3 : Boolean;
var
 X : Extended;
 J1, J2 : Cardinal;
 I : Integer;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;
const
 VALIDATENO : Integer = 3;
 MINX : Extended = -MaxInt-1;
 MAXX : Extended = MaxInt;
 XSTEPSIZE : Extended = 100000;

begin
 X := 0;
 try
  Result := True;
  X := MINX;
  while X < MAXX do
   begin
    PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
    RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
    for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
     begin
      Set8087PrecisionRadioGroup.ItemIndex := J1;
      for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
       begin
        SetRoundModeRadioGroup.ItemIndex := J2;
        Update;
        ControlWordBefore := Get8087CW;
        I := Floor32ExtendedFunction(X);
        ControlWordAfter := Get8087CW;
        IEdit.Text := IntToStr(I);
        if ControlWordBefore <> ControlWordAfter then
         begin
          Result := False;
          ErrorTrapExtended(VALIDATENO, X);
          Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
          SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
          Exit;
         end;
       end;
     end;
    Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
    SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
    X := X + XSTEPSIZE;
   end;
 except
  Result := False;
  ErrorTrapExtended(VALIDATENO, X);
 end;
end;

//Validates that function raises an overflow exception
//RTL Floor does not pass this

function TMainForm.ValidateExtended4 : Boolean;
var
 X : Extended;
 I : Integer;
const
 VALIDATENO : Integer = 4;

begin
 I := 0;//For compiler
 try
  try
   Result := False;
   X := MaxInt;
   X := X + 1;
   I := Floor32ExtendedFunction(X);
   ErrorTrapExtended(VALIDATENO, X);
  except
   Result := True;
  end;
 finally
  IEdit.Text := IntToStr(I);
 end;
end;

//Validates that function raises an overflow exception
//RTL Floor does not pass this

function TMainForm.ValidateExtended5 : Boolean;
var
 X : Extended;
 I : Integer;
const
 VALIDATENO : Integer = 5;

begin
 I := 0;//For compiler
 try
  try
   Result := False;
   X := -MaxInt;
   X := X - 300;
   I := Floor32ExtendedFunction(X);
   ErrorTrapExtended(VALIDATENO, X);
  except
   Result := True;
  end;
 finally
  IEdit.Text := IntToStr(I);
 end;
end;

//Validates that function works with any FPU controlword setting

function TMainForm.ValidateExtended6 : Boolean;
var
 X : Extended;
 I1, I2 : Integer;
 PrecisionIndex : Integer;
 RoundModeIndex : Integer;
 J1 : Integer;
 J2 : Integer;
const
 VALIDATENO : Integer = 6;
 MINX  : Extended = 1E-64;
 MAXX : Extended = 1E-64;
 XSTEPSIZE : Extended = 1.01;

begin
 X := 0;
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
      X := MINX;
      while X < MAXX do
       begin
        I1 := Floor32_Ref(X);
        I2 := Floor32ExtendedFunction(X);
        if I1 <> I2 then
         begin
          Result := False;
          ErrorTrapExtended(VALIDATENO, X);
          Exit;
         end;
        I1 := Floor32_Ref(-X);
        I2 := Floor32ExtendedFunction(-X);
        if I1 <> I2 then
         begin
          Result := False;
          ErrorTrapExtended(VALIDATENO, X);
          Exit;
         end;
        X := X * XSTEPSIZE;
       end;
     end;
   end;
  Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
  SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
 except
  Result := False;
  ErrorTrapExtended(VALIDATENO, X);
 end;
end;

function TMainForm.ValidateExtended7 : Boolean;
var
 I, Iref : Integer;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;
 X: Extended;
const
 VALIDATENO : Integer = 7;
 MINX : Extended = -MaxInt;
 MAXX : Extended = MaxInt;
 XSTEPSIZE : Extended = 2E6;

begin
 Result := True;
 X := MINX;
 while X < MAXX do
  begin
   if SSESupported then
    begin
     MaxMXCSR := High(Word);
     for MXCSR := 0 to MaxMXCSR do
      begin
       Iref := Floor32_Ref(X);
       //Clear 5 lsb's
       MXCSR2 := MXCSR;
       MXCSR2 := (MXCSR2 shr 7) shl 7;
       SetMXCSR(MXCSR2);
       MXCSRBefore := GetMXCSR;
       I := Floor32ExtendedFunction(X);
       MXCSRAfter := GetMXCSR;
       if MXCSRBefore <> MXCSRAfter then
        begin
         Result := False;
         ErrorTrapExtended(VALIDATENO, X);
         Exit;
        end;
       if I <> Iref then
        begin
         Result := False;
         ErrorTrapExtended(VALIDATENO, X);
         Exit;
        end;
      end;
    end;
   X := X + XSTEPSIZE;
  end;
end;

//Validation of basic functionality for positive and negative numbers

function TMainForm.ValidateDouble1 : Boolean;
var
 X : Double;
 I1, I2 : Integer;
const
 VALIDATENO : Integer = 1;
 MINX : Double = 1E-64;
 MAXX : Double = MaxInt;
 XSTEPSIZE : Double = 1.00001;

begin
 X := MINX;
 try
  Result := True;
  while X < MAXX do
   begin
    I1 := Floor32_Ref(X);
    I2 := Floor32DoubleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapDouble(VALIDATENO, X);
      Break;
     end;
    I1 := Floor32_Ref(-X);
    I2 := Floor32DoubleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapDouble(VALIDATENO, X);
      Break;
     end;
    X := X * XSTEPSIZE;
   end;
 except
  Result := False;
  ErrorTrapDouble(VALIDATENO, X);
 end;
end;

//Validation of basic functionality for positive and negative numbers

function TMainForm.ValidateDouble2 : Boolean;
var
 X, XStepSize, Xold : Double;
 I1, I2 : Integer;
const
 VALIDATENO : Integer = 2;
 MINX : Double = 0;
 MAXX : Double = MaxInt;

begin
 XStepSize := 25.5;
 X := MINX;
 try
  Result := True;
  while X < MAXX do
   begin
    I1 := Floor32_Ref(X);
    I2 := Floor32DoubleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapDouble(VALIDATENO, X);
      Break;
     end;
    I1 := Floor32_Ref(-X);
    I2 := Floor32DoubleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapDouble(VALIDATENO, X);
      Break;
     end;
    Xold := X;
    X := X + XStepSize;
    if Xold = X then
     XStepSize := XStepSize + 0.5;
   end;
 except
  Result := False;
  ErrorTrapDouble(VALIDATENO, X);
 end;
end;

//Validates that the function does not change the FPU controlword

function TMainForm.ValidateDouble3 : Boolean;
var
 X : Double;
 J1, J2 : Cardinal;
 I : Integer;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;
const
 VALIDATENO : Integer = 3;
 XSTEPSIZE : Double = 100000;
 MINX : Double = -MaxInt-1;
 MAXX : Double = MaxInt;

begin
 X := 0;
 try
  Result := True;
  X := MINX;
  while X < MAXX do
   begin
    PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
    RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
    for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
     begin
      Set8087PrecisionRadioGroup.ItemIndex := J1;
      for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
       begin
        SetRoundModeRadioGroup.ItemIndex := J2;
        Update;
        ControlWordBefore := Get8087CW;
        I := Floor32DoubleFunction(X);
        ControlWordAfter := Get8087CW;
        IEdit.Text := IntToStr(I);
        if ControlWordBefore <> ControlWordAfter then
         begin
          Result := False;
          Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
          SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
          ErrorTrapDouble(VALIDATENO, X);
          Exit;
         end;
       end;
     end;
    Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
    SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
    X := X + XSTEPSIZE;
   end;
 except
  Result := False;
  ErrorTrapDouble(VALIDATENO, X);
 end;
end;

//Validates that function raises an overflow exception

function TMainForm.ValidateDouble4 : Boolean;
var
 X : Double;
 I : Integer;
const
 VALIDATENO : Integer = 4;

begin
I := 0;//For compiler
 try
  try
   Result := False;
   X := MaxInt;
   X := X + 1;
   I := Floor32DoubleFunction(X);
   ErrorTrapDouble(VALIDATENO, X);
  except
   Result := True;
  end;
 finally
  IEdit.Text := IntToStr(I);
 end;
end;

//Validates that function raises an overflow exception

function TMainForm.ValidateDouble5 : Boolean;
var
 X : Double;
 I : Integer;
const
 VALIDATENO : Integer = 5;

begin
 I := 0;//For compiler
 try
  try
   Result := False;
   X := -MaxInt;
   X := X - 300;
   I := Floor32DoubleFunction(X);
   ErrorTrapDouble(VALIDATENO, X);
  except
   Result := True;
  end;
 finally
  IEdit.Text := IntToStr(I);
 end;
end;

//Validates that function works with any FPU controlword setting

function TMainForm.ValidateDouble6 : Boolean;
var
 X : Double;
 I1, I2 : Integer;
 PrecisionIndex: Integer;
 RoundModeIndex: Integer;
 J1: Integer;
 J2: Integer;
const
 VALIDATENO : Integer = 6;
 XSTEPSIZE : Double = 1.01;

begin
 X := 0;
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
      X := 1E-64;
      while X < 1E9 do
       begin
        I1 := Floor32_Ref(X);
        I2 := Floor32DoubleFunction(X);
        if I1 <> I2 then
         begin
          Result := False;
          ErrorTrapDouble(VALIDATENO, X);
          Exit;
         end;
        I1 := Floor32_Ref(-X);
        I2 := Floor32DoubleFunction(-X);
        if I1 <> I2 then
         begin
          Result := False;
          ErrorTrapDouble(VALIDATENO, X);
          Exit;
         end;
        X := X * XSTEPSIZE;
       end;
     end;
   end;
  Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
  SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
 except
  Result := False;
  ErrorTrapDouble(VALIDATENO, X);
 end;
end;

function TMainForm.ValidateDouble7 : Boolean;
var
 I, Iref : Integer;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;
 X : Double;
const
 VALIDATENO : Integer = 7;
 MINX : Double = -MaxInt;
 MAXX : Double = MaxInt;
 XSTEPSIZE : Double = 1E6;

begin
 Result := True;
 X := MINX;
 while X < MAXX do
  begin
   if SSESupported then
    begin
     MaxMXCSR := High(Word);
     for MXCSR := 0 to MaxMXCSR do
      begin
       Iref := Floor32_Ref(X);
       //Clear 5 lsb's
       MXCSR2 := MXCSR;
       MXCSR2 := (MXCSR2 shr 7) shl 7;
       SetMXCSR(MXCSR2);
       MXCSRBefore := GetMXCSR;
       I := Floor32DoubleFunction(X);
       MXCSRAfter := GetMXCSR;
       if MXCSRBefore <> MXCSRAfter then
        begin
         Result := False;
         ErrorTrapDouble(VALIDATENO, X);
         Exit;
        end;
       if I <> Iref then
        begin
         Result := False;
         ErrorTrapDouble(VALIDATENO, X);
         Exit;
        end;
      end;
    end;
   X := X + XSTEPSIZE;
  end;
end;

//Validation of basic functionality for positive and negative numbers

function TMainForm.ValidateSingle1 : Boolean;
var
 X : Single;
 I1, I2 : Integer;
const
 MINX : Single = 1E-40;
 MAXX : Single = MaxInt;
 XSTEPSIZE : Single = 1.00001;
 VALIDATENO : Integer = 1;

begin
 X := MINX;
 try
  Result := True;
  while X < MAXX do
   begin
    I1 := Floor32_Ref(X);
    I2 := Floor32SingleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapSingle(VALIDATENO, X);
      Break;
     end;
    I1 := Floor32_Ref(-X);
    I2 := Floor32SingleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapSingle(VALIDATENO, X);
      Break;
     end;
    X := X * XSTEPSIZE;
   end;
 except
  Result := False;
  ErrorTrapSingle(VALIDATENO, X);
 end;
end;

//Validation of basic functionality for positive and negative numbers

function TMainForm.ValidateSingle2 : Boolean;
var
 X, Xold, XStepSize : Single;
 I1, I2 : Integer;
const
 VALIDATENO : Integer = 2;
 MINX : Single = 0;
 MAXX : Single = MaxInt;

begin
 XStepSize := 5.5;
 X := MINX;
 try
  Result := True;
  while X < MAXX do
   begin
    I1 := Floor32_Ref(X);
    I2 := Floor32SingleFunction(X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapSingle(VALIDATENO, X);
      Break;
     end;
    I1 := Floor32_Ref(-X);
    I2 := Floor32SingleFunction(-X);
    if I1 <> I2 then
     begin
      Result := False;
      ErrorTrapSingle(VALIDATENO, X);
      Break;
     end;
    Xold := X;
    X := X + XStepSize;
    if Xold = X then
     XStepSize := XStepSize + 1;
   end;
 except
  Result := False;
  ErrorTrapSingle(VALIDATENO, X);
 end;
end;

//Validates that the function does not change the FPU controlword

function TMainForm.ValidateSingle3 : Boolean;
var
 X : Single;
 J1, J2 : Cardinal;
 I : Integer;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;
const
 VALIDATENO : Integer = 3;
 XSTEPSIZE : Double = 100000;
 MINX : Double = -MaxInt-1;
 MAXX : Double = MaxInt;

begin
 X := 0;
 try
  Result := True;
  X := MINX;
  while X < MAXX do
   begin
    PrecisionIndex := Set8087PrecisionRadioGroup.ItemIndex;
    RoundModeIndex := SetRoundModeRadioGroup.ItemIndex;
    for J1 := 0 to Set8087PrecisionRadioGroup.Items.Count-1 do
     begin
      Set8087PrecisionRadioGroup.ItemIndex := J1;
      for J2 := 0 to SetRoundModeRadioGroup.Items.Count-1 do
       begin
        SetRoundModeRadioGroup.ItemIndex := J2;
        Update;
        ControlWordBefore := Get8087CW;
        I := Floor32SingleFunction(X);
        ControlWordAfter := Get8087CW;
        IEdit.Text := IntToStr(I);
        if ControlWordBefore <> ControlWordAfter then
         begin
          Result := False;
          Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
          SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
          ErrorTrapSingle(VALIDATENO, X);
          Exit;
         end;
       end;
     end;
    Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
    SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
    X := X + XSTEPSIZE;
   end;
 except
  Result := False;
  ErrorTrapSingle(VALIDATENO, X);
 end;
end;

//Validates that function raises an overflow exception

function TMainForm.ValidateSingle4 : Boolean;
var
 X : Single;
 I : Integer;
const
 VALIDATENO : Integer = 4;

begin
 I := 0;//For compiler
 try
  try
   Result := False;
   X := MaxInt;
   X := X + 1;
   I := Floor32SingleFunction(X);
   ErrorTrapSingle(VALIDATENO, X);
  except
   Result := True;
  end;
 finally
  IEdit.Text := IntToStr(I);
 end;
end;

//Validates that function raises an overflow exception

function TMainForm.ValidateSingle5 : Boolean;
var
 X : Single;
 I : Integer;
const
 VALIDATENO : Integer = 5;

begin
 I := 0;//For compiler
 try
  try
   Result := False;
   X := -MaxInt;
   X := X - 300;
   I := Floor32SingleFunction(X);
   ErrorTrapSingle(VALIDATENO, X);
  except
   Result := True;
  end;
 finally
  IEdit.Text := IntToStr(I);
 end;
end;

//Validates that function works with any FPU controlword setting

function TMainForm.ValidateSingle6 : Boolean;
var
 X : Single;
 I1, I2 : Integer;
 PrecisionIndex : Integer;
 RoundModeIndex : Integer;
 J1 : Integer;
 J2 : Integer;
const
 VALIDATENO : Integer = 6;
 XSTEPSIZE : Single = 1.01;
 MINX : Single = 1E-40;
 MAXX : Single = MaxInt;

begin
 X := 0;
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
      X := MINX;
      while X < MAXX do
       begin
        I1 := Floor32_Ref(X);
        I2 := Floor32SingleFunction(X);
        if I1 <> I2 then
         begin
          Result := False;
          ErrorTrapSingle(VALIDATENO, X);
          Exit;
         end;
        I1 := Floor32_Ref(-X);
        I2 := Floor32SingleFunction(-X);
        if I1 <> I2 then
         begin
          Result := False;
          ErrorTrapSingle(VALIDATENO, X);
          Exit;;
         end;
        X := X * XSTEPSIZE;
       end;
     end;
   end;
  Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
  SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
 except
  Result := False;
  ErrorTrapSingle(VALIDATENO, X);
 end;
end;

function TMainForm.ValidateSingle7 : Boolean;
var
 I : Integer;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;
 X : Single;
 Iref: Integer;
const
 VALIDATENO : Integer = 7;
 MINX : Single = -MaxInt;
 MAXX : Single = MaxInt;
 XSTEPSIZE : Single = 1E6;

begin
 Result := True;
 X := MINX;
 while X < MAXX do
  begin
   if SSESupported then
    begin
     MaxMXCSR := High(Word);
     for MXCSR := 0 to MaxMXCSR do
      begin
       Iref := Floor32_Ref(X);
       //Clear 5 lsb's
       MXCSR2 := MXCSR;
       MXCSR2 := (MXCSR2 shr 7) shl 7;
       SetMXCSR(MXCSR2);
       MXCSRBefore := GetMXCSR;
       I := Floor32SingleFunction(X);
       MXCSRAfter := GetMXCSR;
       if MXCSRBefore <> MXCSRAfter then
        begin
         Result := False;
         ErrorTrapSingle(VALIDATENO, X);
         Exit;
        end;
       if I <> Iref then
        begin
         Result := False;
         ErrorTrapSingle(VALIDATENO, X);
         Exit;
        end;
      end;
    end;
   X := X + XSTEPSIZE;
  end;
end;

procedure TMainForm.ValidateExtendedButtonClick(Sender: TObject);
var
 Valid: Boolean;

begin
 ValidateExtendedButton.Caption := 'Running';
 Valid := ValidateExtended1 and
          ValidateExtended2 and
          ValidateExtended3 and
          ValidateExtended4 and
          ValidateExtended5 and
          ValidateExtended6 and
          ValidateExtended7;
 if Valid then
  ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Extended' + #9 + 'Passed')
 else
 ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Extended' + #9 + 'Failed');
 ValidateExtendedButton.Caption := 'Validate Extended';
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog1.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog1.FileName := FResultsFileName;
 SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
 if SaveDialog1.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('Floor32 Report');
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;
 Valid : Boolean;
begin
 ValidateAllButton.Caption := 'Running';
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_LOWEST) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_LOWEST failed');

 for I1 := 0 to FunctionExtendedSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionExtendedSelectionRadioGroup.ItemIndex := I1;
   Valid := ValidateExtended1 and
            ValidateExtended2 and
            ValidateExtended3 and
            ValidateExtended4 and
            ValidateExtended5 and
            ValidateExtended6 and
            ValidateExtended7;
   if Valid then
    ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Extended' + #9 + 'Passed')
   else
    ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Extended' + #9 + 'Failed');
   Update;
  end;
 for I2 := 0 to FunctionDoubleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionDoubleSelectionRadioGroup.ItemIndex := I2;
   Valid := ValidateDouble1 and
            ValidateDouble2 and
            ValidateDouble3 and
            ValidateDouble4 and
            ValidateDouble5 and
            ValidateDouble6 and
            ValidateDouble7;
   if Valid then
    ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Double' + #9 + 'Passed')
   else
    ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Double' + #9 + 'Failed');
   Update;
  end;
 for I3 := 0 to FunctionSingleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSingleSelectionRadioGroup.ItemIndex := I3;
   Valid := ValidateSingle1 and
            ValidateSingle2 and
            ValidateSingle3 and
            ValidateSingle4 and
            ValidateSingle5 and
            ValidateSingle6 and
            ValidateSingle7;
   if Valid then
    ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Single' + #9 + 'Passed')
   else
    ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Single' + #9 + 'Failed');
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

procedure TMainForm.FunctionExtendedSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionExtendedSelectionRadioGroup.ItemIndex+1 of
  1 : Floor32ExtendedFunction := Floor;
  2 : Floor32ExtendedFunction := Floor32_DKC_Pas_1;
  3 : Floor32ExtendedFunction := Floor32_DKC_IA32_1;
  4 : Floor32ExtendedFunction := Floor32_PLR_IA32_1;
  5 : Floor32ExtendedFunction := Floor32_PLR_IA32_2;
  6 : Floor32ExtendedFunction := Floor32_PLR_PAS_1;
  7 : Floor32ExtendedFunction := Floor32_JOH_IA32_1;
  8 : Floor32ExtendedFunction := Floor32_JOH_PAS_1;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.FunctionDoubleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionDoubleSelectionRadioGroup.ItemIndex+1 of
  1 : Floor32DoubleFunction := Floor32_DKC_Pas_1;
  2 : Floor32DoubleFunction := Floor32_DKC_IA32_1;
  3 : Floor32DoubleFunction := Floor32_PLR_IA32_1;
  4 : Floor32DoubleFunction := Floor32_PLR_IA32_2;
  5 : Floor32DoubleFunction := Floor32_JOH_IA32_1;
  6 : Floor32DoubleFunction := Floor32_JOH_PAS_1;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.FunctionSingleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSingleSelectionRadioGroup.ItemIndex+1 of
  1 : Floor32SingleFunction := Floor32_DKC_Pas_1;
  2 : Floor32SingleFunction := Floor32_DKC_IA32_1;
  3 : Floor32SingleFunction := Floor32_PLR_IA32_1;
  4 : Floor32SingleFunction := Floor32_PLR_IA32_2;
  5 : Floor32SingleFunction := Floor32_JOH_IA32_1;
  6 : Floor32SingleFunction := Floor32_JOH_PAS_1;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.BenchmarkDoubleButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 BenchmarkDoubleButton.Caption := 'Running';
 FunctionName := FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex];
 Bench := BenchmarkDouble;
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
 SortRichEdit1;
 SortRichEditFP;
 BenchmarkTest;
 BenchmarkDoubleButton.Caption := 'Benchmark Double';
end;

procedure TMainForm.BenchmarkSingleButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 BenchmarkSingleButton.Caption := 'Running';
 FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
 Bench := BenchmarkSingle;
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
 SortRichEdit1;
 SortRichEditFP;
 BenchmarkTest;
 BenchmarkSingleButton.Caption := 'Benchmark Single';
end;

procedure TMainForm.ValidateDoubleButtonClick(Sender: TObject);
var
 Valid: Boolean;

begin
 ValidateDoubleButton.Caption := 'Running';
 Valid := ValidateDouble1 and
          ValidateDouble2 and
          ValidateDouble3 and
          ValidateDouble4 and
          ValidateDouble5 and
          ValidateDouble6 and
          ValidateDouble7;
 if Valid then
  ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Double' + #9 + 'Passed')
 else
  ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Double' + #9 + 'Failed');
 ValidateDoubleButton.Caption := 'Validate Double';
end;

procedure TMainForm.ValidateSingleButtonClick(Sender: TObject);
var
  Valid: Boolean;
begin
 ValidateSingleButton.Caption := 'Running';
 Valid := ValidateSingle1 and
          ValidateSingle2 and
          ValidateSingle3 and
          ValidateSingle4 and
          ValidateSingle5 and
          ValidateSingle6 and
          ValidateSingle7;
 if Valid then
  ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Single' + #9 + 'Passed')
 else
  ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Single' + #9 + 'Failed');
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
   ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   SortRichEdit1;
   SortRichEditFP;
   BenchmarkTest;
   Update;
  end;
 for I2 := 0 to FunctionDoubleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionDoubleSelectionRadioGroup.ItemIndex := I2;
   FunctionName := FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex];
   Bench := BenchmarkDouble;
   ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   SortRichEdit1;
   SortRichEditFP;
   BenchmarkTest;
   Update;
  end;
 for I3 := 0 to FunctionSingleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSingleSelectionRadioGroup.ItemIndex := I3;
   FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
   Bench := BenchmarkSingle;
   ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   SortRichEdit1;
   SortRichEditFP;
   BenchmarkTest;
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

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
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
