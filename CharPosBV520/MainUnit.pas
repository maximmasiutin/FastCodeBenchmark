unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, TeeProcs, TeEngine, Chart, Series,
  ComCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'CharPos';

type
  TMainForm = class(TForm)
    StrEdit: TEdit;
    CharEdit: TEdit;
    CharPosEdit: TEdit;
    CloseBitBtn: TBitBtn;
    Chart1: TChart;
    FunctionSelectRadioGroup: TRadioGroup;
    Series1: TLineSeries;
    Series2: TLineSeries;
    ReportRichEdit: TRichEdit;
    ValidateButton: TButton;
    ValidateAllButton: TButton;
    BenchmarkButton: TButton;
    BenchmarkAllButton: TButton;
    Panel1: TPanel;
    SaveReportSpeedButton: TSpeedButton;
    PrintSpeedButton: TSpeedButton;
    SaveDialog: TSaveDialog;
    ErrorEdit: TEdit;
    AddressEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ClearButton: TButton;
    RepeatBenchButton: TButton;
    SpreadBenchPercentageEdit: TEdit;
    Label6: TLabel;
    SpreadBench1Edit: TEdit;
    SpreadBench2Edit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    MaxSpreadButton: TButton;
    MaxSpreadBenchPercentageEdit: TEdit;
    Label13: TLabel;
    Series3: TLineSeries;
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    FunctionNameEdit: TEdit;
    CleanButton: TButton;
    Label5: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionSelectRadioGroupClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure SaveReportSpeedButtonClick(Sender: TObject);
    procedure PrintSpeedButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure RepeatBenchButtonClick(Sender: TObject);
    procedure MaxSpreadButtonClick(Sender: TObject);
    procedure CleanButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
   procedure ClearAllEditBoxes;
   procedure CleanResultsRichEdit;
   procedure BenchmarkTest;
   procedure AlignmentTest;
   function Benchmark : Integer;
   function Validate1 : Boolean;
   function Validate2 : Boolean;
   function Validate3 : Boolean;
   function Validate4 : Boolean;
   function Validate5 : Boolean;
   function Validate6 : Boolean;
   function Validate7 : Boolean;
   function Validate8 : Boolean;
   function Validate9 : Boolean;
   function Validate10 : Boolean;
   function Validate11 : Boolean;
   function Validate12 : Boolean;
   function Validate13 : Boolean;
   function Validate14 : Boolean;
   procedure SortRichEdit;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

uses FastcodeCPUID, SystemInfoUnit, CharPosUnit, CharPosJOHUnit, CharPosCJGUnit, CharPosShaUnit,
  CharPosDKCUnit;

{$R *.dfm}

type
 TCharPosFunction = function(Chr : Char; const Str : AnsiString) : Integer;

var
 CharPosFunction : TCharPosFunction;
 StringArray : array[1..255] of AnsiString;

const
 NOOFLOOPS : Cardinal = 40000;
 SCALE : Cardinal = 30000;

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

procedure TMainForm.FormCreate(Sender: TObject);
var
 J : Cardinal;
 Str1, Str2 : AnsiString;
 CpuString : string;
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 110;
 ReportRichEdit.Paragraph.Tab[1] := 160;
 CharPosFunction := CharPos_DKC_Pas_1_a;
 StrEdit.Text := '123456a8123456781234567812345678123';
 CharEdit.Text := 'a';
 Str1 := 'T';
 Str2 := '';
 for J := 1 to 255 do
  begin
   StringArray[J] := Str1 + Str2;
   Str2 := Str2 + 'X';
   if J mod 17 = 0 then
    Str2 := '';
   Str1 := 'A' + Str1;
  end;
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
 case FunctionSelectRadioGroup.ItemIndex+1 of
   1 : CharPosFunction := CharPos_DKC_Pas_1_a;
   2 : CharPosFunction := CharPos_DKC_Pas_1_b;
   3 : CharPosFunction := CharPos_DKC_Pas_1_c;
   4 : CharPosFunction := CharPos_DKC_Pas_1_d;
   5 : CharPosFunction := CharPos_PERL_IA32_1_a;
   6 : CharPosFunction := CharPos_PERL_IA32_1_b;
   7 : CharPosFunction := CharPos_PERL_IA32_1_c;
   8 : CharPosFunction := CharPos_PERL_IA32_1_d;
   9 : CharPosFunction := CharPos_JOH_MMX_1_a;
   10 : CharPosFunction := CharPos_JOH_MMX_1_b;
   11 : CharPosFunction := CharPos_JOH_MMX_1_c;
   12 : CharPosFunction := CharPos_JOH_MMX_1_d;
   13 : CharPosFunction := CharPos_JOH_SSE_1_a;
   14 : CharPosFunction := CharPos_JOH_SSE_1_b;
   15 : CharPosFunction := CharPos_JOH_SSE_1_c;
   16 : CharPosFunction := CharPos_JOH_SSE_1_d;
   17 : CharPosFunction := CharPos_DD_Pas_1_a;
   18 : CharPosFunction := CharPos_DD_Pas_1_b;
   19 : CharPosFunction := CharPos_DD_Pas_1_c;
   20 : CharPosFunction := CharPos_DD_Pas_1_d;
   21 : CharPosFunction := CharPos_JOH_Pas_1_a;
   22 : CharPosFunction := CharPos_JOH_Pas_1_b;
   23 : CharPosFunction := CharPos_JOH_Pas_1_c;
   24 : CharPosFunction := CharPos_JOH_Pas_1_d;
   25 : CharPosFunction := CharPos_Mw_PAS_2_a;
   26 : CharPosFunction := CharPos_Mw_PAS_2_b;
   27 : CharPosFunction := CharPos_Mw_PAS_2_c;
   28 : CharPosFunction := CharPos_Mw_PAS_2_d;
   29 : CharPosFunction := CharPos_JOH_SSE2_1_a;
   30 : CharPosFunction := CharPos_JOH_SSE2_1_b;
   31 : CharPosFunction := CharPos_JOH_SSE2_1_c;
   32 : CharPosFunction := CharPos_JOH_SSE2_1_d;
   33 : CharPosFunction := CharPos_DKC_MMX_1_a;
   34 : CharPosFunction := CharPos_DKC_MMX_1_b;
   35 : CharPosFunction := CharPos_DKC_MMX_1_c;
   36 : CharPosFunction := CharPos_DKC_MMX_1_d;
   37 : CharPosFunction := CharPos_DKC_SSE_1_a;
   38 : CharPosFunction := CharPos_DKC_SSE_1_b;
   39 : CharPosFunction := CharPos_DKC_SSE_1_c;
   40 : CharPosFunction := CharPos_DKC_SSE_1_d;
   41 : CharPosFunction := CharPos_JOH_Pas_2_a;
   42 : CharPosFunction := CharPos_JOH_Pas_2_b;
   43 : CharPosFunction := CharPos_JOH_Pas_2_c;
   44 : CharPosFunction := CharPos_JOH_Pas_2_d;
   45 : CharPosFunction := CharPos_CJG_Pas_3_a;
   46 : CharPosFunction := CharPos_CJG_Pas_3_b;
   47 : CharPosFunction := CharPos_CJG_Pas_3_c;
   48 : CharPosFunction := CharPos_CJG_Pas_3_d;
   49 : CharPosFunction := CharPos_JOH_IA32_1_a;
   50 : CharPosFunction := CharPos_JOH_IA32_1_b;
   51 : CharPosFunction := CharPos_JOH_IA32_1_c;
   52 : CharPosFunction := CharPos_JOH_IA32_1_d;
   53 : CharPosFunction := CharPos_Sha_Pas_1_a;
   54 : CharPosFunction := CharPos_Sha_Pas_1_b;
   55 : CharPosFunction := CharPos_Sha_Pas_1_c;
   56 : CharPosFunction := CharPos_Sha_Pas_1_d;
   57 : CharPosFunction := CharPos_Sha_Pas_2_a;
   58 : CharPosFunction := CharPos_Sha_Pas_2_b;
   59 : CharPosFunction := CharPos_Sha_Pas_2_c;
   60 : CharPosFunction := CharPos_Sha_Pas_2_d;
   61 : CharPosFunction := CharPos_Sha_IA32_1_a;
   62 : CharPosFunction := CharPos_Sha_IA32_1_b;
   63 : CharPosFunction := CharPos_Sha_IA32_1_c;
   64 : CharPosFunction := CharPos_Sha_IA32_1_d;
   65 : CharPosFunction := CharPos_CJG_Pas_5_a;
   66 : CharPosFunction := CharPos_CJG_Pas_5_b;
   67 : CharPosFunction := CharPos_CJG_Pas_5_c;
   68 : CharPosFunction := CharPos_CJG_Pas_5_d;
   69 : CharPosFunction := CharPos_CJG_Pas_6_a;
   70 : CharPosFunction := CharPos_CJG_Pas_6_b;
   71 : CharPosFunction := CharPos_CJG_Pas_6_c;
   72 : CharPosFunction := CharPos_CJG_Pas_6_d;
   73 : CharPosFunction := CharPos_CJG_Pas_7_a;
   74 : CharPosFunction := CharPos_CJG_Pas_7_b;
   75 : CharPosFunction := CharPos_CJG_Pas_7_c;
   76 : CharPosFunction := CharPos_CJG_Pas_7_d;
   77 : CharPosFunction := CharPos_CJG_Pas_9_a;
   78 : CharPosFunction := CharPos_CJG_Pas_9_b;
   79 : CharPosFunction := CharPos_CJG_Pas_9_c;
   80 : CharPosFunction := CharPos_CJG_Pas_9_d;
  else
   raise Exception.Create('Invalid function');
  end;
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
begin
 ErrorEdit.Color := clSkyBlue;
 ErrorEdit.Text := '';
 Update;
 if Validate1 and
    Validate2 and
    Validate3 and
    Validate4 and
    Validate5 and
    Validate6 and
    Validate7 and
    Validate8 and
    Validate9 and
    Validate10 and
    Validate11 and
    Validate12 and
    Validate13 and
    Validate14 then
  ReportRichEdit.Lines.Add(FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex] + #9 + 'Passed')
 else
  ReportRichEdit.Lines.Add(FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex] + #9 + 'Failed')
end;

function TMainForm.Validate1 : Boolean;
var
 StringArray : array[1..24] of AnsiString;
 Chr : Char;
 Str : AnsiString;
 StrNo, CharPos : Cardinal;

begin
 Result := True;
 Chr := 'Y';
 StringArray[1] := '';
 StringArray[2] := 'Y';
 StringArray[3] := 'X';
 StringArray[4] := 'YX';
 StringArray[5] := 'XY';
 StringArray[6] := '12345678';
 StringArray[7] := '1234567Y';
 StringArray[8] := 'YY123456';
 StringArray[9] := 'YYY1234567';
 StringArray[10] := 'YYYY1234567';
 StringArray[11] := 'YYYYY1234567';
 StringArray[12] := 'YYYYYY1234567';
 StringArray[13] := 'YYYYYYY1234567';
 StringArray[14] := 'YYYYYYYY1234567';
 StringArray[15] := 'YYYYYYYYYYYYYYYY';
 StringArray[16] := 'aYYYYYYYYYYYYYYYY';
 StringArray[17] := 'aaYYYYYYYYYYYYYYYY';
 StringArray[18] := 'aaaYYYYYYYYYYYYYYYY';
 StringArray[19] := 'aaaaYYYYYYYYYYYYYYYY';
 StringArray[20] := 'aaaaaYYYYYYYYYYYYYYYY';
 StringArray[21] := 'aaaaaaYYYYYYYYYYYYYYYY';
 StringArray[22] := 'aaaaaaaYYYYYYYYYYYYYYYY';
 StringArray[23] := 'aaaaaaaaYYYYYYYYYYYYYYYY';
 StringArray[24] := '12345678';
 ErrorEdit.Color := clGreen;
 for StrNo := 1 to 24 do
  begin
   if StrNo = 24 then
    Chr := #0;
   Str := StringArray[StrNo];
   CharPos := CharPosFunction(Chr, Str);
   case StrNo of
    1 :
     begin
      if CharPos <> 0 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '0';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    2 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    3 :
     begin
      if CharPos <> 0 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '0';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    4 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    5 :
     begin
      if CharPos <> 2 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '2';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    6 :
     begin
      if CharPos <> 0 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '0';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    7 :
     begin
      if CharPos <> 8 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '8';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    8 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    9 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    10 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    11 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    12 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    13 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    14 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    15 :
     begin
      if CharPos <> 1 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '1';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    16 :
     begin
      if CharPos <> 2 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '2';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    17 :
     begin
      if CharPos <> 3 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '3';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    18 :
     begin
      if CharPos <> 4 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '4';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    19 :
     begin
      if CharPos <> 5 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '5';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    20 :
     begin
      if CharPos <> 6 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '6';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    21 :
     begin
      if CharPos <> 7 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '7';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    22 :
     begin
      if CharPos <> 8 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '8';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    23 :
     begin
      if CharPos <> 9 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '9';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
    24 :
     begin
      if CharPos <> 0 then
       begin
        ErrorEdit.Text := IntToStr(CharPos) + ' <> ' + '0';
        ErrorEdit.Color := clRed;
        Result := False;
        Break;
       end;
     end;
   end;
  end;
end;

function TMainForm.Validate2 : Boolean;
var
 Chr : Char;
 Str : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 K : Cardinal;

begin
 Result := True;
 Chr := 's';
 Str := #0;
 for K := 1 to 10000 do
  begin
   Str := Char(Random(255)) + Str;
   CharPos1 := Pos(Chr, Str);
   CharPos2 := CharPosFunction(Chr, Str);
   if CharPos1 <> CharPos2 then
    begin
     ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
     ErrorEdit.Color := clRed;
     Result := False;
     Break;
    end;
  end;
end;

function TMainForm.Validate3 : Boolean;
var
 Chr1 : Char;
 Str : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I : Byte;

begin
 Result := True;
 Str := 'abcdefghijklmnopqrstuvwzxyABCDEFGHIJKLMNOPQRSTUVWZX1234567890@£${[]}|~\+´¨,.-!"#¤%&/()=?`^*_:';
 for I := 0 to 255 do
  begin
   Chr1 := Char(I);
   CharPos1 := Pos(Chr1, Str);
   CharPos2 := CharPosFunction(Chr1, Str);
   if CharPos1 <> CharPos2 then
    begin
     ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
     ErrorEdit.Color := clRed;
     Result := False;
     Break;
    end;
  end;
end;

function TMainForm.Validate4 : Boolean;
var
 Chr : Char;
 Str : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I1, I2 : Byte;

begin
 Result := True;
 for I1 := 0 to 255 do
  begin
   Str := Char(I1);
   for I2 := 0 to 255 do
    begin
     Chr := Char(I2);
     CharPos1 := Pos(Chr, Str);
     CharPos2 := CharPosFunction(Chr, Str);
     if CharPos1 <> CharPos2 then
      begin
       ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
       ErrorEdit.Color := clRed;
       Result := False;
       Break;
      end;
    end;
  end;
end;

function TMainForm.Validate5 : Boolean;
var
 Chr : Char;
 Str : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I1, I2, I3 : Byte;

begin
 Result := True;
 for I1 := 0 to 100 do
  begin
   for I2 := 0 to 100 do
    begin
     Str := Char(I1) + Char(I2);
     for I3 := 0 to 100 do
      begin
       Chr := Char(I3);
       CharPos1 := Pos(Chr, Str);
       CharPos2 := CharPosFunction(Chr, Str);
       if CharPos1 <> CharPos2 then
        begin
         ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
         ErrorEdit.Color := clRed;
         Result := False;
         Break;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate6 : Boolean;
var
 Chr : Char;
 Str : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I1, I2, I3, I4 : Byte;

begin
 Result := True;
 for I1 := 0 to 10 do
  begin
   for I2 := 140 to 150 do
    begin
     for I3 := 230 to 255 do
      begin
       Str := Char(I1) + Char(I2) + Char(I3);
       for I4 := 60 to 80 do
        begin
         Chr := Char(I4);
         CharPos1 := Pos(Chr, Str);
         CharPos2 := CharPosFunction(Chr, Str);
         if CharPos1 <> CharPos2 then
          begin
           ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
           ErrorEdit.Color := clRed;
           Result := False;
           Break;
          end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate7 : Boolean;
var
 Chr : Char;
 Str : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I1, I2, I3, I4, I5 : Byte;

begin
 Result := True;
 for I1 := 0 to 10 do
  begin
   for I2 := 230 to 240 do
    begin
     for I3 := 85 to 90 do
      begin
       for I4 := 70 to 74 do
        begin
         Str := Char(I1) + Char(I2) + Char(I3) + Char(I4);
         for I5 := 0 to 255 do
          begin
           Chr := Char(I5);
           CharPos1 := Pos(Chr, Str);
           CharPos2 := CharPosFunction(Chr, Str);
           if CharPos1 <> CharPos2 then
            begin
             ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
             ErrorEdit.Color := clRed;
             Result := False;
             Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate8 : Boolean;
var
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter : Cardinal;
 X, Y, Z : Extended;
 Str : AnsiString;

begin
 Str := 'Welcome my dear - to the register check';
 asm
  mov EBXRegisterBefore, ebx
  mov EDIRegisterBefore, edi
  mov ESIRegisterBefore, esi
 end;
 //CharPosFunction(Chr, Str);
 asm
  mov edx,Str
  mov eax,8
  call dword ptr [CharPosFunction]
 end;
 asm
  mov EBXRegisterAfter, ebx
  mov EDIRegisterAfter, edi
  mov ESIRegisterAfter, esi
 end;
 //Verify that registers are preserved
 if ((EBXRegisterAfter <> EBXRegisterBefore) or
     (EDIRegisterAfter <> EDIRegisterBefore) or
     (ESIRegisterAfter <> ESIRegisterBefore)) then
  begin
   ErrorEdit.Text := 'EBX, EDI or ESI register not preserved';
   Result := False;
  end
 else
  begin
   ErrorEdit.Text := 'Passed register test';
   Result := True;
  end;
 try
  X := 2;
  Y := 3;
  Z := X * Y;
  if Z <> 6 then
   Z := 6;
 except
  ErrorEdit.Text := 'EMMS is missing';
  Result := False;
 end;
end;

function TMainForm.Validate9 : Boolean;
var
 Chr : Char;
 Str : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I1, I2, I3, I4, I5, I6 : Byte;

begin
 Result := True;
 for I1 := 0 to 5 do
  begin
   for I2 := 15 to 20 do
    begin
     for I3 := 205 to 210 do
      begin
       for I4 := 30 to 40 do
        begin
         for I5 := 40 to 50 do
          begin
           Str := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5);
           for I6 := 100 to 255 do
            begin
             Chr := Char(I6);
             CharPos1 := Pos(Chr, Str);
             CharPos2 := CharPosFunction(Chr, Str);
             if CharPos1 <> CharPos2 then
              begin
               ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
               ErrorEdit.Color := clRed;
               Result := False;
               Break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate10 : Boolean;
var
 Chr1, Chr2 : Char;
 Str, Str1 : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I, J : Byte;
 StringArray : array[0..255] of AnsiString;

begin
 Str1 := 'T';
 for J := 0 to 255 do
  begin
   StringArray[J] := Str1;
   Str1 := 'A' + Str1;
  end;
 Chr1 := 'T';
 Chr2 := 'X';
 Result := True;
 for I := 0 to 255 do
  begin
   Str := StringArray[I];
   CharPos1 := CharPosFunction(Chr1, Str);
   if CharPos1 <> I+1 then
    begin
     Result := False;
     Break;
    end;
   CharPos2 := CharPosFunction(Chr2, Str);
   if CharPos2 <> 0 then
    begin
     Result := False;
     Break;
    end;
  end;
end;

function TMainForm.Validate11 : Boolean;
var
 Chr : Char;
 Str, ExtendedStr : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I1, I2, I3, I4, I5, I6 : Byte;

begin
 Result := True;
 for I1 := 100 to 110 do
  begin
   for I2 := 210 to 220 do
    begin
     for I3 := 20 to 30 do
      begin
       for I4 := 35 to 40 do
        begin
         for I5 := 55 to 60 do
          begin
           Str := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5);
           for I6 := 20 to 25 do
            begin
             Chr := Char(I6);
             ExtendedStr := Str + Str + Str;
             CharPos1 := Pos(Chr, ExtendedStr);
             CharPos2 := CharPosFunction(Chr, ExtendedStr);
             if CharPos1 <> CharPos2 then
              begin
               ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
               ErrorEdit.Color := clRed;
               Result := False;
               Break;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate12 : Boolean;
var
 Chr : Char;
 Str, ExtendedStr : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I1, I2, I3, I4, I5, I6, I7 : Byte;

begin
 Result := True;
 for I1 := 0 to 5 do
  begin
   for I2 := 0 to 5 do
    begin
     for I3 := 0 to 5 do
      begin
       for I4 := 0 to 5 do
        begin
         for I5 := 0 to 5 do
          begin
           for I6 := 0 to 5 do
            begin
             Str := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6);
             for I7 := 0 to 5 do
              begin
               ExtendedStr := 'ABCDEFGHIJKLMNOPQRTSUVZXY!"#¤%&/()=?`^*_:;1234567890+´¨-.,<@£$[]}|~\' + Str;
               Chr := Char(I7);
               CharPos1 := Pos(Chr, ExtendedStr);
               CharPos2 := CharPosFunction(Chr, ExtendedStr);
               if CharPos1 <> CharPos2 then
                begin
                 ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
                 ErrorEdit.Color := clRed;
                 Result := False;
                 Break;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate13 : Boolean;
var
 Chr : Char;
 Str : AnsiString;
 CharPos1, CharPos2 : Cardinal;
 I1, I2, I3, I4, I5, I6, I7, I8, I9 : Byte;

begin
 Result := True;
 for I1 := 0 to 2 do
  begin
   for I2 := 1 to 3 do
    begin
     for I3 := 2 to 4 do
      begin
       for I4 := 3 to 5 do
        begin
         for I5 := 4 to 6 do
          begin
           for I6 := 5 to 7 do
            begin
             for I7 := 6 to 8 do
              begin
               for I8 := 7 to 9 do
                begin
                 Str := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6) + Char(I7) + Char(I8);
                 for I9 := 0 to 5 do
                  begin
                   Chr := Char(I9);
                   CharPos1 := Pos(Chr, Str);
                   CharPos2 := CharPosFunction(Chr, Str);
                   if CharPos1 <> CharPos2 then
                    begin
                     ErrorEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
                     ErrorEdit.Color := clRed;
                     Result := False;
                     Break;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

var
 S1Global : string;

function TMainForm.Validate14 : Boolean;
var
 ChrPos : Integer;

begin
 S1Global := 'z';
 (PInteger(Integer(S1Global)-4))^ := 0;
 ChrPos := CharPosFunction('z', S1Global);
 if ChrPos <> 0 then
  Result := False
 else
  Result := True;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I, FunctionAddress : Cardinal;
 FunctionAddressString : AnsiString;

begin
 ValidateAllButton.Caption := 'Running';
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_LOWEST) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_LOWEST failed');

 ReportRichEdit.Clear;
 Label4.Caption := 'Validation';
 Update;
 for I := 0 to FunctionSelectRadioGroup.Items.Count-1 do
  begin
   FunctionSelectRadioGroup.ItemIndex := I;
   FunctionAddress := Cardinal(@CharPosFunction);
   FunctionAddressString := IntToHex(FunctionAddress, 8);
   AddressEdit.Text := FunctionAddressString;
   try
   if Validate1 and
      Validate2 and
      Validate3 and
      Validate4 and
      Validate5 and
      Validate6 and
      Validate7 and
      Validate8 and
      Validate9 and
      Validate10 and
      Validate11 and
      Validate12 and
      Validate13 and
      Validate14 then
    ReportRichEdit.Lines.Add(FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex] + #9 + FunctionAddressString[8] + #9 + 'Passed')
   else
    ReportRichEdit.Lines.Add(FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex] + #9 + FunctionAddressString[8] + #9 + 'Failed');
   except
   begin
    FunctionAddress := Cardinal(@CharPosFunction);
    FunctionAddressString := IntToHex(FunctionAddress, 8);
    ReportRichEdit.Lines.Add(FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex] + #9 + FunctionAddressString[8] + #9 + 'Failed');
   end;
   end;
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

function TMainForm.Benchmark : Integer;
var
 lpPerformanceCount, StartCount, EndCount, lpFrequency, NoOfTicks, NoOfTicksMin : TLargeInteger;
 Succes : Boolean;
 FunctionName, FunctionAddressString : AnsiString;
 Chr1, Chr2 : Char;
 I, CharPos, K, FunctionAddress, RunCount : Cardinal;
 RunTimeSec : Double;
 Bench1FP, Bench2FP, SumBenchFP : Double;
const
 RUNCOUNTMAX : Cardinal = 3;

begin
 try
  StartCount := 0;
  EndCount := 0;
  FunctionName := FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@CharPosFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  AddressEdit.Text := FunctionAddressString;
  Succes := QueryPerformanceFrequency(lpFrequency);
  if not Succes then
   raise Exception.Create('QueryPerformanceFrequency failed');
  CharPos := 0;
  Series1.Clear;
  SumBenchFP := 0;
  Chr1 := 'T';
  Chr2 := 'X';
  for K := 1 to 255 do
   begin
    RunCount := 0;
    NoOfTicksMin := TLargeInteger(MaxInt)*MaxInt;
    repeat
     Inc(RunCount);
     Succes := QueryPerformanceCounter(lpPerformanceCount);
     if Succes then
      StartCount := lpPerformanceCount
     else
      raise Exception.Create('QueryPerformanceCounter failed');
     for I := 1 to NOOFLOOPS do
      begin
       CharPos := CharPosFunction(Chr1, StringArray[K]);
      end;
     for I := 1 to NOOFLOOPS do
      begin
       CharPos := CharPosFunction(Chr2, StringArray[K]);
      end;
     Succes := QueryPerformanceCounter(lpPerformanceCount);
     if Succes then
      EndCount := lpPerformanceCount
     else
      raise Exception.Create('QueryPerformanceCounter failed');
     NoOfTicks := EndCount - StartCount;
     if NoOfTicks < NoOfTicksMin then
      NoOfTicksMin := NoOfTicks;
    until(RunCount = RUNCOUNTMAX);
    RunTimeSec := NoOfTicksMin / lpFrequency;
    Bench1FP := RunTimeSec * SCALE;
    Series1.AddXY(K, Bench1FP, '', clBlue);
    Bench2FP := Bench1FP/K;
    SumBenchFP := SumBenchFP + Bench2FP;
    Update;
   end;
  CharPosEdit.Text := IntToStr(CharPos);
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + FloatToStrF(SumBenchFP, ffFixed, 8, 0));
  Result := Round(SumBenchFP);
 except
  Result := 0;
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Exception' + #9 + '9999');
 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
 BenchmarkAllButton.Caption := 'Running';

 ReportRichEdit.Clear;
 Label4.Caption := 'Benchmark';
 Update;
 for I := 0 to FunctionSelectRadioGroup.Items.Count-1 do
  begin
   FunctionSelectRadioGroup.ItemIndex := I;
   Benchmark;
   BenchmarkTest;
   AlignmentTest;
   if ReportRichEdit.Lines.Count >= 1 then
    SortRichEdit;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := FResultsFileName;
 if SaveDialog.Execute then
  begin
   ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('CharPos Report');
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
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

//Finds the maximum spread in benchmarks due to code lignment for any function.

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
 AlignSpreadBench1Edit.Text := '';
 AlignSpreadBench2Edit.Text := '';
 AlignMaxSpreadBenchPercentageEdit.Text := '';
 AlignFunctionName1Edit.Text := '';
 AlignFunctionName2Edit.Text := '';
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
             AlignSpreadBench1Edit.Text := BenchString1;
             AlignSpreadBench2Edit.Text := BenchString2;
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
 SpreadBench1Edit.Text := '';
 SpreadBench2Edit.Text := '';
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
         SpreadBench1Edit.Text := BenchString1;
         SpreadBench2Edit.Text := BenchString2;
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

//Removes multiple results from same function. Preserves the fastest result

procedure TMainForm.CleanResultsRichEdit;
var
 LineNo1, LineNo2, Tab1Pos1, Tab1Pos2 : Integer;
 S1, S2, FunctionName1, FunctionName2 : AnsiString;

begin
 for LineNo1 := 0 to ReportRichEdit.Lines.Count-2 do
  begin
   S1 := ReportRichEdit.Lines[LineNo1];
   LineNo2 := LineNo1+1;
   while LineNo2 <= ReportRichEdit.Lines.Count-1 do
    begin
     S2 := ReportRichEdit.Lines[LineNo2];
     Tab1Pos1 := CharPos(#9, S1);
     Tab1Pos2 := CharPos(#9, S2);
     FunctionName1 := Copy(S1, 0, Tab1Pos1-1);
     FunctionName2 := Copy(S2, 0, Tab1Pos2-1);
     if FunctionName1 = FunctionName2 then
      begin
       ReportRichEdit.Lines.Delete(LineNo2);
       Dec(LineNo2);
      end;
     Inc(LineNo2);
    end;
  end;
end;

procedure TMainForm.RepeatBenchButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 for I := 1 to 20 do
  begin
   BenchmarkButtonClick(nil);
   BenchmarkTest;
   AlignmentTest;
  end;
end;

procedure TMainForm.MaxSpreadButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 MaxSpreadBenchPercentageEdit.Text := '0';
 for I := 0 to FunctionSelectRadioGroup.Items.Count-1 do
  begin
   ReportRichEdit.Clear;
   FunctionSelectRadioGroup.ItemIndex := I;
   RepeatBenchButtonClick(nil);
   if StrToFloat(SpreadBenchPercentageEdit.Text) > StrToFloat(MaxSpreadBenchPercentageEdit.Text) then
    MaxSpreadBenchPercentageEdit.Text := SpreadBenchPercentageEdit.Text;
   Update;
  end;
end;

procedure TMainForm.CleanButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 Benchmark;
 BenchmarkTest;
 AlignmentTest;
 if ReportRichEdit.Lines.Count >= 1 then
  SortRichEdit;
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
