unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, TeEngine, Series, ExtCtrls,
  TeeProcs, Chart;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'ArcCos';

type
  TMainForm = class(TForm)
    BenchmarkGroupBox: TGroupBox;
    RunSingleButton: TButton;
    ResultEdit: TEdit;
    ValidationGroupBox: TGroupBox;
    ValidateExtendedPrecisionButton: TButton;
    MaxErrorEdit: TEdit;
    ResultLabel: TLabel;
    CloseBitBtn: TBitBtn;
    ErrorLabel: TLabel;
    ReportRichEdit: TRichEdit;
    BenchmarkAllButton: TButton;
    Label1: TLabel;
    ErrorChart: TChart;
    Series1: TLineSeries;
    ValidateDoublePrecisionButton: TButton;
    ValidateSinglePrecisionButton: TButton;
    ChartLeftAxisLabel: TLabel;
    FunctionSelectionSingleRadioGroup: TRadioGroup;
    FunctionSelectionDoubleRadioGroup: TRadioGroup;
    FunctionSelectionExtendedRadioGroup: TRadioGroup;
    RunDoubleButton: TButton;
    RunExtendedButton: TButton;
    Series2: TLineSeries;
    ValidateAllButton: TButton;
    Panel1: TPanel;
    SaveSpeedButton: TSpeedButton;
    SaveDialog: TSaveDialog;
    RuntimeEdit: TEdit;
    SpeedButton1: TSpeedButton;
    PrintSpeedButton: TSpeedButton;
    AboutSpeedButton: TSpeedButton;
    procedure RunSingleButtonClick(Sender: TObject);
    procedure ValidateExtendedPrecisionButtonClick(Sender: TObject);
    procedure NoOfClocksPerRunEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ValidateDoublePrecisionButtonClick(Sender: TObject);
    procedure ValidateSinglePrecisionButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FunctionSelectionSingleRadioGroupClick(Sender: TObject);
    procedure FunctionSelectionDoubleRadioGroupClick(Sender: TObject);
    procedure FunctionSelectionExtendedRadioGroupClick(Sender: TObject);
    procedure RunDoubleButtonClick(Sender: TObject);
    procedure RunExtendedButtonClick(Sender: TObject);
    procedure SaveSpeedButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure PrintSpeedButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure SortRichEdit1;
    procedure SortRichEditFP;
    procedure ValidateExtended1;
    procedure ValidateExtended2;
    procedure ValidateExtended3;
    procedure ValidateDouble1;
    procedure ValidateDouble2;
    procedure ValidateDouble3;
    procedure ValidateSingle1;
    procedure ValidateSingle2;
    procedure ValidateSingle3;
    procedure BenchmarkArcCosExtended;
    procedure BenchmarkArcCosDouble;
    procedure BenchmarkArcCosSingle;
    procedure BenchmarkArcCosRTLExtended;
    procedure BenchmarkArcCosRTLDouble;
    procedure BenchmarkArcCosRTLSingle;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, FastcodeCPUID, SystemInfoUnit, ArcCosUnit, ArcCosJOHUnit, AboutUnit;

type
 TArcCosFunctionExtended = function (const X: Extended): Extended;
 TArcCosFunctionDouble = function (const X: Double): Double;
 TArcCosFunctionSingle = function (const X: Single): Single;

const
 MAXNOOFRUNS : Cardinal = 5000000;
 LIMITEXTENDEDPRECISION : Extended = 2.169E-19;
 LIMITDOUBLEPRECISION : Extended = 2.3E-16;
 LIMITSINGLEPRECISION : Extended = 2E-7;
 SCALE : Cardinal = 100;
 LIMITEXTENDEDPRECISIONRELAXED : Extended = 2E-17;
 LIMITDOUBLEPRECISIONRELAXED : Extended = 2E-14;
 LIMITSINGLEPRECISIONRELAXED : Extended = 2.7E-5;

var
 ArcCosFunctionExtended : TArcCosFunctionExtended;
 ArcCosFunctionDouble : TArcCosFunctionDouble;
 ArcCosFunctionSingle : TArcCosFunctionSingle;
 X1e, X2e, X3e, X4e, X5e, X6e, X7e, Y1e, Y2e, Y3e, Y4e, Y5e, Y6e, Y7e : Extended;/// sets of variables needed to secure a linesplit on P4 (7*10 = 70 byte > 64 = L1 cache line size)
 X1d, X2d, X3d, X4d, X5d, X6d, X7d, Y1d, Y2d, Y3d, Y4d, Y5d, Y6d, Y7d : Double;/// sets of variables needed to secure a linesplit on P4 (7*10 = 70 byte > 64 = L1 cache line size)
 X1s, X2s, X3s, X4s, X5s, X6s, X7s, Y1s, Y2s, Y3s, Y4s, Y5s, Y6s, Y7s : Single;/// sets of variables needed to secure a linesplit on P4 (7*10 = 70 byte > 64 = L1 cache line size)

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

procedure TMainForm.BenchmarkArcCosExtended;
var
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;
 FunctionName : AnsiString;

begin
 Update;
 X1e := -0.1;
 X2e := -0.2;
 X3e := -0.3;
 X4e := 0.4;
 X5e := 0.5;
 X6e := 0.6;
 X7e := 0.7;
 Y1e := 999999;
 Y2e := 999999;
 Y3e := 999999;
 Y4e := 999999;
 Y5e := 999999;
 Y6e := 999999;
 Y7e := 999999;
 RuntimeEdit.Text := 'Running';
 RuntimeEdit.Color := clBlue;
 Update;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   Y1e := ArcCosFunctionExtended(X1e);
   Y2e := ArcCosFunctionExtended(X2e);
   Y3e := ArcCosFunctionExtended(X3e);
   Y4e := ArcCosFunctionExtended(X4e);
   Y5e := ArcCosFunctionExtended(X5e);
   Y6e := ArcCosFunctionExtended(X6e);
   Y7e := ArcCosFunctionExtended(X7e);
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 ResultEdit.Text := FloatToStr((Y1e + Y2e + Y3e + Y4e + Y5e + Y6e + Y7e) / 7);
 RuntimeEdit.Text := FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0);
 RuntimeEdit.Color := clLime;
 FunctionName := FunctionSelectionExtendedRadioGroup.Items[FunctionSelectionExtendedRadioGroup.ItemIndex];
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0));
 Update;
end;

procedure TMainForm.BenchmarkArcCosRTLExtended;
var
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;
 FunctionName : AnsiString;

begin
 Update;
 X1e := -0.1;
 X2e := -0.2;
 X3e := -0.3;
 X4e := 0.4;
 X5e := 0.5;
 X6e := 0.6;
 X7e := 0.7;
 Y1e := 999999;
 Y2e := 999999;
 Y3e := 999999;
 Y4e := 999999;
 Y5e := 999999;
 Y6e := 999999;
 Y7e := 999999;
 RuntimeEdit.Text := 'Running';
 RuntimeEdit.Color := clBlue;
 Update;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   Y1e := ArcCos(X1e);
   Y2e := ArcCos(X2e);
   Y3e := ArcCos(X3e);
   Y4e := ArcCos(X4e);
   Y5e := ArcCos(X5e);
   Y6e := ArcCos(X6e);
   Y7e := ArcCos(X7e);
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 ResultEdit.Text := FloatToStr((Y1e + Y2e + Y3e + Y4e + Y5e + Y6e + Y7e) / 7);
 RuntimeEdit.Text := FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0);
 RuntimeEdit.Color := clLime;
 FunctionName := 'ArcCos_RTL_IA32_1';
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0));
 Update;
end;

procedure TMainForm.BenchmarkArcCosDouble;
var
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;
 FunctionName : AnsiString;

begin
 Update;
 X1d := -0.1;
 X2d := -0.2;
 X3d := -0.3;
 X4d := 0.4;
 X5d := 0.5;
 X6d := 0.6;
 X7d := 0.7;
 Y1d := 999999;
 Y2d := 999999;
 Y3d := 999999;
 Y4d := 999999;
 Y5d := 999999;
 Y6d := 999999;
 Y7d := 999999;
 RuntimeEdit.Text := 'Running';
 RuntimeEdit.Color := clBlue;
 Update;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   Y1d := ArcCosFunctionDouble(X1d);
   Y2d := ArcCosFunctionDouble(X2d);
   Y3d := ArcCosFunctionDouble(X3d);
   Y4d := ArcCosFunctionDouble(X4d);
   Y5d := ArcCosFunctionDouble(X5d);
   Y6d := ArcCosFunctionDouble(X6d);
   Y7d := ArcCosFunctionDouble(X7d);
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 * 60 * RunTime);
 ResultEdit.Text := FloatToStr((Y1d + Y2d + Y3d + Y4d + Y5d + Y6d + Y7d) / 7);
 RuntimeEdit.Text := FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0);
 RuntimeEdit.Color := clLime;
 FunctionName := FunctionSelectionDoubleRadioGroup.Items[FunctionSelectionDoubleRadioGroup.ItemIndex];
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0));
 Update;
end;

procedure TMainForm.BenchmarkArcCosRTLDouble;
var
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;
 FunctionName : AnsiString;

begin
 Update;
 X1d := -0.1;
 X2d := -0.2;
 X3d := -0.3;
 X4d := 0.4;
 X5d := 0.5;
 X6d := 0.6;
 X7d := 0.7;
 Y1d := 999999;
 Y2d := 999999;
 Y3d := 999999;
 Y4d := 999999;
 Y5d := 999999;
 Y6d := 999999;
 Y7d := 999999;
 RuntimeEdit.Text := 'Running';
 RuntimeEdit.Color := clBlue;
 Update;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   Y1d := ArcCos(X1d);
   Y2d := ArcCos(X2d);
   Y3d := ArcCos(X3d);
   Y4d := ArcCos(X4d);
   Y5d := ArcCos(X5d);
   Y6d := ArcCos(X6d);
   Y7d := ArcCos(X7d);
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 ResultEdit.Text := FloatToStr((Y1d + Y2d + Y3d + Y4d + Y5d + Y6d + Y7d) / 7);
 RuntimeEdit.Text := FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0);
 RuntimeEdit.Color := clLime;
 FunctionName := 'ArcCos_RTL_IA32_1';
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0));
 Update;
end;

procedure TMainForm.BenchmarkArcCosSingle;
var
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;
 FunctionName : AnsiString;

begin
 Update;
 X1s := -0.1;
 X2s := -0.2;
 X3s := -0.3;
 X4s := 0.4;
 X5s := 0.5;
 X6s := 0.6;
 X7s := 0.7;
 Y1s := 999999;
 Y2s := 999999;
 Y3s := 999999;
 Y4s := 999999;
 Y5s := 999999;
 Y6s := 999999;
 Y7s := 999999;
 RuntimeEdit.Text := 'Running';
 RuntimeEdit.Color := clBlue;
 Update;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   Y1s := ArcCosFunctionSingle(X1s);
   Y2s := ArcCosFunctionSingle(X2s);
   Y3s := ArcCosFunctionSingle(X3s);
   Y4s := ArcCosFunctionSingle(X4s);
   Y5s := ArcCosFunctionSingle(X5s);
   Y6s := ArcCosFunctionSingle(X6s);
   Y7s := ArcCosFunctionSingle(X7s);
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 ResultEdit.Text := FloatToStr((Y1s + Y2s + Y3s + Y4s + Y5s + Y6s + Y7s) / 7);
 RuntimeEdit.Text := FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0);
 RuntimeEdit.Color := clLime;
 FunctionName := FunctionSelectionSingleRadioGroup.Items[FunctionSelectionSingleRadioGroup.ItemIndex];
 ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0));
 Update;
end;

procedure TMainForm.BenchmarkArcCosRTLSingle;
var
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;
 FunctionName : AnsiString;

begin
 Update;
 X1s := -0.1;
 X2s := -0.2;
 X3s := -0.3;
 X4s := 0.4;
 X5s := 0.5;
 X6s := 0.6;
 X7s := 0.7;
 Y1s := 999999;
 Y2s := 999999;
 Y3s := 999999;
 Y4s := 999999;
 Y5s := 999999;
 Y6s := 999999;
 Y7s := 999999;
 RuntimeEdit.Text := 'Running';
 RuntimeEdit.Color := clBlue;
 Update;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   Y1s := ArcCos(X1s);
   Y2s := ArcCos(X2s);
   Y3s := ArcCos(X3s);
   Y4s := ArcCos(X4s);
   Y5s := ArcCos(X5s);
   Y6s := ArcCos(X6s);
   Y7s := ArcCos(X7s);
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 ResultEdit.Text := FloatToStr((Y1s + Y2s + Y3s + Y4s + Y5s + Y6s + Y7s) / 7);
 RuntimeEdit.Text := FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0);
 RuntimeEdit.Color := clLime;
 FunctionName := 'ArcCos_RTL_IA32_1';
 ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + FloatToStrF(RuntimeSec * SCALE, ffFixed, 9, 0));
 Update;
end;

procedure TMainForm.RunSingleButtonClick(Sender: TObject);
begin
 if FunctionSelectionSingleRadioGroup.ItemIndex = 0 then
  BenchmarkArcCosRTLSingle
 else
  BenchmarkArcCosSingle;
end;

procedure TMainForm.NoOfClocksPerRunEditClick(Sender: TObject);
begin
 RuntimeEdit.SelectAll;
 RuntimeEdit.CopyToClipboard;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 CpuString : string;

begin
 ArcCosFunctionExtended := ArcCos;
 ArcCosFunctionDouble := ArcCosDKC1;
 ArcCosFunctionSingle := ArcCosDKC1;
 RuntimeEdit.Text := '';
 ResultEdit.Text := '';
 MaxErrorEdit.Text := '';
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 100;
 ReportRichEdit.Paragraph.Tab[1] := 150;

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

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';
 Update;
 for I1 := 0 to FunctionSelectionSingleRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionSingleRadioGroup.ItemIndex := I1;
   if I1 = 0 then
    BenchmarkArcCosRTLSingle
   else
    BenchmarkArcCosSingle;
   SortRichEditFP;
   SortRichEdit1;
  end;
 for I2 := 0 to FunctionSelectionDoubleRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionDoubleRadioGroup.ItemIndex := I2;
   if I2 = 0 then
    BenchmarkArcCosRTLDouble
   else
    BenchmarkArcCosDouble;
   SortRichEditFP;
   SortRichEdit1;
  end;
 for I3 := 0 to FunctionSelectionExtendedRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionExtendedRadioGroup.ItemIndex := I3;
   if I3 = 0 then
    BenchmarkArcCosRTLExtended
   else
    BenchmarkArcCosExtended;
   SortRichEditFP;
   SortRichEdit1;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.ValidateExtendedPrecisionButtonClick(Sender: TObject);
begin
 ValidateExtended1;
 ValidateExtended2;
 ValidateExtended3;
end;

procedure TMainForm.ValidateExtended1;
var
 Xe, Ye : Extended;
 Yref, Error, AbsError, MaxAbsError : Extended;
 Passed : Boolean;
 FunctionName : AnsiString;
const
 STEPSIZE : Extended = 1E-3;

begin
 MaxAbsError := 0;
 MaxErrorEdit.Color := clBlue;
 ChartLeftAxisLabel.Caption := 'Error*1E19';
 Series1.Clear;
 Update;
 Xe := -1;
 Passed := True;
 repeat
  Yref := ArcCos(Xe);
  //Function to validate
  Ye := ArcCosFunctionExtended(Xe);
  Error := Yref - Ye;
  Series1.AddXY(Xe, Error*1E19, '', clRed);
  Update;
  AbsError := Abs(Error);
  if AbsError > MaxAbsError then
   MaxAbsError := AbsError;
  MaxErrorEdit.Text := FloatToStr(MaxAbsError);
  if AbsError > LIMITEXTENDEDPRECISION then
   begin
    Passed := False;
   end;
  Xe := Xe + STEPSIZE;
 until(Xe >= 1);
 FunctionName := FunctionSelectionExtendedRadioGroup.Items[FunctionSelectionExtendedRadioGroup.ItemIndex];
 if Passed then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Extended' + #9 + 'Passed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Extended' + #9 + 'Failed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end;
end;

procedure TMainForm.ValidateExtended2;
var
 Xe : Extended;
 Error, AbsError, MaxAbsError : Extended;
 Passed : Boolean;
 FunctionName : AnsiString;
const
 STEPSIZE : Extended = 1E-3;

begin
 MaxAbsError := 0;
 MaxErrorEdit.Color := clBlue;
 ChartLeftAxisLabel.Caption := 'Error*1E19';
 Series1.Clear;
 Update;
 Xe := -1;
 Passed := True;
 repeat
  Error := Xe + ArcCosFunctionExtended(Cos(Xe));
  Series1.AddXY(Xe, Error*1E19, '', clRed);
  Update;
  AbsError := Abs(Error);
  if AbsError > MaxAbsError then
   MaxAbsError := AbsError;
  MaxErrorEdit.Text := FloatToStr(MaxAbsError);
  if AbsError > LIMITEXTENDEDPRECISIONRELAXED then
   begin
    Passed := False;
   end;
  Xe := Xe + STEPSIZE;
 until(Xe >= 0);
 FunctionName := FunctionSelectionExtendedRadioGroup.Items[FunctionSelectionExtendedRadioGroup.ItemIndex];
 if Passed then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Extended' + #9 + 'Passed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Extended' + #9 + 'Failed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end;
end;

procedure TMainForm.ValidateExtended3;
var
 Xe, Ye : Extended;
 Yref, Error, AbsError, MaxAbsError : Extended;
 Passed : Boolean;
 FunctionName : AnsiString;
const
 STEPSIZE : Extended = 1E-3;

begin
 FunctionName := FunctionSelectionExtendedRadioGroup.Items[FunctionSelectionExtendedRadioGroup.ItemIndex];
 MaxAbsError := 0;
 Passed := True;
 Error := (Cos(ArcCosFunctionExtended(pi/4))*4) - pi;  //Should return 0.0
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITEXTENDEDPRECISION then
  begin
   Passed := False;
  end;
 Xe := 0;
 Ye := ArcCosFunctionExtended(Xe);
 Yref := PI/2;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITEXTENDEDPRECISION then
  begin
   Passed := False;
  end;
 Error := ArcCosFunctionExtended(1);
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITEXTENDEDPRECISION then
  begin
   Passed := False;
  end;
 Xe := 1;
 Ye := ArcCosFunctionExtended(Xe);
 Yref := 0;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITEXTENDEDPRECISION then
  begin
   Passed := False;
  end;
 Xe := -1;
 Ye := ArcCosFunctionExtended(Xe);
 Yref := PI;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITEXTENDEDPRECISION then
  begin
   Passed := False;
  end;
 Xe := 0.5;
 Ye := ArcCosFunctionExtended(Xe);
 Yref := PI/3;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITEXTENDEDPRECISION then
  begin
   Passed := False;
  end;
 Xe := -0.5;
 Ye := ArcCosFunctionExtended(Xe);
 Yref := 2*PI/3;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITEXTENDEDPRECISION then
  begin
   Passed := False;
  end;
 if Passed then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Extended' + #9 + 'Passed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Extended' + #9 + 'Failed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end;
end;

procedure TMainForm.ValidateDoublePrecisionButtonClick(Sender: TObject);
begin
 ValidateDouble1;
 ValidateDouble2;
 ValidateDouble3;
end;

procedure TMainForm.ValidateDouble1;
var
 Xe : Extended;
 Xd, Yd : Double;
 Yref, Error, AbsError, MaxAbsError : Extended;
 Passed : Boolean;
 FunctionName : AnsiString;
const
 STEPSIZE : Extended = 1E-3;

begin
 MaxAbsError := 0;
 MaxErrorEdit.Color := clBlue;
 ChartLeftAxisLabel.Caption := 'Error*1E15';
 Series1.Clear;
 Update;
 Xd := -1;
 Passed := True;
 repeat
  Xe := Xd;
  Yref := ArcCos(Xe);
  //Function to validate
  if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
   Yd := ArcCosFunctionDouble(Xd)
  else
   Yd := ArcCos(Xd);
  Error := Yref - Yd;
  Series1.AddXY(Xe, Error*1E15, '', clRed);
  Update;
  AbsError := Abs(Error);
  if AbsError > MaxAbsError then
   MaxAbsError := AbsError;
  MaxErrorEdit.Text := FloatToStr(MaxAbsError);
  if AbsError > LIMITDOUBLEPRECISION then
   Passed := False;
  Xd := Xd + STEPSIZE;
 until(Xd >= 1);
 FunctionName := FunctionSelectionDoubleRadioGroup.Items[FunctionSelectionDoubleRadioGroup.ItemIndex];
 if Passed then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Double' + #9 + 'Passed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Double' + #9 + 'Failed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end;
end;

procedure TMainForm.ValidateDouble2;
var
 Xe : Double;
 Error, AbsError, MaxAbsError : Extended;
 Passed : Boolean;
 FunctionName : AnsiString;
const
 STEPSIZE : Double = 1E-3;

begin
 MaxAbsError := 0;
 MaxErrorEdit.Color := clBlue;
 ChartLeftAxisLabel.Caption := 'Error*1E15';
 Series1.Clear;
 Update;
 Xe := -1;
 Passed := True;
 repeat
  Error := Xe + ArcCosFunctionDouble(Cos(Xe));
  Series1.AddXY(Xe, Error*1E15, '', clRed);
  Update;
  AbsError := Abs(Error);
  if AbsError > MaxAbsError then
   MaxAbsError := AbsError;
  MaxErrorEdit.Text := FloatToStr(MaxAbsError);
  if AbsError > LIMITDOUBLEPRECISIONRELAXED then
   begin
    Passed := False;
   end;
  Xe := Xe + STEPSIZE;
 until(Xe >= 0);
 FunctionName := FunctionSelectionDoubleRadioGroup.Items[FunctionSelectionDoubleRadioGroup.ItemIndex];
 if Passed then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Double' + #9 + 'Passed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Double' + #9 + 'Failed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end;
end;

procedure TMainForm.ValidateDouble3;
var
 Xe, Ye : Double;
 Yref, Error, AbsError, MaxAbsError : Extended;
 Passed : Boolean;
 FunctionName : AnsiString;
const
 STEPSIZE : Extended = 1E-3;

begin
 FunctionName := FunctionSelectionDoubleRadioGroup.Items[FunctionSelectionDoubleRadioGroup.ItemIndex];
 MaxAbsError := 0;
 Passed := True;
 Error := (Cos(ArcCosFunctionDouble(pi/4))*4) - pi;  //Should return 0.0
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITDOUBLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := 0;
 Ye := ArcCosFunctionDouble(Xe);
 Yref := PI/2;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITDOUBLEPRECISION then
  begin
   Passed := False;
  end;
 Error := ArcCosFunctionDouble(1);
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITDOUBLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := 1;
 Ye := ArcCosFunctionDouble(Xe);
 Yref := 0;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITDOUBLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := -1;
 Ye := ArcCosFunctionDouble(Xe);
 Yref := PI;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITDOUBLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := 0.5;
 Ye := ArcCosFunctionDouble(Xe);
 Yref := PI/3;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITDOUBLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := -0.5;
 Ye := ArcCosFunctionDouble(Xe);
 Yref := 2*PI/3;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITDOUBLEPRECISION then
  begin
   Passed := False;
  end;
 if Passed then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Double' + #9 + 'Passed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Double' + #9 + 'Failed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end;
end;

procedure TMainForm.ValidateSinglePrecisionButtonClick(Sender: TObject);
begin
 ValidateSingle1;
 ValidateSingle2;
 ValidateSingle3;
end;

procedure TMainForm.ValidateSingle1;
var
 Xe : Extended;
 Xs, Ys : Single;
 Yref, Error, AbsError, MaxAbsError : Extended;
 Passed : Boolean;
 FunctionName : AnsiString;
const
 STEPSIZE : Extended = 1E-3;

begin
 MaxAbsError := 0;
 MaxErrorEdit.Color := clBlue;
 ChartLeftAxisLabel.Caption := 'Error*1E7';
 Series1.Clear;
 Update;
 Xs := -1;
 Passed := True;
 repeat
  Xe := Xs;
  Yref := ArcCos(Xe);
  //Function to validate
  if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
   Ys := ArcCosFunctionSingle(Xs)
  else
   Ys := ArcCos(Xs);//Validates RTL against itself
  Error := Yref - Ys;
  Series1.AddXY(Xe, Error * 1E7, '', clRed);
  Update;
  AbsError := Abs(Error);
  if AbsError > LIMITSINGLEPRECISION then
   Passed := False;
  if AbsError > MaxAbsError then
   MaxAbsError := AbsError;
  MaxErrorEdit.Text := FloatToStr(MaxAbsError);
  Xs := Xs + STEPSIZE;
 until(Xs >= 1);
 FunctionName := FunctionSelectionSingleRadioGroup.Items[FunctionSelectionSingleRadioGroup.ItemIndex];
 if Passed then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + 'Passed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + 'Failed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end;
end;

procedure TMainForm.ValidateSingle2;
var
 Xe : Single;
 Error, AbsError, MaxAbsError : Extended;
 Passed : Boolean;
 FunctionName : AnsiString;
const
 STEPSIZE : Single = 1E-3;

begin
 MaxAbsError := 0;
 MaxErrorEdit.Color := clBlue;
 ChartLeftAxisLabel.Caption := 'Error*1E7';
 Series1.Clear;
 Update;
 Xe := -1;
 Passed := True;
 repeat
  Error := Xe + ArcCosFunctionSingle(Cos(Xe));
  Series1.AddXY(Xe, Error*1E7, '', clRed);
  Update;
  AbsError := Abs(Error);
  if AbsError > MaxAbsError then
   MaxAbsError := AbsError;
  MaxErrorEdit.Text := FloatToStr(MaxAbsError);
  if AbsError > LIMITSINGLEPRECISIONRELAXED then
   begin
    Passed := False;
   end;
  Xe := Xe + STEPSIZE;
 until(Xe >= 0);
 FunctionName := FunctionSelectionSingleRadioGroup.Items[FunctionSelectionSingleRadioGroup.ItemIndex];
 if Passed then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + 'Passed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + 'Failed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end;
end;

procedure TMainForm.ValidateSingle3;
var
 Xe, Ye : Single;
 Yref, Error, AbsError, MaxAbsError : Extended;
 Passed : Boolean;
 FunctionName : AnsiString;
const
 STEPSIZE : Single = 1E-3;

begin
 FunctionName := FunctionSelectionSingleRadioGroup.Items[FunctionSelectionSingleRadioGroup.ItemIndex];
 MaxAbsError := 0;
 Passed := True;
 Error := (Cos(ArcCosFunctionSingle(pi/4))*4) - pi;  //Should return 0.0
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITSINGLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := 0;
 Ye := ArcCosFunctionSingle(Xe);
 Yref := PI/2;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITSINGLEPRECISION then
  begin
   Passed := False;
  end;
 Error := ArcCosFunctionSingle(1);
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITSINGLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := 1;
 Ye := ArcCosFunctionSingle(Xe);
 Yref := 0;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITSINGLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := -1;
 Ye := ArcCosFunctionSingle(Xe);
 Yref := PI;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITSINGLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := 0.5;
 Ye := ArcCosFunctionSingle(Xe);
 Yref := PI/3;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITSINGLEPRECISION then
  begin
   Passed := False;
  end;
 Xe := -0.5;
 Ye := ArcCosFunctionSingle(Xe);
 Yref := 2*PI/3;
 Error := Yref - Ye;
 AbsError := Abs(Error);
 if AbsError > MaxAbsError then
  MaxAbsError := AbsError;
 MaxErrorEdit.Text := FloatToStr(MaxAbsError);
 if AbsError > LIMITSINGLEPRECISION then
  begin
   Passed := False;
  end;
 if Passed then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + 'Passed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + 'Failed' + #9 + 'MaxError : ' + FloatToStrF(MaxAbsError, ffExponent, 4, 4));
  end;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
 ErrorChart.CopyToClipboardBitmap;
end;

procedure TMainForm.FunctionSelectionSingleRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionSingleRadioGroup.ItemIndex+1 of
  //1 : ArcCosFunctionSingle := ArcCos;
  2 : ArcCosFunctionSingle := ArcCosNJ1;
  3 : ArcCosFunctionSingle := ArcCosDKC1;
  4 : ArcCosFunctionSingle := ArcCosJOH;
 end;
end;

procedure TMainForm.FunctionSelectionDoubleRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionDoubleRadioGroup.ItemIndex+1 of
  //1 : ArcCosFunctionDouble := ArcCos;
  2 : ArcCosFunctionDouble := ArcCosNJ1;
  3 : ArcCosFunctionDouble := ArcCosDKC1;
  4 : ArcCosFunctionDouble := ArcCosJOH;
 end;
end;

procedure TMainForm.FunctionSelectionExtendedRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionExtendedRadioGroup.ItemIndex+1 of
  1 : ArcCosFunctionExtended := ArcCos;
  2 : ArcCosFunctionExtended := ArcCosNJ1;
  3 : ArcCosFunctionExtended := ArcCosDKC1;
  4 : ArcCosFunctionExtended := ArcCosJOH;
 end;
end;

procedure TMainForm.RunDoubleButtonClick(Sender: TObject);
begin
 if FunctionSelectionDoubleRadioGroup.ItemIndex = 0 then
  BenchmarkArcCosRTLDouble
 else
  BenchmarkArcCosDouble;
end;

procedure TMainForm.RunExtendedButtonClick(Sender: TObject);
begin
 if FunctionSelectionExtendedRadioGroup.ItemIndex = 0 then
  BenchmarkArcCosRTLExtended
 else
  BenchmarkArcCosExtended;
end;

procedure TMainForm.SaveSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := FResultsFileName;
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 for I1 := 0 to FunctionSelectionSingleRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionSingleRadioGroup.ItemIndex := I1;
   ValidateSinglePrecisionButtonClick(nil);
  end;
 for I2 := 0 to FunctionSelectionDoubleRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionDoubleRadioGroup.ItemIndex := I2;
   ValidateDoublePrecisionButtonClick(nil);
  end;
 for I3 := 0 to FunctionSelectionExtendedRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionExtendedRadioGroup.ItemIndex := I3;
   ValidateExtendedPrecisionButtonClick(nil);
  end;
 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('ArcCos Report');
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
