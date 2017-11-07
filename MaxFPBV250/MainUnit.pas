unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'MaxFP';

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
    ResultsRichEdit: TRichEdit;
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
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, FastcodeCPUID, SystemInfoUnit, MaxFPUnit;

const
 LOOPEND1 : Cardinal = 100000;
 RUNTIMESCALE : Cardinal = 100;
 ARRAYSIZE : Cardinal = 1000;

type
 TMaxFPSingleFunction = function (const A, B : Single) : Single;
 TMaxFPDoubleFunction = function (const A, B : Double) : Double;
 TMaxFPExtendedFunction = function (const A, B : Extended) : Extended;

var
 MaxFPSingleFunction : TMaxFPSingleFunction;
 MaxFPDoubleFunction : TMaxFPDoubleFunction;
 MaxFPExtendedFunction : TMaxFPExtendedFunction;
 SingleArray : array of Single;
 DoubleArray : array of Double;
 ExtendedArray : array of Extended;

procedure TMainForm.DevelopSingleButtonClick(Sender: TObject);
var
 X1, X2, Y : Single;

begin
 X1 := StrToInt(X1Edit.Text);
 X2 := StrToInt(X2Edit.Text);
 Y := MaxFPSingleFunction(X2, X1);
 Y2Edit.Text := FloatToStr(Y);
end;

procedure TMainForm.BenchmarkSingleButtonClick(Sender: TObject);
begin
 BenchmarkSingle;
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
      Y1 := Max(X1, X2);
      Y2 := MaxFPSingleFunction(X1, X2);
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
      Y1 := Max(X1, X2);
      Y2 := MaxFPSingleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for negative versus positive numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := I1;
      X2 := -I2;
      Y1 := Max(X1, X2);
      Y2 := MaxFPSingleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for negative versus positive numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := -I1;
      X2 := I2;
      Y1 := Max(X1, X2);
      Y2 := MaxFPSingleFunction(X1, X2);
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
    ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + 'Passed');
   end
  else
   begin
    ValidEdit.Color := clRed;
    ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + 'Failed');
   end;
  Update;
 except
  ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + 'Failed');
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
      Y1 := Max(X1, X2);
      Y2 := MaxFPDoubleFunction(X1, X2);
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
      Y1 := Max(X1, X2);
      Y2 := MaxFPDoubleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for negative versus positive numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := I1;
      X2 := -I2;
      Y1 := Max(X1, X2);
      Y2 := MaxFPDoubleFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for negative versus positive numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := -I1;
      X2 := I2;
      Y1 := Max(X1, X2);
      Y2 := MaxFPDoubleFunction(X1, X2);
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
    ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + 'Passed');
   end
  else
   begin
    ValidEdit.Color := clRed;
    ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + 'Failed');
   end;
  Update;
 except
  ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + 'Failed');
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
      Y1 := Max(X1, X2);
      Y2 := MaxFPExtendedFunction(X1, X2);
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
      Y1 := Max(X1, X2);
      Y2 := MaxFPExtendedFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for negative versus positive numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := -I1;
      X2 := I2;
      Y1 := Max(X1, X2);
      Y2 := MaxFPExtendedFunction(X1, X2);
      if Y1 <> Y2 then
       begin
        Valid := False;
        goto Invalid;
       end;
     end;
   end;
  //Validation for negative versus positive numbers
  for I1 := 1 to 10000 do
   begin
    for I2 := 1 to 10000 do
     begin
      X1 := I1;
      X2 := -I2;
      Y1 := Max(X1, X2);
      Y2 := MaxFPExtendedFunction(X1, X2);
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
    ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + 'Passed');
   end
  else
   begin
    ValidEdit.Color := clRed;
    ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + 'Failed');
   end;
  Update;
 except
  ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkSingle;
var
 J1, I1, I2 : Cardinal;
 Y1, Y2, Y3 : Single;
 StartTime, EndTime, RunTime : TDateTime;
 FunctionName : AnsiString;
 Hour, Min, RunTimeSec, MSec: Word;

begin
 try
  FunctionName := SingleFunctionSelectRadioGroup.Items[SingleFunctionSelectRadioGroup.ItemIndex];
  //Fill array with pseudo random values
  for J1 := 0 to ARRAYSIZE-1 do
   begin
    SingleArray[J1] := Random(100000);
   end;
  Y1 := 0;
  Y2 := 0;
  Y3 := 0;
  StartTime := Time;
  for I1 := 1 to LOOPEND1 do
   begin
    for I2 := 0 to ARRAYSIZE-2 do
     begin
      Y1 := MaxFPSingleFunction(SingleArray[I2], SingleArray[I2+1]);
      Y2 := MaxFPSingleFunction(SingleArray[I2+1], SingleArray[I2]);
      Y3 := MaxFPSingleFunction(SingleArray[I2], SingleArray[I2]);
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
  ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Single' + #9 + IntToStr(RunTimeSec));
  Update;
 except
  ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '99999');
 end;
end;

procedure TMainForm.BenchmarkDouble;
var
 J1, I1, I2 : Cardinal;
 Y1, Y2, Y3 : Double;
 StartTime, EndTime, RunTime : TDateTime;
 FunctionName : AnsiString;
 Hour, Min, RunTimeSec, MSec: Word;

begin
 try
  FunctionName := DoubleFunctionSelectRadioGroup.Items[DoubleFunctionSelectRadioGroup.ItemIndex];
  //Fill array with pseudo random values
  for J1 := 0 to ARRAYSIZE-1 do
   begin
    DoubleArray[J1] := Random(100000);
   end;
  Y1 := 0;
  Y2 := 0;
  Y3 := 0;
  StartTime := Time;
  for I1 := 1 to LOOPEND1 do
   begin
    for I2 := 0 to ARRAYSIZE-2 do
     begin
      Y1 := MaxFPDoubleFunction(DoubleArray[I2], DoubleArray[I2+1]);
      Y2 := MaxFPDoubleFunction(DoubleArray[I2+1], DoubleArray[I2]);
      Y3 := MaxFPDoubleFunction(DoubleArray[I2], DoubleArray[I2]);
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
  ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Double' + #9 + IntToStr(RunTimeSec));
  Update;
 except
  ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '99999');
 end;
end;

procedure TMainForm.BenchmarkExtended;
var
 J1, I1, I2 : Cardinal;
 Y1, Y2, Y3 : Extended;
 StartTime, EndTime, RunTime : TDateTime;
 FunctionName : AnsiString;
 Hour, Min, RunTimeSec, MSec: Word;

begin
 try
  FunctionName := ExtendedFunctionSelectRadioGroup.Items[ExtendedFunctionSelectRadioGroup.ItemIndex];
  //Fill array with pseudo random values
  for J1 := 0 to ARRAYSIZE-1 do
   begin
    ExtendedArray[J1] := Random(100000);
   end;
  Y1 := 0;
  Y2 := 0;
  Y3 := 0;
  StartTime := Time;
  for I1 := 1 to LOOPEND1 do
   begin
    for I2 := 0 to ARRAYSIZE-2 do
     begin
      Y1 := MaxFPExtendedFunction(ExtendedArray[I2], ExtendedArray[I2+1]);
      Y2 := MaxFPExtendedFunction(ExtendedArray[I2+1], ExtendedArray[I2]);
      Y3 := MaxFPExtendedFunction(ExtendedArray[I2], ExtendedArray[I2]);
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
  ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Extended' + #9 + IntToStr(RunTimeSec));
  Update;
 except
  ResultsRichEdit.Lines.Add(FunctionName + #9 + 'Failed' + #9 + '99999');
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ResultsRichEdit.Clear;
 MaxFPSingleFunction := Max;
 MaxFPDoubleFunction := Max;
 MaxFPExtendedFunction := Max;
 Y1Edit.Text := '';
 Y2Edit.Text := '';
 Y3Edit.Text := '';
 ValidEdit.Text := '';
 X1Edit.Text := '1234';
 X2Edit.Text := '234';
 RunTimeEdit1.Text := '';
 ResultsRichEdit.Paragraph.TabCount := 2;
 ResultsRichEdit.Paragraph.Tab[0] := 80;
 ResultsRichEdit.Paragraph.Tab[1] := 120;
 SetLength(SingleArray, ARRAYSIZE);
 SetLength(DoubleArray, ARRAYSIZE);
 SetLength(ExtendedArray, ARRAYSIZE);

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

procedure TMainForm.SingleFunctionSelectRadioGroupClick(Sender: TObject);
begin
 case SingleFunctionSelectRadioGroup.ItemIndex of
   0 : MaxFPSingleFunction := Max;
   1 : MaxFPSingleFunction := MaxDKCPas;
   2 : MaxFPSingleFunction := MaxDKCASM1;
   3 : MaxFPSingleFunction := MaxDKCASM2;
   4 : MaxFPSingleFunction := MaxDKCASM3;
   5 : MaxFPSingleFunction := MaxJOH_RTL;
   6 : MaxFPSingleFunction := MaxJOH;
   7 : MaxFPSingleFunction := MaxDKCSSE;
 end;
end;

procedure TMainForm.SaveResultsSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := 'MaxFPBenchReport.Txt';
 if SaveDialog.Execute then
  ResultsRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintResultsSpeedButtonClick(Sender: TObject);
begin
 ResultsRichEdit.Print('Max Results');
end;

procedure TMainForm.ValidateSingleButtonClick(Sender: TObject);
begin
 ValidateSingle;
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ResultsRichEdit.Clear;
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
   Update;
  end;
 for I2 := 0 to DoubleFunctionSelectRadioGroup.Items.Count-1 do
  begin
   DoubleFunctionSelectRadioGroup.ItemIndex := I2;
   BenchmarkDouble;
   Update;
  end;
 for I3 := 0 to ExtendedFunctionSelectRadioGroup.Items.Count-1 do
  begin
   ExtendedFunctionSelectRadioGroup.ItemIndex := I3;
   BenchmarkExtended;
   Update;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ResultsRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.DoubleFunctionSelectRadioGroupClick(Sender: TObject);
begin
 case DoubleFunctionSelectRadioGroup.ItemIndex of
   0 : MaxFPDoubleFunction := Max;
   1 : MaxFPDoubleFunction := MaxDKCPas;
   2 : MaxFPDoubleFunction := MaxDKCASM1;
   3 : MaxFPDoubleFunction := MaxDKCASM2;
   4 : MaxFPDoubleFunction := MaxDKCASM3;
   5 : MaxFPDoubleFunction := MaxJOH_RTL;
   6 : MaxFPDoubleFunction := MaxJOH;
   7 : MaxFPDoubleFunction := MaxDKCSSE2_1;
   8 : MaxFPDoubleFunction := MaxDKCSSE2_2;
 end;
end;

procedure TMainForm.ExtendedFunctionSelectRadioGroupClick(Sender: TObject);
begin
 case ExtendedFunctionSelectRadioGroup.ItemIndex of
   0 : MaxFPExtendedFunction := Max;
   1 : MaxFPExtendedFunction := MaxDKCPas;
   2 : MaxFPExtendedFunction := MaxDKCASM1;
   3 : MaxFPExtendedFunction := MaxDKCASM2;
   4 : MaxFPExtendedFunction := MaxDKCASM3;
   5 : MaxFPExtendedFunction := MaxJOH_RTL;
   6 : MaxFPExtendedFunction := MaxJOH;
 end;
end;

procedure TMainForm.DevelopDoubleButtonClick(Sender: TObject);
var
 X1, X2, Y : Double;

begin
 X1 := StrToInt(X1Edit.Text);
 X2 := StrToInt(X2Edit.Text);
 Y := MaxFPDoubleFunction(X2, X1);
 Y2Edit.Text := FloatToStr(Y);
end;

procedure TMainForm.DevelopExtendedButtonClick(Sender: TObject);
var
 X1, X2, Y : Extended;

begin
 X1 := StrToInt(X1Edit.Text);
 X2 := StrToInt(X2Edit.Text);
 Y := MaxFPExtendedFunction(X2, X1);
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
end;

procedure TMainForm.BenchmarkExtendedButtonClick(Sender: TObject);
begin
 BenchmarkExtended;
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
 FResultList.AddStrings(ResultsRichEdit.Lines);
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
