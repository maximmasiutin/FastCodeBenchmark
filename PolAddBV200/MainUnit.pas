unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'PolAdd';

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
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    AboutSpeedButton: TSpeedButton;
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
    procedure AboutSpeedButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    function ValidateSingle1 : Boolean;
    function ValidateSingle2 : Boolean;
    function ValidateSingle3 : Boolean;
    function ValidateSingle4 : Boolean;
    function ValidateSingle5 : Boolean;
    function ValidateDouble1 : Boolean;
    function ValidateDouble2 : Boolean;
    function ValidateDouble3 : Boolean;
    function ValidateDouble4 : Boolean;
    function ValidateDouble5 : Boolean;
    function ValidateExtended1 : Boolean;
    function ValidateExtended2 : Boolean;
    function ValidateExtended3 : Boolean;
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
 ComplexDataTypesUnit, Math, FastcodeCPUID, SystemInfoUnit, PolAddDKCUnit, PolAddAZUnit, PolAddPLRUnit,
  PolAddJOHUnit, AboutUnit;

{$R *.dfm}

const
 NOOFRUNS : Cardinal = 4000;
 SUBBENCH1SCALE : Double = 300;
 SUBBENCH2SCALE : Double = 300;
 NOOFRERUNS : Cardinal = 5;
 BENCHARRAYSIZE : Cardinal = 1000;
 MINVALIDATEEXTENDED2 : Extended = 1E-25;
 MAXVALIDATEEXTENDED2 : Extended = 9E19; //Max range for SinCos 2^63
 VALIDATEEXTENDED2STEPSIZE : Extended = 1E1;
 MINVALIDATEDOUBLE2 : Double = 1E-25;
 MAXVALIDATEDOUBLE2 : Double = 9E19; //Max range for SinCos 2^63
 VALIDATEDOUBLE2STEPSIZE : Double = 1E1;
 MINVALIDATESINGLE2 : Single = 1E-19;
 MAXVALIDATESINGLE2 : Single = 9E19;  //Max range for SinCos 2^63
 VALIDATESINGLE2STEPSIZE : Single = 1E1;
 MINEXTENDED : Extended = 3.6E-4951;
 MAXEXTENDED : Extended = 1.1E4932;
 EXTENDEDLIMIT : Extended = 1E-18;
 MINSINGLE : Single = 1.5E-45;
 MAXSINGLE : Single = 3.4E38;
 SINGLELIMIT : Single = 1E-4;  //Relaxed a little because this function involves many calculations and errors sum up
 SLEEPVALIDATE4 : Cardinal = 250;
 MINDOUBLE : Double = 5E-324;
 MAXDOUBLE : Double = 1.7E308;
 DOUBLELIMIT : Double = 1E-13; //Relaxed a little because this function involves many calculations and errors sum up

type
 TPolAddExtendedFunction = function (const X, Y : TPolarComplexE) : TPolarComplexE;
 TPolAddDoubleFunction = function (const X, Y : TPolarComplexD) : TPolarComplexD;
 TPolAddSingleFunction = function (const X, Y : TPolarComplexS) : TPolarComplexS;

var
 DoubleSrc1Sub1BenchmarkArrayInitAdress : Cardinal;
 DoubleSrc2Sub1BenchmarkArrayInitAdress : Cardinal;
 DoubleResultSub1BenchmarkArrayInitAdress : Cardinal;
 ExtendedSrc1Sub2BenchmarkArrayInitAdress : Cardinal;
 ExtendedSrc2Sub2BenchmarkArrayInitAdress : Cardinal;
 ExtendedResultSub2BenchmarkArrayInitAdress : Cardinal;
 PolAddExtendedFunction : TPolAddExtendedFunction;
 PolAddDoubleFunction : TPolAddDoubleFunction;
 PolAddSingleFunction : TPolAddSingleFunction;
 ExtendedSrc1Sub1BenchmarkArray : array of TPolarComplexE;
 DoubleSrc1Sub1BenchmarkArray : array of TPolarComplexD;
 SingleSrc1Sub1BenchmarkArray : array of TPolarComplexS;
 ExtendedSrc2Sub1BenchmarkArray : array of TPolarComplexE;
 DoubleSrc2Sub1BenchmarkArray : array of TPolarComplexD;
 SingleSrc2Sub1BenchmarkArray : array of TPolarComplexS;
 ExtendedResultSub1BenchmarkArray : array of TPolarComplexE;
 DoubleResultSub1BenchmarkArray : array of TPolarComplexD;
 SingleResultSub1BenchmarkArray : array of TPolarComplexS;
 ExtendedSrc1Sub2BenchmarkArray : array of TPolarComplexE;
 DoubleSrc1Sub2BenchmarkArray : array of TPolarComplexD;
 SingleSrc1Sub2BenchmarkArray : array of TPolarComplexS;
 ExtendedSrc2Sub2BenchmarkArray : array of TPolarComplexE;
 DoubleSrc2Sub2BenchmarkArray : array of TPolarComplexD;
 SingleSrc2Sub2BenchmarkArray : array of TPolarComplexS;
 ExtendedResultSub2BenchmarkArray : array of TPolarComplexE;
 DoubleResultSub2BenchmarkArray : array of TPolarComplexD;
 SingleResultSub2BenchmarkArray : array of TPolarComplexS;
 EnableCMOV : Boolean = False;
 EnableMMX : Boolean = False;
 SSESupported : Boolean = False;
 SSE2Supported : Boolean = False;
 Enable3DNow : Boolean = False;
 EnableExt3DNow : Boolean = False;
 NoOfTicksArray : array of Int64;
 lpFrequency : Int64;

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

//Finds the maximum spread in benchmarks due to code lignment for any function.

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
         if MaxSpread > 1 then
          MaxSpreadBenchPercentageEdit.Color := clYellow;
         if MaxSpread > 2 then
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
 S1, S2, FunctionName1, FunctionName2, Precision1, Precision2,
 CompleteFunctionName1, CompleteFunctionName2 : AnsiString;

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
 X, Y, Z : TPolarComplexE;

begin
 Result := True;
 X.Amplitude := 1;
 X.Phase := 1;
 Y.Amplitude := 1;
 Y.Phase := 1;
 Z := PolAddExtendedFunction(X, Y);
 if not((Abs(Z.Amplitude - 2) / Z.Amplitude < EXTENDEDLIMIT)
   and ((Abs(Z.Phase - 1) / Z.Phase) < EXTENDEDLIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 0;
 X.Phase := 1;
 Y.Amplitude := 2;
 Y.Phase := 3;
 Z := PolAddExtendedFunction(X, Y);
 if not((Abs(Z.Amplitude - 2) / Z.Amplitude < EXTENDEDLIMIT)
   and ((Abs(Z.Phase - 3) / Z.Phase) < EXTENDEDLIMIT)) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateExtended2 : Boolean;
var
 X, Y, Z1, Z2 : TPolarComplexE;

begin
 Result := True;
 Y.Phase := MINVALIDATEEXTENDED2;
 while Y.Phase < MAXVALIDATEEXTENDED2 / VALIDATEEXTENDED2STEPSIZE do
  begin
   Y.Amplitude := MINVALIDATEEXTENDED2;
   while Y.Amplitude < MAXVALIDATEEXTENDED2 / VALIDATEEXTENDED2STEPSIZE do
    begin
     X.Phase := MINVALIDATEEXTENDED2;
     while X.Phase < MAXVALIDATEEXTENDED2 / VALIDATEEXTENDED2STEPSIZE do
      begin
       X.Amplitude := MINVALIDATEEXTENDED2;
       while X.Amplitude < MAXVALIDATEEXTENDED2 / VALIDATEEXTENDED2STEPSIZE do
        begin
         Z1 := PolAdd_DKC_Pas_1(X, Y);
         Z2 := PolAddExtendedFunction(X, Y);
         if (Z1.Amplitude <> 0) and (Z1.Phase <> 0) then
          begin
           if (Abs(Z1.Amplitude - Z2.Amplitude) / Z1.Amplitude > EXTENDEDLIMIT) or
              (Abs(Z1.Phase - Z2.Phase) / Z1.Phase > EXTENDEDLIMIT) then
            begin
             Result := False;
             Exit;
            end;
          end;
         X.Amplitude := X.Amplitude * VALIDATEEXTENDED2STEPSIZE;
        end;
       X.Phase := X.Phase * VALIDATEEXTENDED2STEPSIZE;
      end;
     Y.Amplitude := Y.Amplitude * VALIDATEEXTENDED2STEPSIZE;
    end;
   Y.Phase := Y.Phase * VALIDATEEXTENDED2STEPSIZE;
  end;
end;

function TMainForm.ValidateExtended3 : Boolean;
var
 X, Y, Z : TPolarComplexE;

begin
 Result := False;
 try
  X.Amplitude := MAXEXTENDED;
  X.Phase := 0;
  Y.Amplitude := MAXEXTENDED;
  Y.Phase := 0;
  Z := PolAddExtendedFunction(X, Y);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateExtended4 : Boolean;
var
 X, Y, Z : TPolarComplexE;
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
     Sleep(1000);
     X.Amplitude := 0;
     X.Phase := 0;
     Y.Amplitude := 0;
     Y.Phase := 0;
     ControlWordBefore := Get8087CW;
     Z := PolAddExtendedFunction(X, Y);
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
 X, Y, Z : TPolarComplexE;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;

begin
 Result := True;
 if SSESupported then
  begin
   X.Amplitude := 0;
   X.Phase := 0;
   Y.Amplitude := 0;
   Y.Phase := 0;
   MaxMXCSR := High(Word);
   for MXCSR := 0 to MaxMXCSR do
    begin
     //Clear 5 lsb's
     MXCSR2 := MXCSR;
     MXCSR2 := (MXCSR2 shr 7) shl 7;
     SetMXCSR(MXCSR2);
     MXCSRBefore := GetMXCSR;
     Z := PolAddExtendedFunction(X, Y);
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
 X, Y, Z : TPolarComplexD;

begin
 Result := True;
 X.Amplitude := 1;
 X.Phase := 1;
 Y.Amplitude := 1;
 Y.Phase := 1;
 Z := PolAddDoubleFunction(X, Y);
 if not((Abs(Z.Amplitude - 2) / Z.Amplitude < DOUBLELIMIT)
   and ((Abs(Z.Phase - 1) / Z.Phase) < DOUBLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 0;
 X.Phase := 1;
 Y.Amplitude := 2;
 Y.Phase := 3;
 Z := PolAddDoubleFunction(X, Y);
 if not((Abs(Z.Amplitude - 2) / Z.Amplitude < DOUBLELIMIT)
   and ((Abs(Z.Phase - 3) / Z.Phase) < DOUBLELIMIT)) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateDouble2 : Boolean;
var
 X, Y, Z1, Z2 : TPolarComplexD;
 Xref, Yref, Zref : TPolarComplexE;

begin
 Result := True;
 Y.Phase := MINVALIDATEDOUBLE2;
 while Y.Phase < MAXVALIDATEDOUBLE2 / VALIDATEDOUBLE2STEPSIZE do
  begin
   Y.Amplitude := MINVALIDATEDOUBLE2;
   while Y.Amplitude < MAXVALIDATEDOUBLE2 / VALIDATEDOUBLE2STEPSIZE do
    begin
     X.Phase := MINVALIDATEDOUBLE2;
     while X.Phase < MAXVALIDATEDOUBLE2 / VALIDATEDOUBLE2STEPSIZE do
      begin
       X.Amplitude := MINVALIDATEDOUBLE2;
       while X.Amplitude < MAXVALIDATEDOUBLE2 / VALIDATEDOUBLE2STEPSIZE do
        begin
         //Do reference calculation in Extended precision
         Xref.Amplitude := X.Amplitude;
         Xref.Phase := X.Phase;
         Yref.Amplitude := Y.Amplitude;
         Yref.Phase := Y.Phase;
         Zref := PolAdd_DKC_Pas_1(Xref, Yref);
         Z1.Amplitude := Zref.Amplitude;
         Z1.Phase := Zref.Phase;
         Z2 := PolAddDoubleFunction(X, Y);
         if (Z1.Amplitude <> 0) and (Z1.Phase <> 0) then
          begin
           if (Abs(Z1.Amplitude - Z2.Amplitude) / Z1.Amplitude > DOUBLELIMIT) or
              (Abs(Z1.Phase - Z2.Phase) / Z1.Phase > DOUBLELIMIT) then
            begin
             Result := False;
             Exit;
            end;
          end;
         X.Amplitude := X.Amplitude * VALIDATEDOUBLE2STEPSIZE;
        end;
       X.Phase := X.Phase * VALIDATEDOUBLE2STEPSIZE;
      end;
     Y.Amplitude := Y.Amplitude * VALIDATEDOUBLE2STEPSIZE;
    end;
   Y.Phase := Y.Phase * VALIDATEDOUBLE2STEPSIZE;
  end;
end;

function TMainForm.ValidateDouble3 : Boolean;
var
 X, Y, Z : TPolarComplexD;

begin
 Result := False;
 try
  X.Amplitude := MAXDOUBLE;
  X.Phase := 0;
  Y.Amplitude := MAXDOUBLE;
  Y.Phase := 0;
  Z := PolAddDoubleFunction(X, Y);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateDouble4 : Boolean;
var
 X, Y, Z : TPolarComplexD;
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
     Sleep(1000);
     X.Amplitude := 0;
     X.Phase := 0;
     Y.Amplitude := 0;
     Y.Phase := 0;
     ControlWordBefore := Get8087CW;
     Z := PolAddDoubleFunction(X, Y);
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
 X, Y, Z : TPolarComplexD;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;

begin
 Result := True;
 if SSESupported then
  begin
   X.Amplitude := 0;
   X.Phase := 0;
   Y.Amplitude := 0;
   Y.Phase := 0;
   MaxMXCSR := High(Word);
   for MXCSR := 0 to MaxMXCSR do
    begin
     MXCSR2 := MXCSR;
     MXCSR2 := (MXCSR2 shr 7) shl 7;
     SetMXCSR(MXCSR2);
     MXCSRBefore := GetMXCSR;
     Z := PolAddDoubleFunction(X, Y);
     MXCSRAfter := GetMXCSR;
     if MXCSRBefore <> MXCSRAfter then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

//TODO 1 -DKC: Make validation relative

function TMainForm.ValidateSingle1 : Boolean;
var
 X, Y, Z : TPolarComplexS;

begin
 Result := True;
 X.Amplitude := 1;
 X.Phase := 1;
 Y.Amplitude := 1;
 Y.Phase := 1;
 Z := PolAddSingleFunction(X, Y);
 if not((Abs(Z.Amplitude - 2) / Z.Amplitude < SINGLELIMIT)
   and ((Abs(Z.Phase - 1) / Z.Phase) < SINGLELIMIT)) then
  begin
   Result := False;
   Exit;
  end;
 X.Amplitude := 0;
 X.Phase := 1;
 Y.Amplitude := 2;
 Y.Phase := 3;
 Z := PolAddSingleFunction(X, Y);
 if not((Abs(Z.Amplitude - 2) / Z.Amplitude < SINGLELIMIT)
   and ((Abs(Z.Phase - 3) / Z.Phase) < SINGLELIMIT)) then
  begin
   Result := False;
  end;
end;

function TMainForm.ValidateSingle2 : Boolean;
var
 X, Y, Z1, Z2 : TPolarComplexS;
 Xref, Yref, Zref : TPolarComplexE;

begin
 Result := True;
 Y.Phase := MINVALIDATESINGLE2;
 while Y.Phase < MAXVALIDATESINGLE2 / VALIDATESINGLE2STEPSIZE do
  begin
   Y.Amplitude := MINVALIDATESINGLE2;
   while Y.Amplitude < MAXVALIDATESINGLE2 / VALIDATESINGLE2STEPSIZE do
    begin
     X.Phase := MINVALIDATESINGLE2;
     while X.Phase < MAXVALIDATESINGLE2 / VALIDATESINGLE2STEPSIZE do
      begin
       X.Amplitude := MINVALIDATESINGLE2;
       while X.Amplitude < MAXVALIDATESINGLE2 / VALIDATESINGLE2STEPSIZE do
        begin
         //Do reference calculation in Extended precision
         Xref.Amplitude := X.Amplitude;
         Xref.Phase := X.Phase;
         Yref.Amplitude := Y.Amplitude;
         Yref.Phase := Y.Phase;
         Zref := PolAdd_DKC_Pas_1(Xref, Yref);
         Z1.Amplitude := Zref.Amplitude;
         Z1.Phase := Zref.Phase;
         Z2 := PolAddSingleFunction(X, Y);
         if (Z1.Amplitude <> 0) and (Z1.Phase <> 0) then
          begin
           if ((Abs(Z1.Amplitude - Z2.Amplitude) / Z1.Amplitude) > SINGLELIMIT) or
              ((Abs(Z1.Phase - Z2.Phase) / Z1.Phase) > SINGLELIMIT) then
            begin
             Result := False;
             Exit;
            end;
          end;
         X.Amplitude := X.Amplitude * VALIDATESINGLE2STEPSIZE;
        end;
       X.Phase := X.Phase * VALIDATESINGLE2STEPSIZE;
      end;
     Y.Amplitude := Y.Amplitude * VALIDATESINGLE2STEPSIZE;
    end;
   Y.Phase := Y.Phase * VALIDATESINGLE2STEPSIZE;
  end;
end;

function TMainForm.ValidateSingle3 : Boolean;
var
 X, Y, Z : TPolarComplexS;

begin
 Result := False;
 try
  X.Amplitude := MAXSINGLE;
  X.Phase := 0;
  Y.Amplitude := MAXSINGLE;
  Y.Phase := 0;
  Z := PolAddSingleFunction(X, Y);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateSingle4 : Boolean;
var
 X, Y, Z : TPolarComplexS;
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
     Sleep(1000);
     X.Amplitude := 0;
     X.Phase := 0;
     Y.Amplitude := 0;
     Y.Phase := 0;
     ControlWordBefore := Get8087CW;
     Z := PolAddSingleFunction(X, Y);
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
 X, Y, Z : TPolarComplexS;
 MXCSR, MXCSR2, MXCSRBefore, MXCSRAfter, MaxMXCSR : Cardinal;

begin
 Result := True;
 if SSESupported then
  begin
   X.Amplitude := 0;
   X.Phase := 0;
   Y.Amplitude := 0;
   Y.Phase := 0;
   MaxMXCSR := High(Word);
   for MXCSR := 0 to MaxMXCSR do
    begin
     MXCSR2 := MXCSR;
     MXCSR2 := (MXCSR2 shr 7) shl 7;
     SetMXCSR(MXCSR2);
     MXCSRBefore := GetMXCSR;
     Z := PolAddSingleFunction(X, Y);
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
  FunctionAddress := Cardinal(@PolAddExtendedFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if ValidateExtended1 and
     ValidateExtended2 and
     ValidateExtended3 and
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
  FunctionAddress := Cardinal(@PolAddExtendedFunction);
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
 lpPerformanceCount, StartCount, EndCount, NoOfTicks,
 MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 // Used to control alignment
 // Edit1.Text := IntToHex(Integer(@ExtendedSrc1Sub1BenchmarkArray[0]), 8);
 // Edit2.Text := IntToHex(Integer(@ExtendedSrc2Sub1BenchmarkArray[0]), 8);
 // Edit3.Text := IntToHex(Integer(@ExtendedResultSub1BenchmarkArray[0]), 8);
 // Update;
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
        := PolAddExtendedFunction(ExtendedSrc1Sub1BenchmarkArray[I5],
                                  ExtendedSrc2Sub1BenchmarkArray[I5]);
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
 lpPerformanceCount, StartCount, EndCount, NoOfTicks,
 MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 // Used to control alignment
 // Edit1.Text := IntToHex(Integer(@ExtendedSrc1Sub2BenchmarkArray[0]), 8);
 // Edit2.Text := IntToHex(Integer(@ExtendedSrc2Sub2BenchmarkArray[0]), 8);
 // Edit3.Text := IntToHex(Integer(@ExtendedResultSub2BenchmarkArray[0]), 8);
 // Update;
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
        := PolAddExtendedFunction(ExtendedSrc1Sub2BenchmarkArray[I5],
                                  ExtendedSrc2Sub2BenchmarkArray[I5]);
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
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

function TMainForm.SubBenchmarkDouble1 : Cardinal;
var
 I1, I2, I4, I5 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks,
 MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 // Used to control alignment
 // Edit1.Text := IntToHex(Integer(@DoubleSrc1Sub1BenchmarkArray[0]), 8);
 // Edit2.Text := IntToHex(Integer(@DoubleSrc2Sub1BenchmarkArray[0]), 8);
 // Edit3.Text := IntToHex(Integer(@DoubleResultSub1BenchmarkArray[0]), 8);
 // Update;
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
        := PolAddDoubleFunction(DoubleSrc1Sub1BenchmarkArray[I5],
                                DoubleSrc2Sub1BenchmarkArray[I5]);
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
 lpPerformanceCount, StartCount, EndCount, NoOfTicks,
 MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 // Used to control alignment
 // Edit1.Text := IntToHex(Integer(@DoubleSrc1Sub2BenchmarkArray[0]), 8);
 // Edit2.Text := IntToHex(Integer(@DoubleSrc2Sub2BenchmarkArray[0]), 8);
 // Edit3.Text := IntToHex(Integer(@DoubleResultSub2BenchmarkArray[0]), 8);
 Update;
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
        := PolAddDoubleFunction(DoubleSrc1Sub2BenchmarkArray[I5],
                                DoubleSrc2Sub2BenchmarkArray[I5]);
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
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

function TMainForm.SubBenchmarkSingle1 : Cardinal;
var
 I1, I2, I4, I5 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks,
 MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 // Used to control alignment
 // Edit1.Text := IntToHex(Integer(@SingleSrc1Sub1BenchmarkArray[0]), 8);
 // Edit2.Text := IntToHex(Integer(@SingleSrc2Sub1BenchmarkArray[0]), 8);
 // Edit3.Text := IntToHex(Integer(@SingleResultSub1BenchmarkArray[0]), 8);
 // Update;
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
        := PolAddSingleFunction(SingleSrc1Sub1BenchmarkArray[I5],
                                SingleSrc2Sub1BenchmarkArray[I5]);
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
 lpPerformanceCount, StartCount, EndCount, NoOfTicks,
 MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 // Used to control alignment
 // Edit1.Text := IntToHex(Integer(@SingleSrc1Sub2BenchmarkArray[0]), 8);
 // Edit2.Text := IntToHex(Integer(@SingleSrc2Sub2BenchmarkArray[0]), 8);
 // Edit3.Text := IntToHex(Integer(@SingleResultSub2BenchmarkArray[0]), 8);
 Update;
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
        := PolAddSingleFunction(SingleSrc1Sub2BenchmarkArray[I5],
                                SingleSrc2Sub2BenchmarkArray[I5]);
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
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 J1, J2, J3, J4, J5, J6, J7, J8, J9, J10, J11, J12 :Cardinal;
 CpuString : string;
 Succes : Boolean;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
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
 //Subbench1 misaligned arrays
 //The 8 byte dynamic array header will force 8 byte alignment not 16 byte alignment
 SetLength(  ExtendedSrc1Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(    DoubleSrc1Sub1BenchmarkArray, BENCHARRAYSIZE+4);
 SetLength(    SingleSrc1Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(  ExtendedSrc2Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(    DoubleSrc2Sub1BenchmarkArray, BENCHARRAYSIZE+4);
 SetLength(    SingleSrc2Sub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(ExtendedResultSub1BenchmarkArray, BENCHARRAYSIZE);
 SetLength(  DoubleResultSub1BenchmarkArray, BENCHARRAYSIZE+4);
 SetLength(  SingleResultSub1BenchmarkArray, BENCHARRAYSIZE);
 asm
  mov eax, DoubleSrc1Sub1BenchmarkArray
  mov      DoubleSrc1Sub1BenchmarkArrayInitAdress, EAX
  add eax, 4 //Misalign
  mov      DoubleSrc1Sub1BenchmarkArray, EAX
 end;
 asm
  mov eax, DoubleSrc2Sub1BenchmarkArray
  mov      DoubleSrc2Sub1BenchmarkArrayInitAdress, EAX
  add eax, 4  //Misalign
  mov      DoubleSrc2Sub1BenchmarkArray, EAX
 end;
 asm
  mov eax, DoubleResultSub1BenchmarkArray
  mov      DoubleResultSub1BenchmarkArrayInitAdress, EAX
  add eax, 4  //Misalign
  mov      DoubleResultSub1BenchmarkArray, EAX
 end;
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
 for J4 := 0 to BENCHARRAYSIZE-1 do
  begin
   ExtendedSrc2Sub1BenchmarkArray[J4].Amplitude := J4+1;
   ExtendedSrc2Sub1BenchmarkArray[J4].Phase := J4+1;
  end;
 for J5 := 0 to BENCHARRAYSIZE-1 do
  begin
   DoubleSrc2Sub1BenchmarkArray[J5].Amplitude := J5+1;
   DoubleSrc2Sub1BenchmarkArray[J5].Phase := J5+1;
  end;
 for J6 := 0 to BENCHARRAYSIZE-1 do
  begin
   SingleSrc2Sub1BenchmarkArray[J6].Amplitude := J6+1;
   SingleSrc2Sub1BenchmarkArray[J6].Phase := J6+1;
  end;
 //Subbench2 aligned arrays
 //FastMM4 will 16 byte align if allocsize > 148 byte, but there are 8 byte in front of dynamic arrays
 SetLength(  ExtendedSrc1Sub2BenchmarkArray, BENCHARRAYSIZE+8);
 SetLength(    DoubleSrc1Sub2BenchmarkArray, BENCHARRAYSIZE);
 SetLength(    SingleSrc1Sub2BenchmarkArray, BENCHARRAYSIZE);
 SetLength(  ExtendedSrc2Sub2BenchmarkArray, BENCHARRAYSIZE+8);
 SetLength(    DoubleSrc2Sub2BenchmarkArray, BENCHARRAYSIZE);
 SetLength(    SingleSrc2Sub2BenchmarkArray, BENCHARRAYSIZE);
 SetLength(ExtendedResultSub2BenchmarkArray, BENCHARRAYSIZE+8);
 SetLength(  DoubleResultSub2BenchmarkArray, BENCHARRAYSIZE);
 SetLength(  SingleResultSub2BenchmarkArray, BENCHARRAYSIZE);
 asm
  mov eax, ExtendedSrc1Sub2BenchmarkArray
  mov      ExtendedSrc1Sub2BenchmarkArrayInitAdress, eax
  add eax, 8 //Align
  mov      ExtendedSrc1Sub2BenchmarkArray, eax
 end;
 asm
  mov eax, ExtendedSrc2Sub2BenchmarkArray
  mov      ExtendedSrc2Sub2BenchmarkArrayInitAdress, eax
  add eax, 8 //Align
  mov      ExtendedSrc2Sub2BenchmarkArray, eax
 end;
 asm
  mov eax, ExtendedResultSub2BenchmarkArray
  mov      ExtendedResultSub2BenchmarkArrayInitAdress, eax
  add eax, 8 //Align
  mov      ExtendedResultSub2BenchmarkArray, eax
 end;
 for J7 := 0 to BENCHARRAYSIZE-1 do
  begin
   ExtendedSrc1Sub2BenchmarkArray[J7].Amplitude := J7+1;
   ExtendedSrc1Sub2BenchmarkArray[J7].Phase := J7+1;
  end;
 for J8 := 0 to BENCHARRAYSIZE-1 do
  begin
   DoubleSrc1Sub2BenchmarkArray[J8].Amplitude := J8+1;
   DoubleSrc1Sub2BenchmarkArray[J8].Phase := J8+1;
  end;
 for J9 := 0 to BENCHARRAYSIZE-1 do
  begin
   SingleSrc1Sub2BenchmarkArray[J9].Amplitude := J9+1;
   SingleSrc1Sub2BenchmarkArray[J9].Phase := J9+1;
  end;
 for J10 := 0 to BENCHARRAYSIZE-1 do
  begin
   ExtendedSrc2Sub2BenchmarkArray[J10].Amplitude := J10+1;
   ExtendedSrc2Sub2BenchmarkArray[J10].Phase := J10+1;
  end;
 for J11 := 0 to BENCHARRAYSIZE-1 do
  begin
   DoubleSrc2Sub2BenchmarkArray[J11].Amplitude := J11+1;
   DoubleSrc2Sub2BenchmarkArray[J11].Phase := J11+1;
  end;
 for J12 := 0 to BENCHARRAYSIZE-1 do
  begin
   SingleSrc2Sub2BenchmarkArray[J12].Amplitude := J12+1;
   SingleSrc2Sub2BenchmarkArray[J12].Phase := J12+1;
  end;

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

procedure TMainForm.ExtendedFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case ExtendedFunctionSelectionRadioGroup.ItemIndex of
  0 : PolAddExtendedFunction := PolAdd_DKC_Pas_1;
  1 : PolAddExtendedFunction := PolAdd_DKC_Pas_2;
  2 : PolAddExtendedFunction := PolAdd_DKC_Pas_3;
  3 : PolAddExtendedFunction := PolAdd_DKC_IA32_1;
  4 : PolAddExtendedFunction := PolAdd_DKC_IA32_2;
  5 : PolAddExtendedFunction := PolAdd_DKC_IA32_3;
  6 : PolAddExtendedFunction := PolAdd_AZ_IA32_1;
  7 : PolAddExtendedFunction := PolAdd_PLR_IA32_1;
  8 : PolAddExtendedFunction := PolAdd_PLR_IA32_2;
  9 : PolAddExtendedFunction := PolAdd_PLR_IA32_3;
  10 : PolAddExtendedFunction := PolAdd_PLR_IA32_4;
  11 : PolAddExtendedFunction := PolAdd_PLR_PAS_1;
  12 : PolAddExtendedFunction := PolAdd_JOH_IA32_1;
  13 : PolAddExtendedFunction := PolAdd_JOH_PAS_1;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.DoubleFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case DoubleFunctionSelectionRadioGroup.ItemIndex of
  0 : PolAddDoubleFunction := PolAdd_DKC_Pas_1;
  1 : PolAddDoubleFunction := PolAdd_DKC_Pas_2;
  2 : PolAddDoubleFunction := PolAdd_DKC_Pas_3;
  3 : PolAddDoubleFunction := PolAdd_DKC_IA32_1;
  4 : PolAddDoubleFunction := PolAdd_DKC_IA32_2;
  5 : PolAddDoubleFunction := PolAdd_AZ_IA32_1;
  6 : PolAddDoubleFunction := PolAdd_PLR_IA32_2;
  7 : PolAddDoubleFunction := PolAdd_PLR_IA32_3;
  8 : PolAddDoubleFunction := PolAdd_PLR_IA32_4;
  9 : PolAddDoubleFunction := PolAdd_PLR_PAS_1;
  10 : PolAddDoubleFunction := PolAdd_JOH_IA32_1;
  11 : PolAddDoubleFunction := PolAdd_JOH_PAS_1;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.SingleFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case SingleFunctionSelectionRadioGroup.ItemIndex of
  0 : PolAddSingleFunction := PolAdd_DKC_Pas_1;
  1 : PolAddSingleFunction := PolAdd_DKC_Pas_2;
  2 : PolAddSingleFunction := PolAdd_DKC_Pas_3;
  3 : PolAddSingleFunction := PolAdd_DKC_IA32_1;
  4 : PolAddSingleFunction := PolAdd_DKC_IA32_2;
  5 : PolAddSingleFunction := PolAdd_AZ_IA32_1;
  6 : PolAddSingleFunction := PolAdd_PLR_IA32_2;
  7 : PolAddSingleFunction := PolAdd_PLR_IA32_3;
  8 : PolAddSingleFunction := PolAdd_PLR_IA32_4;
  9 : PolAddSingleFunction := PolAdd_PLR_PAS_1;
  10 : PolAddSingleFunction := PolAdd_JOH_IA32_1;
  11 : PolAddSingleFunction := PolAdd_JOH_PAS_1;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
// if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST) = False then
//  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
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
 //Do not save all results from a "Benchmark Test"
 if Sender <> nil then
  begin
   if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
   FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
   FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
   FResultList.AddStrings(ReportRichEdit.Lines);
   FResultList.Add('');
   FResultList.SaveToFile(FBenchmarkFileName);
  end;
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
 ReportRichEdit.Print('ComplexPolAddBenchReport');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1 : Cardinal;
const
 NOOFBENCHRUNS : Cardinal = 4;

begin
 BenchTestButton.Caption := 'Running';
 //NOOFBENCHRUNS bench all runs via the bench all button
 for I1 := 0 to NOOFBENCHRUNS do
  BenchmarkAllButtonClick(nil);
 //The first part of the test runs with very good results, but
 //This next part will give very bad results.
 //Removing the second part is "cheating"
 { TODO 1 -oDKC -cBug : Investigate benchmark precision problem }
 //One Benchmark all run via the bench single buttons
// for I2 := 0 to ExtendedFunctionSelectionRadioGroup.Items.Count-1 do
//  begin
//   ExtendedFunctionSelectionRadioGroup.ItemIndex := I2;
//   BenchmarkExtendedButtonClick(nil);
//  end;
// for I2 := 0 to DoubleFunctionSelectionRadioGroup.Items.Count-1 do
//  begin
//   DoubleFunctionSelectionRadioGroup.ItemIndex := I2;
//   BenchmarkDoubleButtonClick(nil);
//  end;
// for I2 := 0 to SingleFunctionSelectionRadioGroup.Items.Count-1 do
//  begin
//   SingleFunctionSelectionRadioGroup.ItemIndex := I2;
//   BenchmarkSingleButtonClick(nil);
//  end;
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
  FunctionAddress := Cardinal(@PolAddDoubleFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if ValidateDouble1 and
     ValidateDouble2 and
     ValidateDouble3 and
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
  FunctionAddress := Cardinal(@PolAddSingleFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if ValidateSingle1 and
     ValidateSingle2 and
     ValidateSingle3 and
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
  FunctionAddress := Cardinal(@PolAddDoubleFunction);
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
  FunctionAddress := Cardinal(@PolAddDoubleFunction);
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
 //DoubleSrc1Sub1BenchmarkArrayInitAdress : Cardinal;
 asm
  Mov EAX, DoubleSrc1Sub1BenchmarkArrayInitAdress
  Mov      DoubleSrc1Sub1BenchmarkArray, EAX
 end;
 //DoubleSrc2Sub1BenchmarkArrayInitAdress : Cardinal;
 asm
  Mov EAX, DoubleSrc2Sub1BenchmarkArrayInitAdress
  Mov      DoubleSrc2Sub1BenchmarkArray, EAX
 end;
 //DoubleResultSub1BenchmarkArrayInitAdress : Cardinal;
 asm
  Mov EAX, DoubleResultSub1BenchmarkArrayInitAdress
  Mov      DoubleResultSub1BenchmarkArray, EAX
 end;
 //ExtendedSrc1Sub2BenchmarkArrayInitAdress : Cardinal;
 asm
  Mov EAX, ExtendedSrc1Sub2BenchmarkArrayInitAdress
  Mov      ExtendedSrc1Sub2BenchmarkArray, EAX
 end;
 //ExtendedSrc2Sub2BenchmarkArrayInitAdress : Cardinal;
 asm
  Mov EAX, ExtendedSrc2Sub2BenchmarkArrayInitAdress
  Mov      ExtendedSrc2Sub2BenchmarkArray, EAX
 end;
 //ExtendedResultSub2BenchmarkArrayInitAdress : Cardinal;
 asm
  Mov EAX, ExtendedResultSub2BenchmarkArrayInitAdress
  Mov      ExtendedResultSub2BenchmarkArray, EAX
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
