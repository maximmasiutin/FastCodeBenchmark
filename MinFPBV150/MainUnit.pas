unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'MinFP';

type
  TMainForm = class(TForm)
    DevelopSingleButton: TButton;
    BenchmarkSingleButton: TButton;
    X1Edit: TEdit;
    X2Edit: TEdit;
    Y2Edit: TEdit;
    RunTimeEdit1: TEdit;
    RunTimeLabel: TLabel;
    SingleFunctionSelectRadioGroup: TRadioGroup;
    CloseBitBtn: TBitBtn;
    TopPanel: TPanel;
    SaveResultsSpeedButton: TSpeedButton;
    PrintResultsSpeedButton: TSpeedButton;
    ReportRichEdit: TRichEdit;
    BenchmarkAllButton: TButton;
    SaveDialog: TSaveDialog;
    ValidateSingleButton: TButton;
    ValidEdit: TEdit;
    ClearButton: TButton;
    DoubleFunctionSelectRadioGroup: TRadioGroup;
    ExtendedFunctionSelectRadioGroup: TRadioGroup;
    DevelopDoubleButton: TButton;
    DevelopExtendedButton: TButton;
    ValidateDoubleButton: TButton;
    ValidateExtendedButton: TButton;
    BenchmarkDoubleButton: TButton;
    BenchmarkExtendedButton: TButton;
    Y1Edit: TEdit;
    Y3Edit: TEdit;
    ValidateAllButton: TButton;
    procedure DevelopSingleButtonClick(Sender: TObject);
    procedure BenchmarkSingleButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SingleFunctionSelectRadioGroupClick(Sender: TObject);
    procedure SaveResultsSpeedButtonClick(Sender: TObject);
    procedure PrintResultsSpeedButtonClick(Sender: TObject);
    procedure ValidateSingleButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure DoubleFunctionSelectRadioGroupClick(Sender: TObject);
    procedure ExtendedFunctionSelectRadioGroupClick(Sender: TObject);
    procedure DevelopDoubleButtonClick(Sender: TObject);
    procedure DevelopExtendedButtonClick(Sender: TObject);
    procedure ValidateDoubleButtonClick(Sender: TObject);
    procedure ValidateExtendedButtonClick(Sender: TObject);
    procedure BenchmarkDoubleButtonClick(Sender: TObject);
    procedure BenchmarkExtendedButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure ValidateSingle;
    procedure ValidateDouble;
    procedure ValidateExtended;
    procedure BenchmarkSingle;
    procedure BenchmarkDouble;
    procedure BenchmarkExtended;
    procedure SortRichEditFP;
    procedure SortRichEdit1;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, FastcodeCPUID, SystemInfoUnit, MinFPDKCUnit, MinFPJOHUnit;

const
 LOOPEND1 : Cardinal = 100000;
 RUNTIMESCALE : Cardinal = 100;
 ARRAYSIZE : Cardinal = 1000;

type
 TMinFPSingleFunction = function (const A, B : Single) : Single;
 TMinFPDoubleFunction = function (const A, B : Double) : Double;
 TMinFPExtendedFunction = function (const A, B : Extended) : Extended;

var
 MinFPSingleFunction : TMinFPSingleFunction;
 MinFPDoubleFunction : TMinFPDoubleFunction;
 MinFPExtendedFunction : TMinFPExtendedFunction;
 SingleArray : array of Single;
 DoubleArray : array of Double;
 ExtendedArray : array of Extended;

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

procedure InitializeBenchArraySingle;
var
 J1 : Cardinal;

begin
 //Fill array with pseudo random values
 for J1 := 0 to ARRAYSIZE-1 do
  begin
   SingleArray[J1] := Random(100000);
  end;
end;

procedure InitializeBenchArrayDouble;
var
 J1 : Cardinal;

begin
 //Fill array with pseudo random values
 for J1 := 0 to ARRAYSIZE-1 do
  begin
   DoubleArray[J1] := Random(100000);
  end;

end;

procedure InitializeBenchArrayExtended;
var
 J1 : Cardinal;

begin
 //Fill array with pseudo random values
 for J1 := 0 to ARRAYSIZE-1 do
  begin
   ExtendedArray[J1] := Random(100000);
  end;
end;

procedure TMainForm.DevelopSingleButtonClick(Sender: TObject);
var
 X1, X2, Y : Single;

begin
 X1 := StrToInt(X1Edit.Text);
 X2 := StrToInt(X2Edit.Text);
 Y := MinFPSingleFunction(X2, X1);
 Y2Edit.Text := FloatToStr(Y);
end;

procedure TMainForm.BenchmarkSingleButtonClick(Sender: TObject);
begin
 BenchmarkSingle;
 SortRichEditFP;
 SortRichEdit1;
end;

procedure TMainForm.ValidateSingle;
var
 I1, I2 : Cardinal;
 X1, X2, Y1, Y2 : Single;
 Valid : Boolean;
 FunctionName : AnsiString;
label
 Invalid;

begin
 try
  FunctionName := SingleFunctionSelectRadioGroup.Items[SingleFunctionSelectRadioGroup.ItemIndex];
  ValidEdit.Color := clBlue;
  Update;
  Valid := True;
  //Validation for positive numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := I1;
      X2 := I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPSingleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for negative numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := -I1;
      X2 := -I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPSingleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for positive versus negative numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := I1;
      X2 := -I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPSingleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for positive versus negative numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := -I1;
      X2 := I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPSingleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
 Invalid :
  if Valid then
   begin
    ValidEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + 'Passed');
   end
  else
   begin
    ValidEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + 'Failed');
   end;
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + 'Failed');
 end;
end;

procedure TMainForm.ValidateDouble;
var
 I1, I2 : Cardinal;
 X1, X2, Y1, Y2 : Double;
 Valid : Boolean;
 FunctionName : AnsiString;
label
 Invalid;

begin
 try
  FunctionName := DoubleFunctionSelectRadioGroup.Items[DoubleFunctionSelectRadioGroup.ItemIndex];
  ValidEdit.Color := clBlue;
  Update;
  Valid := True;
  //Validation for positive numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := I1;
      X2 := I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPDoubleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for negative numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := -I1;
      X2 := -I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPDoubleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for positive versus negative numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := I1;
      X2 := -I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPDoubleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for positive versus negative numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := -I1;
      X2 := I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPDoubleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
 Invalid :
  if Valid then
   begin
    ValidEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + 'Passed');
   end
  else
   begin
    ValidEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + 'Failed');
   end;
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + 'Failed');
 end;
end;

procedure TMainForm.ValidateExtended;
var
 I1, I2 : Cardinal;
 X1, X2, Y1, Y2 : Extended;
 Valid : Boolean;
 FunctionName : AnsiString;
label
 Invalid;

begin
 try
  FunctionName := ExtendedFunctionSelectRadioGroup.Items[ExtendedFunctionSelectRadioGroup.ItemIndex];
  ValidEdit.Color := clBlue;
  Update;
  Valid := True;
  //Validation for positive numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := I1;
      X2 := I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPExtendedFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for negative numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := -I1;
      X2 := -I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPExtendedFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for positive versus negative numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := I1;
      X2 := -I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPExtendedFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for positive versus negative numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := -I1;
      X2 := I2;
      Y1 := Min(X1, X2);
      Y2 := MinFPExtendedFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
 Invalid :
  if Valid then
   begin
    ValidEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + 'Passed');
   end
  else
   begin
    ValidEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + 'Failed');
   end;
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkSingle;
var
 I1, I2 : Cardinal;
 Y1, Y2, Y3 : Single;
 StartTime, EndTime, RunTime : TDateTime;
 FunctionName : AnsiString;
 Hour, Min, RunTimeSec, MSec: Word;

begin
 try
  FunctionName := SingleFunctionSelectRadioGroup.Items[SingleFunctionSelectRadioGroup.ItemIndex];
  Y1 := 0;
  Y2 := 0;
  Y3 := 0;
  StartTime := Time;
  for I1 := 1 to LOOPEND1 do
   begin
    for I2 := 0 to ARRAYSIZE-2 do
     begin
      Y1 := MinFPSingleFunction(SingleArray[I2], SingleArray[I2+1]);
      Y2 := MinFPSingleFunction(SingleArray[I2+1], SingleArray[I2]);
      Y3 := MinFPSingleFunction(SingleArray[I2], SingleArray[I2]);
     end;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  DecodeTime(RunTime, Hour, Min, RunTimeSec, MSec);
  RunTimeSec := RunTimeSec*1000 + MSec;
  RunTimeEdit1.Text := IntToStr(RunTimeSec);
  Y1Edit.Text := FloatToStr(Y1);
  Y2Edit.Text := FloatToStr(Y2);
  Y3Edit.Text := FloatToStr(Y3);
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + IntToStr(RunTimeSec));
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '99999');
 end;
end;

procedure TMainForm.BenchmarkDouble;
var
 I1, I2 : Cardinal;
 Y1, Y2, Y3 : Double;
 StartTime, EndTime, RunTime : TDateTime;
 FunctionName : AnsiString;
 Hour, Min, RunTimeSec, MSec: Word;

begin
 try
  FunctionName := DoubleFunctionSelectRadioGroup.Items[DoubleFunctionSelectRadioGroup.ItemIndex];
  Y1 := 0;
  Y2 := 0;
  Y3 := 0;
  StartTime := Time;
  for I1 := 1 to LOOPEND1 do
   begin
    for I2 := 0 to ARRAYSIZE-2 do
     begin
      Y1 := MinFPDoubleFunction(DoubleArray[I2], DoubleArray[I2+1]);
      Y2 := MinFPDoubleFunction(DoubleArray[I2+1], DoubleArray[I2]);
      Y3 := MinFPDoubleFunction(DoubleArray[I2], DoubleArray[I2]);
     end;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  DecodeTime(RunTime, Hour, Min, RunTimeSec, MSec);
  RunTimeSec := RunTimeSec*1000 + MSec;
  RunTimeEdit1.Text := IntToStr(RunTimeSec);
  // Compiler will remove code if not used (Y1) !!
  Y1Edit.Text := FloatToStr(Y1);
  Y2Edit.Text := FloatToStr(Y2);
  Y3Edit.Text := FloatToStr(Y3);
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + IntToStr(RunTimeSec));
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '99999');
 end;
end;

procedure TMainForm.BenchmarkExtended;
var
 I1, I2 : Cardinal;
 Y1, Y2, Y3 : Extended;
 StartTime, EndTime, RunTime : TDateTime;
 FunctionName : AnsiString;
 Hour, Min, RunTimeSec, MSec: Word;

begin
 try
  FunctionName := ExtendedFunctionSelectRadioGroup.Items[ExtendedFunctionSelectRadioGroup.ItemIndex];
  Y1 := 0;
  Y2 := 0;
  Y3 := 0;
  StartTime := Time;
  for I1 := 1 to LOOPEND1 do
   begin
    for I2 := 0 to ARRAYSIZE-2 do
     begin
      Y1 := MinFPExtendedFunction(ExtendedArray[I2], ExtendedArray[I2+1]);
      Y2 := MinFPExtendedFunction(ExtendedArray[I2+1], ExtendedArray[I2]);
      Y3 := MinFPExtendedFunction(ExtendedArray[I2], ExtendedArray[I2]);
     end;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  DecodeTime(RunTime, Hour, Min, RunTimeSec, MSec);
  RunTimeSec := RunTimeSec*1000 + MSec;
  RunTimeEdit1.Text := IntToStr(RunTimeSec);
  // Compiler will remove code if not used (Y1) !!
  Y1Edit.Text := FloatToStr(Y1);
  Y2Edit.Text := FloatToStr(Y2);
  Y3Edit.Text := FloatToStr(Y3);
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + IntToStr(RunTimeSec));
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '99999');
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ReportRichEdit.Clear;
 MinFPSingleFunction := Min;
 MinFPDoubleFunction := Min;
 MinFPExtendedFunction := Min;
 Y1Edit.Text := '';
 Y2Edit.Text := '';
 Y3Edit.Text := '';
 ValidEdit.Text := '';
 X1Edit.Text := '1234';
 X2Edit.Text := '234';
 RunTimeEdit1.Text := '';
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 80;
 ReportRichEdit.Paragraph.Tab[1] := 120;
 SetLength(SingleArray, ARRAYSIZE);
 SetLength(DoubleArray, ARRAYSIZE);
 SetLength(ExtendedArray, ARRAYSIZE);
 InitializeBenchArraySingle;
 InitializeBenchArrayDouble;
 InitializeBenchArrayExtended;

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

procedure TMainForm.SaveResultsSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := FResultsFileName;
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintResultsSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('Min Results');
end;

procedure TMainForm.ValidateSingleButtonClick(Sender: TObject);
begin
 ValidateSingle;
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';

 for I1 := 0 to SingleFunctionSelectRadioGroup.Items.Count-1 do
  begin
   SingleFunctionSelectRadioGroup.ItemIndex := I1;
   BenchmarkSingle;
   SortRichEditFP;
   SortRichEdit1;
   Update;
  end;
 for I2 := 0 to DoubleFunctionSelectRadioGroup.Items.Count-1 do
  begin
   DoubleFunctionSelectRadioGroup.ItemIndex := I2;
   BenchmarkDouble;
   SortRichEditFP;
   SortRichEdit1;
   Update;
  end;
 for I3 := 0 to ExtendedFunctionSelectRadioGroup.Items.Count-1 do
  begin
   ExtendedFunctionSelectRadioGroup.ItemIndex := I3;
   BenchmarkExtended;
   SortRichEditFP;
   SortRichEdit1;
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

procedure TMainForm.SingleFunctionSelectRadioGroupClick(Sender: TObject);
begin
 case SingleFunctionSelectRadioGroup.ItemIndex of
   0 : MinFPSingleFunction := Min;
   1 : MinFPSingleFunction := MinJOH_RTL;
   2 : MinFPSingleFunction := MinJOH;
   3 : MinFPSingleFunction := MinDKC_Pas;
   4 : MinFPSingleFunction := MinDKC_RTL;
   5 : MinFPSingleFunction := MinDKC_Asm2;
   6 : MinFPSingleFunction := MinDKC_SSE_2;
 else
  raise Exception.Create('Invalid function');
 end;
end;

procedure TMainForm.DoubleFunctionSelectRadioGroupClick(Sender: TObject);
begin
 case DoubleFunctionSelectRadioGroup.ItemIndex of
  0 : MinFPDoubleFunction := Min;
  1 : MinFPDoubleFunction := MinJOH_RTL;
  2 : MinFPDoubleFunction := MinJOH;
  3 : MinFPDoubleFunction := MinDKC_Pas;
  4 : MinFPDoubleFunction := MinDKC_RTL;
  5 : MinFPDoubleFunction := MinDKC_Asm2;
  6 : MinFPDoubleFunction := MinDKC_SSE2_3;
 else
  raise Exception.Create('Invalid function');
 end;
end;

procedure TMainForm.ExtendedFunctionSelectRadioGroupClick(Sender: TObject);
begin
 case ExtendedFunctionSelectRadioGroup.ItemIndex of
  0 : MinFPExtendedFunction := Min;
  1 : MinFPExtendedFunction := MinJOH_RTL;
  2 : MinFPExtendedFunction := MinJOH;
  3 : MinFPExtendedFunction := MinDKC_Pas;
  4 : MinFPExtendedFunction := MinDKC_RTL;
  5 : MinFPExtendedFunction := MinDKC_Asm2;
 else
  raise Exception.Create('Invalid function');
 end;
end;

procedure TMainForm.DevelopDoubleButtonClick(Sender: TObject);
var
 X1, X2, Y : Double;

begin
 X1 := StrToInt(X1Edit.Text);
 X2 := StrToInt(X2Edit.Text);
 Y := MinFPDoubleFunction(X2, X1);
 Y2Edit.Text := FloatToStr(Y);
end;

procedure TMainForm.DevelopExtendedButtonClick(Sender: TObject);
var
 X1, X2, Y : Extended;

begin
 X1 := StrToInt(X1Edit.Text);
 X2 := StrToInt(X2Edit.Text);
 Y := MinFPExtendedFunction(X2, X1);
 Y2Edit.Text := FloatToStr(Y);
end;

procedure TMainForm.ValidateDoubleButtonClick(Sender: TObject);
begin
 ValidateDouble;
end;

procedure TMainForm.ValidateExtendedButtonClick(Sender: TObject);
begin
 ValidateExtended;
end;

procedure TMainForm.BenchmarkDoubleButtonClick(Sender: TObject);
begin
 BenchmarkDouble;
 SortRichEditFP;
 SortRichEdit1;
end;

procedure TMainForm.BenchmarkExtendedButtonClick(Sender: TObject);
begin
 BenchmarkExtended;
 SortRichEditFP;
 SortRichEdit1;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';

 for I1 := 0 to SingleFunctionSelectRadioGroup.Items.Count-1 do
  begin
   SingleFunctionSelectRadioGroup.ItemIndex := I1;
   ValidateSingle;
   Update;
  end;
 for I2 := 0 to DoubleFunctionSelectRadioGroup.Items.Count-1 do
  begin
   DoubleFunctionSelectRadioGroup.ItemIndex := I2;
   ValidateDouble;
   Update;
  end;
 for I3 := 0 to ExtendedFunctionSelectRadioGroup.Items.Count-1 do
  begin
   ExtendedFunctionSelectRadioGroup.ItemIndex := I3;
   ValidateExtended;
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
