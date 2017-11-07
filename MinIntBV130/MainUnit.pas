unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'MinInt';

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
    ReportRichEdit: TRichEdit;
    BenchmarkAllButton: TButton;
    SaveDialog: TSaveDialog;
    ValidateButton: TButton;
    ValidEdit: TEdit;
    ClearButton: TButton;
    ValidateAllButton: TButton;
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
    BenchTestButton: TButton;
    SpreadTestButton: TButton;
    ProgressBar1: TProgressBar;
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
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure AlignmentTest;
    procedure ClearAllEditBoxes;
    procedure BenchmarkTest;
    procedure SortRichEdit;
    function Validate1 : Boolean;
    function Validate2 : Boolean;
    function Validate3 : Boolean;
    function Validate4 : Boolean;
    function Validate5 : Boolean;
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
 Math, DateUtils, FastcodeCPUID, SystemInfoUnit, MinIntDKCUnit, MinIntLBGUnit, MinIntShaUnit;

const
 LOOPEND1 : Cardinal = 20000;

type
 TMinFunction = function (const A, B : Integer) : Integer;

var
 MinFunction : TMinFunction;

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

procedure TMainForm.DevelopButtonClick(Sender: TObject);
var
 X1, X2, Y : Integer;

begin
 X1 := StrToInt(X1Edit.Text);
 X2 := StrToInt(X2Edit.Text);
 Y := MinDKCPas_a(X2, X1);
 Y2Edit.Text := IntToStr(Y);
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 Benchmark;
 SortRichEdit;
 AlignmentTest;
 BenchmarkTest;
end;

function TMainForm.Validate1 : Boolean;
var
 I1, I2, Y1, Y2 : Integer;
const
 VALIDATE1MAX : Integer = 10000;

begin
 Result := True;
 for I1 := 0 to VALIDATE1MAX do
  begin
   for I2 := 0 to VALIDATE1MAX do
    begin
     Y1 := Min(I1, I2);
     Y2 := MinFunction(I1, I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
 for I1 := 0 to VALIDATE1MAX do
  begin
   for I2 := 0 to VALIDATE1MAX do
    begin
     Y1 := Min(-I1, -I2);
     Y2 := MinFunction(-I1, -I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
 for I1 := 0 to VALIDATE1MAX do
  begin
   for I2 := 0 to VALIDATE1MAX do
    begin
     Y1 := Min(-I1, I2);
     Y2 := MinFunction(-I1, I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
 for I1 := 0 to VALIDATE1MAX do
  begin
   for I2 := 0 to VALIDATE1MAX do
    begin
     Y1 := Min(I1, -I2);
     Y2 := MinFunction(I1, -I2);
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
 I1, I2, Y : Integer;

begin
 Result := True;
 I1 := 0;
 ProgressBar1.Max := MAXINT;
 ProgressBar1.Min := 0;
 Update;
 for I2 := 0 to MAXINT do
  begin
   if I2 mod 1000 = 0 then
    begin
     ProgressBar1.Position := I2;
     Update;
    end;
   Y := MinFunction(I1, I2);
   if Y <> I1 then
    begin
     Result := False;
     Exit;
    end;
  end;
end;

function TMainForm.Validate3 : Boolean;
var
 X, I1, I2, Y : Integer;

begin
 Result := True;
 I1 := 0;
 ProgressBar1.Max := MAXINT;
 ProgressBar1.Min := 0;
 Update;
 X := Low(Integer);
 for I2 := X to 0 do
  begin
   if I2 mod 1000000 = 0 then
    begin
     ProgressBar1.Position := MAXINT + I2;
     Update;
    end;
   Y := MinFunction(I1, I2);
   if Y <> I2 then
    begin
     Result := False;
     Exit;
    end;
  end;
end;

function TMainForm.Validate4 : Boolean;
var
 I1, I2, Y1, Y2, X : Integer;
const
 VALIDATE4STEPSIZE : Integer = 98765;

begin
 ProgressBar1.Min := 0;
 ProgressBar1.Max := MAXINT;
 Result := True;
 I1 := High(Integer);
 while I1 >= Low(Integer) + VALIDATE4STEPSIZE do
  begin
   X := I1 shr 1;
   ProgressBar1.Position := (MAXINT shr 1 - X) * 2;
   Update;
   I2 := High(Integer);
   while I2 >= Low(Integer) + VALIDATE4STEPSIZE do
    begin
     Y1 := Min(I1, I2);
     Y2 := MinFunction(I1, I2);
     if Y1 <> Y2 then
      begin
       Result := False;
       Exit;
      end;
     Dec(I2, VALIDATE4STEPSIZE);
    end;
   Dec(I1, VALIDATE4STEPSIZE);
  end;
end;

function TMainForm.Validate5 : Boolean;
var
 X, I1, I2, Y : Integer;

begin
 Result := True;
 I1 := Low(Integer);
 ProgressBar1.Max := MAXINT;
 ProgressBar1.Min := Low(Integer);
 Update;
 X := Low(Integer);
 for I2 := X to MAXINT do
  begin
   if I2 mod 1000 = 0 then
    begin
     ProgressBar1.Position := I2;
     Update;
    end;
   Y := MinFunction(I1, I2);
   if Y <> I1 then
    begin
     Result := False;
     Exit;
    end;
  end;
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
 FunctionName := FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex];
 FunctionAddress := Cardinal(@MinFunction);
 FunctionAddressString := IntToHex(FunctionAddress, 8);
 AddressEdit.Text := FunctionAddressString;
 IntArrayMax := 10000;
 SetLength(IntArray, IntArrayMax);
 for J := 0 to IntArrayMax-1 do
  begin
   IntArray[J] := Random(MaxInt);
  end;
 Y1 := 0;
 Y2 := 0;
 Y3 := 0;
 StartTime := Time;
 for I1 := 1 to LOOPEND1 do
  begin
   for I2 := 0 to IntArrayMax-2 do
    begin
     Y1 := MinFunction(IntArray[I2], IntArray[I2+1]);
     Y2 := MinFunction(IntArray[I2+1], IntArray[I2]);
     Y3 := MinFunction(IntArray[I2], IntArray[I2]);
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
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 MinFunction := Min;
 X1Edit.Text := '1234';
 X2Edit.Text := '234';
 ReportRichEdit.Paragraph.TabCount := 1;
 ReportRichEdit.Paragraph.Tab[0] := 90;

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
    1 : MinFunction := MinDKCPas_a;
    2 : MinFunction := MinDKCPas_b;
    3 : MinFunction := MinDKCPas_c;
    4 : MinFunction := MinDKCPas_d;
    5 : MinFunction := MinLBG_a;
    6 : MinFunction := MinLBG_b;
    7 : MinFunction := MinLBG_c;
    8 : MinFunction := MinLBG_d;
    9 : MinFunction := MinShaIntegerPas_a;
   10 : MinFunction := MinShaIntegerPas_b;
   11 : MinFunction := MinShaIntegerPas_c;
   12 : MinFunction := MinShaIntegerPas_d;
   13 : MinFunction := MinShaInteger_a;
   14 : MinFunction := MinShaInteger_b;
   15 : MinFunction := MinShaInteger_c;
   16 : MinFunction := MinShaInteger_d;
 else
  raise Exception.Create('Invalid function');
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
 ReportRichEdit.Print('Min Results');
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName : AnsiString;

begin
 FunctionName := FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex];
 ValidEdit.Color := clBlue;
 Update;
 if Validate1 and
    Validate2 and
    Validate3 and
    Validate4 and
    Validate5 then
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

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
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
   AlignmentTest;
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

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 Update;
 for I := 0 to FunctionSelectRadioGroup.Items.Count-1 do
  begin
   FunctionSelectRadioGroup.ItemIndex := I;
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
   for I2 := 0 to FunctionSelectRadioGroup.Items.Count-1  do
    begin
     FunctionSelectRadioGroup.ItemIndex := I2;
     BenchmarkButtonClick(nil);
     Update;
    end;
   FunctionSelectRadioGroup.ItemIndex := I1;
   BenchmarkButtonClick(nil);
   for I3 := FunctionSelectRadioGroup.Items.Count-1 downto 0 do
    begin
     FunctionSelectRadioGroup.ItemIndex := I3;
     BenchmarkButtonClick(nil);
     Update;
    end;
  end;
 BenchTestButton.Caption := 'Bench Test';
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
