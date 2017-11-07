unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'MaxInt';

type
  TMainForm = class(TForm)
    BenchmarkButton: TButton;
    RunTimeEdit1: TEdit;
    RunTimeLabel: TLabel;
    FunctionSelectionRadioGroup: TRadioGroup;
    CloseBitBtn: TBitBtn;
    TopPanel: TPanel;
    SaveResultsSpeedButton: TSpeedButton;
    PrintResultsSpeedButton: TSpeedButton;
    ReportRichEdit: TRichEdit;
    BenchmarkAllButton: TButton;
    SaveDialog: TSaveDialog;
    ValidateButton: TButton;
    ValidEdit: TEdit;
    ClearButton: TButton;
    AddressEdit: TEdit;
    Label1: TLabel;
    Bench1Edit: TEdit;
    Bench2Edit: TEdit;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    MaxSpreadBenchPercentageEdit: TEdit;
    FunctionNameEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ValidateAllButton: TButton;
    ProgressBar1: TProgressBar;
    SpreadTestButton: TButton;
    BenchTestButton: TButton;
    AboutSpeedButton: TSpeedButton;
    Y2Edit: TEdit;
    AlignCheckButton: TButton;
    AlignCheckEdit: TEdit;
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure SaveResultsSpeedButtonClick(Sender: TObject);
    procedure PrintResultsSpeedButtonClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure AlignCheckButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    function Validate1 : Boolean;
    function Validate2 : Boolean;
    function Validate3 : Boolean;
    procedure ClearAllEditBoxes;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    procedure Validate;
    procedure Benchmark;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, FastcodeCPUID, SystemInfoUnit, MaxIntUnit, DateUtils, AboutUnit;

const
 BENCHLOOPEND1 : Cardinal = 20000;
 VALIDATE1MIN : Integer = 0;
 VALIDATE1MAX : Integer = 20000;
 VALIDATE2MIN : Integer = 0;
 VALIDATE2MAX : Integer = MAXINT;
 VALIDATE3MIN : Integer = MAXINT - 200000;
 VALIDATE3MAX : Integer = MAXINT;
 VALIDATE2STEPSIZE : Integer = 100000;

type
 TMaxFunction = function (const A, B : Integer) : Integer;

var
 MaxFunction : TMaxFunction;

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
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
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

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
end;

procedure TMainForm.AlignmentTest;
var
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2,
 ShortFunctionName1, ShortFunctionName2 : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : Char;
 Tab1Pos1, Tab1Pos2 : Cardinal;

begin
 if ReportRichEdit.Lines.Count < 2 then
  Exit;
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
     ShortFunctionName1 := Copy(S1, 0, Tab1Pos1-3);
     ShortFunctionName2 := Copy(S2, 0, Tab1Pos2-3);
     if ShortFunctionName1 = ShortFunctionName2 then
      begin
       if (FunctionName1[Length(FunctionName1)] = 'a') or
          (FunctionName1[Length(FunctionName1)] = 'b') or
          (FunctionName1[Length(FunctionName1)] = 'c') or
          (FunctionName1[Length(FunctionName1)] = 'd') then
        begin
         if (FunctionName2[Length(FunctionName1)] = 'a') or
            (FunctionName2[Length(FunctionName1)] = 'b') or
            (FunctionName2[Length(FunctionName1)] = 'c') or
            (FunctionName2[Length(FunctionName1)] = 'd') then
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
           if Spread > MaxSpread then
            begin
             Bench1Edit.Text := BenchString1;
             Bench2Edit.Text := BenchString2;
             MaxSpread := Spread;
             AlignMaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 1);
             AlignFunctionName1Edit.Text := FunctionName1;
             AlignFunctionName2Edit.Text := FunctionName2;
             Update;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//Finds the maximum spread in benchmarks for any function.

procedure TMainForm.BenchmarkTest;
var
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2 : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : Char;
 Tab1Pos1, Tab1Pos2 : Cardinal;

begin
 if ReportRichEdit.Lines.Count < 2 then
  Exit;
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
       if Spread > MaxSpread then
        begin
         Bench1Edit.Text := BenchString1;
         Bench2Edit.Text := BenchString2;
         MaxSpread := Spread;
         MaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 1);
         FunctionNameEdit.Text := FunctionName1;
         MaxSpreadBenchPercentageEdit.Color := clGreen;
         if MaxSpread > 2 then
          MaxSpreadBenchPercentageEdit.Color := clYellow;
         if MaxSpread > 5 then
          MaxSpreadBenchPercentageEdit.Color := clRed;
         Update;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 Benchmark;
 SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
end;

function TMainForm.Validate1 : Boolean;
var
 I1, I2, Y1, Y2 : Integer;

begin
 ProgressBar1.Min := VALIDATE1MIN;
 ProgressBar1.Max := VALIDATE1MAX;
 Result := True;
 for I1 := VALIDATE1MIN to VALIDATE1MAX do
  begin
   ProgressBar1.Position := I1;
   Update;
   for I2 := VALIDATE1MIN to VALIDATE1MAX do
    begin
     Y1 := Max(I1, I2);
     Y2 := MaxFunction(I1, I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
     Y1 := Max(-I1, -I2);
     Y2 := MaxFunction(-I1, -I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
     Y1 := Max(-I1, I2);
     Y2 := MaxFunction(-I1, I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
     Y1 := Max(I1, -I2);
     Y2 := MaxFunction(I1, -I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.Validate2 : Boolean;
var
 I1, I2, Y1, Y2 : Integer;

begin
 ProgressBar1.Max := VALIDATE2MAX;
 ProgressBar1.Min := VALIDATE2MIN;
 Result := True;
 I1 := VALIDATE2MIN;
 while I1 < VALIDATE2MAX - VALIDATE2STEPSIZE do
  begin
   ProgressBar1.Position := I1;
   Update;
   I2 := VALIDATE2MIN;
   while I2 < VALIDATE2MAX - VALIDATE2STEPSIZE do
    begin
     Y1 := Max(I1, I2);
     Y2 := MaxFunction(I1, I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
     Y1 := Max(-I1, -I2);
     Y2 := MaxFunction(-I1, -I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
     Y1 := Max(-I1, I2);
     Y2 := MaxFunction(-I1, I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
     Y1 := Max(I1, -I2);
     Y2 := MaxFunction(I1, -I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
     Inc(I2, VALIDATE2STEPSIZE);
    end;
   Inc(I1, VALIDATE2STEPSIZE);
  end;
end;

function TMainForm.Validate3 : Boolean;
var
 I1, I2, Y1, Y2 : Integer;

begin
 ProgressBar1.Min := VALIDATE3MIN;
 ProgressBar1.Max := VALIDATE3MAX;
 Result := True;
 for I1 := VALIDATE3MIN to VALIDATE3MAX do
  begin
   ProgressBar1.Position := I1;
   Update;
   I2 := 0;
   Y1 := Max(I1, I2);
   Y2 := MaxFunction(I1, I2);
   if Y1 <> Y2 then
    begin
     Result := False;
     Exit;
    end;
   Y1 := Max(-I1, I2);
   Y2 := MaxFunction(-I1, I2);
   if Y1 <> Y2 then
    begin
     Result := False;
     Exit;
    end;
  end;
end;

procedure TMainForm.Validate;
var
 FunctionName : AnsiString;

begin
 FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
 ValidEdit.Color := clBlue;
 Update;
 if Validate1 and Validate2 and Validate3 then
  begin
   ValidEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName + #9 + 'Passed');
  end
 else
  begin
   ValidEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed');
  end;
 Update;
end;

procedure TMainForm.Benchmark;
var
 J, I1, I2, IntArrayMax, FunctionAddress : Cardinal;
 Y1, Y2, Y3 : Integer;
 StartTime, EndTime, RunTime : TDateTime;
 FunctionName, FunctionAddressString : AnsiString;
 AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
 IntArray : array of Integer;

begin
 FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
 FunctionAddress := Cardinal(@MaxFunction);
 FunctionAddressString := IntToHex(FunctionAddress, 8);
 AddressEdit.Text := FunctionAddressString;
 IntArrayMax := 10000;
 SetLength(IntArray, IntArrayMax);
 for J := 0 to IntArrayMax do
  begin
   IntArray[J] := Random(MaxInt);
  end;
 Y1 := 0;
 Y2 := 0;
 Y3 := 0;
 StartTime := Time;
 for I1 := 1 to BENCHLOOPEND1 do
  begin
   for I2 := 0 to IntArrayMax-2 do
    begin
     Y1 := MaxFunction(IntArray[I2], IntArray[I2+1]);
     Y2 := MaxFunction(IntArray[I2+1], IntArray[I2]);
     Y3 := MaxFunction(IntArray[I2], IntArray[I2]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeEdit1.Text := TimeToStr(RunTime);
 Y2Edit.Text := FloatToStr(Y1);
 Y2Edit.Text := FloatToStr(Y2);
 Y2Edit.Text := FloatToStr(Y3);
 DecodeDateTime(RunTime, AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
 //ResultsRichEdit.Lines.Add(FunctionName + #9 + IntToStr(1000*(60*AMinute + ASecond + 0.001*AMilliSecond)));
 ReportRichEdit.Lines.Add(FunctionName + #9
                         + FunctionAddressString[8] + #9
                         + IntToStr((60000*AMinute + 1000*ASecond + AMilliSecond)));
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ClearAllEditBoxes;
 ReportRichEdit.Clear;
 MaxFunction := Max;
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 80;
 ReportRichEdit.Paragraph.Tab[1] := 100;

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

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionRadioGroup.ItemIndex of
   0 : MaxFunction := Max_RTL_IA32_1_a;
   1 : MaxFunction := Max_RTL_IA32_1_b;
   2 : MaxFunction := Max_RTL_IA32_1_c;
   3 : MaxFunction := Max_RTL_IA32_1_d;
   4 : MaxFunction := Max_DKC_IA32_1_a;
   5 : MaxFunction := Max_DKC_IA32_1_b;
   6 : MaxFunction := Max_DKC_IA32_1_c;
   7 : MaxFunction := Max_DKC_IA32_1_d;
   8 : MaxFunction := Max_LBG_IA32_1_a;
   9 : MaxFunction := Max_LBG_IA32_1_b;
   10 : MaxFunction := Max_LBG_IA32_1_c;
   11 : MaxFunction := Max_LBG_IA32_1_d;
   12 : MaxFunction := Max_DKC_Pas_1_a;
   13 : MaxFunction := Max_DKC_Pas_1_b;
   14 : MaxFunction := Max_DKC_Pas_1_c;
   15 : MaxFunction := Max_DKC_Pas_1_d;
   16 : MaxFunction := Max_Sha_IA32_1_a;
   17 : MaxFunction := Max_Sha_IA32_1_b;
   18 : MaxFunction := Max_Sha_IA32_1_c;
   19 : MaxFunction := Max_Sha_IA32_1_d;
   20 : MaxFunction := Max_Sha_Pas_1_a;
   21 : MaxFunction := Max_Sha_Pas_1_b;
   22 : MaxFunction := Max_Sha_Pas_1_c;
   23 : MaxFunction := Max_Sha_Pas_1_d;
 else
  raise Exception.Create('Invalid Function Number');
 end;
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
 ReportRichEdit.Print('Max Results');
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
begin
 ValidateButton.Caption := 'Running';
 Validate;
 ValidateButton.Caption := 'Validate';
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 if not SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
 BenchmarkAllButton.Caption := 'Running';
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   Benchmark;
   SortRichEdit;
   BenchmarkTest;
   AlignmentTest;
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

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 Update;
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   ValidateButtonClick(nil);
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

procedure TMainForm.SpreadTestButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 SpreadTestButton.Caption := 'Running';
 for I := 0 to 20 do
  begin
   BenchmarkButtonClick(nil);
   SortRichEdit;
   BenchmarkTest;
   Update;
  end;
 SpreadTestButton.Caption := 'Spread Test';
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 for I1 := 0 to 2 do
  begin
   for I2 := 0 to FunctionSelectionRadioGroup.Items.Count-1  do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkButtonClick(nil);
     Update;
    end;
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkButtonClick(nil);
   for I3 := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I3;
     BenchmarkButtonClick(nil);
     Update;
    end;
  end;
 BenchTestButton.Caption := 'Bench Test';  
end;

procedure TMainForm.AlignCheckButtonClick(Sender: TObject);
var
 I, J, TabPos1, TabPos2, K, L, P, Q, T : Integer;
 FunctionName, FunctionName1, FunctionName2, FunctionAddressString, FunctionAlignString1, FunctionAlignString2, S1, S2 : AnsiString;
 FunctionAddress : Cardinal;
 AlignStringArray : array[1..4] of AnsiString;

begin
 AlignCheckEdit.Text := '';
 AlignCheckEdit.Color := clGreen;
 Update;
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   FunctionAddress := Cardinal(@MaxFunction);
   FunctionAddressString := IntToHex(FunctionAddress, 8);
   ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]);
  end;
 for J := 0 to ReportRichEdit.Lines.Count-1 do
  begin
   for T := 1 to 4 do
    AlignStringArray[T] := '';
   S1 := ReportRichEdit.Lines.Strings[J];
   TabPos1 := CharPos(#9, S1);
   if CharPos('_', S1) <> 0 then
    FunctionName1 := Copy(S1, 1, TabPos1-3)
   else
    FunctionName1 := Copy(S1, 1, TabPos1-1);
   FunctionAlignString1 := Copy(S1, TabPos1+1, 1);
   L := 1;
   AlignStringArray[L] := FunctionAlignString1;
   for K := J+1 to ReportRichEdit.Lines.Count-1 do
    begin
     S2 := ReportRichEdit.Lines.Strings[K];
     TabPos2 := CharPos(#9, S2);
     if CharPos('_', S2) <> 0 then
      FunctionName2 := Copy(S2, 1, TabPos2-3)
     else
      FunctionName2 := Copy(S2, 1, TabPos2-1);
     FunctionAlignString2 := Copy(S2, TabPos2+1, 1);
     if FunctionName1 = FunctionName2 then
      begin
       Inc(L);
       AlignStringArray[L] := FunctionAlignString2;
      end;
    end;
   for P := 1 to 4 do
    for Q := P+1 to 4 do
     begin
      if (AlignStringArray[P] = AlignStringArray[Q]) and (AlignStringArray[P] <> '') then
       begin
        AlignCheckEdit.Text := FunctionName1;
        AlignCheckEdit.Color := clRed;
        Exit;
       end;
     end;
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
