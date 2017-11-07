unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'MinInt64';

type
  TMainForm = class(TForm)
    DevelopButton: TButton;
    BenchmarkButton: TButton;
    X1Edit: TEdit;
    X2Edit: TEdit;
    Y2Edit: TEdit;
    RunTimeEdit1: TEdit;
    RunTimeLabel: TLabel;
    FunctionSelectRadioGroup: TRadioGroup;
    CloseBitBtn: TBitBtn;
    TopPanel: TPanel;
    SaveResultsSpeedButton: TSpeedButton;
    PrintResultsSpeedButton: TSpeedButton;
    ResultsRichEdit: TRichEdit;
    BenchmarkAllButton: TButton;
    SaveDialog: TSaveDialog;
    ValidateButton: TButton;
    ValidEdit: TEdit;
    ClearButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    AddressEdit: TEdit;
    Label4: TLabel;
    ValidateAllButton: TButton;
    procedure DevelopButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionSelectRadioGroupClick(Sender: TObject);
    procedure SaveResultsSpeedButtonClick(Sender: TObject);
    procedure PrintResultsSpeedButtonClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure Validate;
    procedure Benchmark;
    procedure SortRichEdit;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, DateUtils, FastcodeCPUID, SystemInfoUnit, MinInt64ShaUnit, MinInt64JOHUnit, MinInt64DKCUnit;

const
 LOOPEND1 : Cardinal = 20000;
 MAXINT64 : Int64 = $7FFFFFFFFFFFFFFF;

type
 TMinFunction = function (const A, B : Int64) : Int64;

var
 MinFunction : TMinFunction;

procedure TMainForm.SortRichEdit;
var
 I2, I3, LineNo, X1, X2 : Integer;
 S1, S2, Bench1String, Bench2String : AnsiString;
 Bench1, Bench2 : Double;
 Swapped : Boolean;
 C1, C2 : Char;

begin
 repeat
  Swapped := False;
  for LineNo := 0 to ResultsRichEdit.Lines.Count-2 do
   begin
    S1 := ResultsRichEdit.Lines[LineNo];
    S2 := ResultsRichEdit.Lines[LineNo+1];
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
      Swapped := True;
      ResultsRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

procedure TMainForm.DevelopButtonClick(Sender: TObject);
var
 X1, X2, Y : Int64;

begin
 X1 := StrToInt(X1Edit.Text);
 X2 := StrToInt(X2Edit.Text);
 Y := MinFunction(X1, X2);
 Y2Edit.Text := IntToStr(Y);
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 Benchmark;
 SortRichEdit;
end;

procedure TMainForm.Validate;
var
 I1, I2 : Integer;
 Y1, Y2 : Int64;
 I164, I264, MinI164 : Int64;
 Valid : Boolean;
 FunctionName, FunctionAddressString : AnsiString;
 FunctionAddress : Cardinal;
label
 Finished;

begin
 FunctionName := FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex];
 FunctionAddress := Cardinal(@MinFunction);
 FunctionAddressString := IntToHex(FunctionAddress, 8);
 AddressEdit.Text := FunctionAddressString;
 ValidEdit.Color := clBlue;
 Update;
 I164 := 0;
 I264 := 0;
 Y1 := Min(I164, I264);
 Y2 := MinFunction(I164, I264);
 if Y1 <> Y2 then
  begin
   Valid := False;
   goto Finished;
  end;
 I164 := 0;
 I264 := 1;
 Y1 := Min(I164, I264);
 Y2 := MinFunction(I164, I264);
 if Y1 <> Y2 then
  begin
   Valid := False;
   goto Finished;
  end;
 I164 := 1;
 I264 := 0;
 Y1 := Min(I164, I264);
 Y2 := MinFunction(I164, I264);
 if Y1 <> Y2 then
  begin
   Valid := False;
   goto Finished;
  end;
 I164 := -1;
 I264 := 0;
 Y1 := Min(I164, I264);
 Y2 := MinFunction(I164, I264);
 if Y1 <> Y2 then
  begin
   Valid := False;
   goto Finished;
  end;
 I164 := 0;
 I264 := -1;
 Y1 := Min(I164, I264);
 Y2 := MinFunction(I164, I264);
 if Y1 <> Y2 then
  begin
   Valid := False;
   goto Finished;
  end;
 I164 := 1;
 I264 := -1;
 Y1 := Min(I164, I264);
 Y2 := MinFunction(I164, I264);
 if Y1 <> Y2 then
  begin
   Valid := False;
   goto Finished;
  end;
 I164 := MAXINT64;
 I264 := MAXINT64;
 Y1 := Min(I164, I264);
 Y2 := MinFunction(I164, I264);
 if Y1 <> Y2 then
  begin
   Valid := False;
   goto Finished;
  end;
 I164 := -MAXINT64;
 I264 := -MAXINT64;
 Y1 := Min(I164, I264);
 Y2 := MinFunction(I164, I264);
 if Y1 <> Y2 then
  begin
   Valid := False;
   goto Finished;
  end;
 Valid := True;
 I164 := -MAXINT64;
 I264 := MAXINT64;
 Y1 := Min(I164, I264);
 Y2 := MinFunction(I164, I264);
 if Y1 <> Y2 then
  begin
   Valid := False;
   goto Finished;
  end;
 for I1 := 1 to 10000 do
  begin
   for I2 := 1 to 10000 do
    begin
     I164 := I1*30000;
     I264 := I2*30000;
     Y1 := Min(I164, I264);
     Y2 := MinFunction(I164, I264);
     if Y1 <> Y2 then
      begin
       Valid := False;
       goto Finished;
      end;
     Y1 := Min(-I164, -I264);
     Y2 := MinFunction(-I164, -I264);
     if Y1 <> Y2 then
      begin
       Valid := False;
       goto Finished;
      end;
     I164 := I1*30000;
     I264 := I2*30000;
     Y1 := Min(I164, -I264);
     Y2 := MinFunction(I164, -I264);
     if Y1 <> Y2 then
      begin
       Valid := False;
       goto Finished;
      end;
     I164 := I1*30000;
     I264 := I2*30000;
     Y1 := Min(-I164, I264);
     Y2 := MinFunction(-I164, I264);
     if Y1 <> Y2 then
      begin
       Valid := False;
       goto Finished;
      end;
    end;
  end;
 I164 := MAXINT64;
 MinI164 := MAXINT64 - 2000;
 while I164 > MinI164 do
  begin
   I264 := -I164;
   Y1 := MinFunction(I164, I264);
   if Y1 <> I264 then
    begin
     Valid := False;
     goto Finished;
    end;
   Dec(I164);
  end;
 Finished :
 if Valid then
  begin
   ValidEdit.Color := clGreen;
   ResultsRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Passed');
  end
 else
  begin
   ValidEdit.Color := clRed;
   ResultsRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Failed');
  end;
 Update;
end;

procedure TMainForm.Benchmark;
var
 J, I1, I2, IntArrayMax, FunctionAddress : Cardinal;
 Y1, Y2, Y3 : Int64;
 StartTime, EndTime, RunTime : TDateTime;
 FunctionName, FunctionAddressString : AnsiString;
 AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
 Int64Array : array of Int64;

begin
 FunctionName := FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex];
 FunctionAddress := Cardinal(@MinFunction);
 FunctionAddressString := IntToHex(FunctionAddress, 8);
 AddressEdit.Text := FunctionAddressString;
 Update;
 IntArrayMax := 10000;
 SetLength(Int64Array, IntArrayMax);
 for J := 0 to IntArrayMax-1 do
  begin
   Int64Array[J] := Int64(Random(MaxInt))*Random(MaxInt);
  end;
 Y1 := 0;
 Y2 := 0;
 Y3 := 0;
 StartTime := Time;
 for I1 := 1 to LOOPEND1 do
  begin
   for I2 := 0 to IntArrayMax-2 do
    begin
     Y1 := MinFunction(Int64Array[I2], Int64Array[I2+1]);
     Y2 := MinFunction(Int64Array[I2+1], Int64Array[I2]);
     Y3 := MinFunction(Int64Array[I2], Int64Array[I2]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeEdit1.Text := TimeToStr(RunTime);
 Y2Edit.Text := FloatToStr(Y1);
 Y2Edit.Text := FloatToStr(Y2);
 Y2Edit.Text := FloatToStr(Y3);
 DecodeDateTime(RunTime, AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
 ResultsRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9
                         + IntToStr((60000*AMinute + 1000*ASecond + AMilliSecond)));
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ResultsRichEdit.Clear;
 MinFunction := Min;
 Y2Edit.Text := '';
 ValidEdit.Text := '';
 X1Edit.Text := '211111111';
 X2Edit.Text := '111111111';
 RunTimeEdit1.Text := '';
 AddressEdit.Text := '';
 ResultsRichEdit.Paragraph.TabCount := 2;
 ResultsRichEdit.Paragraph.Tab[0] := 90;
 ResultsRichEdit.Paragraph.Tab[1] := 130;
 FunctionSelectRadioGroupClick(nil);

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

procedure TMainForm.FunctionSelectRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectRadioGroup.ItemIndex of
    0 : MinFunction := Min;
    1 : MinFunction := Min_DKC_Pas_1_a;
    2 : MinFunction := Min_DKC_Pas_1_b;
    3 : MinFunction := Min_DKC_Pas_1_c;
    4 : MinFunction := Min_DKC_Pas_1_d;
    5 : MinFunction := Min_DKC_IA32_3_a;
    6 : MinFunction := Min_DKC_IA32_3_b;
    7 : MinFunction := Min_DKC_IA32_3_c;
    8 : MinFunction := Min_DKC_IA32_3_d;
    9 : MinFunction := Min_DKC_IA32_4_a;
   10 : MinFunction := Min_DKC_IA32_4_b;
   11 : MinFunction := Min_DKC_IA32_4_c;
   12 : MinFunction := Min_DKC_IA32_4_d;
   13 : MinFunction := Min_JOH_IA32_1_a;
   14 : MinFunction := Min_JOH_IA32_1_b;
   15 : MinFunction := Min_JOH_IA32_1_c;
   16 : MinFunction := Min_JOH_IA32_1_d;
   17 : MinFunction := Min_DKC_IA32Ext_1_a;
   18 : MinFunction := Min_DKC_IA32Ext_1_b;
   19 : MinFunction := Min_DKC_IA32Ext_1_c;
   20 : MinFunction := Min_DKC_IA32Ext_1_d;
   21 : MinFunction := Min_SHA_IA32_1_a;
   22 : MinFunction := Min_SHA_IA32_1_b;
   23 : MinFunction := Min_SHA_IA32_1_c;
   24 : MinFunction := Min_SHA_IA32_1_d;
   25 : MinFunction := Min_JOH_IA32_2_a;
   26 : MinFunction := Min_JOH_IA32_2_b;
   27 : MinFunction := Min_JOH_IA32_2_c;
   28 : MinFunction := Min_JOH_IA32_2_d;
   29 : MinFunction := Min_SHA_IA32_2_a;
   30 : MinFunction := Min_SHA_IA32_2_b;
   31 : MinFunction := Min_SHA_IA32_2_c;
   32 : MinFunction := Min_SHA_IA32_2_d;
 else
  raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.SaveResultsSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := FResultsFileName;
 if SaveDialog.Execute then
  ResultsRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintResultsSpeedButtonClick(Sender: TObject);
begin
 ResultsRichEdit.Print('Min Results');
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
begin
 Validate;
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ResultsRichEdit.Clear;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';

 for I := 0 to FunctionSelectRadioGroup.Items.Count-1 do
  begin
   FunctionSelectRadioGroup.ItemIndex := I;
   Benchmark;
   SortRichEdit;
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

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';

 for I := 0 to FunctionSelectRadioGroup.Items.Count-1 do
  begin
   FunctionSelectRadioGroup.ItemIndex := I;
   Validate;
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
