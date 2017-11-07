unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TMainForm = class(TForm)
    ValidateExtendedButton: TButton;
    ValidationEdit: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    ReportRichEdit: TRichEdit;
    BenchmarkExtendedButton: TButton;
    RuntimeEdit: TEdit;
    ExtendedFunctionSelectionRadioGroup: TRadioGroup;
    BenchmarkAllButton: TButton;
    Label2: TLabel;
    Bench1Edit: TEdit;
    Bench2Edit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ValidateAllButton: TButton;
    ClearButton: TButton;
    MaxSpreadBenchPercentageEdit: TEdit;
    FunctionNameEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    SaveReportSpeedButton: TSpeedButton;
    PrintReportSpeedButton: TSpeedButton;
    SaveDialog: TSaveDialog;
    BenchTestButton: TButton;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    CleanResultsButton: TButton;
    DoubleFunctionSelectionRadioGroup: TRadioGroup;
    SingleFunctionSelectionRadioGroup: TRadioGroup;
    ValidateDoubleButton: TButton;
    ValidateSingleButton: TButton;
    BenchmarkDoubleButton: TButton;
    BenchmarkSingleButton: TButton;
    Set8087PrecisionRadioGroup: TRadioGroup;
    SetRoundModeRadioGroup: TRadioGroup;
    procedure ValidateExtendedButtonClick(Sender: TObject);
    procedure BenchmarkExtendedButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExtendedFunctionSelectionRadioGroupClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure SaveReportSpeedButtonClick(Sender: TObject);
    procedure PrintReportSpeedButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure MaxSpreadBenchPercentageEditClick(Sender: TObject);
    procedure CleanResultsButtonClick(Sender: TObject);
    procedure DoubleFunctionSelectionRadioGroupClick(Sender: TObject);
    procedure SingleFunctionSelectionRadioGroupClick(Sender: TObject);
    procedure ValidateDoubleButtonClick(Sender: TObject);
    procedure ValidateSingleButtonClick(Sender: TObject);
    procedure BenchmarkDoubleButtonClick(Sender: TObject);
    procedure BenchmarkSingleButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Set8087PrecisionRadioGroupClick(Sender: TObject);
    procedure SetRoundModeRadioGroupClick(Sender: TObject);
  private
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
    function ValidateDouble7 : Boolean;
    function ValidateExtended1 : Boolean;
    function ValidateExtended2 : Boolean;
    function ValidateExtended3 : Boolean;
    function ValidateExtended4 : Boolean;
    function ValidateExtended5 : Boolean;
    function ValidateExtended6 : Boolean;
    procedure BenchmarkExtended;
    procedure BenchmarkDouble;
    procedure BenchmarkSingle;
    procedure ClearAllEditBoxes;
    procedure CleanResultsFPRichEdit;
    procedure SortRichEdit1;
    procedure SortRichEditFP;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    function SubBenchmarkExtended1 : Cardinal;
    function SubBenchmarkExtended2 : Cardinal;
    function SubBenchmarkDouble1 : Cardinal;
    function SubBenchmarkSingle1 : Cardinal;
    function SubBenchmarkDouble2 : Cardinal;
    function SubBenchmarkSingle2 : Cardinal;
  public
    { Public declarations }
  end;

var
 MainForm: TMainForm;

implementation

uses
 ComplexDataTypesUnit, Math, RegtToPolDKCUnit, RectToPol_JOH;

{$R *.dfm}

const
 NOOFRUNS : Cardinal = 2000;
 SUB1NOOFRUNS : Cardinal = 90;
 SUB2NOOFRUNS : Cardinal = 5;
 SUBBENCH1SCALE : Double = 300;
 SUBBENCH1ARRAYSIZE : Cardinal = 30;
 SUBBENCH2ARRAYSIZE : Cardinal = 200;
 NOOFRERUNS : Cardinal = 3;
 BENCHARRAYSIZE : Cardinal = 1000;
 MINVALIDATEEXTENDED2 : Extended = 1E-2000;
 MAXVALIDATEEXTENDED2 : Extended = 1E2000;
 VALIDATEEXTENDED2STEPSIZE : Extended = 8E2;
 MINVALIDATESINGLE2 : Single = 1E-18;
 MAXVALIDATESINGLE2 : Single = 1E18;
 VALIDATESINGLE2STEPSIZE : Single = 1.03;
 MINEXTENDED : Extended = 3.6E-4951;
 MAXEXTENDED : Extended = 1.1E4932;
 EXTENDEDLIMIT : Extended = 1E-18;
 MINSINGLE : Single = 1.5E-45;
 MAXSINGLE : Single = 3.4E38;
 SINGLELIMIT : Single = 1E-7;
 SLEEPVALIDATE4 : Cardinal = 250;
 //SSE2 limits
 VALIDATEDOUBLE2STEPSIZE_SSE2 : Double = 1.1;
 MAXVALIDATEDOUBLE2_SSE2 : Double = 1E5;
 MINDOUBLE_SSE2 : Double = 1E-5;
 MAXDOUBLE_SSE2 : Double = 1E5;
 DOUBLELIMIT_SSE2 : Double = 1E-1;
 //IA 32 Limits
 VALIDATEDOUBLE2STEPSIZE : Double = 1.1;
 MAXVALIDATEDOUBLE6 : Double = 1E100;
 MINVALIDATEDOUBLE6 : Double = 1E-100;
 MINDOUBLE : Double = 5E-324;
 MAXDOUBLE : Double = 1.7E308;
 DOUBLELIMIT : Double = 1E-15;

type
 TRegtToPolExtendedFunction = function (const X : TRegtangularComplexE) : TPolarComplexE;
 TRegtToPolDoubleFunction = function (const X : TRegtangularComplexD) : TPolarComplexD;
 TRegtToPolSingleFunction = function (const X : TRegtangularComplexS) : TPolarComplexS;

var
 ExtendedSrc1Sub2BenchmarkArrayInitAdress : Cardinal;
 DoubleSrc1Sub2BenchmarkArrayInitAdress : Cardinal;
 SingleSrc1Sub2BenchmarkArrayInitAdress : Cardinal;
 ExtendedResultSub2BenchmarkArrayInitAdress : Cardinal;
 DoubleResultSub2BenchmarkArrayInitAdress : Cardinal;
 SingleResultSub2BenchmarkArrayInitAdress : Cardinal;
 RegtToPolExtendedFunction : TRegtToPolExtendedFunction;
 RegtToPolDoubleFunction : TRegtToPolDoubleFunction;
 RegtToPolSingleFunction : TRegtToPolSingleFunction;
 ExtendedSrc1Sub1BenchmarkArray : array of TRegtangularComplexE;
 DoubleSrc1Sub1BenchmarkArray : array of TRegtangularComplexD;
 SingleSrc1Sub1BenchmarkArray : array of TRegtangularComplexS;
 ExtendedSrc2Sub1BenchmarkArray : array of TRegtangularComplexE;
 DoubleSrc2Sub1BenchmarkArray : array of TRegtangularComplexD;
 SingleSrc2Sub1BenchmarkArray : array of TRegtangularComplexS;
 ExtendedResultSub1BenchmarkArray : array of TPolarComplexE;
 DoubleResultSub1BenchmarkArray : array of TPolarComplexD;
 SingleResultSub1BenchmarkArray : array of TPolarComplexS;
 ExtendedSrc1Sub2BenchmarkArray : array of TRegtangularComplexE;
 DoubleSrc1Sub2BenchmarkArray : array of TRegtangularComplexD;
 SingleSrc1Sub2BenchmarkArray : array of TRegtangularComplexS;
 ExtendedResultSub2BenchmarkArray : array of TPolarComplexE;
 DoubleResultSub2BenchmarkArray : array of TPolarComplexD;
 SingleResultSub2BenchmarkArray : array of TPolarComplexS;
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
 Bench1Edit.Text := '';
 Bench2Edit.Text := '';
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

//Removes Divtiple results from same function. Preserves the fastest result

procedure TMainForm.CleanResultsFPRichEdit;
var
 LineNo1, LineNo2, Tab1Pos1, Tab1Pos2, Tab2Pos1, Tab2Pos2 : Integer;
 S1, S2, FunctionName1, FunctionName2, Precision1, Precision2, CompleteFunctionName1, CompleteFunctionName2 : AnsiString;

begin
 //Results must be sorted
 SortRichEditFP;
 for LineNo1 := 0 to ReportRichEdit.Lines.Count-2 do
  begin
   S1 := ReportRichEdit.Lines[LineNo1];
   LineNo2 := LineNo1+1;
   while LineNo2 <= ReportRichEdit.Lines.Count-1 do
    begin
     S2 := ReportRichEdit.Lines[LineNo2];
     Tab1Pos1 := CharPosEY(S1, #9, 1);
     Tab1Pos2 := CharPosEY(S2, #9, 1);
     Tab2Pos1 := CharPosEY(S1, #9, 2);
     Tab2Pos2 := CharPosEY(S2, #9, 2);
     FunctionName1 := Copy(S1, 0, Tab1Pos1-1);
     Precision1 := Copy(S1, Tab1Pos1+1, Tab2Pos1-Tab1Pos1-1);
     CompleteFunctionName1 := FunctionName1 + Precision1;
     FunctionName2 := Copy(S2, 0, Tab1Pos2-1);
     Precision2 := Copy(S2, Tab1Pos2+1, Tab2Pos2-Tab1Pos2-1);
     CompleteFunctionName2 := FunctionName2 + Precision2;
     if CompleteFunctionName1 = CompleteFunctionName2 then
      begin
       ReportRichEdit.Lines.Delete(LineNo2);
       Dec(LineNo2);
      end;
     Inc(LineNo2);
    end;
  end;
end;

function TMainForm.ValidateExtended1 : Boolean;
var
 X : TRegtangularComplexE;
 Y : TPolarComplexE;

begin
 Result := True;
 X.RealPart := 1;
 X.ImaginaryPart := 0;
 Y := RegtToPolExtendedFunction(X);
 if not((Y.Amplitude = 1) and (Y.Phase = 0)) then
  begin
   Result := False;
   Exit;
  end;
 X.RealPart := 0;
 X.ImaginaryPart := 1;
 Y := RegtToPolExtendedFunction(X);
 if not((Y.Amplitude = 1) and (Y.Phase = PI/2)) then
  begin
   Result := False;
   Exit;
  end;
 X.RealPart := -1;
 X.ImaginaryPart := 0;
 Y := RegtToPolExtendedFunction(X);
 if not((Y.Amplitude = 1) and (Y.Phase = PI)) then
  begin
   Result := False;
   Exit;
  end;
 X.RealPart := 1;
 X.ImaginaryPart := 1;
 Y := RegtToPolExtendedFunction(X);
 if ( Abs(Y.Amplitude - Sqrt(2)) >  EXTENDEDLIMIT)  and (Abs(Y.Phase - PI/4) < EXTENDEDLIMIT) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateExtended2 : Boolean;
var
 X : TRegtangularComplexE;
 Y1, Y2 : TPolarComplexE;

begin
 Result := True;
 X.ImaginaryPart := MINVALIDATEEXTENDED2;
 while X.ImaginaryPart < MAXVALIDATEEXTENDED2 do
  begin
   X.RealPart := MINVALIDATEEXTENDED2;
   while X.RealPart < MAXVALIDATEEXTENDED2 do
    begin
     Y1 := RectToPol_JOH_PAS(X);
     Y2 := RegtToPolExtendedFunction(X);
     if ((Y1.Amplitude <> 0) and (Y1.Phase <> 0)) then
      begin
       if (Abs((Y1.Amplitude - Y2.Amplitude) / Y1.Amplitude) > EXTENDEDLIMIT) or
          (Abs((Y1.Phase - Y2.Phase) / Y1.Phase) > EXTENDEDLIMIT) then
        begin
         Result := False;
         Exit;
        end;
      end;
     X.RealPart := X.RealPart * VALIDATEEXTENDED2STEPSIZE;
    end;
   X.ImaginaryPart := X.ImaginaryPart * VALIDATEEXTENDED2STEPSIZE;
  end;
end;

function TMainForm.ValidateExtended3 : Boolean;
var
 X : TRegtangularComplexE;
 Y : TPolarComplexE;

begin
 Result := False;
 try
  X.RealPart := MAXEXTENDED;
  X.ImaginaryPart := MAXEXTENDED;
  Y := RegtToPolExtendedFunction(X);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateExtended4 : Boolean;
var
 X : TRegtangularComplexE;
 Y : TPolarComplexE;
 J1, J2 : Cardinal;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;

begin
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
     Sleep(SLEEPVALIDATE4);
     X.RealPart := 1;
     X.ImaginaryPart := 1;
     ControlWordBefore := Get8087CW;
     Y := RegtToPolExtendedFunction(X);
     ControlWordAfter := Get8087CW;
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
end;

function TMainForm.ValidateExtended5 : Boolean;
var
 X : TRegtangularComplexE;
 Y : TPolarComplexE;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;

begin
 Result := True;
 if SSESupported then
  begin
   X.RealPart := 1;
   X.ImaginaryPart := 1;
   MaxMXCSR := High(Word);
   for MXCSR := 0 to MaxMXCSR do
    begin
     //Clear 5 lsb's
     MXCSR2 := MXCSR;
     MXCSR2 := (MXCSR2 shr 7) shl 7;
     SetMXCSR(MXCSR2);
     MXCSRBefore := GetMXCSR;
     Y := RegtToPolExtendedFunction(X);
     MXCSRAfter := GetMXCSR;
     if MXCSRBefore <> MXCSRAfter then
      begin
       Result := False;
       Exit;
      end;
    end;
  end
end;

function TMainForm.ValidateExtended6 : Boolean;
var
 X : TRegtangularComplexE;
 Y : TPolarComplexE;

begin
 Result := True;
 X.RealPart := 0.5;
 X.ImaginaryPart := 0.5;
 Y := RegtToPolExtendedFunction(X);
 if ( Abs(Y.Amplitude - Sqrt(0.5)) >  EXTENDEDLIMIT)  and (Abs(Y.Phase - PI/4) < EXTENDEDLIMIT) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateDouble1 : Boolean;
var
 X : TRegtangularComplexD;
 Y : TPolarComplexD;

begin
 Result := True;
 X.RealPart := 1;
 X.ImaginaryPart := 0;
 Y := RegtToPolDoubleFunction(X);
 if not((Y.Amplitude = 1) and (Y.Phase = 0)) then
  begin
   Result := False;
   Exit;
  end;
 X.RealPart := 0;
 X.ImaginaryPart := 1;
 Y := RegtToPolDoubleFunction(X);
 if not((Y.Amplitude = 1) and (Abs(Y.Phase - PI/2) < DOUBLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.RealPart := -1;
 X.ImaginaryPart := 0;
 Y := RegtToPolDoubleFunction(X);
 if not((Y.Amplitude = 1) and (Abs(Y.Phase - PI) < DOUBLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.RealPart := 1;
 X.ImaginaryPart := 1;
 Y := RegtToPolDoubleFunction(X);
 if ( Abs(Y.Amplitude - Sqrt(2)) >  DOUBLELIMIT)  and (Abs(Y.Phase - PI/4) < DOUBLELIMIT) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateDouble2 : Boolean;
var
 X : TRegtangularComplexD;
 Y1, Y2 : TPolarComplexD;

begin
 Result := True;
 X.ImaginaryPart := MINDOUBLE_SSE2;
 while X.ImaginaryPart < MAXVALIDATEDOUBLE2_SSE2 do
  begin
   X.RealPart := MINDOUBLE_SSE2;
   while X.RealPart < MAXVALIDATEDOUBLE2_SSE2 do
    begin
     Y1 := RegtToPolDKCPas1(X);
     Y2 := RegtToPolDoubleFunction(X);
     if ((Y1.Amplitude <> 0) and (Y1.Phase <> 0)) then
      begin
       if (Abs((Y1.Amplitude - Y2.Amplitude) / Y1.Amplitude) > DOUBLELIMIT_SSE2) or
          (Abs((Y1.Phase - Y2.Phase) / Y1.Phase) > DOUBLELIMIT_SSE2) then
        begin
         Result := False;
         Exit;
        end;
      end;
     X.RealPart := X.RealPart * VALIDATEDOUBLE2STEPSIZE_SSE2;
    end;
   X.ImaginaryPart := X.ImaginaryPart * VALIDATEDOUBLE2STEPSIZE_SSE2;
  end;
end;

function TMainForm.ValidateDouble3 : Boolean;
var
 X : TRegtangularComplexD;
 Y : TPolarComplexD;

begin
 Result := False;
 try
  X.RealPart := MAXDOUBLE;
  X.ImaginaryPart := MAXDOUBLE;
  Y := RegtToPolDoubleFunction(X);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateDouble4 : Boolean;
var
 X : TRegtangularComplexD;
 Y : TPolarComplexD;
 J1, J2 : Cardinal;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;

begin
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
     Sleep(SLEEPVALIDATE4);
     X.RealPart := 1;
     X.ImaginaryPart := 1;
     ControlWordBefore := Get8087CW;
     Y := RegtToPolDoubleFunction(X);
     ControlWordAfter := Get8087CW;
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
end;

function TMainForm.ValidateDouble5 : Boolean;
var
 X : TRegtangularComplexD;
 Y : TPolarComplexD;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;

begin
 Result := True;
 if SSESupported then
  begin
   X.RealPart := 1;
   X.ImaginaryPart := 1;
   MaxMXCSR := High(Word);
   for MXCSR := 0 to MaxMXCSR do
    begin
     MXCSR2 := MXCSR;
     MXCSR2 := (MXCSR2 shr 7) shl 7;
     SetMXCSR(MXCSR2);
     MXCSRBefore := GetMXCSR;
     Y := RegtToPolDoubleFunction(X);
     MXCSRAfter := GetMXCSR;
     if MXCSRBefore <> MXCSRAfter then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

//Range and precision set to IA32 FP limits

function TMainForm.ValidateDouble6 : Boolean;
var
 X : TRegtangularComplexD;
 Y1, Y2 : TPolarComplexD;

begin
 Result := True;
 X.ImaginaryPart := MINVALIDATEDOUBLE6;
 while X.ImaginaryPart < MAXVALIDATEDOUBLE6 do
  begin
   X.RealPart := MINVALIDATEDouble6;
   while X.RealPart < MAXVALIDATEDOUBLE6 do
    begin
     Y1 := RegtToPolDKCPas1(X);
     Y2 := RegtToPolDoubleFunction(X);
     if ((Y1.Amplitude <> 0) and (Y1.Phase <> 0)) then
      begin
       if (Abs((Y1.Amplitude - Y2.Amplitude) / Y1.Amplitude) > DOUBLELIMIT) or
          (Abs((Y1.Phase - Y2.Phase) / Y1.Phase) > DOUBLELIMIT) then
        begin
         Result := False;
         Exit;
        end;
      end;
     X.RealPart := X.RealPart * VALIDATEDOUBLE2STEPSIZE;
    end;
   X.ImaginaryPart := X.ImaginaryPart * VALIDATEDOUBLE2STEPSIZE;
  end;
end;

function TMainForm.ValidateDouble7 : Boolean;
var
 X : TRegtangularComplexD;
 Y : TPolarComplexD;

begin
 Result := True;
 X.RealPart := 0.5;
 X.ImaginaryPart := 0.5;
 Y := RegtToPolDoubleFunction(X);
 if ( Abs(Y.Amplitude - Sqrt(0.5)) >  DOUBLELIMIT)  and (Abs(Y.Phase - PI/4) < DOUBLELIMIT) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateSingle1 : Boolean;
var
 X : TRegtangularComplexS;
 Y : TPolarComplexS;

begin
 Result := True;
 X.RealPart := 1;
 X.ImaginaryPart := 0;
 Y := RegtToPolSingleFunction(X);
 if not((Y.Amplitude = 1) and (Y.Phase = 0)) then
  begin
   Result := False;
   Exit;
  end;
 X.RealPart := 0;
 X.ImaginaryPart := 1;
 Y := RegtToPolSingleFunction(X);
 if not((Y.Amplitude = 1) and (Abs(Y.Phase - PI/2) < SINGLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.RealPart := -1;
 X.ImaginaryPart := 0;
 Y := RegtToPolSingleFunction(X);
 if not((Y.Amplitude = 1) and (Abs(Y.Phase - PI) < SINGLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.RealPart := 1;
 X.ImaginaryPart := 1;
 Y := RegtToPolSingleFunction(X);
 if ( Abs(Y.Amplitude - Sqrt(2)) >  SINGLELIMIT)  and (Abs(Y.Phase - PI/4) < SINGLELIMIT) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateSingle2 : Boolean;
var
 X : TRegtangularComplexS;
 Y1, Y2 : TPolarComplexS;

begin
 Result := True;
 X.ImaginaryPart := MINVALIDATESINGLE2;
 while X.ImaginaryPart < MAXVALIDATESINGLE2 do
  begin
   X.RealPart := MINVALIDATESINGLE2;
   while X.RealPart < MAXVALIDATESINGLE2 do
    begin
     Y1 := RegtToPolDKCPas1(X);
     Y2 := RegtToPolSingleFunction(X);
     if ((Y1.Amplitude <> 0) and (Y1.Phase <> 0)) then
      begin
       if (Abs((Y1.Amplitude - Y2.Amplitude) / Y1.Amplitude) > SINGLELIMIT) or
          (Abs((Y1.Phase - Y2.Phase) / Y1.Phase) > SINGLELIMIT) then
        begin
         Result := False;
         Exit;
        end;
      end;
     X.RealPart := X.RealPart * VALIDATESINGLE2STEPSIZE;
    end;
   X.ImaginaryPart := X.ImaginaryPart * VALIDATESINGLE2STEPSIZE;
  end;
end;

function TMainForm.ValidateSingle3 : Boolean;
var
 X : TRegtangularComplexS;
 Y : TPolarComplexS;

begin
 Result := False;
 try
  X.RealPart := MAXSINGLE;
  X.ImaginaryPart := MAXSINGLE;
  Y := RegtToPolSingleFunction(X);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateSingle4 : Boolean;
var
 X : TRegtangularComplexS;
 Y : TPolarComplexS;
 J1, J2 : Cardinal;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;

begin
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
     Sleep(SLEEPVALIDATE4);
     X.RealPart := 1;
     X.ImaginaryPart := 1;
     ControlWordBefore := Get8087CW;
     Y := RegtToPolSingleFunction(X);
     ControlWordAfter := Get8087CW;
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
end;

function TMainForm.ValidateSingle5 : Boolean;
var
 X : TRegtangularComplexS;
 Y : TPolarComplexS;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;

begin
 Result := True;
 if SSESupported then
  begin
   X.RealPart := 1;
   X.ImaginaryPart := 1;
   MaxMXCSR := High(Word);
   for MXCSR := 0 to MaxMXCSR do
    begin
     MXCSR2 := MXCSR;
     MXCSR2 := (MXCSR2 shr 7) shl 7;
     SetMXCSR(MXCSR2);
     MXCSRBefore := GetMXCSR;
     Y := RegtToPolSingleFunction(X);
     MXCSRAfter := GetMXCSR;
     if MXCSRBefore <> MXCSRAfter then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.ValidateSingle6 : Boolean;
var
 X : TRegtangularComplexS;
 Y : TPolarComplexS;

begin
 Result := True;
 X.RealPart := 0.5;
 X.ImaginaryPart := 0.5;
 Y := RegtToPolSingleFunction(X);
 if (Abs(Y.Amplitude - Sqrt(0.5)) >  SINGLELIMIT)  and (Abs(Y.Phase - PI/4) < SINGLELIMIT) then
  begin
   Result := False;
  end;
end;

procedure TMainForm.ValidateExtendedButtonClick(Sender: TObject);
var
 FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  ValidateExtendedButton.Caption := 'Running';
  ValidationEdit.Color := clBlue;
  Update;
  FunctionName := ExtendedFunctionSelectionRadioGroup.Items[ExtendedFunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@RegtToPolExtendedFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if ValidateExtended1 and
     ValidateExtended2 and
     ValidateExtended3 and
     ValidateExtended4 and
     ValidateExtended5 and
     ValidateExtended6 then
   begin
    ValidationEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + 'Extended'
                      + #9 + FunctionAddressString[8]
                      + #9 + 'Passed');
   end
  else
   begin
    ValidationEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + 'Extended'
                      + #9 + FunctionAddressString[8]
                      + #9 + 'Failed');
   end;
  ValidateExtendedButton.Caption := 'Validate Extended';
 except
  ReportRichEdit.Lines.Add(FunctionName
                    + #9 + 'Extended'
                    + #9 + FunctionAddressString[8]
                    + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkExtendedButtonClick(Sender: TObject);
begin
 BenchmarkExtendedButton.Caption := 'Running';
 BenchmarkExtended;
 BenchmarkExtendedButton.Caption := 'Benchmark Extended';
end;

procedure TMainForm.BenchmarkExtended;
var
 FunctionAddress, SubBench1, SubBench2, Bench : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := ExtendedFunctionSelectionRadioGroup.Items[ExtendedFunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@RegtToPolExtendedFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  SubBench1 := SubBenchmarkExtended1;
  SubBench2 := SubBenchmarkExtended2;
  Bench := SubBench1 + SubBench2;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + 'Extended'
                           + #9 + FunctionAddressString[8]
                           + #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(SubBench2)
                           + #9 + IntToStr(Bench));
  SortRichEditFP;
  SortRichEdit1;
  BenchmarkTest;
 except
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + 'Extended'
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;

function TMainForm.SubBenchmarkExtended1 : Cardinal;
var
 I1, I2, I4, I5 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     for I5 := 0 to BENCHARRAYSIZE-1 do
      begin
       ExtendedResultSub1BenchmarkArray[I5]
        := RegtToPolExtendedFunction(ExtendedSrc1Sub1BenchmarkArray[I5]);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmarkDouble1 : Cardinal;
var
 I1, I2, I4, I5 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     for I5 := 0 to BENCHARRAYSIZE-1 do
      begin
       DoubleResultSub1BenchmarkArray[I5]
        := RegtToPolDoubleFunction(DoubleSrc1Sub1BenchmarkArray[I5]);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmarkSingle1 : Cardinal;
var
 I1, I2, I4, I5 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     for I5 := 0 to BENCHARRAYSIZE-1 do
      begin
       SingleResultSub1BenchmarkArray[I5]
        := RegtToPolSingleFunction(SingleSrc1Sub1BenchmarkArray[I5]);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmarkExtended2 : Cardinal;
var
 I1, I2, I4, I5 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     for I5 := 0 to BENCHARRAYSIZE-1 do
      begin
       ExtendedResultSub2BenchmarkArray[I5]
        := RegtToPolExtendedFunction(ExtendedSrc1Sub2BenchmarkArray[I5]);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmarkDouble2 : Cardinal;
var
 I1, I2, I4, I5 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     for I5 := 0 to BENCHARRAYSIZE-1 do
      begin
       DoubleResultSub2BenchmarkArray[I5]
        := RegtToPolDoubleFunction(DoubleSrc1Sub2BenchmarkArray[I5]);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmarkSingle2 : Cardinal;
var
 I1, I2, I4, I5 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     for I5 := 0 to BENCHARRAYSIZE-1 do
      begin
       SingleResultSub2BenchmarkArray[I5]
        := RegtToPolSingleFunction(SingleSrc1Sub2BenchmarkArray[I5]);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 J1, J2, J3 :Cardinal;

begin
 GetCPUFeatures;
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 5;
 ReportRichEdit.Paragraph.Tab[0] := 100;
 ReportRichEdit.Paragraph.Tab[1] := 150;
 ReportRichEdit.Paragraph.Tab[2] := 175;
 ReportRichEdit.Paragraph.Tab[3] := 210;
 ReportRichEdit.Paragraph.Tab[4] := 245;
 ExtendedFunctionSelectionRadioGroupClick(nil);
 DoubleFunctionSelectionRadioGroupClick(nil);
 SingleFunctionSelectionRadioGroupClick(nil);
 SetLength(ExtendedSrc1Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(DoubleSrc1Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(SingleSrc1Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(ExtendedSrc2Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(DoubleSrc2Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(SingleSrc2Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(ExtendedResultSub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(DoubleResultSub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(SingleResultSub1BenchmarkArray, BENCHARRAYSIZE);
 for J1 := 0 to BENCHARRAYSIZE-1 do
  begin
   ExtendedSrc1Sub1BenchmarkArray[J1].RealPart := J1+1;
   ExtendedSrc1Sub1BenchmarkArray[J1].ImaginaryPart := J1+1;
  end;
 for J2 := 0 to BENCHARRAYSIZE-1 do
  begin
   DoubleSrc1Sub1BenchmarkArray[J2].RealPart := J2+1;
   DoubleSrc1Sub1BenchmarkArray[J2].ImaginaryPart := J2+1;
  end;
 for J3 := 0 to BENCHARRAYSIZE-1 do
  begin
   SingleSrc1Sub1BenchmarkArray[J3].RealPart := J3+1;
   SingleSrc1Sub1BenchmarkArray[J3].ImaginaryPart := J3+1;
  end;
 for J1 := 0 to BENCHARRAYSIZE-1 do
  begin
   ExtendedSrc2Sub1BenchmarkArray[J1].RealPart := J1+1;
   ExtendedSrc2Sub1BenchmarkArray[J1].ImaginaryPart := J1+1;
  end;
 for J2 := 0 to BENCHARRAYSIZE-1 do
  begin
   DoubleSrc2Sub1BenchmarkArray[J2].RealPart := J2+1;
   DoubleSrc2Sub1BenchmarkArray[J2].ImaginaryPart := J2+1;
  end;
 for J3 := 0 to BENCHARRAYSIZE-1 do
  begin
   SingleSrc2Sub1BenchmarkArray[J3].RealPart := J3+1;
   SingleSrc2Sub1BenchmarkArray[J3].ImaginaryPart := J3+1;
  end;
 SetLength(ExtendedSrc1Sub2BenchmarkArray, BENCHARRAYSIZE+63);
 asm
  Mov EAX, ExtendedSrc1Sub2BenchmarkArray
  Mov ExtendedSrc1Sub2BenchmarkArrayInitAdress, EAX
  And EAX, -64
  Add EAX, 64
  Mov ExtendedSrc1Sub2BenchmarkArray, EAX
 end;
 SetLength(DoubleSrc1Sub2BenchmarkArray, BENCHARRAYSIZE+63);
 asm
  Mov EAX, DoubleSrc1Sub2BenchmarkArray
  Mov DoubleSrc1Sub2BenchmarkArrayInitAdress, EAX
  And EAX, -64
  Add EAX, 64
  Mov DoubleSrc1Sub2BenchmarkArray, EAX
 end;
 SetLength(SingleSrc1Sub2BenchmarkArray, BENCHARRAYSIZE+63);
 asm
  Mov EAX, SingleSrc1Sub2BenchmarkArray
  Mov SingleSrc1Sub2BenchmarkArrayInitAdress, EAX
  And EAX, -64
  Add EAX, 64
  Mov SingleSrc1Sub2BenchmarkArray, EAX
 end;
 SetLength(ExtendedResultSub2BenchmarkArray, BENCHARRAYSIZE+63);
 asm
  Mov EAX, ExtendedResultSub2BenchmarkArray
  Mov ExtendedResultSub2BenchmarkArrayInitAdress, EAX
  And EAX, -64
  Add EAX, 64
  Mov ExtendedResultSub2BenchmarkArray, EAX
 end;
 SetLength(DoubleResultSub2BenchmarkArray, BENCHARRAYSIZE+63);
 asm
  Mov EAX, DoubleResultSub2BenchmarkArray
  Mov DoubleResultSub2BenchmarkArrayInitAdress, EAX
  And EAX, -64
  Add EAX, 64
  Mov DoubleResultSub2BenchmarkArray, EAX
 end;
 SetLength(SingleResultSub2BenchmarkArray, BENCHARRAYSIZE+63);
 asm
  Mov EAX, SingleResultSub2BenchmarkArray
  Mov SingleResultSub2BenchmarkArrayInitAdress, EAX
  And EAX, -64
  Add EAX, 64
  Mov SingleResultSub2BenchmarkArray, EAX
 end;
 for J1 := 0 to BENCHARRAYSIZE-1 do
  begin
   ExtendedSrc1Sub2BenchmarkArray[J1].RealPart := J1+1;
   ExtendedSrc1Sub2BenchmarkArray[J1].ImaginaryPart := J1+1;
  end;
 for J2 := 0 to BENCHARRAYSIZE-1 do
  begin
   DoubleSrc1Sub2BenchmarkArray[J2].RealPart := J2+1;
   DoubleSrc1Sub2BenchmarkArray[J2].ImaginaryPart := J2+1;
  end;
 for J3 := 0 to BENCHARRAYSIZE-1 do
  begin
   SingleSrc1Sub2BenchmarkArray[J3].RealPart := J3+1;
   SingleSrc1Sub2BenchmarkArray[J3].ImaginaryPart := J3+1;
  end;
end;

procedure TMainForm.ExtendedFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case ExtendedFunctionSelectionRadioGroup.ItemIndex of
  0 : RegtToPolExtendedFunction := RegtToPolDKCPas1;
  1 : RegtToPolExtendedFunction := RegtToPolDKCIA32_1;
  2 : RegtToPolExtendedFunction := RectToPol_JOH_PAS;
  3 : RegtToPolExtendedFunction := RectToPol_JOH_IA32;
  4 : RegtToPolExtendedFunction := RectToPol_JOH_IA32_2;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
 BenchmarkAllButton.Caption := 'Running';
 Update;
 for I1 := 0 to ExtendedFunctionSelectionRadioGroup.Items.Count-1 do
  begin
   ExtendedFunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkExtended;
   Update;
  end;
 for I2 := 0 to DoubleFunctionSelectionRadioGroup.Items.Count-1 do
  begin
   DoubleFunctionSelectionRadioGroup.ItemIndex := I2;
   BenchmarkDouble;
   Update;
  end;
 for I3 := 0 to SingleFunctionSelectionRadioGroup.Items.Count-1 do
  begin
   SingleFunctionSelectionRadioGroup.ItemIndex := I3;
   BenchmarkSingle;
   Update;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
 Bench1Edit.Text := '';
 Bench2Edit.Text := '';
 MaxSpreadBenchPercentageEdit.Text := '';
 MaxSpreadBenchPercentageEdit.Color := clInfoBk;
 FunctionNameEdit.Text := '';
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 Update;
 for I1 := 0 to ExtendedFunctionSelectionRadioGroup.Items.Count-1 do
  begin
   ExtendedFunctionSelectionRadioGroup.ItemIndex := I1;
   ValidateExtendedButtonClick(nil);
   Update;
  end;
 for I2 := 0 to DoubleFunctionSelectionRadioGroup.Items.Count-1 do
  begin
   DoubleFunctionSelectionRadioGroup.ItemIndex := I2;
   ValidateDoubleButtonClick(nil);
   Update;
  end;
 for I3 := 0 to SingleFunctionSelectionRadioGroup.Items.Count-1 do
  begin
   SingleFunctionSelectionRadioGroup.ItemIndex := I3;
   ValidateSingleButtonClick(nil);
   Update;
  end;
 ValidateAllButton.Caption := 'Validate All';
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := 'ComplexRectToPolBenchReport.Txt';
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintReportSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('ComplexRectToPolBenchReport');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 BenchmarkExtendedButtonClick(nil);
 Update;
 BenchmarkDoubleButtonClick(nil);
 Update;
 BenchmarkSingleButtonClick(nil);
 Update;
 BenchmarkAllButtonClick(nil);
 for I1 := 0 to SingleFunctionSelectionRadioGroup.Items.Count-1 do
  begin
   for I2 := 0 to SingleFunctionSelectionRadioGroup.Items.Count-1 do
    begin
     SingleFunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkSingle;
     Update;
    end;
   SingleFunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkSingle;
   Update;
  end;
 for I1 := 0 to DoubleFunctionSelectionRadioGroup.Items.Count-1 do
  begin
   for I2 := 0 to DoubleFunctionSelectionRadioGroup.Items.Count-1 do
    begin
     DoubleFunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkDouble;
     Update;
    end;
   DoubleFunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkDouble;
   Update;
  end;
 for I1 := 0 to ExtendedFunctionSelectionRadioGroup.Items.Count-1 do
  begin
   for I2 := 0 to ExtendedFunctionSelectionRadioGroup.Items.Count-1 do
    begin
     ExtendedFunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkExtended;
     Update;
    end;
   ExtendedFunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkExtended;
   Update;
  end;
 BenchTestButton.Caption := 'Bench Test';
end;

procedure TMainForm.MaxSpreadBenchPercentageEditClick(Sender: TObject);
begin
 MaxSpreadBenchPercentageEdit.SelectAll;
 MaxSpreadBenchPercentageEdit.CopyToClipboard;
end;

procedure TMainForm.CleanResultsButtonClick(Sender: TObject);
begin
 CleanResultsFPRichEdit;
 BenchmarkTest;
 AlignmentTest;
end;

procedure TMainForm.DoubleFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case DoubleFunctionSelectionRadioGroup.ItemIndex of
  0 : RegtToPolDoubleFunction := RegtToPolDKCPas1;
  1 : RegtToPolDoubleFunction := RegtToPolDKCIA32_1;
  2 : RegtToPolDoubleFunction := RectToPol_JOH_PAS;
  3 : RegtToPolDoubleFunction := RectToPol_JOH_IA32;
  4 : RegtToPolDoubleFunction := RectToPol_JOH_IA32_2;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.SingleFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case SingleFunctionSelectionRadioGroup.ItemIndex of
  0 : RegtToPolSingleFunction := RegtToPolDKCPas1;
  1 : RegtToPolSingleFunction := RegtToPolDKCIA32_1;
  2 : RegtToPolSingleFunction := RegtToPolDKCIA32_2;
  3 : RegtToPolSingleFunction := RectToPol_JOH_PAS;
  4 : RegtToPolSingleFunction := RectToPol_JOH_IA32;
  5 : RegtToPolSingleFunction := RectToPol_JOH_IA32_2;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.ValidateDoubleButtonClick(Sender: TObject);
var
 FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  ValidateDoubleButton.Caption := 'Running';
  ValidationEdit.Color := clBlue;
  Update;
  FunctionName := DoubleFunctionSelectionRadioGroup.Items[DoubleFunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@RegtToPolDoubleFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if ValidateDouble1 and
     ValidateDouble2 and
     ValidateDouble3 and
     ValidateDouble4 and
     ValidateDouble5 and //IA32 Validation. SSE2 will not pass this
     ValidateDouble6 and
     ValidateDouble7 then
   begin
    ValidationEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + 'Double'
                      + #9 + FunctionAddressString[8]
                      + #9 + 'Passed');
   end
  else
   begin
    ValidationEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + 'Double'
                      + #9 + FunctionAddressString[8]
                      + #9 + 'Failed');
   end;
  ValidateDoubleButton.Caption := 'Validate Double';
 except
  ReportRichEdit.Lines.Add(FunctionName
                    + #9 + 'Double'
                    + #9 + FunctionAddressString[8]
                    + #9 + 'Failed');
 end;
end;

procedure TMainForm.ValidateSingleButtonClick(Sender: TObject);
var
 FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  ValidateSingleButton.Caption := 'Running';
  ValidationEdit.Color := clBlue;
  Update;
  FunctionName := SingleFunctionSelectionRadioGroup.Items[SingleFunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@RegtToPolSingleFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if ValidateSingle1 and
     ValidateSingle2 and
     ValidateSingle3 and
     ValidateSingle4 and
     ValidateSingle5 and
     ValidateSingle6 then
   begin
    ValidationEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + 'Single'
                      + #9 + FunctionAddressString[8]
                      + #9 + 'Passed');
   end
  else
   begin
    ValidationEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + 'Single'
                      + #9 + FunctionAddressString[8]
                      + #9 + 'Failed');
   end;
  ValidateSingleButton.Caption := 'Validate Single';
 except
  ReportRichEdit.Lines.Add(FunctionName
                    + #9 + 'Single'
                    + #9 + FunctionAddressString[8]
                    + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkDoubleButtonClick(Sender: TObject);
begin
 BenchmarkDoubleButton.Caption := 'Running';
 BenchmarkDouble;
 BenchmarkDoubleButton.Caption := 'Benchmark Double';
end;

procedure TMainForm.BenchmarkDouble;
var
 FunctionAddress, SubBench1, SubBench2, Bench : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := DoubleFunctionSelectionRadioGroup.Items[DoubleFunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@RegtToPolDoubleFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  SubBench1 := SubBenchmarkDouble1;
  SubBench2 := SubBenchmarkDouble2;
  Bench := SubBench1 + SubBench2;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + 'Double'
                           + #9 + FunctionAddressString[8]
                           + #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(SubBench2)
                           + #9 + IntToStr(Bench));
  SortRichEditFP;
  SortRichEdit1;
  BenchmarkTest;
 except
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + 'Double'
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;

procedure TMainForm.BenchmarkSingleButtonClick(Sender: TObject);
begin
 BenchmarkSingleButton.Caption := 'Running';
 BenchmarkSingle;
 BenchmarkSingleButton.Caption := 'Benchmark Single';
end;

procedure TMainForm.BenchmarkSingle;
var
 FunctionAddress, SubBench1, SubBench2, Bench : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := SingleFunctionSelectionRadioGroup.Items[SingleFunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@RegtToPolDoubleFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  SubBench1 := SubBenchmarkSingle1;
  SubBench2 := SubBenchmarkSingle2;
  Bench := SubBench1 + SubBench2;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + 'Single'
                           + #9 + FunctionAddressString[8]
                           + #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(SubBench2)
                           + #9 + IntToStr(Bench));
  SortRichEditFP;
  SortRichEdit1;
  BenchmarkTest;
 except
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + 'Single'
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 asm
  Mov EAX, ExtendedSrc1Sub2BenchmarkArrayInitAdress
  Mov ExtendedSrc1Sub2BenchmarkArray, EAX
 end;
 asm
  Mov EAX, DoubleSrc1Sub2BenchmarkArrayInitAdress
  Mov DoubleSrc1Sub2BenchmarkArray, EAX
 end;
 asm
  Mov EAX, SingleSrc1Sub2BenchmarkArrayInitAdress
  Mov SingleSrc1Sub2BenchmarkArray, EAX
 end;
 asm
  Mov EAX, ExtendedResultSub2BenchmarkArrayInitAdress
  Mov ExtendedResultSub2BenchmarkArray, EAX
 end;
 asm
  Mov EAX, DoubleResultSub2BenchmarkArrayInitAdress
  Mov DoubleResultSub2BenchmarkArray, EAX
 end;
 asm
  Mov EAX, SingleResultSub2BenchmarkArrayInitAdress
  Mov SingleResultSub2BenchmarkArray, EAX
 end;
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

end.
