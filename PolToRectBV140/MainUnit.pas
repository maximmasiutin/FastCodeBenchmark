unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'PolToRect';

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
    procedure FormDestroy(Sender: TObject);
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
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    function ValidateSingle1 : Boolean;
    function ValidateSingle2 : Boolean;
    //function ValidateSingle3 : Boolean;
    function ValidateSingle4 : Boolean;
    function ValidateSingle5 : Boolean;
    function ValidateDouble1 : Boolean;
    function ValidateDouble2 : Boolean;
    //function ValidateDouble3 : Boolean;
    function ValidateDouble4 : Boolean;
    function ValidateDouble5 : Boolean;
    function ValidateExtended1 : Boolean;
    function ValidateExtended2 : Boolean;
    //function ValidateExtended3 : Boolean;
    function ValidateExtended4 : Boolean;
    function ValidateExtended5 : Boolean;
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
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
 MainForm: TMainForm;

implementation

uses
 ComplexDataTypesUnit, Math, FastcodeCPUID, SystemInfoUnit, PolToRectDKCUnit, PolToRectFOUnit,
  PolToRectPLRUnit, PolToRectJOHUnit;

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
 MAXVALIDATEEXTENDED2 : Extended = 1E2000;
 VALIDATEEXTENDED2STEPSIZE : Extended = 1E3;
 MINVALIDATESINGLE2 : Single = 1E-18;
 MAXVALIDATESINGLE2 : Single = 1E18;
 VALIDATESINGLE2STEPSIZE : Single = 1.02;
 MINEXTENDED : Extended = 3.6E-4951;
 MAXEXTENDED : Extended = 1.1E4932;
 EXTENDEDLIMIT : Extended = 1E-18;
 MINSINGLE : Single = 1.5E-45;
 MAXSINGLE : Single = 3.4E38;
 SINGLELIMIT : Single = 1.2E-7;
 SLEEPVALIDATE4 : Cardinal = 250;
 //SSE2 limits
 VALIDATEDOUBLE2STEPSIZE_SSE2 : Double = 1.01;
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
 PHASEMAXEXTENDED : Extended = 3.645E20;//2E63;!!!!!!!!!!!
 //PHASEMINEXTENDED : Extended = -2E63;
 PHASEMAXDOUBLE : Double = 1E19;//2E63;
 //PHASEMINDOUBLE : Double = -2E63;
 PHASEMAXSINGLE : Single = 3.645E20;//2E63;
 //PHASEMINSINGLE : Single = -2E63;

type
 TPolToRectExtendedFunction = function (const X : TPolarComplexE) : TRegtangularComplexE;
 TPolToRectDoubleFunction = function (const X : TPolarComplexD) : TRegtangularComplexD;
 TPolToRectSingleFunction = function (const X : TPolarComplexS) : TRegtangularComplexS;

var
 ExtendedSrc1Sub2BenchmarkArrayInitAdress : Cardinal;
 DoubleSrc1Sub2BenchmarkArrayInitAdress : Cardinal;
 SingleSrc1Sub2BenchmarkArrayInitAdress : Cardinal;
 ExtendedResultSub2BenchmarkArrayInitAdress : Cardinal;
 DoubleResultSub2BenchmarkArrayInitAdress : Cardinal;
 SingleResultSub2BenchmarkArrayInitAdress : Cardinal;
 PolToRectExtendedFunction : TPolToRectExtendedFunction;
 PolToRectDoubleFunction : TPolToRectDoubleFunction;
 PolToRectSingleFunction : TPolToRectSingleFunction;
 ExtendedSrc1Sub1BenchmarkArray : array of TPolarComplexE;
 DoubleSrc1Sub1BenchmarkArray : array of TPolarComplexD;
 SingleSrc1Sub1BenchmarkArray : array of TPolarComplexS;
 ExtendedSrc2Sub1BenchmarkArray : array of TPolarComplexE;
 DoubleSrc2Sub1BenchmarkArray : array of TPolarComplexD;
 SingleSrc2Sub1BenchmarkArray : array of TPolarComplexS;
 ExtendedResultSub1BenchmarkArray : array of TRegtangularComplexE;
 DoubleResultSub1BenchmarkArray : array of TRegtangularComplexD;
 SingleResultSub1BenchmarkArray : array of TRegtangularComplexS;
 ExtendedSrc1Sub2BenchmarkArray : array of TPolarComplexE;
 DoubleSrc1Sub2BenchmarkArray : array of TPolarComplexD;
 SingleSrc1Sub2BenchmarkArray : array of TPolarComplexS;
 ExtendedResultSub2BenchmarkArray : array of TRegtangularComplexE;
 DoubleResultSub2BenchmarkArray : array of TRegtangularComplexD;
 SingleResultSub2BenchmarkArray : array of TRegtangularComplexS;
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
 X : TPolarComplexE;
 Y : TRegtangularComplexE;

begin
 Result := True;
 X.Amplitude := 1;
 X.Phase := 0;
 Y := PolToRectExtendedFunction(X);
 if ((Abs(Y.RealPart - 1) > EXTENDEDLIMIT) or (Abs(Y.ImaginaryPart) > EXTENDEDLIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 1;
 X.Phase := PI/2;
 Y := PolToRectExtendedFunction(X);
 if ((Abs(Y.RealPart) > EXTENDEDLIMIT) or (Abs(Y.ImaginaryPart - 1) > EXTENDEDLIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 1;
 X.Phase := PI;
 Y := PolToRectExtendedFunction(X);
 if ((Abs(Y.RealPart + 1) > EXTENDEDLIMIT) or (Abs(Y.ImaginaryPart) > EXTENDEDLIMIT)) then
  begin
   Result := False;
   Exit
  end;
 X.Amplitude := 1;
 X.Phase := -PI/2;
 Y := PolToRectExtendedFunction(X);
 if ((Abs(Y.RealPart) > EXTENDEDLIMIT) or (Abs(Y.ImaginaryPart + 1) > EXTENDEDLIMIT)) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateExtended2 : Boolean;
var
 X : TPolarComplexE;
 Y1, Y2 : TRegtangularComplexE;

begin
 Result := True;
 X.Amplitude := MINEXTENDED;
 while X.Amplitude < MAXVALIDATEEXTENDED2 do
  begin
   X.Phase := MINEXTENDED;
   while X.Phase < PHASEMAXEXTENDED do
    begin
     Y1 := PolToRectDKCPas1(X);
     Y2 := PolToRectExtendedFunction(X);
     if ((Y1.RealPart <> 0) and (Y1.ImaginaryPart <> 0)) then
      begin
       if (Abs((Y1.RealPart - Y2.RealPart) / Y1.RealPart) > EXTENDEDLIMIT) or
          (Abs((Y1.ImaginaryPart - Y2.ImaginaryPart) / Y1.ImaginaryPart) > EXTENDEDLIMIT) then
        begin
         Result := False;
         Exit;
        end;
      end;
     X.Phase := X.Phase * VALIDATEEXTENDED2STEPSIZE;
    end;
   X.Amplitude := X.Amplitude * VALIDATEEXTENDED2STEPSIZE;
  end;
end;

{
function TMainForm.ValidateExtended3 : Boolean;
var
 X : TPolarComplexE;
 Y : TRegtangularComplexE;

begin
 Result := False;
 try
  X.Amplitude := MAXEXTENDED;
  X.Phase := MAXEXTENDED;
  Y := PolToRegtExtendedFunction(X);
 except
  Result := True;
 end;
end;
}

function TMainForm.ValidateExtended4 : Boolean;
var
 X : TPolarComplexE;
 Y : TRegtangularComplexE;
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
     X.Amplitude := 1;
     X.Phase := 1;
     ControlWordBefore := Get8087CW;
     Y := PolToRectExtendedFunction(X);
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
 X : TPolarComplexE;
 Y : TRegtangularComplexE;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;

begin
 Result := True;
 if SSESupported then
  begin
   X.Amplitude := 1;
   X.Phase := 1;
   MaxMXCSR := High(Word);
   for MXCSR := 0 to MaxMXCSR do
    begin
     //Clear 5 lsb's
     MXCSR2 := MXCSR;
     MXCSR2 := (MXCSR2 shr 7) shl 7;
     SetMXCSR(MXCSR2);
     MXCSRBefore := GetMXCSR;
     Y := PolToRectExtendedFunction(X);
     MXCSRAfter := GetMXCSR;
     if MXCSRBefore <> MXCSRAfter then
      begin
       Result := False;
       Exit;
      end;
    end;
  end
end;

function TMainForm.ValidateDouble1 : Boolean;
var
 X : TPolarComplexD;
 Y : TRegtangularComplexD;

begin
 Result := True;
 X.Amplitude := 1;
 X.Phase := 0;
 Y := PolToRectDoubleFunction(X);
 if ((Abs(Y.RealPart - 1) > DOUBLELIMIT) or (Abs(Y.ImaginaryPart) > DOUBLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 1;
 X.Phase := PI/2;
 Y := PolToRectDoubleFunction(X);
 if ((Abs(Y.RealPart) > DOUBLELIMIT) or (Abs(Y.ImaginaryPart - 1) > DOUBLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 1;
 X.Phase := PI;
 Y := PolToRectDoubleFunction(X);
 if ((Abs(Y.RealPart + 1) > DOUBLELIMIT) or (Abs(Y.ImaginaryPart) > DOUBLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 1;
 X.Phase := -PI/2;
 Y := PolToRectDoubleFunction(X);
 if ((Abs(Y.RealPart) > DOUBLELIMIT) or (Abs(Y.ImaginaryPart + 1) > DOUBLELIMIT)) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateDouble2 : Boolean;
var
 X : TPolarComplexD;
 Y1, Y2 : TRegtangularComplexD;
 Xref : TPolarComplexE;
 Y1ref : TRegtangularComplexE;

begin
 Result := True;
 X.Amplitude := MINVALIDATEDOUBLE6;
 while X.Amplitude < MAXVALIDATEDOUBLE6 do
  begin
   X.Phase := MINVALIDATEDOUBLE6;
   while X.Phase < PHASEMAXDOUBLE do
    begin
     Xref.Amplitude := X.Amplitude;
     Xref.Phase := X.Phase;
     Y1ref := PolToRectDKCPas1(Xref);
     Y1.RealPart := Y1ref.RealPart;
     Y1.ImaginaryPart := Y1ref.ImaginaryPart;
     Y2 := PolToRectDoubleFunction(X);
     if ((Y1.RealPart <> 0) and (Y1.ImaginaryPart <> 0)) then
      begin
       if (Abs((Y1.RealPart - Y2.RealPart) / Y1.RealPart) > DOUBLELIMIT) or
          (Abs((Y1.ImaginaryPart - Y2.ImaginaryPart) / Y1.ImaginaryPart) > DOUBLELIMIT) then
        begin
         Result := False;
         Exit;
        end;
      end;
     X.Phase := X.Phase * VALIDATEDOUBLE2STEPSIZE;
    end;
   X.Amplitude := X.Amplitude * VALIDATEDOUBLE2STEPSIZE;
  end;
end;

{
function TMainForm.ValidateDouble3 : Boolean;
var
 X : TPolarComplexD;
 Y : TRegtangularComplexD;

begin
 Result := False;
 try
  X.Amplitude := MAXDOUBLE;
  X.Phase := MAXDOUBLE;
  Y := PolToRegtDoubleFunction(X);
 except
  Result := True;
 end;
end;
}
function TMainForm.ValidateDouble4 : Boolean;
var
 X : TPolarComplexD;
 Y : TRegtangularComplexD;
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
     X.Amplitude := 1;
     X.Phase := 1;
     ControlWordBefore := Get8087CW;
     Y := PolToRectDoubleFunction(X);
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
 X : TPolarComplexD;
 Y : TRegtangularComplexD;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;

begin
 Result := True;
 if SSESupported then
  begin
   X.Amplitude := 1;
   X.Phase := 1;
   MaxMXCSR := High(Word);
   for MXCSR := 0 to MaxMXCSR do
    begin
     MXCSR2 := MXCSR;
     MXCSR2 := (MXCSR2 shr 7) shl 7;
     SetMXCSR(MXCSR2);
     MXCSRBefore := GetMXCSR;
     Y := PolToRectDoubleFunction(X);
     MXCSRAfter := GetMXCSR;
     if MXCSRBefore <> MXCSRAfter then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.ValidateSingle1 : Boolean;
var
 X : TPolarComplexS;
 Y : TRegtangularComplexS;

begin
 Result := True;
 X.Amplitude := 1;
 X.Phase := 0;
 Y := PolToRectSingleFunction(X);
 if ((Abs(Y.RealPart - 1) > SINGLELIMIT) or (Abs(Y.ImaginaryPart) > SINGLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 1;
 X.Phase := PI/2;
 Y := PolToRectSingleFunction(X);
 if ((Abs(Y.RealPart) > SINGLELIMIT) or (Abs(Y.ImaginaryPart - 1) > SINGLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 1;
 X.Phase := PI;
 Y := PolToRectSingleFunction(X);
 if ((Abs(Y.RealPart + 1) > SINGLELIMIT) or (Abs(Y.ImaginaryPart) > SINGLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 1;
 X.Phase := -PI/2;
 Y := PolToRectSingleFunction(X);
 if ((Abs(Y.RealPart) > SINGLELIMIT) or (Abs(Y.ImaginaryPart + 1) > SINGLELIMIT)) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateSingle2 : Boolean;
var
 X : TPolarComplexS;
 Y1, Y2 : TRegtangularComplexS;
 Yref : TRegtangularComplexE;
 Xref : TPolarComplexE;

begin
 Result := True;
 X.Phase := MINVALIDATESINGLE2;
 while X.Phase < MAXVALIDATESINGLE2 do
  begin
   X.Amplitude := MINVALIDATESINGLE2;
   while X.Amplitude < MAXVALIDATESINGLE2 do
    begin
     Xref.Amplitude := X.Amplitude;
     Xref.Phase := X.Phase;
     Yref := PolToRectDKCPas1(Xref);
     Y1.RealPart := Yref.RealPart;
     Y1.ImaginaryPart := Yref.ImaginaryPart;
     Y2 := PolToRectSingleFunction(X);
     if ((Y1.RealPart <> 0) and (Y1.ImaginaryPart <> 0)) then
      begin
       if (Abs((Y1.RealPart - Y2.RealPart) / Y1.RealPart) > SINGLELIMIT) or
          (Abs((Y1.ImaginaryPart - Y2.ImaginaryPart) / Y1.ImaginaryPart) > SINGLELIMIT) then
        begin
         Result := False;
         Exit;
        end;
      end;
     X.Amplitude := X.Amplitude * VALIDATESINGLE2STEPSIZE;
    end;
   X.Phase := X.Phase * VALIDATESINGLE2STEPSIZE;
  end;
end;

{
function TMainForm.ValidateSingle3 : Boolean;
var
 X : TPolarComplexS;
 Y : TRegtangularComplexS;

begin
 Result := False;
 try
  X.Amplitude := MAXSINGLE;
  X.Phase := MAXSINGLE;
  Y := PolToRegtSingleFunction(X);
 except
  Result := True;
 end;
end;
}
function TMainForm.ValidateSingle4 : Boolean;
var
 X : TPolarComplexS;
 Y : TRegtangularComplexS;
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
     X.Amplitude := 1;
     X.Phase := 1;
     ControlWordBefore := Get8087CW;
     Y := PolToRectSingleFunction(X);
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
 X : TPolarComplexS;
 Y : TRegtangularComplexS;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;

begin
 Result := True;
 if SSESupported then
  begin
   X.Amplitude := 1;
   X.Phase := 1;
   MaxMXCSR := High(Word);
   for MXCSR := 0 to MaxMXCSR do
    begin
     MXCSR2 := MXCSR;
     MXCSR2 := (MXCSR2 shr 7) shl 7;
     SetMXCSR(MXCSR2);
     MXCSRBefore := GetMXCSR;
     Y := PolToRectSingleFunction(X);
     MXCSRAfter := GetMXCSR;
     if MXCSRBefore <> MXCSRAfter then
      begin
       Result := False;
       Exit;
      end;
    end;
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
  FunctionAddress := Cardinal(@PolToRectExtendedFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if ValidateExtended1 and
     ValidateExtended2 and
     //ValidateExtended3 and
     ValidateExtended4 and
     ValidateExtended5 then
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
  FunctionAddress := Cardinal(@PolToRectExtendedFunction);
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
        := PolToRectExtendedFunction(ExtendedSrc1Sub1BenchmarkArray[I5]);
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
        := PolToRectDoubleFunction(DoubleSrc1Sub1BenchmarkArray[I5]);
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
        := PolToRectSingleFunction(SingleSrc1Sub1BenchmarkArray[I5]);
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
        := PolToRectExtendedFunction(ExtendedSrc1Sub2BenchmarkArray[I5]);
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
        := PolToRectDoubleFunction(DoubleSrc1Sub2BenchmarkArray[I5]);
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
        := PolToRectSingleFunction(SingleSrc1Sub2BenchmarkArray[I5]);
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
 CpuString : string;

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
   ExtendedSrc1Sub1BenchmarkArray[J1].Amplitude := J1+1;
   ExtendedSrc1Sub1BenchmarkArray[J1].Phase := J1+1;
  end;
 for J2 := 0 to BENCHARRAYSIZE-1 do
  begin
   DoubleSrc1Sub1BenchmarkArray[J2].Amplitude := J2+1;
   DoubleSrc1Sub1BenchmarkArray[J2].Phase := J2+1;
  end;
 for J3 := 0 to BENCHARRAYSIZE-1 do
  begin
   SingleSrc1Sub1BenchmarkArray[J3].Amplitude := J3+1;
   SingleSrc1Sub1BenchmarkArray[J3].Phase := J3+1;
  end;
 for J1 := 0 to BENCHARRAYSIZE-1 do
  begin
   ExtendedSrc2Sub1BenchmarkArray[J1].Amplitude := J1+1;
   ExtendedSrc2Sub1BenchmarkArray[J1].Phase := J1+1;
  end;
 for J2 := 0 to BENCHARRAYSIZE-1 do
  begin
   DoubleSrc2Sub1BenchmarkArray[J2].Amplitude := J2+1;
   DoubleSrc2Sub1BenchmarkArray[J2].Phase := J2+1;
  end;
 for J3 := 0 to BENCHARRAYSIZE-1 do
  begin
   SingleSrc2Sub1BenchmarkArray[J3].Amplitude := J3+1;
   SingleSrc2Sub1BenchmarkArray[J3].Phase := J3+1;
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
   ExtendedSrc1Sub2BenchmarkArray[J1].Amplitude := J1+1;
   ExtendedSrc1Sub2BenchmarkArray[J1].Phase := J1+1;
  end;
 for J2 := 0 to BENCHARRAYSIZE-1 do
  begin
   DoubleSrc1Sub2BenchmarkArray[J2].Amplitude := J2+1;
   DoubleSrc1Sub2BenchmarkArray[J2].Phase := J2+1;
  end;
{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
 for J3 := 0 to BENCHARRAYSIZE-1 do
  begin
   SingleSrc1Sub2BenchmarkArray[J3].Amplitude := J3+1;
   SingleSrc1Sub2BenchmarkArray[J3].Phase := J3+1;
  end;
{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}

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

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := FResultsFileName;
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintReportSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('ComplexPolToRectBenchReport');
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

procedure TMainForm.ExtendedFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case ExtendedFunctionSelectionRadioGroup.ItemIndex of
  0 : PolToRectExtendedFunction := PolToRectDKCPas1;
  1 : PolToRectExtendedFunction := PolToRectDKCIA32_1;
  2 : PolToRectExtendedFunction := PolToRectDKCIA32_2;
  3 : PolToRectExtendedFunction := PolToReg_FO_IA32_1;
  4 : PolToRectExtendedFunction := PolToRect_PLR_IA32_1;
  5 : PolToRectExtendedFunction := PolToRect_PLR_IA32_2;
  6 : PolToRectExtendedFunction := PolToRect_PLR_PAS_1;
  7 : PolToRectExtendedFunction := PolToRect_JOH_IA32_1;
  8 : PolToRectExtendedFunction := PolToRect_JOH_PAS_1;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.DoubleFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case DoubleFunctionSelectionRadioGroup.ItemIndex of
  0 : PolToRectDoubleFunction := PolToRectDKCPas1;
  1 : PolToRectDoubleFunction := PolToRectDKCIA32_1;
  2 : PolToRectDoubleFunction := PolToRectDKCIA32_2;
  3 : PolToRectDoubleFunction := PolToReg_FO_IA32_1;
  4 : PolToRectDoubleFunction := PolToRect_PLR_IA32_1;
  5 : PolToRectDoubleFunction := PolToRect_PLR_IA32_2;
  6 : PolToRectDoubleFunction := PolToRect_PLR_IA32_3;
  7 : PolToRectDoubleFunction := PolToRect_PLR_PAS_1;
  8 : PolToRectDoubleFunction := PolToRect_JOH_IA32_1;
  9 : PolToRectDoubleFunction := PolToRect_JOH_PAS_1;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.SingleFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case SingleFunctionSelectionRadioGroup.ItemIndex of
  0 : PolToRectSingleFunction := PolToRectDKCPas1;
  1 : PolToRectSingleFunction := PolToRectDKCIA32_1;
  2 : PolToRectSingleFunction := PolToRectDKCIA32_2;
  3 : PolToRectSingleFunction := PolToReg_FO_IA32_1;
  4 : PolToRectSingleFunction := PolToRect_PLR_IA32_1;
  5 : PolToRectSingleFunction := PolToRect_PLR_IA32_2;
  6 : PolToRectSingleFunction := PolToRect_PLR_IA32_3;
  7 : PolToRectSingleFunction := PolToRect_PLR_PAS_1;
  8 : PolToRectSingleFunction := PolToRect_JOH_IA32_1;
  9 : PolToRectSingleFunction := PolToRect_JOH_PAS_1;
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
  FunctionAddress := Cardinal(@PolToRectDoubleFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if ValidateDouble1 and
     ValidateDouble2 and
     //ValidateDouble3 and
     ValidateDouble4 and
     ValidateDouble5 then
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
  FunctionAddress := Cardinal(@PolToRectSingleFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if ValidateSingle1 and
     ValidateSingle2 and
     //ValidateSingle3 and
     ValidateSingle4 and
     ValidateSingle5 then
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
  FunctionAddress := Cardinal(@PolToRectDoubleFunction);
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
  FunctionAddress := Cardinal(@PolToRectSingleFunction);
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
