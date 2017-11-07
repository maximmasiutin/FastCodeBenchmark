unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'StrToInt32';

type

 TStrToInt32Function = function (const S: string) : Integer;

 TFunctionEntry = record
  FunctionName : AnsiString;
  FunctionPointer : TStrToInt32Function;
 end;

 TTestSet = record
  S : AnsiString;
  CorrectResult : Integer;
 end;

  TMainForm = class(TForm)
    CloseBitBtn: TBitBtn;
    ReportRichEdit: TRichEdit;
    SaveDialog1: TSaveDialog;
    BenchmarkAllButton: TButton;
    FunctionSelectionRadioGroup: TRadioGroup;
    Panel1: TPanel;
    PrintSpeedButton: TSpeedButton;
    SaveAsSpeedButton: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ValidateAllButton: TButton;
    BenchmarkButton: TButton;
    ResultEdit: TEdit;
    ValidateButton: TButton;
    StatusBar1: TStatusBar;
    ShowErrorDialogCheckBox: TCheckBox;
    Label8: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    SpreadBench1Edit: TEdit;
    SpreadBench2Edit: TEdit;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    FunctionNameEdit: TEdit;
    MaxSpreadBenchPercentageEdit: TEdit;
    BenchTestButton: TButton;
    ClearButton: TButton;
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
    Label1: TLabel;
    Label9: TLabel;
    AlignCheckButton: TButton;
    AlignCheckEdit: TEdit;
    AboutSpeedButton: TSpeedButton;
    CleanButton: TButton;
    Label2: TLabel;
    FasterValidationCheckBox: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CleanButtonClick(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure RegisterFunction(FunctionName : AnsiString; FunctionPointer : TStrToInt32Function);
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure AlignCheckButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure PrintSpeedButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
  private
   FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
   FResultList: TStringList;
   Frequency : Int64;
   NoOfTicksArray : array of Int64;
   TestSetArray1 : array of TTestSet;
   TestSetArray2 : array of TTestSet;
   function ValidationResultsPresent : Boolean;
   procedure ReadIniFile(FileName : AnsiString);
   procedure WriteIniFile(FileName : AnsiString);
   procedure FillFunctionSelectionRadioGroup;
   function SubBenchmark1 : Double;
   function SubBenchmark2 : Double;
   function SubBenchmark3 : Double;
   procedure FillSubBenchmark1StringArrays;
   procedure FillSubBenchmark2StringArrays;
   procedure FillSubBenchmark3StringArrays;
   procedure BenchmarkStrToInt32;
   function Validate : Boolean;
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
   function Validate15 : Boolean;
   function Validate16 : Boolean;
   function Validate17 : Boolean;
   function Validate18 : Boolean;
   function Validate19 : Boolean;
   function Validate20 : Boolean;
   function Validate21 : Boolean;
   function Validate22 : Boolean;
   function Validate23 : Boolean;
   function Validate24 : Boolean;
   function Validate25 : Boolean;
   function Validate26 : Boolean;
   function Validate27 : Boolean;
   function Validate28 : Boolean;
   function Validate29 : Boolean;
   function Validate30 : Boolean;
   function Validate31 : Boolean;
   function Validate32 : Boolean;
   function Validate33 : Boolean;
   function Validate34 : Boolean;
   function Validate35 : Boolean;
   function Validate36 : Boolean;
   function Validate37 : Boolean;
   function Validate38 : Boolean;
   function Validate39 : Boolean;
   function Validate40 : Boolean;
   function Validate41 : Boolean;
   function Validate42 : Boolean;
   function Validate43 : Boolean;
   procedure SortRichEdit;
   procedure FillTestSetArray1;
   procedure FillTestSetArray2;
  public
   procedure AlignmentTest;
   procedure ClearAllEditBoxes;
   procedure BenchmarkTest;
   procedure CleanResultsRichEdit;
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 FastcodeCPUID, SystemInfoUnit, IniFiles, StrUtils, Math, AboutUnit, SysConst;

var
 //Used in validation and benchmark
 SubBenchmark1StringArray : array of String;
 SubBenchmark2StringArray : array of String;
 SubBenchmark3StringArray : array of String;
 StrToInt32Function : TStrToInt32Function;
 FunctionArray : array of TFunctionEntry;

const
 NOOFRERUNS : Cardinal = 7;
 MAXNOOFRUNSSUB1 : Cardinal = 28000;
 MAXNOOFRUNSSUB2 : Cardinal = 1280;
 MAXNOOFRUNSSUB3 : Cardinal = 750;
 RUNTIMESCALE : Cardinal = 100;
 //Adjusted such that the three subbenches carries the same weigth on a blend of the 6 2006 CPU targets
 SUBBENCH1SCALE : Double = 1136;
 SUBBENCH2SCALE : Double = 893;
 SUBBENCH3SCALE : Double = 1000;
 INIFILENAME : AnsiString = 'StrToInt32BV.Ini';
 SUBBENCH2ARRAYSIZE : Integer = 5000;
 SUBBENCH3ARRAYSIZE : Integer = 5000;
 VALIDATE8MIN : Integer = -80000;
 VALIDATE8MAX : Integer = 800000;
 VALIDATE9MAX : Integer = 200000;
 VALIDATE10MAX : Integer = 200000;
 VALIDATE13MIN : Integer = -1234678;
 VALIDATE13MAX : Integer = 123457;
 VALIDATE14MIN : Integer = -1234567;
 VALIDATE14MAX : Integer = 1234568;
 VALIDATE15MIN : Integer = -2235678;
 VALIDATE15MAX : Integer = 234578;
 VALIDATE16MIN : Integer = -1123478;
 VALIDATE16MAX : Integer = 45678;
 VALIDATE29OFFSETMAX : Integer = 400000;
 VALIDATE30OFFSETMAX : Integer = 400000;
 VALIDATE39MAX : Integer = 40000;
 VALIDATE39MAXSTRLEN : Integer = 1234;
 VALIDATE40OFFSETMAX : Integer = 100000;
 VALIDATE43MAX : Integer = 70000;
 
function CharPosEy(const SearchCharacter : Char;
                   const SourceString : AnsiString;
                   Occurrence : Integer = 1;
                   StartPos : Integer = 1) : Integer;
var
 Char1 : Char;
 Index, SourceStringLength : Integer;
label
 Done;

begin
 if SourceString <> '' then
  begin
   SourceStringLength := PInteger(Integer(SourceString)-4)^;
   if ((SourceStringLength > 0) and (Occurrence > 0) and
       (StartPos > 0) and (StartPos <= SourceStringLength)) then
    begin
     Result := 0;
     Index := StartPos - 1;
     repeat
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
      if (Index >= SourceStringLength) then
       Exit;
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
     until(Index >= SourceStringLength);
     Exit;
    end
   else
    Index := -1;
  end
 else
  Index := -1;
 Done :
  Result := Index+1;
end;

function GetAuthorName(FunctionName : AnsiString) : AnsiString;
var
 Pos1, Pos2 : Integer;

begin
 Pos1 := CharPosEy('_', FunctionName, 1);
 Pos2 := CharPosEy('_', FunctionName, 2);
 Result := Copy(FunctionName,Pos1+1, Pos2-Pos1-1);
end;

function GetFunctionType(FunctionName : AnsiString) : AnsiString;
var
 Pos1, Pos2 : Integer;

begin
 Pos1 := CharPosEy('_', FunctionName, 2);
 Pos2 := CharPosEy('_', FunctionName, 3);
 Result := Copy(FunctionName,Pos1+1, Pos2-Pos1-1);
end;

function GetFunctionNumber(FunctionName : AnsiString) : Integer;
var
 Pos1, Pos2 : Integer;

begin
 Pos1 := CharPosEy('_', FunctionName, 3);
 Pos2 := CharPosEy('_', FunctionName, 4);
 Result := StrToInt(Copy(FunctionName,Pos1+1, Pos2-Pos1-1));
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

procedure TMainForm.RegisterFunction(FunctionName : AnsiString; FunctionPointer : TStrToInt32Function);
var
 Size, NewSize : Integer;

begin
 Size := Length(FunctionArray);
 NewSize := Size + 1;
 SetLength(FunctionArray, NewSize);
 FunctionArray[NewSize-1].FunctionName := FunctionName;
 FunctionArray[NewSize-1].FunctionPointer := FunctionPointer;
end;

procedure SwapEntries(Index1, Index2 : Integer);
var
 TempEntry : TFunctionEntry;

begin
 TempEntry := FunctionArray[Index1];
 FunctionArray[Index1] := FunctionArray[Index2];
 FunctionArray[Index2] := TempEntry;
end;

procedure SortFunctionArray;
var
 I1, FunctionNumber1, FunctionNumber2: Integer;
 AuthorName1, AuthorName2, FunctionType1, FunctionType2 : AnsiString;
 Swapped : Boolean;

begin
 //Sort according to function number
 repeat
  Swapped := False;
  for I1 := 0 to Length(FunctionArray)-2 do
   begin
    FunctionNumber1 := GetFunctionNumber(FunctionArray[I1].FunctionName);
    FunctionNumber2 := GetFunctionNumber(FunctionArray[I1+1].FunctionName);
    if FunctionNumber2 < FunctionNumber1 then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
   end;
 until(not Swapped);
 //Sort according to instructionset
 repeat
  Swapped := False;
  for I1 := 0 to Length(FunctionArray)-2 do
   begin
    FunctionType1 := GetFunctionType(FunctionArray[I1].FunctionName);
    FunctionType1 := UpperCase(FunctionType1);
    FunctionType2 := GetFunctionType(FunctionArray[I1+1].FunctionName);
    FunctionType2 := UpperCase(FunctionType2);
    //Clumsy programming just to get started
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'IA32') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'MMX') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'SSE') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'SSE2') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'IA32') and (FunctionType1 = 'MMX') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'IA32') and (FunctionType1 = 'SSE') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'IA32') and (FunctionType1 = 'SSE2') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'IA32') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'MMX') and (FunctionType1 = 'SSE') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'MMX') and (FunctionType1 = 'SSE2') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'MMX') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'SSE') and (FunctionType1 = 'SSE2') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'SSE') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'SSE2') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
   end;
 until(not Swapped);
 //Sort according to Author name
 repeat
  Swapped := False;
  for I1 := 0 to Length(FunctionArray)-2 do
   begin
    AuthorName1 := GetAuthorName(FunctionArray[I1].FunctionName);
    AuthorName2 := GetAuthorName(FunctionArray[I1+1].FunctionName);
    if AuthorName2 < AuthorName1 then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
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
         if MaxSpread > 1 then
          MaxSpreadBenchPercentageEdit.Color := clYellow;
         if MaxSpread > 3 then
          MaxSpreadBenchPercentageEdit.Color := clRed;
         Update;
        end;
      end;
    end;
  end;
end;

//Removes multiple results from same function. Preserves the fastest result

procedure TMainForm.CleanButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 BenchmarkTest;
end;

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

//TODO 1 -oDKC -cBug -DKC: Add more validation testsets

procedure TMainForm.FillTestSetArray1;
var
 Size : Integer;

begin
 Size := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' 00';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' x00';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' $00';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' 0x00';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' -00';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' -x00';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' -$00';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' -0x00';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := 'x0';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0x0';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$0';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-x0';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-0x0';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-$0';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '+0';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0'#0;
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '1';
 TestSetArray1[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-1';
 TestSetArray1[Size-1].CorrectResult := -1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '12';
 TestSetArray1[Size-1].CorrectResult := 12;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' 12';
 TestSetArray1[Size-1].CorrectResult := 12;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '12';
 TestSetArray1[Size-1].CorrectResult := 12;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0xFF439EB2';
 TestSetArray1[Size-1].CorrectResult := -12345678;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0xfF439EB2';
 TestSetArray1[Size-1].CorrectResult := -12345678;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$Efffffff';
 TestSetArray1[Size-1].CorrectResult := -268435457;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$efffffff';
 TestSetArray1[Size-1].CorrectResult := -268435457;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$Dfffffff';
 TestSetArray1[Size-1].CorrectResult := -536870913;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$dfffffff';
 TestSetArray1[Size-1].CorrectResult := -536870913;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$Cfffffff';
 TestSetArray1[Size-1].CorrectResult := -805306369;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$cfffffff';
 TestSetArray1[Size-1].CorrectResult := -805306369;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$Bfffffff';
 TestSetArray1[Size-1].CorrectResult := -1073741825;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$bfffffff';
 TestSetArray1[Size-1].CorrectResult := -1073741825;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$Afffffff';
 TestSetArray1[Size-1].CorrectResult := -1342177281;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$afffffff';
 TestSetArray1[Size-1].CorrectResult := -1342177281;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := 'xefffffff';
 TestSetArray1[Size-1].CorrectResult := -268435457;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := 'xdfffffff';
 TestSetArray1[Size-1].CorrectResult := -536870913;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := 'xcfffffff';
 TestSetArray1[Size-1].CorrectResult := -805306369;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := 'xbfffffff';
 TestSetArray1[Size-1].CorrectResult := -1073741825;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := 'xafffffff';
 TestSetArray1[Size-1].CorrectResult := -1342177281;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0xefffffff';
 TestSetArray1[Size-1].CorrectResult := -268435457;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0xdfffffff';
 TestSetArray1[Size-1].CorrectResult := -536870913;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0xcfffffff';
 TestSetArray1[Size-1].CorrectResult := -805306369;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0xbfffffff';
 TestSetArray1[Size-1].CorrectResult := -1073741825;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0xafffffff';
 TestSetArray1[Size-1].CorrectResult := -1342177281;
 //Testcases submitted by John O'Harrow
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$ffffffff';
 TestSetArray1[Size-1].CorrectResult := -1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$80000001';
 TestSetArray1[Size-1].CorrectResult := -2147483647;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$80000000';
 TestSetArray1[Size-1].CorrectResult := Low(Integer);//-2147483648; D7 chokes on this
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$7FFFFFFF';
 TestSetArray1[Size-1].CorrectResult := $7FFFFFFF;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-x1E';
 TestSetArray1[Size-1].CorrectResult := -30;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := 'x1E';
 TestSetArray1[Size-1].CorrectResult := 30;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-0000000000000001';
 TestSetArray1[Size-1].CorrectResult := -1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0000000000000001';
 TestSetArray1[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '00';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '00000000000000000';
 TestSetArray1[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' 0x7';
 TestSetArray1[Size-1].CorrectResult := 7;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '    -0xf';
 TestSetArray1[Size-1].CorrectResult := -15;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '  xE4';
 TestSetArray1[Size-1].CorrectResult := 228;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '   -xEe';
 TestSetArray1[Size-1].CorrectResult := -238;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '  $EA';
 TestSetArray1[Size-1].CorrectResult := 234;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '   -$EefaBCc';
 TestSetArray1[Size-1].CorrectResult := -250588108;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '$07FFFFFFF';
 TestSetArray1[Size-1].CorrectResult := $7FFFFFFF;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := 'x007FFFFFFF';
 TestSetArray1[Size-1].CorrectResult := $7FFFFFFF;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0x0007FFFFFFF';
 TestSetArray1[Size-1].CorrectResult := $7FFFFFFF;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-$07FFFFFFF';
 TestSetArray1[Size-1].CorrectResult := -$7FFFFFFF;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-x007FFFFFFF';
 TestSetArray1[Size-1].CorrectResult := -$7FFFFFFF;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-0x0007FFFFFFF';
 TestSetArray1[Size-1].CorrectResult := -$7FFFFFFF;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' 01';
 TestSetArray1[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' $01';
 TestSetArray1[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' x01';
 TestSetArray1[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' X07';
 TestSetArray1[Size-1].CorrectResult := 7;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-X07';
 TestSetArray1[Size-1].CorrectResult := -7;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '0XFF';
 TestSetArray1[Size-1].CorrectResult := 255;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-0XFF';
 TestSetArray1[Size-1].CorrectResult := -255;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' 0x01';
 TestSetArray1[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' -01';
 TestSetArray1[Size-1].CorrectResult := -1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' -$01';
 TestSetArray1[Size-1].CorrectResult := -1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' -x01';
 TestSetArray1[Size-1].CorrectResult := -1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' -0x01';
 TestSetArray1[Size-1].CorrectResult := -1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '  +$01';
 TestSetArray1[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '  +x01';
 TestSetArray1[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '   +X07';
 TestSetArray1[Size-1].CorrectResult := 7;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := '-2147483648';
 TestSetArray1[Size-1].CorrectResult := Low(Integer);//-2147483648;
 Inc(Size);
 SetLength(TestSetArray1, Size);
 TestSetArray1[Size-1].S := ' -2147483648';
 TestSetArray1[Size-1].CorrectResult := Low(Integer);//-2147483648;
end;

procedure TMainForm.FillTestSetArray2;
var
 Size : Integer;

begin
 Size := 0;
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '$2000000000000000';
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := ' ';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '123 ';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := #0 + '0';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '3234234234';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '2147483648';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-2147483649';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '12147483648';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-12147483648';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '$17FFFFFFF';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '$1FFFFFFFF';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := 'x1FFFFFFFF';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '0x1FFFFFFFF';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-$1FFFFFFFF';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-x1FFFFFFFF';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-0x1FFFFFFFF';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-X1FFFFFFFF';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-0X1FFFFFFFF';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '$g';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '0xh';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := 'xi';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 //Testcases submitted by John O'Harrow
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := 'X';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '0x';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := 'x';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '+';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '$';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '+-1';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '-+1';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '++1';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
 Inc(Size);
 SetLength(TestSetArray2, Size);
 TestSetArray2[Size-1].S := '--1';
 //TestSetArray[Size-1].CorrectResult := 1; Exception is correct result
end;

procedure TMainForm.FillFunctionSelectionRadioGroup;
var
 I : Integer;

begin
 for I := 1 to Length(FunctionArray) do
  FunctionSelectionRadioGroup.Items.Add(FunctionArray[I-1].FunctionName);
 FunctionSelectionRadioGroup.ItemIndex := 0;
end;

procedure ErrorTrap(ValidateNo : Integer; S : AnsiString);
var
 I : Integer;

begin
 I := StrToInt32Function(S);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' String: ' + S + 'Result: ' + IntToStr(I)), 'Error');
end;

procedure TMainForm.BenchmarkStrToInt32;
var
 Bench, SubBench1, SubBench2, SubBench3 : Double;
 FunctionName, StrToInt32FunctionAddressString : AnsiString;
 StrToInt32FunctionAddress : Cardinal;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  StrToInt32FunctionAddress := Integer(@StrToInt32Function);
  StrToInt32FunctionAddressString := IntToHex(StrToInt32FunctionAddress, 8);
  Update;
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  SubBench3 := SubBenchmark3;
  Bench := SubBench1 + SubBench2 + SubBench3;
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                           StrToInt32FunctionAddressString[8] + #9 +
                           FloatToStrF(SubBench1, ffFixed, 9, 0) + #9 +
                           FloatToStrF(SubBench2, ffFixed, 9, 0) + #9 +
                           FloatToStrF(SubBench3, ffFixed, 9, 0) + #9 +
                           FloatToStrF(Bench, ffFixed, 9, 0));
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                                     'Failed' + #9 +
                                     '9999' + #9 +
                                     '9999' + #9 +
                                     '9999' + #9 +
                                     '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Double;
var
 J, I5, K : Cardinal;
 I1 : Integer;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;

begin
 I1 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB1 do
    for K := 0 to Length(SubBenchmark1StringArray)-1 do
     begin
      //Use testset
      I1 := StrToInt32Function(SubBenchmark1StringArray[K]);
     end;
   if QueryPerformanceCounter(lpPerformanceCount) then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[J-1] := NoOfTicks;
  end;
 ResultEdit.Text := IntToStr(I1);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I5 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I5] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I5];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmark2 : Double;
var
 J, I5, K : Cardinal;
 I1 : Integer;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;

begin
 I1 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB2 do
    for K := 0 to Length(SubBenchmark2StringArray)-1 do
     I1 := StrToInt32Function(SubBenchmark2StringArray[K]);
   if QueryPerformanceCounter(lpPerformanceCount) then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[J-1] := NoOfTicks;
  end;
 ResultEdit.Text := IntToStr(I1);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I5 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I5] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I5];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

function TMainForm.SubBenchmark3 : Double;
var
 J, I5, K : Cardinal;
 I1 : Integer;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;

begin
 I1 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB3 do
    for K := 0 to Length(SubBenchmark3StringArray)-1 do
     I1 := StrToInt32Function(SubBenchmark3StringArray[K]);
   if QueryPerformanceCounter(lpPerformanceCount) then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[J-1] := NoOfTicks;
  end;
 ResultEdit.Text := IntToStr(I1);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I5 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I5] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I5];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH3SCALE);
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 BenchmarkButton.Caption := 'Running';
 if ValidationResultsPresent then
  ReportRichEdit.Clear;
 BenchmarkStrToInt32;
 if ReportRichEdit.Lines.Count > 1 then
  SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
 BenchmarkButton.Caption := 'Benchmark';
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName, StrToInt32FunctionAddressString : AnsiString;
 StrToInt32FunctionAddress : Cardinal;

begin
 try
  if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_LOWEST) = False then
   raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_LOWEST failed');
  ValidateButton.Caption := 'Running';
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  StrToInt32FunctionAddress := Integer(@StrToInt32Function);
  StrToInt32FunctionAddressString := IntToHex(StrToInt32FunctionAddress, 8);
  if Validate then
   ReportRichEdit.Lines.Add(FunctionName + #9 + StrToInt32FunctionAddressString[8] + #9 + 'Passed')
  else
   ReportRichEdit.Lines.Add(FunctionName + #9 + StrToInt32FunctionAddressString[8] + #9 + 'Failed');
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + StrToInt32FunctionAddressString[8] + #9 + 'Failed');
 end;
 StatusBar1.SimpleText := 'Validate Completed';
 ValidateButton.Caption := 'Validate';
end;

//One simple testcase

function TMainForm.Validate1 : Boolean;
var
 S : string;
 I : Integer;
const
 VALIDATENO : Cardinal = 1;

begin
 try
  Result := True;
  S := '92';
  I := StrToInt32Function(S);
  if I <> 92 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//one simple testcase where StrToInt must throw an EConvertError exception

function TMainForm.Validate2 : Boolean;
var
 S : string;
const
 VALIDATENO : Cardinal = 2;

begin
 Result := False;
 S := '';
 try
  StrToInt32Function(S);
  ErrorTrap(VALIDATENO, S);
 except
  on E:EConvertError do
   Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
 end;
end;

//A number of simple testcases with positive decimal numbers

function TMainForm.Validate3 : Boolean;
var
 S : string;
 I : Integer;
const
 VALIDATENO : Cardinal = 3;

begin
 try
  Result := True;
  S := '1';
  I := StrToInt32Function(S);
  if I <> 1 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '10';
  I := StrToInt32Function(S);
  if I <> 10 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '210';
  I := StrToInt32Function(S);
  if I <> 210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '3210';
  I := StrToInt32Function(S);
  if I <> 3210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '43210';
  I := StrToInt32Function(S);
  if I <> 43210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '543210';
  I := StrToInt32Function(S);
  if I <> 543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '6543210';
  I := StrToInt32Function(S);
  if I <> 6543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '76543210';
  I := StrToInt32Function(S);
  if I <> 76543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '876543210';
  I := StrToInt32Function(S);
  if I <> 876543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
   end;
  S := '2147483647';
  I := StrToInt32Function(S);
  if I <> MaxInt then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//A number of simple testcases with negative decimal numbers

function TMainForm.Validate4 : Boolean;
var
 S : string;
 I : Integer;
const
 VALIDATENO : Cardinal = 4;

begin
 try
  Result := True;
  S := '-1';
  I := StrToInt32Function(S);
  if I <> -1 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-10';
  I := StrToInt32Function(S);
  if I <> -10 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-210';
  I := StrToInt32Function(S);
  if I <> -210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-3210';
  I := StrToInt32Function(S);
  if I <> -3210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-43210';
  I := StrToInt32Function(S);
  if I <> -43210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-543210';
  I := StrToInt32Function(S);
  if I <> -543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-6543210';
  I := StrToInt32Function(S);
  if I <> -6543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-76543210';
  I := StrToInt32Function(S);
  if I <> -76543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-876543210';
  I := StrToInt32Function(S);
  if I <> -876543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-2147483648';
  I := StrToInt32Function(S);
  if I <> Low(I) then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Author:            Lars Bloch Gravengaard
//Date:              17/9 2006
//Validate           Hexadecimal values start with a '$'
//                   Hexadecimal values start with a '-$'
//                   Hexadecimal values start with a '0x'
//                   Hexadecimal values start with a '-0x'
//                   Hexadecimal values start with a 'x'
//                   Hexadecimal values start with a '-x'
//                   Leading blanks are ignored

function TMainForm.Validate5 : Boolean;
var
 S : string;
 I : Integer;
const
 VALIDATENO : Cardinal = 5;

begin
 try
  Result := True;
  S := '$1E';
  I := StrToInt32Function(S);
  if I <> 30 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-$1E';
  I := StrToInt32Function(S);
  if I <> -30 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '            -10';
  I := StrToInt32Function(S);
  if I <> -10 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-0x1E';
  I := StrToInt32Function(S);
  if I <> -30 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '0x1E';
  I := StrToInt32Function(S);
  if I <> 30 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-x1E';
  I := StrToInt32Function(S);
  if I <> -30 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := 'x1E';
  I := StrToInt32Function(S);
  if I <> 30 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := ' 3210';
  I := StrToInt32Function(S);
  if I <> 3210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '  43210';
  I := StrToInt32Function(S);
  if I <> 43210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '   543210';
  I := StrToInt32Function(S);
  if I <> 543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '    6543210';
  I := StrToInt32Function(S);
  if I <> 6543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '                                                       76543210';
  I := StrToInt32Function(S);
  if I <> 76543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates all the testsets from TestSetArray1, which are valid integer strings

function TMainForm.Validate6 : Boolean;
var
 S : string;
 TestSetNo, I, MaxTestSetNo : Integer;
const
 VALIDATENO : Cardinal = 6;

begin
  Result := True;
  MaxTestSetNo := Length(TestSetArray1);
  for TestSetNo := 0 to MaxTestSetNo-1 do
   begin
    try
     S := TestSetArray1[TestSetNo].S;
     I := StrToInt32Function(S);
     if I <> TestSetArray1[TestSetNo].CorrectResult then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   end;
end;

//Validates all the testsets from TestSetArray2, which are non valid integer strings

function TMainForm.Validate7 : Boolean;
var
 S : string;
 MaxTestSetNo, TestSetNo : Integer;
const
 VALIDATENO : Cardinal = 7;

begin
 Result := True;
 MaxTestSetNo := Length(TestSetArray2);
 for TestSetNo := 0 to MaxTestSetNo-1 do
  begin
   try
    S := TestSetArray2[TestSetNo].S;
    StrToInt32Function(S);
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   except
    on E:EConvertError do
     Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
    else
    //All other exception types are bad -
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
  end;
end;

//Validates conversion of all decimal numbers from VALIDATE8MIN to VALIDATE8MAX

function TMainForm.Validate8 : Boolean;
var
 S : string;
 I1, I2 : Integer;
const
 VALIDATENO : Cardinal = 8;

begin
 try
  Result := True;
  for I1 := VALIDATE8MIN to VALIDATE8MAX do
   begin
    S := IntToStr(I1);
    I2 := StrToInt32Function(S);
    if I2 <> I1 then
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates VALIDATE9MAX random decimal numbers from 0 to MaxInt

function TMainForm.Validate9 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 9;

begin
 try
  Result := True;
  for I1 := 1 to VALIDATE9MAX do
   begin
    I3 := Random(MaxInt);
    S := IntToStr(I3);
    I2 := StrToInt32Function(S);
    if I2 <> I3 then
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates VALIDATE10MAX random decimal numbers from -MaxInt to 0

function TMainForm.Validate10 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 10;

begin
 try
  Result := True;
  for I1 := 1 to VALIDATE10MAX do
   begin
    I3 := -Random(MaxInt);
    S := IntToStr(I3);
    I2 := StrToInt32Function(S);
    if I2 <> I3 then
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Test all invalid digits in leftmost digit for string lengths = 1->12

function TMainForm.Validate11 : Boolean;
var
 S1, S2 : string;
 I1, I2, I4 : Integer;
const
 VALIDATENO : Cardinal = 11;

begin
 Result := False;
 S1 := '';
 for I4 := 1 to 12 do  //11 digits in '-2,147,483,648';
  begin
   for I1 := 0 to 255 do
    begin
     S2 := Char(I1) + S1;
     if not TryStrToInt(S2, I2) then
      begin
       try
        StrToInt32Function(S2);
        ErrorTrap(VALIDATENO, S2);
        Result := False;
        Exit;
       except
        on E:EConvertError do
         begin
          Result := E.Message = StringReplace(SInvalidInteger, '%s', S2, []);
          if not Result then
           Exit;
         end;
        //All other exception types are bad
        on E:EIntOverflow do
         begin
          ErrorTrap(VALIDATENO, S2);
          Result := False;
          Exit;
         end;
       end;
      end;
    end;
   S1 := S1 + '0';
  end;
end;

//Test all valid digits in leftmost digit for string lengths = 1->12 against the RTL function

function TMainForm.Validate12 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, I4, Iref : Integer;
const
 VALIDATENO : Cardinal = 12;

begin
 Result := True;
 S1 := '';
 for I4 := 1 to 12 do  //11 digits in '-2,147,483,648';
  begin
   for I1 := 0 to 255 do
    begin
     S2 := Char(I1) + S1;
     if TryStrToInt(S2, I2) then
      begin
       try
        Iref := StrToInt(S2);
        I3 := StrToInt32Function(S2);
        if I3 <> Iref then
         begin
          ErrorTrap(VALIDATENO, S2);
          Result := False;
          Exit;
         end;
       except
        ErrorTrap(VALIDATENO, S2);
        Result := False;
       end;
      end;
    end;
   S1 := S1 + '0';
  end;
end;

//Validates conversion of all '$' prefixed hexadecimal numbers from VALIDATE13MIN VALIDATE13MAX

function TMainForm.Validate13 : Boolean;
var
 S : string;
 I1, I2 : Integer;
const
 VALIDATENO : Cardinal = 13;

begin
 try
  Result := True;
  for I1 := VALIDATE13MIN to VALIDATE13MAX do
   begin
    S := '$' + IntToHex(I1,1);
    I2 := StrToInt32Function(S);
    if I2 <> I1 then
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates conversion of all '0x' prefixed hexadecimal numbers from VALIDATE14MIN VALIDATE14MAX

function TMainForm.Validate14 : Boolean;
var
 S : string;
 I1, I2 : Integer;
const
 VALIDATENO : Cardinal = 14;

begin
 try
  Result := True;
  for I1 := VALIDATE14MIN to VALIDATE14MAX do
   begin
    S := '0x' + IntToHex(I1,1);
    I2 := StrToInt32Function(S);
    if I2 <> I1 then
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates conversion of all 'x' prefixed hexadecimal numbers from VALIDATE15MIN VALIDATE15MAX

function TMainForm.Validate15 : Boolean;
var
 S : string;
 I1, I2 : Integer;
const
 VALIDATENO : Cardinal = 15;

begin
 try
  Result := True;
  for I1 := VALIDATE15MIN to VALIDATE15MAX do
   begin
    S := 'x' + IntToHex(I1,1);
    I2 := StrToInt32Function(S);
    if I2 <> I1 then
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates conversion of all 'X' prefixed hexadecimal numbers from VALIDATE16MIN VALIDATE16MAX

function TMainForm.Validate16 : Boolean;
var
 S : string;
 I1, I2 : Integer;
const
 VALIDATENO : Cardinal = 16;

begin
 try
  Result := True;
  for I1 := VALIDATE16MIN to VALIDATE16MAX do
   begin
    S := 'X' + IntToHex(I1,1);
    I2 := StrToInt32Function(S);
    if I2 <> I1 then
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates all possible one char strings against RTL function

function TMainForm.Validate17 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 17;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end;
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates all possible one char strings prepended with '-' against RTL function

function TMainForm.Validate18 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 18;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := '-' + Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates all possible one char strings prepended with '$' against RTL function

function TMainForm.Validate19 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 19;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := '$' + Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates all possible one char strings prepended with '-$' against RTL function

function TMainForm.Validate20 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 20;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := '-$' + Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates all possible one char strings prepended with '0x' against RTL function

function TMainForm.Validate21 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 21;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := '0x' + Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates all possible one char strings prepended with '-0x' against RTL function

function TMainForm.Validate22 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 22;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := '-0x' + Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates all possible one char strings prepended with 'x' against RTL function

function TMainForm.Validate23 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 23;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := 'x' + Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates all possible one char strings prepended with '-x' against RTL function

function TMainForm.Validate24 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 24;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := '-x' + Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates all possible one char strings prepended with 'X' against RTL function

function TMainForm.Validate25 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 25;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := 'X' + Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates all possible one char strings prepended with '-X' against RTL function

function TMainForm.Validate26 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 26;

begin
 Result := True;
 for I3 := 0 to 255 do
  begin
   S := '-X' + Char(I3);
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates conversion of all '$' prefixed 8 digit hexadecimal numbers
//Only two least significant digits are never changed

function TMainForm.Validate27 : Boolean;
var
 S : string;
 I1, I2, I3, I4, I5, I6, Iref, Ires : Integer;
const
 VALIDATENO : Cardinal = 27;
 CharArray : array[1..22] of Char = ('0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','A','B','C','D','E','F');
begin
 try
  Result := True;
  for I1 := Low(CharArray) to High(CharArray) do
   begin
    for I2 := Low(CharArray) to High(CharArray) do
     begin
      for I3 := Low(CharArray) to High(CharArray) do
       begin
        for I4 := Low(CharArray) to High(CharArray) do
         begin
          for I5 := Low(CharArray) to High(CharArray) do
           begin
            for I6 := Low(CharArray) to High(CharArray) do
             begin
              S := '$' + CharArray[I1] + CharArray[I2] + CharArray[I3]
                       + CharArray[I4] + CharArray[I5] + CharArray[I6]
                       + 'FF';
              Iref := StrToInt(S);
              Ires := StrToInt32Function(S);
              if Iref <> Ires then
               begin
                ErrorTrap(VALIDATENO, S);
                Result := False;
                Exit;
               end;
             end;
           end;
         end;
       end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

{
// The RTL function wants AnsiStrings to be zero terminated and fails here

var
 GlobalStrValidate26: AnsiString;

function TMainForm.Validate26 : Boolean;
const
 VALIDATENO : Cardinal = 26;

begin
 GlobalStrValidate26 := '123';
 PInteger(Integer(GlobalStrValidate26)-4)^ := 0; //Set Length to 0
 try
  StrToInt32Function(GlobalStrValidate26);
  ErrorTrap(VALIDATENO, GlobalStrValidate26);
  Result := False;
 except
  on E:EConvertError do
    Result := True
  else
   //All other exception types are bad -
   begin
    ErrorTrap(VALIDATENO, GlobalStrValidate26);
    Result := False;
    Exit;
   end;
 end;
end;

//The RTL function does not handle non nil zero length strings and neither should we.

var
 GlobalStrValidate27: AnsiString;

function TMainForm.Validate27 : Boolean;
var
 I : Integer;
const
 VALIDATENO : Cardinal = 27;

begin
 GlobalStrValidate27 := '123'+#0;
 PInteger(Integer(GlobalStrValidate27)-4)^ := 0; //Set Length to 0
 try
  I := StrToInt32Function(GlobalStrValidate27);
  ErrorTrap(VALIDATENO, GlobalStrValidate27);
  Result := False;
 except
  on E:EConvertError do
    Result := True
  else
   //All other exception types are bad -
   begin
    ErrorTrap(VALIDATENO, GlobalStrValidate27);
    Result := False;
    Exit;
   end;
 end;
end;
}

//Validates  non-nil zero length zero terminated string.

var
 GlobalStrValidate28: AnsiString;

function TMainForm.Validate28 : Boolean;
const
 VALIDATENO : Cardinal = 28;

begin
 GlobalStrValidate28 := #0;
 PInteger(Integer(GlobalStrValidate28)-4)^ := 0; //Set Length to 0
 try
  StrToInt32Function(GlobalStrValidate28);
  ErrorTrap(VALIDATENO, GlobalStrValidate28);
  Result := False;
 except
  on E:EConvertError do
   begin
    Result := E.Message = StringReplace(SInvalidInteger, '%s', GlobalStrValidate28, []);
    if not Result then
     Exit;
   end
  else
   //All other exception types are bad -
   begin
    ErrorTrap(VALIDATENO, GlobalStrValidate28);
    Result := False;
    Exit;
   end;
 end;
end;

//Validates that proper exception is raised for all numbers MaxInt -> MaxInt+VALIDATE29OFFSETMAX

function TMainForm.Validate29 : Boolean;
var
 S : string;
 I : Integer;
 I64 : Int64;
const
 VALIDATENO : Cardinal = 29;

begin
 Result := True;
 for I := 1 to VALIDATE29OFFSETMAX do
  begin
   try
    I64 := Int64(MaxInt) + Int64(I);
    S := IntToStr(I64);
    StrToInt32Function(S);
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   except
    on E:EConvertError do
     begin
      Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
      if not Result then
       Exit;
     end
    else
    //All other exception types are bad -
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
  end;
end;

//Validates that proper exception is raised for all numbers MinInt -> MinInt-VALIDATE30OFFSETMAX

function TMainForm.Validate30 : Boolean;
var
 S : string;
 I : Integer;
 I64 : Int64;
const
 VALIDATENO : Cardinal = 30;

begin
 Result := True;
 for I := 1 to VALIDATE30OFFSETMAX do
  begin
   try
    I64 := Int64(Low(Integer)) - Int64(I);
    S := IntToStr(I64);
    StrToInt32Function(S);
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   except
    on E:EConvertError do
     begin
      Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
      if not Result then
       Exit;
     end
    else
    //All other exception types are bad -
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
  end;
end;

//Validates all $ prefixed hexadecimal numbers
//Adopted from Val B&V made by John O'Harrow

function TMainForm.Validate31 : Boolean;
var
 Lookup: array[0..$FFFF] of array[1..4] of Char; {'0000'..'FFFF'}
 I, J, Res : Integer;
 S: string;
 P1, P2: PInteger;
const
 VALIDATENO : Cardinal = 31;

 procedure SetupLookup;
 var
  I: integer;
  S: string;
 begin
  for I := 0 to $FFFF do
   begin
    S := IntToHex(I,4);
    Move(S[1], Lookup[I], 4);
   end;
 end;

begin
 try
  Result := True;
  SetupLookup;
  S := '$00000000';
  P1 := @S[2];
  P2 := @S[6];
  for I := 0 to $FFFF do
   begin
    P1^ := Pinteger(@Lookup[I])^; {Set First 4 Chars in S}
    for J := 0 to $FFFF do
     begin
      P2^ := Pinteger(@Lookup[J])^; {Set Last 4 Chars in S}
      Res := StrToInt32Function(S);
      if (Res <> (I shl 16) + J) then
       begin
        ErrorTrap(VALIDATENO, S);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates all decimal numbers
//Adopted from Val B&V made by John O'Harrow

function TMainForm.Validate32 : Boolean;
var
 Lookup: packed array[0..9999] of array[1..4] of Char; {'0000'..'9999'}
 I, Max, Min, M, Res : Integer;
 S: string;
 P: PInteger;
const
 VALIDATENO : Cardinal = 32;

  procedure SetupLookup;
  var
   I : Integer;
   S : string;

  begin
   for I := 0 to 9999 do
    begin
     S := IntToStr(I);
     if Length(S) = 1 then
      S := '000' + S
     else
      if Length(S) = 2 then
       S := '00' + S
      else
       if Length(S) = 3 then
        S := '0' + S;
     Move(S[1], Lookup[I], 4);
    end;
  end;

begin
 try
  Result := True;
  SetupLookup;
  I := -10000; {test -10000..+10000}
  repeat
   S := IntToStr(I);
   Res := StrToInt32Function(S);
   if (Res <> I) then
    begin
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   Inc(I);
  until I > 10000;
  I := MaxInt; {Test Last MaxInt MOD 10000}
  repeat
   S := IntToStr(I);
   Res := StrToInt32Function(S);
   if (Res <> I) then
    begin
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   Dec(I);
  until I mod 10000 = 0;
  S := IntToStr(I);
  Res := StrToInt32Function(S);
  if (Res <> I) then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  Max := I;
  I := -MaxInt-1; {Test Last MinInt MOD 10000}
  repeat
   S := IntToStr(I);
   Res := StrToInt32Function(S);
   if (Res <> I) then
    begin
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   Inc(I);
  until I mod 10000 = 0;
  S := IntToStr(I);
  Res := StrToInt32Function(S);
  if (Res <> I) then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  Min := I;
  I := 10000;
  while I < Max do {Test All Positive Values from 10000 and up}
   begin
    S := IntToStr(I);
    P := @S[Length(S)-3];
    for M := 0 to 9999 do
     begin
      P^ := Pinteger(@Lookup[M])^; {Set Last 4 Digits in S}
      Res := StrToInt32Function(S);
      if (Res <> I+M) then
       begin
        ErrorTrap(VALIDATENO, S);
        Result := False;
        Exit;
       end;
     end;
    Inc(I,10000);
   end;
  I := -10000;
  while I > Min do {Test All Negative Values}
   begin
    S := IntToStr(I);
    P := @S[Length(S)-3];
    for M := 0 to 9999 do
     begin
      P^ := Pinteger(@Lookup[M])^; {Set Last 4 Digits in S}
      Res := StrToInt32Function(S);
      if (Res <> I-M) then
       begin
        ErrorTrap(VALIDATENO, S);
        Result := False;
        Exit;
       end;
     end;
    Dec(I,10000);
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates all 0x prefixed hexadecimal numbers
//Adopted from Val B&V made by John O'Harrow

function TMainForm.Validate33 : Boolean;
var
 Lookup: array[0..$FFFF] of array[1..4] of Char; {'0000'..'FFFF'}
 I, J, Res : Integer;
 S: string;
 P1, P2: PInteger;
const
 VALIDATENO : Cardinal = 33;

 procedure SetupLookup;
 var
  I: integer;
  S: string;
 begin
  for I := 0 to $FFFF do
   begin
    S := IntToHex(I,4);
    Move(S[1], Lookup[I], 4);
   end;
 end;

begin
 try
  Result := True;
  SetupLookup;
  S := '0x00000000';
  P1 := @S[3];
  P2 := @S[7];
  for I := 0 to $FFFF do
   begin
    P1^ := Pinteger(@Lookup[I])^; {Set First 4 Chars in S}
    for J := 0 to $FFFF do
     begin
      P2^ := Pinteger(@Lookup[J])^; {Set Last 4 Chars in S}
      Res := StrToInt32Function(S);
      if (Res <> (I shl 16) + J) then
       begin
        ErrorTrap(VALIDATENO, S);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates all x prefixed hexadecimal numbers
//Adopted from Val B&V made by John O'Harrow

function TMainForm.Validate34 : Boolean;
var
 Lookup: array[0..$FFFF] of array[1..4] of Char; {'0000'..'FFFF'}
 I, J, Res : Integer;
 S: string;
 P1, P2: PInteger;
const
 VALIDATENO : Cardinal = 34;

 procedure SetupLookup;
 var
  I: integer;
  S: string;
 begin
  for I := 0 to $FFFF do
   begin
    S := IntToHex(I,4);
    Move(S[1], Lookup[I], 4);
   end;
 end;

begin
 try
  Result := True;
  SetupLookup;
  S := 'x00000000';
  P1 := @S[2];
  P2 := @S[6];
  for I := 0 to $FFFF do
   begin
    P1^ := Pinteger(@Lookup[I])^; {Set First 4 Chars in S}
    for J := 0 to $FFFF do
     begin
      P2^ := Pinteger(@Lookup[J])^; {Set Last 4 Chars in S}
      Res := StrToInt32Function(S);
      if (Res <> (I shl 16) + J) then
       begin
        ErrorTrap(VALIDATENO, S);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates all 0X prefixed hexadecimal numbers
//Adopted from Val B&V made by John O'Harrow

function TMainForm.Validate35 : Boolean;
var
 Lookup: array[0..$FFFF] of array[1..4] of Char; {'0000'..'FFFF'}
 I, J, Res : Integer;
 S: string;
 P1, P2: PInteger;
const
 VALIDATENO : Cardinal = 35;

 procedure SetupLookup;
 var
  I: integer;
  S: string;
 begin
  for I := 0 to $FFFF do
   begin
    S := IntToHex(I,4);
    Move(S[1], Lookup[I], 4);
   end;
 end;

begin
 try
  Result := True;
  SetupLookup;
  S := '0X00000000';
  P1 := @S[3];
  P2 := @S[7];
  for I := 0 to $FFFF do
   begin
    P1^ := Pinteger(@Lookup[I])^; {Set First 4 Chars in S}
    for J := 0 to $FFFF do
     begin
      P2^ := Pinteger(@Lookup[J])^; {Set Last 4 Chars in S}
      Res := StrToInt32Function(S);
      if (Res <> (I shl 16) + J) then
       begin
        ErrorTrap(VALIDATENO, S);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates all X prefixed hexadecimal numbers
//Adopted from Val B&V made by John O'Harrow

function TMainForm.Validate36 : Boolean;
var
 Lookup: array[0..$FFFF] of array[1..4] of Char; {'0000'..'FFFF'}
 I, J, Res : Integer;
 S: string;
 P1, P2: PInteger;
const
 VALIDATENO : Cardinal = 36;

 procedure SetupLookup;
 var
  I: integer;
  S: string;
 begin
  for I := 0 to $FFFF do
   begin
    S := IntToHex(I,4);
    Move(S[1], Lookup[I], 4);
   end;
 end;

begin
 try
  Result := True;
  SetupLookup;
  S := 'X00000000';
  P1 := @S[2];
  P2 := @S[6];
  for I := 0 to $FFFF do
   begin
    P1^ := Pinteger(@Lookup[I])^; {Set First 4 Chars in S}
    for J := 0 to $FFFF do
     begin
      P2^ := Pinteger(@Lookup[J])^; {Set Last 4 Chars in S}
      Res := StrToInt32Function(S);
      if (Res <> (I shl 16) + J) then
       begin
        ErrorTrap(VALIDATENO, S);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

//Validates all possible two char strings against RTL function. Avoid #0 chars.

function TMainForm.Validate37 : Boolean;
var
 S : string;
 I1, I2, I3, I4 : Integer;
const
 VALIDATENO : Cardinal = 37;

begin
 Result := True;
 for I4 := 1 to 255 do
  begin
  for I3 := 1 to 255 do
   begin
    S := Char(I3) + Char(I4);
    try
     I1 := StrToInt(S);
     try
      I2 := StrToInt32Function(S);
      if I2 <> I1 then
       begin
        ErrorTrap(VALIDATENO, S);
        Result := False;
        Exit;
       end;
     except
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
    except
     //StrToInt raised exception - so must our function - did RTL function raise E:EConvertError? Yes - otherwise it would fail this validation
     try
      StrToInt32Function(S);
     except
      on E:EConvertError do
       begin
        Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
        if not Result then
         Exit;
       end
      else
       //All other exception types are bad -
       begin
        ErrorTrap(VALIDATENO, S);
        Result := False;
        Exit;
       end;
     end;
    end;
   end;
  end;
end;

//Validates all possible three char strings against RTL function. Avoid #0 chars.

function TMainForm.Validate38 : Boolean;
var
 S : string;
 I1, I2, I3, I4, I5 : Integer;
const
 VALIDATENO : Cardinal = 38;

begin
 Result := True;
 for I5 := 1 to 255 do
  begin
   for I4 := 1 to 255 do
    begin
     for I3 := 1 to 255 do
      begin
       S := Char(I3) + Char(I4) + Char(I5);
       try
        I1 := StrToInt(S);
        try
         I2 := StrToInt32Function(S);
         if I2 <> I1 then
          begin
           ErrorTrap(VALIDATENO, S);
           Result := False;
           Exit;
          end;
        except
         ErrorTrap(VALIDATENO, S);
         Result := False;
         Exit;
        end;
       except
        //StrToInt raised exception - so must our function - did RTL function raise E:EConvertError? Yes - otherwise it would fail this validation
        try
         StrToInt32Function(S);
        except
         on E:EConvertError do
          begin
           Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
           if not Result then
            Exit;
          end
         else
          //All other exception types are bad -
          begin
           ErrorTrap(VALIDATENO, S);
           Result := False;
           Exit;
          end;
        end;
       end;
      end;
    end;
  end;
end;

//Validates VALIDATE39MAX random strings maximally VALIDATE39MAXSTRLEN long, against RTL function. Avoid #0 chars.

function TMainForm.Validate39 : Boolean;
var
 S : string;
 I1, I2, I3 : Integer;
const
 VALIDATENO : Cardinal = 39;

begin
 Result := True;
 for I3 := 0 to VALIDATE39MAX do
  begin
   if I3 mod VALIDATE39MAXSTRLEN = 0 then
    S := '';
   S := Char(Random(254)+1)+ S;
   try
    I1 := StrToInt(S);
    try
     I2 := StrToInt32Function(S);
     if I2 <> I1 then
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
   except
    //StrToInt raised exception - so must our function - did RTL function raise E:EConvertError? Yes - otherwise it would fail this validation
    try
     StrToInt32Function(S);
    except
     on E:EConvertError do
      begin
       Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
       if not Result then
        Exit;
      end
     else
      //All other exception types are bad -
      begin
       ErrorTrap(VALIDATENO, S);
       Result := False;
       Exit;
      end;
    end;
   end;
  end;
end;

//Validates that proper exception is raised for all numbers MinInt -> MinInt-VALIDATE30OFFSETMAX

function TMainForm.Validate40 : Boolean;
var
 S : string;
 I, I1, I2 : Integer;
 I64 : Int64;
const
 VALIDATENO : Cardinal = 40;

begin
 Result := True;
 for I := 1 to VALIDATE40OFFSETMAX do
  begin
   try
    I1 := Random(MaxInt);
    I2 := Random(MaxInt);
    I64 := Int64(I1) * Int64(I2);
    if I64 <= MaxInt then
     Continue;
    S := IntToStr(I64);
    StrToInt32Function(S);
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   except
    on E:EConvertError do
     begin
      Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
      if not Result then
       Exit;
     end
    else
    //All other exception types are bad
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
  end;
end;

function TMainForm.Validate41 : Boolean;
var
 S : string;
 I1, I2, I3, I4, I5, I6 : Integer;
const
 VALIDATENO : Cardinal = 41;

begin
 Result := True;
 for I6 := 0 to 10 do
  begin
   for I5 := 0 to 10 do
    begin
     for I4 := 0 to 10 do
      begin
       for I3 := 0 to 10 do
        begin
         S := Char(I3) + Char(I4) + Char(I5) + Char(I6);
         try
          I1 := StrToInt(S);
          try
           I2 := StrToInt32Function(S);
           if I2 <> I1 then
            begin
             ErrorTrap(VALIDATENO, S);
             Result := False;
             Exit;
            end;
          except
           ErrorTrap(VALIDATENO, S);
           Result := False;
           Exit;
          end;
         except
          //StrToInt raised exception - so must our function - did RTL function raise E:EConvertError? Yes - otherwise it would fail this validation
          try
           StrToInt32Function(S);
          except
           on E:EConvertError do
            begin
             Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
             if not Result then
              Exit;
            end
           else
            //All other exception types are bad -
            begin
             ErrorTrap(VALIDATENO, S);
             Result := False;
             Exit;
            end;
          end;
         end;
        end;
      end;
    end;
  end;
end;

//A number of simple testcases with positive decimal numbers

function TMainForm.Validate42 : Boolean;
var
 S : string;
 I : Integer;
const
 VALIDATENO : Cardinal = 42;

begin
 try
  Result := True;
  S := '0'#0;
  I := StrToInt32Function(S);
  if I <> 0 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '10'#0;
  I := StrToInt32Function(S);
  if I <> 10 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '210'#0;
  I := StrToInt32Function(S);
  if I <> 210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '3210'#0'ABFG';
  I := StrToInt32Function(S);
  if I <> 3210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '43210'#0'12';
  I := StrToInt32Function(S);
  if I <> 43210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-543210'#0;
  I := StrToInt32Function(S);
  if I <> -543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '6543210'#0;
  I := StrToInt32Function(S);
  if I <> 6543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '76543210'#0;
  I := StrToInt32Function(S);
  if I <> 76543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   end;
  S := '-876543210'#0;
  I := StrToInt32Function(S);
  if I <> -876543210 then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
   end;
  S := '2147483647'#0;
  I := StrToInt32Function(S);
  if I <> MaxInt then
   begin
    ErrorTrap(VALIDATENO, S);
    Result := False;
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False;
 end;
end;

function TMainForm.Validate43 : Boolean;
var
 S : string;
 I : Integer;
const
 VALIDATENO : Cardinal = 43;

begin
 Result := True;
 S := IntToStr(High(Integer));
 for I := 0 to VALIDATE43MAX do
  begin
   try
    S := '1'+ S;
    StrToInt32Function(S);
    ErrorTrap(VALIDATENO, S);
    Result := False;
    Exit;
   except
    on E:EConvertError do
     begin
      Result := E.Message = StringReplace(SInvalidInteger, '%s', S, []);
      if not Result then
       Exit;
     end
    else
    //All other exception types are bad -
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
   end;
  end;
end;

{
function TMainForm.Validate7 : Boolean;
var
 J, K, OffSet, OffSetx : Integer;
 Str : string;
 SearchChar : Char;
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore, EBPRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter, EBPRegisterAfter : Cardinal;
 X, Y, Z : Extended;
 SearchCharByte : Byte;
const
 STRSIZE : Integer = 355;
 VALIDATENO : Cardinal = 7;
 MINOFFSET : Integer = -23;

begin
 OffSetx := MINOFFSET;
 Str := '';//For compiler
 SearchChar := '8';//For compiler
 Offset := -9;//For compiler
 try
  Result := True;
  SetLength(Str, STRSIZE);
  for K := 1 to Length(Str) do
   Str[K] := Char(K-2 mod 255 + 1);
  for SearchCharByte := 0 to 255 do
   begin
    SearchChar := Char(SearchCharByte);
    for OffSet := MINOFFSET to Length(Str) do
     begin
      OffSetx := OffSet;
      asm
       mov EBXRegisterBefore, ebx
       mov EDIRegisterBefore, edi
       mov ESIRegisterBefore, esi
       mov EBPRegisterBefore, ebp
      end;
      CharPosIExFunction(SearchChar, Str, OffSet);
      asm
       mov EBXRegisterAfter, ebx
       mov EDIRegisterAfter, edi
       mov ESIRegisterAfter, esi
       mov EBPRegisterAfter, ebp
      end;
      //Verify that registers are preserved
      if ((EBXRegisterAfter <> EBXRegisterBefore) or
          (EDIRegisterAfter <> EDIRegisterBefore) or
          (ESIRegisterAfter <> ESIRegisterBefore) or
          (EBPRegisterAfter <> EBPRegisterBefore)) then
       begin
        ErrorTrap(VALIDATENO, SearchChar, Str, OffSetx);
        Result := False;
        Exit;
       end;
      try
       //Test for missing emms instruction in MMX functions
       X := 2;
       Y := 3;
       Z := X * Y;
       if Z <> 6 then
        Z := 6;
      except
       ErrorTrap(VALIDATENO, SearchChar, Str, OffSetx);
       Result := False;
       Exit;
      end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, SearchChar, Str, OffSetx);
  Result := False
 end;
end;

}

//Used in subbenchmark 1

// 89 decimal numbers
// 16 $ prefixed hexadecimal numbers
// 16 0x prefixed hexadecimal numbers
// 16 x prefixed hexadecimal numbers
// 16 0X prefixed hexadecimal numbers
// 16 X prefixed hexadecimal numbers
// 14 decimal numbers with leading spaces
// 14 hexadecimal numbers with leading spaces
// 10 decimal numbers with leading zeroes
// 10 hexadecimal numbers with leading zeroes

procedure TMainForm.FillSubBenchmark1StringArrays;
var
 J : Integer;

begin
 //Allocate "enough" space
 SetLength(SubBenchmark1StringArray,250);
 J := 0;
 // 89 decimal numbers
 SubBenchmark1StringArray[J]  := '0';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '2';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-3';
 Inc(J);
 SubBenchmark1StringArray[J]  := '4';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-5';
 Inc(J);
 SubBenchmark1StringArray[J]  := '6';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-7';
 Inc(J);
 SubBenchmark1StringArray[J]  := '8';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-9';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '2';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-3';
 Inc(J);
 SubBenchmark1StringArray[J]  := '4';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-5';
 Inc(J);
 SubBenchmark1StringArray[J]  := '6';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-7';
 Inc(J);
 SubBenchmark1StringArray[J]  := '8';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-9';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '2';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-3';
 Inc(J);
 SubBenchmark1StringArray[J]  := '4';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-5';
 Inc(J);
 SubBenchmark1StringArray[J]  := '6';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-7';
 Inc(J);
 SubBenchmark1StringArray[J]  := '8';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-9';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '2';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-3';
 Inc(J);
 SubBenchmark1StringArray[J]  := '4';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-5';
 Inc(J);
 SubBenchmark1StringArray[J]  := '6';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-7';
 Inc(J);
 SubBenchmark1StringArray[J]  := '8';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-9';
 Inc(J);
 SubBenchmark1StringArray[J]  := '10';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-20';
 Inc(J);
 SubBenchmark1StringArray[J]  := '30';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-40';
 Inc(J);
 SubBenchmark1StringArray[J]  := '50';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-11';
 Inc(J);
 SubBenchmark1StringArray[J]  := '22';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-33';
 Inc(J);
 SubBenchmark1StringArray[J]  := '44';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-55';
 Inc(J);
 SubBenchmark1StringArray[J]  := '12';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-23';
 Inc(J);
 SubBenchmark1StringArray[J]  := '34';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-45';
 Inc(J);
 SubBenchmark1StringArray[J]  := '56';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-13';
 Inc(J);
 SubBenchmark1StringArray[J]  := '24';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-35';
 Inc(J);
 SubBenchmark1StringArray[J]  := '46';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-57';
 Inc(J);
 SubBenchmark1StringArray[J]  := '100';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-200';
 Inc(J);
 SubBenchmark1StringArray[J]  := '300';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-111';
 Inc(J);
 SubBenchmark1StringArray[J]  := '222';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-333';
 Inc(J);
 SubBenchmark1StringArray[J]  := '123';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-234';
 Inc(J);
 SubBenchmark1StringArray[J]  := '345';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-134';
 Inc(J);
 SubBenchmark1StringArray[J]  := '256';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-378';
 Inc(J);
 SubBenchmark1StringArray[J]  := '1000';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-2000';
 Inc(J);
 SubBenchmark1StringArray[J]  := '1111';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-2222';
 Inc(J);
 SubBenchmark1StringArray[J]  := '1234';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-2345';
 Inc(J);
 SubBenchmark1StringArray[J]  := '1111';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-2222';
 Inc(J);
 SubBenchmark1StringArray[J]  := '10000';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-11111';
 Inc(J);
 SubBenchmark1StringArray[J]  := '12345';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-23456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '123456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-234567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '1234567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-12345678';
 Inc(J);
 SubBenchmark1StringArray[J]  := '123456789';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-1234567890';
 Inc(J);
 // 16 $ prefixed hexadecimal numbers
 SubBenchmark1StringArray[J]  := '$1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '$12';
 Inc(J);
 SubBenchmark1StringArray[J]  := '$123';
 Inc(J);
 SubBenchmark1StringArray[J]  := '$1234';
 Inc(J);
 SubBenchmark1StringArray[J]  := '$12345';
 Inc(J);
 SubBenchmark1StringArray[J]  := '$123456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '$1234567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$12';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$123';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$1234';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$12345';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$123456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$1234567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$12345678';
 Inc(J);
 // 16 0x prefixed hexadecimal numbers
 SubBenchmark1StringArray[J]  := '0x1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0x12';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0x123';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0x1234';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0x12345';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0x123456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0x1234567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0x1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0x12';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0x123';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0x1234';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0x12345';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0x123456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0x1234567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0x12345678';
 Inc(J);
 // 16 x prefixed hexadecimal numbers
 SubBenchmark1StringArray[J]  := 'x1';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'x12';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'x123';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'x1234';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'x12a45';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'x123456';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'x12A4567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-x1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-x1b';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-x12c';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-x123d';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-x1234e';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-x1f3456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-x12a4567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-x1234d678';
 Inc(J);
 // 16 0X prefixed hexadecimal numbers
 SubBenchmark1StringArray[J]  := '0X1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0X12';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0X12a';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0X12b4';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0X123c5';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0X12a456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0X123f567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0X1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0X1e';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0X123';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0X1234';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0X1d345';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0X123456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0X12a4567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0X123f5678';
 Inc(J);
 // 16 X prefixed hexadecimal numbers
 SubBenchmark1StringArray[J]  := 'X1';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'X12';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'X12f';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'X12a4';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'X12b45';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'X123c56';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'X1234f67';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-X1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-X12';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-X123';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-X1f34';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-Xf2345';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-X1b3456';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-X12c4567';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-X123d5678';
 Inc(J);
 // 14 decimal numbers with leading spaces
 SubBenchmark1StringArray[J]  := ' 0';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' -1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '  2';
 Inc(J);
 SubBenchmark1StringArray[J]  := '  -3';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   4';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   -5';
 Inc(J);
 SubBenchmark1StringArray[J]  := '     0006';
 Inc(J);
 SubBenchmark1StringArray[J]  := '     -7';
 Inc(J);
 SubBenchmark1StringArray[J]  := '       08';
 Inc(J);
 SubBenchmark1StringArray[J]  := '         -9';
 Inc(J);
 SubBenchmark1StringArray[J]  := '    06';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' -18';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   28';
 Inc(J);
 SubBenchmark1StringArray[J]  := '     -37';
 Inc(J);
 // 14 hexadecimal numbers with leading spaces
 SubBenchmark1StringArray[J]  := ' $0';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' -x1';
 Inc(J);
 SubBenchmark1StringArray[J]  := '  $2';
 Inc(J);
 SubBenchmark1StringArray[J]  := '  -X3';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   $4';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   -0x5';
 Inc(J);
 SubBenchmark1StringArray[J]  := '     0X0006';
 Inc(J);
 SubBenchmark1StringArray[J]  := '     -X7';
 Inc(J);
 SubBenchmark1StringArray[J]  := '       $08';
 Inc(J);
 SubBenchmark1StringArray[J]  := '         -0X9';
 Inc(J);
 SubBenchmark1StringArray[J]  := '    +x06';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' -$18';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   $28';
 Inc(J);
 SubBenchmark1StringArray[J]  := '     -$37';
 Inc(J);
 // 10 decimal numbers with leading zeroes
 SubBenchmark1StringArray[J]  := '00000000000000';
 Inc(J);
 SubBenchmark1StringArray[J]  := '00000000000001';
 Inc(J);
 SubBenchmark1StringArray[J]  := '00000000000024';
 Inc(J);
 SubBenchmark1StringArray[J]  := '00000000000324';
 Inc(J);
 SubBenchmark1StringArray[J]  := '00000000005324';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-00000000000000';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-00000000000001';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-00000000000024';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-00000000000324';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-00000000005324';
 Inc(J);
 // 10 hexadecimal numbers with leading zeroes
 SubBenchmark1StringArray[J]  := 'x00000000000000';
 Inc(J);
 SubBenchmark1StringArray[J]  := '0x00000000000001';
 Inc(J);
 SubBenchmark1StringArray[J]  := '$00000000000024';
 Inc(J);
 SubBenchmark1StringArray[J]  := '$00000000000324';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'X00000000005324';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-0X00000000000000';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$00000000000001';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-$00000000000024';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-x00000000000324';
 Inc(J);
 SubBenchmark1StringArray[J]  := '-X00000000005324';
 //Adjust array sizes
 SetLength(SubBenchmark1StringArray,J+1);
end;

function RandomLogarithmic32: Integer;
const
  LN_MAXINT = 21.487562;    // Ln(2^31 - 1), rounded down for safety
  INT_COUNT = 4294967296.0; // Number of 32-bit integers as a float number
var
  LogValue: Extended;
begin
  LogValue := (Random + Random / INT_COUNT) * LN_MAXINT;
  Result := Floor(Exp(LogValue));
end;

function RandomSign: Integer;
begin
  Result := Random(2) * 2 - 1;
end;

procedure TMainForm.FillSubBenchmark2StringArrays;
var
 I, J : Integer;

begin
 SetLength(SubBenchmark2StringArray, SUBBENCH2ARRAYSIZE);
 RandSeed := $01234567;
 for I := 0 to SUBBENCH2ARRAYSIZE-1 do
  begin
   J := RandomSign * RandomLogarithmic32;
   SubBenchmark2StringArray[I]  := IntToStr(J);
  end;
end;

procedure TMainForm.FillSubBenchmark3StringArrays;
var
 I, J : Integer;

begin
 SetLength(SubBenchmark3StringArray, SUBBENCH3ARRAYSIZE);
 RandSeed := $01234567;
 for I := 0 to SUBBENCH3ARRAYSIZE-1 do
  begin
   J := RandomLogarithmic32;
   if RandomSign < 0 then
    begin
     if I mod 5 = 0 then
      SubBenchmark3StringArray[I]  := '-$' + IntToHex(J,1)
     else if I mod 5 = 1 then
      SubBenchmark3StringArray[I]  := '-0x' + IntToHex(J,1)
     else if I mod 5 = 2 then
      SubBenchmark3StringArray[I]  := '-0X' + IntToHex(J,1)
     else if I mod 5 = 3 then
      SubBenchmark3StringArray[I]  := '-X' + IntToHex(J,1)
     else
      SubBenchmark3StringArray[I]  := '-x' + IntToHex(J,1);
    end
   else
    begin
     if I mod 5 = 0 then
      SubBenchmark3StringArray[I]  := '$' + IntToHex(J,1)
     else if I mod 5 = 1 then
      SubBenchmark3StringArray[I]  := '0x' + IntToHex(J,1)
     else if I mod 5 = 2 then
      SubBenchmark3StringArray[I]  := '0X' + IntToHex(J,1)
     else if I mod 5 = 3 then
      SubBenchmark3StringArray[I]  := 'X' + IntToHex(J,1)
     else
      SubBenchmark3StringArray[I]  := 'x' + IntToHex(J,1);
    end;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WriteIniFile(INIFILENAME);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 CpuString : string;

begin
 ClearAllEditBoxes;
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 120;
 ReportRichEdit.Paragraph.Tab[1] := 155;
 ReportRichEdit.Paragraph.Tab[2] := 200;
 ReportRichEdit.Paragraph.Tab[3] := 245;
 ReportRichEdit.Paragraph.Tab[4] := 300;
 FillSubBenchmark1StringArrays;
 FillSubBenchmark2StringArrays;
 FillSubBenchmark3StringArrays;
 FillTestSetArray1;
 FillTestSetArray2;
 if not QueryPerformanceFrequency(Frequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 SortFunctionArray;
 FillFunctionSelectionRadioGroup;
 ReadIniFile(INIFILENAME);
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

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
var
 FunctionPointer : TStrToInt32Function;
begin
 FunctionPointer := FunctionArray[FunctionSelectionRadioGroup.ItemIndex].FunctionPointer;
 StrToInt32Function := FunctionPointer;
end;

procedure TMainForm.SaveButtonClick(Sender: TObject);
begin
 SaveDialog1.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog1.FileName := FResultsFileName;
 if SaveDialog1.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog1.FileName);
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

function TMainForm.ValidationResultsPresent : Boolean;
var
 LineNo : Integer;
 S1 : AnsiString;
begin
 Result := False;
 for LineNo := 0 to ReportRichEdit.Lines.Count-1 do
  begin
   S1 := ReportRichEdit.Lines[LineNo];
   if (Pos('Passed', S1) <> 0) or (Pos('Failed', S1) <> 0) then
    begin
     Result := True;
     Exit;
    end;
  end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1 : Integer;

begin
 BenchmarkAllButton.Caption := 'Running';
 if ValidationResultsPresent then
  ReportRichEdit.Clear;
 Update;
 for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I1 := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkStrToInt32;
   BenchmarkTest;
   AlignmentTest;
   if ReportRichEdit.Lines.Count > 1 then
    SortRichEdit;
   ReportRichEdit.SelStart := 0;
   ReportRichEdit.Perform(EM_ScrollCaret, 0, 0);
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';
 if Sender <> nil then //Do not log results when doing benchmark test
  begin
   if FileExists(FBenchmarkFileName) then
    FResultList.LoadFromFile(FBenchmarkFileName);
   FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
   FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
   FResultList.AddStrings(ReportRichEdit.Lines);
   FResultList.Add('');
   FResultList.SaveToFile(FBenchmarkFileName);
  end;
end;

function TMainForm.Validate : Boolean;
begin
 Result := Validate1 and
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
           Validate14 and
           Validate15 and
           Validate16 and
           Validate17 and
           Validate18 and
           Validate19 and
           Validate20 and
           Validate21 and
           Validate22 and
           Validate23 and
           Validate24 and
           Validate25 and
           Validate26 and
           Validate27 and
           Validate28 and
           Validate29 and
           Validate30 and
           Validate37 and
           Validate38 and
           Validate39 and
           Validate40 and
           Validate41 and
           Validate42 and
           Validate43;
 if  not FasterValidationCheckBox.Checked then
  begin
   Result := Result and
             Validate31 and
             Validate32 and
             Validate33 and
             Validate34 and
             Validate35 and
             Validate36;
   end;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Integer;
 FunctionName, StrToInt32FunctionAddressString, S : AnsiString;
 StrToInt32FunctionAddress : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_IDLE) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_IDLE failed');
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   if FasterValidationCheckBox.Checked then
    begin
     //Only validate _a functions
     S := FunctionName[Length(FunctionName)];
     if S <> 'a' then
      Continue;
    end;
   StrToInt32FunctionAddress := Integer(@StrToInt32Function);
   StrToInt32FunctionAddressString := IntToHex(StrToInt32FunctionAddress, 8);
   Update;
   try
    if Validate then
     ReportRichEdit.Lines.Add(FunctionName + #9 + StrToInt32FunctionAddressString[8] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionName + #9 + StrToInt32FunctionAddressString[8] + #9 + 'Failed');
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionName + #9 + StrToInt32FunctionAddressString[8] + #9 + 'Failed');
   end;
  end;
 StatusBar1.SimpleText := 'Validate All Completed';
 ValidateAllButton.Caption := 'Validate All';

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('StrToInt32 Benchmark Results');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 for I1 := 1 to 3 do
  BenchmarkAllButtonClick(nil);
 BenchTestButton.Caption := 'Bench Test';
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
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
   FunctionAddress := Cardinal(@StrToInt32Function);
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

//******************************************************************************
//Ini file handling functions
//******************************************************************************

procedure TMainForm.ReadIniFile(FileName : AnsiString);
var
 IniFile : TIniFile;

begin
 IniFile := TIniFile.Create(FileName);
 FunctionSelectionRadioGroup.ItemIndex := IniFile.ReadInteger('Settings', 'SelectedFunction', 0);
 FasterValidationCheckBox.Checked := IniFile.ReadBool('Settings', 'FasterValidation', False);
 ShowErrorDialogCheckBox.Checked := IniFile.ReadBool('Settings', 'ShowErrorDialog', False);
 IniFile.Free;
end;

procedure TMainForm.WriteIniFile(FileName : AnsiString);
var
 IniFile : TIniFile;

begin
 IniFile := TIniFile.Create(FileName);
 IniFile.WriteInteger('Settings', 'SelectedFunction', FunctionSelectionRadioGroup.ItemIndex);
 IniFile.WriteBool('Settings', 'FasterValidation', FasterValidationCheckBox.Checked);
 IniFile.WriteBool('Settings', 'ShowErrorDialog', ShowErrorDialogCheckBox.Checked);
 IniFile.Free;
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
    FasterValidationCheckBox.Checked := False;
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    ValidateAllButton.Click;
    Halt;
  end;
end;


end.
