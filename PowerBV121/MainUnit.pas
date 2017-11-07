unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, TeEngine, Series, ExtCtrls,
  TeeProcs, Chart;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'Power';

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
    BenchmarksAllButton: TButton;
    Label1: TLabel;
    ValidateDoublePrecisionButton: TButton;
    ValidateSinglePrecisionButton: TButton;
    FunctionSelectionSingleRadioGroup: TRadioGroup;
    FunctionSelectionDoubleRadioGroup: TRadioGroup;
    FunctionSelectionExtendedRadioGroup: TRadioGroup;
    RunDoubleButton: TButton;
    RunExtendedButton: TButton;
    ValidateAllButton: TButton;
    Panel1: TPanel;
    SaveSpeedButton: TSpeedButton;
    SaveDialog: TSaveDialog;
    RuntimeEdit: TEdit;
    DevelopExtendedButton: TButton;
    YEdit: TEdit;
    ClearButton: TButton;
    DevelopSingleButton: TButton;
    DevelopDoubleButton: TButton;
    DevelopIntPowerButton: TButton;
    Set8087PrecisionRadioGroup: TRadioGroup;
    SetRoundModeRadioGroup: TRadioGroup;
    AboutSpeedButton: TSpeedButton;
    procedure RunSingleButtonClick(Sender: TObject);
    procedure ValidateExtendedPrecisionButtonClick(Sender: TObject);
    procedure NoOfClocksPerRunEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BenchmarksAllButtonClick(Sender: TObject);
    procedure ValidateDoublePrecisionButtonClick(Sender: TObject);
    procedure ValidateSinglePrecisionButtonClick(Sender: TObject);
    procedure FunctionSelectionSingleRadioGroupClick(Sender: TObject);
    procedure FunctionSelectionDoubleRadioGroupClick(Sender: TObject);
    procedure FunctionSelectionExtendedRadioGroupClick(Sender: TObject);
    procedure RunDoubleButtonClick(Sender: TObject);
    procedure RunExtendedButtonClick(Sender: TObject);
    procedure SaveSpeedButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure DevelopExtendedButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure DevelopSingleButtonClick(Sender: TObject);
    procedure DevelopDoubleButtonClick(Sender: TObject);
    procedure DevelopIntPowerButtonClick(Sender: TObject);
    procedure Set8087PrecisionRadioGroupClick(Sender: TObject);
    procedure SetRoundModeRadioGroupClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
   procedure SortRichEdit1;
   procedure SortRichEditFP;
   procedure BenchmarkExtended;
   procedure BenchmarkDouble;
   procedure BenchmarkSingle;
   function SubBenchmark1RTLExtended : Cardinal;
   function SubBenchmark2RTLExtended : Cardinal;
   function SubBenchmark1Extended : Cardinal;
   function SubBenchmark2Extended : Cardinal;
   function SubBenchmark1RTLDouble : Cardinal;
   function SubBenchmark2RTLDouble : Cardinal;
   function SubBenchmark1Double : Cardinal;
   function SubBenchmark2Double : Cardinal;
   function SubBenchmark1RTLSingle : Cardinal;
   function SubBenchmark2RTLSingle : Cardinal;
   function SubBenchmark1Single : Cardinal;
   function SubBenchmark2Single : Cardinal;
   function ValidateSingle1 : Boolean;
   function ValidateSingle2 : Boolean;
   function ValidateSingle3 : Boolean;
   function ValidateSingle4 : Boolean;
   function ValidateSingle5 : Boolean;
   function ValidateSingle6 : Boolean;
   function ValidateDouble1 : Boolean;
   function ValidateDouble2 : Boolean;
   function ValidateDouble3 : Boolean;
   function ValidateDouble4 : Boolean;
   function ValidateDouble5 : Boolean;
   function ValidateDouble6 : Boolean;
   function ValidateExtended1 : Boolean;
   function ValidateExtended2 : Boolean;
   function ValidateExtended3 : Boolean;
   function ValidateExtended4 : Boolean;
   function ValidateExtended5 : Boolean;
   function ValidateExtended6 : Boolean;
  public
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 SystemInfoUnit, FastCodeCPUID, Math, PowerDKCUnit, PowerJOHUnit, AboutUnit;

type
 TPowerFunctionExtended = function (const Base, Exponent: Extended): Extended;
 TPowerFunctionDouble = function (const Base, Exponent: Double): Double;
 TPowerFunctionSingle = function (const Base, Exponent: Single): Single;

const
 MAXNOOFRUNS : Cardinal = 200000;
 LIMITEXTENDEDPRECISION : Extended = 1E-18;
 LIMITDOUBLEPRECISION : Extended = 1.2E-16;
 LIMITSINGLEPRECISION : Extended = 6E-8;
 SCALE : Cardinal = 100;

var
 PowerFunctionExtended : TPowerFunctionExtended;
 PowerFunctionDouble : TPowerFunctionDouble;
 PowerFunctionSingle : TPowerFunctionSingle;

 SubBench1BasesArraySingle : array of Single;
 SubBench1ExponentsArraySingle : array of Single;
 SubBench1ResultsArraySingle : array of Single;

 SubBench1BasesArrayDouble : array of Double;
 SubBench1ExponentsArrayDouble : array of Double;
 SubBench1ResultsArrayDouble : array of Double;

 SubBench1BasesArrayExtended : array of Extended;
 SubBench1ExponentsArrayExtended : array of Extended;
 SubBench1ResultsArrayExtended : array of Extended;

 SubBench2BasesArraySingle : array of Single;
 SubBench2ExponentsArraySingle : array of Single;
 SubBench2ResultsArraySingle : array of Single;

 SubBench2BasesArrayDouble : array of Double;
 SubBench2ExponentsArrayDouble : array of Double;
 SubBench2ResultsArrayDouble : array of Double;

 SubBench2BasesArrayExtended : array of Extended;
 SubBench2ExponentsArrayExtended : array of Extended;
 SubBench2ResultsArrayExtended : array of Extended;
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

procedure InitializeBenchArrays;
var
 I1, I2 : Integer;
const
 SIZEBENCHARRAY : Cardinal = 40;

begin
 SetLength(SubBench1BasesArraySingle, SIZEBENCHARRAY);
 SetLength(SubBench1ExponentsArraySingle, SIZEBENCHARRAY);
 SetLength(SubBench1ResultsArraySingle, SIZEBENCHARRAY);
 SetLength(SubBench1BasesArrayDouble, SIZEBENCHARRAY);
 SetLength(SubBench1ExponentsArrayDouble, SIZEBENCHARRAY);
 SetLength(SubBench1ResultsArrayDouble, SIZEBENCHARRAY);
 SetLength(SubBench1BasesArrayExtended, SIZEBENCHARRAY);
 SetLength(SubBench1ExponentsArrayExtended, SIZEBENCHARRAY);
 SetLength(SubBench1ResultsArrayExtended, SIZEBENCHARRAY);
 SetLength(SubBench2BasesArraySingle, SIZEBENCHARRAY);
 SetLength(SubBench2ExponentsArraySingle, SIZEBENCHARRAY);
 SetLength(SubBench2ResultsArraySingle, SIZEBENCHARRAY);
 SetLength(SubBench2BasesArrayDouble, SIZEBENCHARRAY);
 SetLength(SubBench2ExponentsArrayDouble, SIZEBENCHARRAY);
 SetLength(SubBench2ResultsArrayDouble, SIZEBENCHARRAY);
 SetLength(SubBench2BasesArrayExtended, SIZEBENCHARRAY);
 SetLength(SubBench2ExponentsArrayExtended, SIZEBENCHARRAY);
 SetLength(SubBench2ResultsArrayExtended, SIZEBENCHARRAY);

 //Benchmarking IntPower
 //Real bases
 //Integer exponents
 //Using small bases allows for greater range of exponents without overflow

 for I1 := 0 to SIZEBENCHARRAY-1 do
  begin
   SubBench1BasesArraySingle[I1] := 1.0001;
   SubBench1ExponentsArraySingle[I1] := Round(I1 - (SIZEBENCHARRAY-1)/2);

   SubBench1BasesArrayDouble[I1] := 1.0001;
   SubBench1ExponentsArrayDouble[I1] := Round(I1 - (SIZEBENCHARRAY-1)/2);

   SubBench1BasesArrayExtended[I1] := 1.0001;
   SubBench1ExponentsArrayExtended[I1] := Round(I1 - (SIZEBENCHARRAY-1)/2);
  end;

 //Benchmarking Power
 //Real bases and exponents
 //Using small bases allows for greater range of exponents without overflow

 for I2 := 0 to SIZEBENCHARRAY-1 do
  begin
   SubBench2BasesArraySingle[I2] := 1.0001;
   SubBench2ExponentsArraySingle[I2] := (I2*I2*I2 / 10) - (SIZEBENCHARRAY-1)/2;

   SubBench2BasesArrayDouble[I2] := 1.0001;
   SubBench2ExponentsArrayDouble[I2] := (I2*I2*I2 / 10) - (SIZEBENCHARRAY-1)/2;

   SubBench2BasesArrayExtended[I2] := 1.0001;
   SubBench2ExponentsArrayExtended[I2] := (I2*I2*I2 / 10) - (SIZEBENCHARRAY-1)/2;
  end;
end;

function TMainForm.SubBenchmark2RTLExtended : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench1BasesArrayExtended);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench2ResultsArrayExtended[I] := Power(SubBench2BasesArrayExtended[I],
                                               SubBench2ExponentsArrayExtended[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark1RTLExtended : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench1BasesArrayExtended);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench1ResultsArrayExtended[I] := Power(SubBench1BasesArrayExtended[I],
                                               SubBench1ExponentsArrayExtended[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark1RTLDouble : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench1BasesArrayDouble);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench1ResultsArrayDouble[I] := Power(SubBench1BasesArrayDouble[I],
                                             SubBench1ExponentsArrayDouble[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 * 60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark2RTLDouble : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench2BasesArrayDouble);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench2ResultsArrayDouble[I] := Power(SubBench2BasesArrayDouble[I],
                                             SubBench2ExponentsArrayDouble[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 * 60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark1RTLSingle : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench1BasesArraySingle);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench1ResultsArraySingle[I] := Power(SubBench1BasesArraySingle[I],
                                             SubBench1ExponentsArraySingle[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark2RTLSingle : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench2BasesArraySingle);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench2ResultsArraySingle[I] := Power(SubBench2BasesArraySingle[I],
                                             SubBench2ExponentsArraySingle[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark2Extended : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench1BasesArrayExtended);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench2ResultsArrayExtended[I] := PowerFunctionExtended(SubBench2BasesArrayExtended[I],
                                                               SubBench2ExponentsArrayExtended[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark1Extended : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench1BasesArrayExtended);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench1ResultsArrayExtended[I] := PowerFunctionExtended(SubBench1BasesArrayExtended[I],
                                                               SubBench1ExponentsArrayExtended[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark1Double : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench1BasesArrayDouble);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench1ResultsArrayDouble[I] := PowerFunctionDouble(SubBench1BasesArrayDouble[I],
                                                           SubBench1ExponentsArrayDouble[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 * 60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark2Double : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench2BasesArrayDouble);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench2ResultsArrayDouble[I] := PowerFunctionDouble(SubBench2BasesArrayDouble[I],
                                                           SubBench2ExponentsArrayDouble[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 * 60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark1Single : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench1BasesArraySingle);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench1ResultsArraySingle[I] := PowerFunctionSingle(SubBench1BasesArraySingle[I],
                                                           SubBench1ExponentsArraySingle[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

function TMainForm.SubBenchmark2Single : Cardinal;
var
 RunNo, I, IMax : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 IMax := Length(SubBench2BasesArraySingle);
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNS do
  begin
   for I := 0 to IMax-1 do
    begin
     SubBench2ResultsArraySingle[I] := PowerFunctionSingle(SubBench2BasesArraySingle[I],
                                                           SubBench2ExponentsArraySingle[I]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 *60 * RunTime);
 Result := Round(RuntimeSec * SCALE);
end;

procedure TMainForm.RunSingleButtonClick(Sender: TObject);
begin
 BenchmarkSingle;
end;

procedure TMainForm.BenchmarkSingle;
var
 SubBench1, Subbench2, Bench : Cardinal;
 FunctionName : AnsiString;

begin
 RuntimeEdit.Text := 'Running';
 RuntimeEdit.Color := clBlue;
 Update;
 if FunctionSelectionSingleRadioGroup.ItemIndex = 0 then
  begin
   SubBench1 := SubBenchmark1RTLSingle;
   SubBench2 := SubBenchmark2RTLSingle;
  end
 else
  begin
   SubBench1 := SubBenchmark1Single;
   SubBench2 := SubBenchmark2Single;
  end;
 Bench := SubBench1 + SubBench2;
 RuntimeEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 RuntimeEdit.Color := clLime;
 FunctionName := FunctionSelectionSingleRadioGroup.Items[FunctionSelectionSingleRadioGroup.ItemIndex];
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + IntToStr(SubBench1)
                                                       + #9 + IntToStr(SubBench2)
                                                       + #9 + IntToStr(Bench));
 SortRichEditFP;
 SortRichEdit1;
 Update;
end;

procedure TMainForm.NoOfClocksPerRunEditClick(Sender: TObject);
begin
 RuntimeEdit.SelectAll;
 RuntimeEdit.CopyToClipboard;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var  CpuString : string;
begin
 InitializeBenchArrays;
 PowerFunctionExtended := Power_DKC_Pas_4;
 PowerFunctionDouble := Power_DKC_Pas_4;
 PowerFunctionSingle := Power_DKC_Pas_4;
 RuntimeEdit.Text := '';
 ResultEdit.Text := '';
 MaxErrorEdit.Text := '';
 Yedit.Text := '';
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 100;
 ReportRichEdit.Paragraph.Tab[1] := 140;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 200;
 FunctionSelectionSingleRadioGroupClick(nil);
 FunctionSelectionDoubleRadioGroupClick(nil);
 FunctionSelectionExtendedRadioGroupClick(nil);

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

function TMainForm.ValidateSingle1 : Boolean;
var
 X,Y,Z : Single;

begin
 Result := True;
 X := 0;
 Z := 0;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 0;
 Z := 1;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1.000000000001;
 Z := -MaxInt;
 Z := Z-1;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y-1) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 0;
 Z := MaxInt;
 Z := Z+1;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1.000000000001;
 Z := MaxInt;
 Z := Z+1;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Z := 1;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y + 1) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Z := -1;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Z := -1;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y + 1) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1.000000000001;
 Z := MaxInt;
 Z := Z-0.1;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITSINGLEPRECISION then
  begin
   Result := False;
  end;
 X := -1;
 Z := 0;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Z := 0;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITSINGLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
end;

function TMainForm.ValidateDouble1 : Boolean;
var
 X,Y,Z : Double;

begin
 Result := True;
 X := 0;
 Z := 0;
 if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionDouble(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 0;
 Z := 1;
 if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionDouble(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1.000000000001;
 Z := -MaxInt;
 Z := Z-1;
 if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionDouble(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y-0.997854630042322332) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 0;
 Z := MaxInt;
 Z := Z+1;
 if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionDouble(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1.000000000001;
 Z := MaxInt;
 Z := Z+1;
 if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionDouble(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1.00214998246546871) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Z := 1;
 if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionDouble(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y + 1) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Z := -1;
 if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionDouble(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Z := -1;
 if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionDouble(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y + 1) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1.000000000001;
 Z := MaxInt;
 Z := Z-0.1;
 if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionDouble(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1.00214998246436626) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
  end;
 X := -1;
 Z := 0;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Z := 0;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITDOUBLEPRECISION then
  begin
   Result := False;
   Exit;
  end;
end;

function TMainForm.ValidateExtended1 : Boolean;
var
 X,Y,Z : Extended;

begin
 Result := True;
 X := 0;
 Z := 0;
 if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionExtended(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 0;
 Z := 1;
 if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionExtended(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1.000000000001;
 Z := -MaxInt;
 Z := Z-1;
 if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionExtended(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y-0.997854820553871851) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 0;
 Z := MaxInt;
 Z := Z+1;
 if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionExtended(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1.000000000001;
 Z := MaxInt;
 Z := Z+1;
 if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionExtended(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1.002149791133882021) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Z := 1;
 if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionExtended(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y + 1) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Z := -1;
 if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionExtended(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Z := -1;
 if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionExtended(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y + 1) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1.000000000001;
 Z := MaxInt;
 Z := Z-0.1;
 if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionExtended(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1.002149791132779656) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
  end;
 X := -1;
 Z := 0;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Z := 0;
 if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
  Y := PowerFunctionSingle(X,Z)
 else
  Y := Power(X,Z);
 if Abs(Y - 1) > LIMITEXTENDEDPRECISION then
  begin
   Result := False;
   Exit;
  end;
end;

procedure TMainForm.BenchmarksAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 BenchmarksAllButton.Caption := 'Running';
 Update;
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
 for I1 := 0 to FunctionSelectionSingleRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionSingleRadioGroup.ItemIndex := I1;
   BenchmarkSingle;
  end;
 for I2 := 0 to FunctionSelectionDoubleRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionDoubleRadioGroup.ItemIndex := I2;
   BenchmarkDouble;
  end;
 for I3 := 0 to FunctionSelectionExtendedRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionExtendedRadioGroup.ItemIndex := I3;
   BenchmarkExtended;
  end;

 BenchmarksAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.ValidateExtendedPrecisionButtonClick(Sender: TObject);
var
 FunctionName : AnsiString;

begin
 MaxErrorEdit.Color := clBlue;
 FunctionName := FunctionSelectionExtendedRadioGroup.Items[FunctionSelectionExtendedRadioGroup.ItemIndex];
 if ValidateExtended1 and
    ValidateExtended2 and
    ValidateExtended3 and
    ValidateExtended4 and
    ValidateExtended5 and
    ValidateExtended6 then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Extended' + #9 + 'Passed');
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Extended' + #9 + 'Failed');
  end;
end;

function TMainForm.ValidateExtended2 : Boolean;
var
 Xe, Ze, Xmin, Zmin, Xmax, Zmax : Extended;
 Ye : Extended;
 Yref, Error, RelError, AbsRelError, MaxAbsRelError : Extended;
const
 STEPSIZE : Extended = 1.1;

begin
 Xmax := 1E2;
 Zmax := 1E2;
 Xmin := 1E-32;
 Zmin := 1E-32;
 MaxAbsRelError := 0;
 MaxErrorEdit.Color := clBlue;
 Update;
 Ze := Zmin;
 Result := True;
 repeat
  Xe := Xmin;
  repeat
   Yref := Power(Xe,Ze);
   //Function to validate
   if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
    Ye := PowerFunctionExtended(Xe,Ze)
   else
    Ye := Power(Xe,Ze);
   Error := Yref - Ye;
   if Yref <> 0 then
    RelError := Error / Yref
   else
    RelError := 999E99;
   AbsRelError := Abs(RelError);
   if AbsRelError > LIMITEXTENDEDPRECISION then
    begin
     Result := False;
     Exit;
    end;
   if AbsRelError > MaxAbsRelError then
    MaxAbsRelError := AbsRelError;
   MaxErrorEdit.Text := FloatToStr(MaxAbsRelError);
   Update;
   Xe := Xe * STEPSIZE;
  until(Xe >= Xmax);
  Ze := Ze * STEPSIZE;
 until(Ze >= Zmax);
end;

function TMainForm.ValidateExtended3 : Boolean;
var
 I1, I2 : Integer;
 X, Y1, Y2, Z : Extended;

begin
 Result := True;
 for I1 := 0 to 15 do
  begin
   for I2 := 0 to 15 do
    begin
     X := I1;
     Z := I2;
     if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
      Y1 := PowerFunctionExtended(X,Z)
     else
      Y1 := Power(X,Z);
     Y2 := Power(X,Z);
     if Abs(Y1 - Y2) > LIMITEXTENDEDPRECISION then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.ValidateExtended4 : Boolean;
var
 I1, I2 : Integer;
 X, Y1, Y2, Z : Extended;

begin
 Result := True;
 for I1 := -1 downto -15 do
  begin
   for I2 := -1 downto -15 do
    begin
     X := I1;
     Z := I2;
     if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
      Y1 := PowerFunctionExtended(X,Z)
     else
      Y1 := Power(X,Z);
     Y2 := Power(X,Z);
     if Abs(Y1 - Y2) > LIMITEXTENDEDPRECISION then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.ValidateExtended5 : Boolean;
var
 Xe, Ze, Xmin, Zmin, Xmax, Zmax : Extended;
 Ye : Extended;
 Yref, Error, RelError, AbsRelError, MaxAbsRelError : Extended;
const
 STEPSIZE : Extended = 1.2;

begin
 Xmax := 1E2854;
 Zmax := 2;
 Xmin := 1;
 Zmin := 1;
 MaxAbsRelError := 0;
 MaxErrorEdit.Color := clBlue;
 Update;
 Ze := Zmin;
 Result := True;
 repeat
  Xe := Xmin;
  repeat
   Yref := Power(Xe,Ze);
   //Function to validate
   if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
    Ye := PowerFunctionExtended(Xe,Ze)
   else
    Ye := Power(Xe,Ze);
   Error := Yref - Ye;
   if Yref <> 0 then
    RelError := Error / Yref
   else
    RelError := 999E99;
   AbsRelError := Abs(RelError);
   if AbsRelError > LIMITEXTENDEDPRECISION then
    begin
     Result := False;
     Exit;
    end;
   if AbsRelError > MaxAbsRelError then
    MaxAbsRelError := AbsRelError;
   MaxErrorEdit.Text := FloatToStr(MaxAbsRelError);
   Update;
   Xe := Xe * STEPSIZE;
  until(Xe >= Xmax);
  Ze := Ze * STEPSIZE;
 until(Ze >= Zmax);
end;

function TMainForm.ValidateExtended6 : Boolean;
var
 Xe, Ze, Xmin, Zmin, Xmax, Zmax : Extended;
 Ye : Extended;
 Yref, Error, RelError, AbsRelError, MaxAbsRelError : Extended;
const
 STEPSIZE : Extended = 1.1;

begin
 Xmax := 2;
 Zmax := 1E4;
 Xmin := 1;
 Zmin := 1;
 MaxAbsRelError := 0;
 MaxErrorEdit.Color := clBlue;
 Update;
 Ze := Zmin;
 Result := True;
 repeat
  Xe := Xmin;
  repeat
   Yref := Power(Xe,Ze);
   //Function to validate
   if FunctionSelectionExtendedRadioGroup.ItemIndex <> 0 then
    Ye := PowerFunctionExtended(Xe,Ze)
   else
    Ye := Power(Xe,Ze);
   Error := Yref - Ye;
   if Yref <> 0 then
    RelError := Error / Yref
   else
    RelError := 999E99;
   AbsRelError := Abs(RelError);
   if AbsRelError > LIMITEXTENDEDPRECISION then
    begin
     Result := False;
     Exit;
    end;
   if AbsRelError > MaxAbsRelError then
    MaxAbsRelError := AbsRelError;
   MaxErrorEdit.Text := FloatToStr(MaxAbsRelError);
   Update;
   Xe := Xe * STEPSIZE;
  until(Xe >= Xmax);
  Ze := Ze * STEPSIZE;
 until(Ze >= Zmax);
end;

procedure TMainForm.ValidateDoublePrecisionButtonClick(Sender: TObject);
var
 FunctionName : AnsiString;

begin
 MaxErrorEdit.Color := clBlue;
 FunctionName := FunctionSelectionDoubleRadioGroup.Items[FunctionSelectionDoubleRadioGroup.ItemIndex];
 if ValidateDouble1 and
    ValidateDouble2 and
    ValidateDouble3 and
    ValidateDouble4 and
    ValidateDouble5 and
    ValidateDouble6 then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Double' + #9 + 'Passed');
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Double' + #9 + 'Failed');
  end;
end;

function TMainForm.ValidateDouble2 : Boolean;
var
 Xe, Ze, Xmin, Zmin, Xmax, Zmax : Extended;
 Xd, Yd, Zd : Double;
 Yref, Error, RelError, AbsRelError, MaxAbsRelError : Extended;
const
 STEPSIZE : Extended = 1.1;

begin
 Xmax := 1E2;
 Zmax := 1E2;
 Xmin := 1E-3;
 Zmin := 1E-3;
 MaxAbsRelError := 0;
 MaxErrorEdit.Color := clBlue;
 Update;
 Zd := Zmin;
 Result := True;
 repeat
  Xd := Xmin;
  repeat
   Xe := Xd;
   Ze := Zd;
   Yref := Power(Xe,Ze);
   //Function to validate
   if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
    Yd := PowerFunctionDouble(Xd,Zd)
   else
    Yd := Power(Xd,Zd);
   Error := Yref - Yd;
   if Yref <> 0 then
    RelError := Error / Yref
   else
    RelError := 9999E99;
   AbsRelError := Abs(RelError);
   if AbsRelError > LIMITDOUBLEPRECISION then
    begin
     Result := False;
     Exit;
    end;
   if AbsRelError > MaxAbsRelError then
    MaxAbsRelError := AbsRelError;
   MaxErrorEdit.Text := FloatToStr(MaxAbsRelError);
   Update;
   Xd := Xd * STEPSIZE;
  until(Xd >= Xmax);
  Zd := Zd * STEPSIZE;
 until(Zd >= Zmax);
end;

function TMainForm.ValidateDouble3 : Boolean;
var
 I1, I2 : Integer;
 X, Y1, Y2, Z : Double;

begin
 Result := True;
 for I1 := 0 to 15 do
  begin
   for I2 := 0 to 15 do
    begin
     X := I1;
     Z := I2;
     if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
      Y1 := PowerFunctionDouble(X,Z)
     else
      Y1 := Power(X,Z);
     Y2 := Power(X,Z);
     if Abs(Y1 - Y2) > LIMITDoublePRECISION then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.ValidateDouble4 : Boolean;
var
 I1, I2 : Integer;
 X, Y1, Y2, Z : Double;

begin
 Result := True;
 for I1 := -1 downto -15 do
  begin
   for I2 := -1 downto -15 do
    begin
     X := I1;
     Z := I2;
     if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
      Y1 := PowerFunctionDouble(X,Z)
     else
      Y1 := Power(X,Z);
     Y2 := Power(X,Z);
     if Abs(Y1 - Y2) > LIMITDoublePRECISION then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.ValidateDouble5 : Boolean;
var
 Xe, Ze, Xmin, Zmin, Xmax, Zmax : Extended;
 Xd, Yd, Zd : Double;
 Yref, Error, RelError, AbsRelError, MaxAbsRelError : Extended;
const
 STEPSIZE : Extended = 1.05;

begin
 Xmax := 4E155;
 Zmax := 2;
 Xmin := 1;
 Zmin := 1;
 MaxAbsRelError := 0;
 MaxErrorEdit.Color := clBlue;
 Update;
 Zd := Zmin;
 Result := True;
 repeat
  Xd := Xmin;
  repeat
   Xe := Xd;
   Ze := Zd;
   Yref := Power(Xe,Ze);
   //Function to validate
   if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
    Yd := PowerFunctionDouble(Xd,Zd)
   else
    Yd := Power(Xd,Zd);
   Error := Yref - Yd;
   if Yref <> 0 then
    RelError := Error / Yref
   else
    RelError := 9999E99;
   AbsRelError := Abs(RelError);
   if AbsRelError > LIMITDOUBLEPRECISION then
    begin
     Result := False;
     Exit;
    end;
   if AbsRelError > MaxAbsRelError then
    MaxAbsRelError := AbsRelError;
   MaxErrorEdit.Text := FloatToStr(MaxAbsRelError);
   Update;
   Xd := Xd * STEPSIZE;
  until(Xd >= Xmax);
  Zd := Zd * STEPSIZE;
 until(Zd >= Zmax);
end;

function TMainForm.ValidateDouble6 : Boolean;
var
 Xe, Ze, Xmin, Zmin, Xmax, Zmax : Extended;
 Xd, Yd, Zd : Double;
 Yref, Error, RelError, AbsRelError, MaxAbsRelError : Extended;
const
 STEPSIZE : Extended = 1.01;

begin
 Xmax := 2;
 Zmax := 1E3;
 Xmin := 1;
 Zmin := 1;
 MaxAbsRelError := 0;
 MaxErrorEdit.Color := clBlue;
 Update;
 Zd := Zmin;
 Result := True;
 repeat
  Xd := Xmin;
  repeat
   Xe := Xd;
   Ze := Zd;
   Yref := Power(Xe,Ze);
   //Function to validate
   if FunctionSelectionDoubleRadioGroup.ItemIndex <> 0 then
    Yd := PowerFunctionDouble(Xd,Zd)
   else
    Yd := Power(Xd,Zd);
   Error := Yref - Yd;
   if Yref <> 0 then
    RelError := Error / Yref
   else
    RelError := 9999E99;
   AbsRelError := Abs(RelError);
   if AbsRelError > LIMITDOUBLEPRECISION then
    begin
     Result := False;
     Exit;
    end;
   if AbsRelError > MaxAbsRelError then
    MaxAbsRelError := AbsRelError;
   MaxErrorEdit.Text := FloatToStr(MaxAbsRelError);
   Update;
   Xd := Xd * STEPSIZE;
  until(Xd >= Xmax);
  Zd := Zd * STEPSIZE;
 until(Zd >= Zmax);
end;

function TMainForm.ValidateSingle2 : Boolean;
var
 Xe, Ze, Xmin, Zmin, Xmax, Zmax : Extended;
 Xs, Ys, Zs : Single;
 Yref, Error, RelError, AbsRelError, MaxAbsRelError : Extended;
const
 STEPSIZE : Extended = 1.1;

begin
 Xmax := 1E1;
 Zmax := 1E1;
 Xmin := 1E-3;
 Zmin := 1E-3;
 MaxAbsRelError := 0;
 Zs := Zmin;
 Result := True;
 repeat
  Xs := Xmin;
  repeat
   Xe := Xs;
   Ze := Zs;
   Yref := Power(Xe,Ze);
   //Function to validate
   if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
    Ys := PowerFunctionSingle(Xs,Zs)
   else
    Ys := Power(Xs,Zs);
   Error := Yref - Ys;
   RelError := Error / Yref;
   AbsRelError := Abs(RelError);
   if AbsRelError > LIMITSINGLEPRECISION then
    begin
     Result := False;
     Exit;
    end;
   if AbsRelError > MaxAbsRelError then
    MaxAbsRelError := AbsRelError;
   MaxErrorEdit.Text := FloatToStr(MaxAbsRelError);
   Update;
   Xs := Xs * STEPSIZE;
  until(Xs >= Xmax);
  Zs := Zs * STEPSIZE;
 until(Zs >= Zmax);
end;

function TMainForm.ValidateSingle3 : Boolean;
var
 I1, I2 : Integer;
 X, Y1, Y2, Z : Single;

begin
 Result := True;
 for I1 := 0 to 15 do
  begin
   for I2 := 0 to 15 do
    begin
     X := I1;
     Z := I2;
     if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
      Y1 := PowerFunctionSingle(X,Z)
     else
      Y1 := Power(X,Z);
     Y2 := Power(X,Z);
     if Abs(Y1 - Y2) > LIMITSinglePRECISION then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.ValidateSingle4 : Boolean;
var
 I1, I2 : Integer;
 X, Y1, Y2, Z : Single;

begin
 Result := True;
 for I1 := -1 downto -15 do
  begin
   for I2 := -1 downto -15 do
    begin
     X := I1;
     Z := I2;
     if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
      Y1 := PowerFunctionSingle(X,Z)
     else
      Y1 := Power(X,Z);
     Y2 := Power(X,Z);
     if Abs(Y1 - Y2) > LIMITSINGLEPRECISION then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.ValidateSingle5 : Boolean;
var
 Xe, Ze, Xmin, Zmin, Xmax, Zmax : Extended;
 Xs, Ys, Zs : Single;
 Yref, Error, RelError, AbsRelError, MaxAbsRelError : Extended;
const
 STEPSIZE : Extended = 1.01;

begin
 Xmax := 2E19;
 Zmax := 2;
 Xmin := 1;
 Zmin := 1;
 MaxAbsRelError := 0;
 Zs := Zmin;
 Result := True;
 repeat
  Xs := Xmin;
  repeat
   Xe := Xs;
   Ze := Zs;
   Yref := Power(Xe,Ze);
   //Function to validate
   if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
    Ys := PowerFunctionSingle(Xs,Zs)
   else
    Ys := Power(Xs,Zs);
   Error := Yref - Ys;
   RelError := Error / Yref;
   AbsRelError := Abs(RelError);
   if AbsRelError > LIMITSINGLEPRECISION then
    begin
     Result := False;
     Exit;
    end;
   if AbsRelError > MaxAbsRelError then
    MaxAbsRelError := AbsRelError;
   MaxErrorEdit.Text := FloatToStr(MaxAbsRelError);
   Update;
   Xs := Xs * STEPSIZE;
  until(Xs >= Xmax);
  Zs := Zs * STEPSIZE;
 until(Zs >= Zmax);
end;

function TMainForm.ValidateSingle6 : Boolean;
var
 Xe, Ze, Xmin, Zmin, Xmax, Zmax : Extended;
 Xs, Ys, Zs : Single;
 Yref, Error, RelError, AbsRelError, MaxAbsRelError : Extended;
const
 STEPSIZE : Extended = 1.01;

begin
 Xmax := 2;
 Zmax := 1E2;
 Xmin := 1;
 Zmin := 1;
 MaxAbsRelError := 0;
 Zs := Zmin;
 Result := True;
 repeat
  Xs := Xmin;
  repeat
   Xe := Xs;
   Ze := Zs;
   Yref := Power(Xe,Ze);
   //Function to validate
   if FunctionSelectionSingleRadioGroup.ItemIndex <> 0 then
    Ys := PowerFunctionSingle(Xs,Zs)
   else
    Ys := Power(Xs,Zs);
   Error := Yref - Ys;
   RelError := Error / Yref;
   AbsRelError := Abs(RelError);
   if AbsRelError > LIMITSINGLEPRECISION then
    begin
     Result := False;
     Exit;
    end;
   if AbsRelError > MaxAbsRelError then
    MaxAbsRelError := AbsRelError;
   MaxErrorEdit.Text := FloatToStr(MaxAbsRelError);
   Update;
   Xs := Xs * STEPSIZE;
  until(Xs >= Xmax);
  Zs := Zs * STEPSIZE;
 until(Zs >= Zmax);
end;

procedure TMainForm.ValidateSinglePrecisionButtonClick(Sender: TObject);
var
 FunctionName : AnsiString;

begin
 MaxErrorEdit.Color := clBlue;
 FunctionName := FunctionSelectionSingleRadioGroup.Items[FunctionSelectionSingleRadioGroup.ItemIndex];
 if ValidateSingle1 and
    ValidateSingle2 and
    ValidateSingle3 and
    ValidateSingle4 and
    ValidateSingle5 and
    ValidateSingle6 then
  begin
   MaxErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + 'Passed');
  end
 else
  begin
   MaxErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName +#9 + 'Single' + #9 + 'Failed');
  end;
end;

procedure TMainForm.FunctionSelectionSingleRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionSingleRadioGroup.ItemIndex+1 of
  1 :; //PowerFunctionSingle := Power;
  2 :  PowerFunctionSingle := Power_DKC_Pas_1;
  3 :  PowerFunctionSingle := Power_DKC_Pas_4;
  4 :  PowerFunctionSingle := Power_DKC_IA32_1;
  5 :  PowerFunctionSingle := Power_DKC_IA32_2;
  6 :  PowerFunctionSingle := Power_DKC_IA32_3;
  7 :  PowerFunctionSingle := Power_DKC_IA32Ext_2;
  8 :  PowerFunctionSingle := Power_DKC_IA32Ext_3;
  9 :  PowerFunctionSingle := Power_DKC_IA32Ext_4;
  10 :  PowerFunctionSingle := Power_DKC_IA32Ext_5;
  11 :  PowerFunctionSingle := Power_DKC_SSE_1;
  12 : PowerFunctionSingle := Power_DKC_SSE_2;
  13 : PowerFunctionSingle := Power_JOH_IA32_1;
 else
  raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.FunctionSelectionDoubleRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionDoubleRadioGroup.ItemIndex+1 of
  1 :;// PowerFunctionDouble := Power;
  2 : PowerFunctionDouble := Power_DKC_Pas_1;
  3 : PowerFunctionDouble := Power_DKC_Pas_4;
  4 : PowerFunctionDouble := Power_DKC_IA32_1;
  5 : PowerFunctionDouble := Power_DKC_IA32_2;
  6 : PowerFunctionDouble := Power_DKC_IA32_3;
  7 : PowerFunctionDouble := Power_DKC_IA32Ext_2;
  8 : PowerFunctionDouble := Power_DKC_IA32Ext_3;
  9 : PowerFunctionDouble := Power_DKC_IA32Ext_4;
  10 : PowerFunctionDouble := Power_DKC_IA32Ext_5;
  11 : PowerFunctionDouble := Power_DKC_SSE2_1;
  12 : PowerFunctionDouble := Power_DKC_SSE2_2;
  13 : PowerFunctionDouble := Power_JOH_IA32_1;
 else
  raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.FunctionSelectionExtendedRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionExtendedRadioGroup.ItemIndex+1 of
  1 : PowerFunctionExtended := Power;
  2 : PowerFunctionExtended := Power_DKC_Pas_1;
  3 : PowerFunctionExtended := Power_DKC_Pas_4;
  4 : PowerFunctionExtended := Power_DKC_IA32_1;
  5 : PowerFunctionExtended := Power_DKC_IA32_2;
  6 : PowerFunctionExtended := Power_DKC_IA32_3;
  7 : PowerFunctionExtended := Power_DKC_IA32Ext_2;
  8 : PowerFunctionExtended := Power_DKC_IA32Ext_3;
  9 : PowerFunctionExtended := Power_DKC_IA32Ext_4;
  10 : PowerFunctionExtended := Power_DKC_IA32Ext_5;
  11 : PowerFunctionExtended := Power_JOH_IA32_1;
 else
  raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.RunDoubleButtonClick(Sender: TObject);
begin
 BenchmarkDouble;
end;

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
end;

procedure TMainForm.BenchmarkDouble;
var
 SubBench1, Subbench2, Bench : Cardinal;
 FunctionName : AnsiString;

begin
 RuntimeEdit.Text := 'Running';
 RuntimeEdit.Color := clBlue;
 Update;
 if FunctionSelectionDoubleRadioGroup.ItemIndex = 0 then
  begin
   SubBench1 := SubBenchmark1RTLDouble;
   SubBench2 := SubBenchmark2RTLDouble;
  end
 else
  begin
   SubBench1 := SubBenchmark1Double;
   SubBench2 := SubBenchmark2Double;
  end;
 Bench := SubBench1 + SubBench2;
 RuntimeEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 RuntimeEdit.Color := clLime;
 FunctionName := FunctionSelectionDoubleRadioGroup.Items[FunctionSelectionDoubleRadioGroup.ItemIndex];
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + IntToStr(SubBench1)
                                                         + #9 + IntToStr(SubBench2)
                                                         + #9 + IntToStr(Bench));
 SortRichEditFP;
 SortRichEdit1;
 Update;
end;

procedure TMainForm.RunExtendedButtonClick(Sender: TObject);
begin
 BenchmarkExtended;
end;

procedure TMainForm.BenchmarkExtended;
var
 SubBench1, Subbench2, Bench : Cardinal;
 FunctionName : AnsiString;

begin
 RuntimeEdit.Text := 'Running';
 RuntimeEdit.Color := clBlue;
 Update;
 if FunctionSelectionExtendedRadioGroup.ItemIndex = 0 then
  begin
   SubBench1 := SubBenchmark1RTLExtended;
   SubBench2 := SubBenchmark2RTLExtended;
  end
 else
  begin
   SubBench1 := SubBenchmark1Extended;
   SubBench2 := SubBenchmark2Extended;
  end;
 Bench := SubBench1 + SubBench2;
 RuntimeEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 RuntimeEdit.Color := clLime;
 FunctionName := FunctionSelectionExtendedRadioGroup.Items[FunctionSelectionExtendedRadioGroup.ItemIndex];
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + IntToStr(SubBench1)
                                                         + #9 + IntToStr(SubBench2)
                                                         + #9 + IntToStr(Bench));
 SortRichEditFP;
 SortRichEdit1;
 Update;
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
 ValidateAllButton.Caption := 'Running';
 Update;

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
 ValidateAllButton.Caption := 'Validate All';

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.DevelopExtendedButtonClick(Sender: TObject);
var
 X,Y1,Y2,Z : Extended;

begin
 X := 1.000000000001;
 Z := 1E10;
 Y1 := Power(X,Z);
 Y2 := PowerFunctionExtended(X,Z);
 YEdit.Text := FloatToStr(Y1);
 YEdit.Text := FloatToStr(Y2);
end;

procedure TMainForm.DevelopSingleButtonClick(Sender: TObject);
var
 X,Y1,Y2,Z : Single;

begin
 X := 1.3;
 Z := 1.1;
 Y1 := Power(X,Z);
 Y2 := PowerFunctionSingle(X,Z);
 YEdit.Text := FloatToStr(Y1);
 YEdit.Text := FloatToStr(Y2);
end;

procedure TMainForm.DevelopDoubleButtonClick(Sender: TObject);
var
 X,Y1,Y2,Z : Double;

begin
 X := 1.3;
 Z := 1.1;
 Y1 := Power(X,Z);
 Y2 := PowerFunctionDouble(X,Z);
 YEdit.Text := FloatToStr(Y1);
 YEdit.Text := FloatToStr(Y2);
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.DevelopIntPowerButtonClick(Sender: TObject);
var
 X,Y1,Y2 : Extended;
 Z : Integer;

begin
 X := 2;
 Z := 6;
 Y1 := IntPower(X,Z);
 YEdit.Text := FloatToStr(Y1);
 Y2 := IntPowerDKCPas4(X,Z);
 YEdit.Text := FloatToStr(Y2);
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
begin
 case SetRoundModeRadioGroup.ItemIndex of
  0 : SetRoundMode(rmNearest);
  1 : SetRoundMode(rmDown);
  2 : SetRoundMode(rmUp);
  3 : SetRoundMode(rmTruncate);
 end;
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
    BenchmarksAllButton.Click;
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
