unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'CharPosRev';

type

 TCharPosRevFunction = function (SearchChar : Char; const S: string) : Integer;

 TFunctionEntry = record
  FunctionName : AnsiString;
  FunctionPointer : TCharPosRevFunction;
 end;

 TTestSet = record
  SearchChar : Char;
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
    RemoveSlowestFunctionVersionsButton: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CleanButtonClick(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure RegisterFunction(FunctionName : AnsiString; FunctionPointer : TCharPosRevFunction);
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
    procedure RemoveSlowestFunctionVersionsButtonClick(Sender: TObject);
  private
   FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
   FResultList: TStringList;
   Frequency : Int64;
   NoOfTicksArray : array of Int64;
   TestSetArray : array of TTestSet;
   procedure ReadIniFile(FileName : AnsiString);
   procedure WriteIniFile(FileName : AnsiString);
   procedure FillFunctionSelectionRadioGroup;
   function SubBenchmark1 : Double;
   function SubBenchmark2 : Double;
   procedure FillSubBenchmark1StringArrays;
   procedure FillSubBenchmark2StringArrays;
   procedure BenchmarkCharPosRev;
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
   procedure SortRichEdit;
   procedure FillTestSetArray;
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
 FastcodeCPUID, SystemInfoUnit, IniFiles, StrUtils, Math, CharPosRevDKCUnit, AboutUnit, CharPosRevRefUnit,
 CharPosRevTestUnit;

var
 //Used in validation and benchmark
 SearchCharArray : array of Char;
 StringArray : array of String;
 CharPosRevFunction : TCharPosRevFunction;
 FunctionArray : array of TFunctionEntry;
 SubBench2StrArray : array of string;

const
 NOOFRERUNS : Cardinal = 12;//Reduce this for faster benchmarking with reduced precision
 MAXNOOFRUNSSUB1 : Cardinal = 256100;
 MAXNOOFRUNSSUB2 : Cardinal = 10892;
 RUNTIMESCALE : Cardinal = 100;
 //Adjusted such that the two subbenches carries the same weigth on a blend of the 6 2006 CPU targets
 SUBBENCH1SCALE : Double = 1000;
 SUBBENCH2SCALE : Double = 1000;
 INIFILENAME : AnsiString = 'CharPosRevBV.Ini';
 MAXSTRLENSUBBENCH2 : Integer = 177;
 SEARCHCHARSUBBENCH2 : Char = 'F';
 NOOFSTRINGSSUBBENCH2 : Integer = 1000;
 MATCHRATIO : Integer = 4;

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

procedure TMainForm.RegisterFunction(FunctionName : AnsiString; FunctionPointer : TCharPosRevFunction);
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
         if MaxSpread > 2 then
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

//TODO 1 -DKC: Add more validation testsets

procedure TMainForm.FillTestSetArray;
var
 Size : Integer;

begin
 Size := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BCDE';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'A';
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'X';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BB';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BA';
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'AB';
 TestSetArray[Size-1].CorrectResult := 1;

 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBB';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBA';
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BAB';
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'ABB';
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBB';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBA';
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBAB';
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BABB';
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'ABBB';
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'ABA';
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := #0;
 TestSetArray[Size-1].S := 'ABA';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := #0;
 TestSetArray[Size-1].S := #0'ABA';
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'XXXA';
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'XXAX';
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'XAXX';
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'AXXX';
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'ABBBB';
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'XXXXXXXXXXXXXXXXXABBBBBBBBBBBBBBBB';
 TestSetArray[Size-1].CorrectResult := 18;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'XXXXXXXXXXXXXXXXABBBBBBBBBBBBBBBB';
 TestSetArray[Size-1].CorrectResult := 17;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'ABBBBBBBBBBBBBBB';
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBBBBBBBBBBBBBB';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBBBBBBBBBBBBBA';
 TestSetArray[Size-1].CorrectResult := 16;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBBBBBBBBBBBBAB';
 TestSetArray[Size-1].CorrectResult := 15;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBBBBBB';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBBBBBA';
 TestSetArray[Size-1].CorrectResult := 8;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBBBBAB';
 TestSetArray[Size-1].CorrectResult := 7;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBBBABB';
 TestSetArray[Size-1].CorrectResult := 6;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBBABBB';
 TestSetArray[Size-1].CorrectResult := 5;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBBABBBB';
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BBABBBBB';
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BABBBBBB';
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'ABBBBBBB';
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'x';
 TestSetArray[Size-1].S := 'ABAxbgreredfggyj';
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'ABAxbgreredfggyj';
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ZZ';
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ZZZ';
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ZZZZ';
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ZZZZZ';
 TestSetArray[Size-1].CorrectResult := 5;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'AZZZZZ';
 TestSetArray[Size-1].CorrectResult := 6;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'AZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 7;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'AZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 8;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'AZZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 9;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'AZZZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 10;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'AZZZZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 11;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ABZZZZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 12;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ABCZZZZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 13;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ABCDZZZZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 14;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ABCDEZZZZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 15;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ABCDEFZZZZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 16;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'ABCDEFZZZZZZZZZZZ';
 TestSetArray[Size-1].CorrectResult := 17;
end;

procedure TMainForm.FillFunctionSelectionRadioGroup;
var
 I : Integer;

begin
 for I := 1 to Length(FunctionArray) do
  FunctionSelectionRadioGroup.Items.Add(FunctionArray[I-1].FunctionName);
 FunctionSelectionRadioGroup.ItemIndex := 0;
end;

procedure ErrorTrap(ValidateNo : Integer; SearchChar : Char; S : AnsiString);
var
 CorrectResult, Result : Integer;

begin
 CorrectResult := CharPosRevRef(SearchChar, S);
 Result := CharPosRevFunction(SearchChar, S);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' SearchChar: ' + SearchChar + ' String: ' + S + ' Result: ' + IntToStr(Result) + ' Correct Result: ' + IntToStr(CorrectResult)), 'Error');
end;

procedure TMainForm.BenchmarkCharPosRev;
var
 Bench, SubBench1, SubBench2 : Double;
 FunctionName, CharPosRewFunctionAddressString : AnsiString;
 CharPosRewFunctionAddress : Cardinal;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  CharPosRewFunctionAddress := Integer(@CharPosRevFunction);
  CharPosRewFunctionAddressString := IntToHex(CharPosRewFunctionAddress, 8);
  Update;
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  Bench := SubBench1 + SubBench2;
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                           CharPosRewFunctionAddressString[8] + #9 +
                           FloatToStrF(SubBench1, ffFixed, 9, 0) + #9 +
                           FloatToStrF(SubBench2, ffFixed, 9, 0) + #9 +
                           FloatToStrF(Bench, ffFixed, 9, 0));
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                                     'Failed' + #9 +
                                     '9999' + #9 +
                                     '9999' + #9 +
                                     '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Double;
var
 J, I1, I5, K, RunNo : Cardinal;
 SearchCharArrayLength : Integer;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;

begin
 SearchCharArrayLength := Length(SearchCharArray);
 I1 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB1 do
    for K := 0 to SearchCharArrayLength - 1 do
     I1 := CharPosRevFunction(SearchCharArray[K], StringArray[K]);
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
 I, J, I1, I5 : Cardinal;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 SubBench2StrArrayLength : Integer;

begin
 SubBench2StrArrayLength := Length(SubBench2StrArray);
 I1 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB2 do
    for I := 0 to SubBench2StrArrayLength-1 do
     I1 := CharPosRevFunction(SEARCHCHARSUBBENCH2, SubBench2StrArray[I]);
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

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 BenchmarkButton.Caption := 'Running';
 BenchmarkCharPosRev;
 if ReportRichEdit.Lines.Count > 1 then
  SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
 //CalculateStats;//Debug only
 BenchmarkButton.Caption := 'Benchmark';
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName, CharPosRevFunctionAddressString : AnsiString;
 CharPosRevFunctionAddress : Cardinal;

begin
 try
  ValidateButton.Caption := 'Running';
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  CharPosRevFunctionAddress := Integer(@CharPosRevFunction);
  CharPosRevFunctionAddressString := IntToHex(CharPosRevFunctionAddress, 8);
  if Validate then
   ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosRevFunctionAddressString[8] + #9 + 'Passed')
  else
   ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosRevFunctionAddressString[8] + #9 + 'Failed');
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosRevFunctionAddressString[8] + #9 + 'Failed');
 end;
 StatusBar1.SimpleText := 'Validate Completed';
 ValidateButton.Caption := 'Validate';
end;

function TMainForm.Validate1 : Boolean;
var
 TestNo, I : Integer;
const
 VALIDATENO : Cardinal = 1;

begin
 StatusBar1.SimpleText := 'Running Validate1';
 Update;
 Result := True;
 for TestNo := 0 to Length(TestSetArray)-1 do
  begin
   try
    I := CharPosRevFunction(TestSetArray[TestNo].SearchChar,
                            TestSetArray[TestNo].S);
    if I <> TestSetArray[TestNo].CorrectResult then
     begin
      ErrorTrap(VALIDATENO, TestSetArray[TestNo].SearchChar,
                            TestSetArray[TestNo].S);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, TestSetArray[TestNo].SearchChar,
                          TestSetArray[TestNo].S);
    Result := False;
   end;
  end;
end;

function TMainForm.Validate2 : Boolean;
var
 I, Iref, J : Integer;
 S : String;
 SearchChar : Char;
const
 VALIDATE2MAX : Integer = 255;
 VALIDATENO : Cardinal = 2;

begin
 StatusBar1.SimpleText := 'Running Validate2';
 Update;
 Result := True;
 SearchChar := #0;
 S := '';
 for J := 1 to VALIDATE2MAX do
  begin
   S := S + Char(J);
   Iref := 0;//Never find #0, because we do not put it in S
   try
    I := CharPosRevFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S);
    Result := False;
   end;
  end;
end;

function TMainForm.Validate3 : Boolean;
var
 I, Iref, J : Integer;
 S : String;
 SearchChar : Char;
const
 VALIDATE2MAX : Integer = 12345678;
 VALIDATENO : Cardinal = 3;

begin
 StatusBar1.SimpleText := 'Running Validate3';
 Update;
 Result := True;
 S := '';
 for J := 1 to VALIDATE2MAX do
  begin
   SearchChar := Char(J);
   S := S + SearchChar;
   Iref := J;
   try
    I := CharPosRevFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S);
    Result := False;
   end;
  end;
end;

function TMainForm.Validate4 : Boolean;
var
 I, Iref, J : Integer;
 S : String;
 SearchChar, C : Char;
const
 VALIDATE2MAX : Integer = 17487;
 VALIDATENO : Cardinal = 4;

begin
 StatusBar1.SimpleText := 'Running Validate4';
 Update;
 Result := True;
 S := 'X';
 for J := 1 to VALIDATE2MAX do
  begin
   SearchChar := 'X';
   C := Char(Random(255));
   if C <> SearchChar then
    S := S + C;
   Iref := 1;
   try
    I := CharPosRevFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S);
    Result := False;
   end;
  end;
end;

function TMainForm.Validate5 : Boolean;
var
 I, Iref, J : Integer;
 S : String;
 SearchChar, C1, C2 : Char;
const
 VALIDATE2MAX : Integer = 674;
 VALIDATENO : Cardinal = 5;

begin
 StatusBar1.SimpleText := 'Running Validate5';
 Update;
 Result := True;
 S := 'x';
 SearchChar := 'x';
 for J := 1 to VALIDATE2MAX do
  begin
   C1 := Char(Random(255));
   if C1 = SearchChar then
    C1 := 'A';
   C2 := Char(Random(255));
   if C2 = SearchChar then
    C2 := 'A';
   S := C1 + S + C2;
   Iref := J+1;
   try
    I := CharPosRevFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S);
    Result := False;
   end;
  end;
end;

var
 GlobalStr: AnsiString;

function TMainForm.Validate6 : Boolean;
const
 VALIDATENO : Cardinal = 6;

begin
 StatusBar1.SimpleText := 'Running Validate6';
 Update;
 GlobalStr := '0';
 PInteger(Integer(GlobalStr)-4)^ := 0; //Set Length to 0
 Result := CharPosRevFunction('0', GlobalStr) = 0;
 if not Result then
  ErrorTrap(VALIDATENO, '0', GlobalStr);
end;

{$WARNINGS OFF}
{$HINTS OFF}

function TMainForm.Validate7 : Boolean;
var
 K, StrSize : Integer;
 S : string;
 SearchChar : Char;
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore, EBPRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter, EBPRegisterAfter : Cardinal;
 X, Y, Z : Extended;
 SearchCharByte : Byte;
const
 STRSIZEMAX : Integer = 1455;
 VALIDATENO : Cardinal = 7;

begin
 S := '';//For compiler
 SearchChar := '8';//For compiler
 try
  Result := True;
  for StrSize := 0 to STRSIZEMAX do
   begin
    SetLength(S, StrSize);
    for K := 1 to Length(S) do
     S[K] := Char(K-2 mod 255 + 1);
    for SearchCharByte := 0 to 255 do
     begin
      SearchChar := Char(SearchCharByte);
      asm
       mov EBXRegisterBefore, ebx
       mov EDIRegisterBefore, edi
       mov ESIRegisterBefore, esi
       mov EBPRegisterBefore, ebp
      end;
      CharPosRevFunction(SearchChar, S);
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
        ErrorTrap(VALIDATENO, SearchChar, S);
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
       ErrorTrap(VALIDATENO, SearchChar, S);
       Result := False;
       Exit;
      end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, SearchChar, S);
  Result := False
 end;
end;

{$WARNINGS ON}
{$HINTS ON}

function TMainForm.Validate8 : Boolean;
var
 I, Iref, J1, J2, J3, J4 : Integer;
 S : String;
 SearchChar : Char;
const
 VALIDATE8MAX : Integer = 60;//Must be <= 255
 VALIDATENO : Cardinal = 8;

begin
 StatusBar1.SimpleText := 'Running Validate8';
 Update;
 Result := True;
 SearchChar := #0;
 SetLength(S, 4);
 Iref := 0;
 for J1 := 1 to VALIDATE8MAX do
  begin
   S[1] := Char(J1);
   for J2 := 1 to VALIDATE8MAX do
    begin
     S[2] := Char(J2);
     for J3 := 1 to VALIDATE8MAX do
      begin
       S[3] := Char(J3);
       for J4 := 1 to VALIDATE8MAX do
        begin
         S[4] := Char(J4);
         try
          I := CharPosRevFunction(SearchChar, S);
          if I <> Iref then
           begin
            ErrorTrap(VALIDATENO, SearchChar, S);
            Result := False;
            Exit;
           end;
         except
          ErrorTrap(VALIDATENO, SearchChar, S);
          Result := False;
         end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate9 : Boolean;
var
 I, Iref, J1, J2, J3, J4 : Integer;
 S : String;
 SearchChar : Char;
const
 VALIDATE9MIN : Integer = 60;//Must be > #0 and <= 255 and < VALIDATE9MAX
 VALIDATE9MAX : Integer = 120;//Must be <= 255
 VALIDATENO : Cardinal = 9;

begin
 StatusBar1.SimpleText := 'Running Validate9';
 Update;
 Result := True;
 SearchChar := #0;
 SetLength(S, 5);
 S[1] := #0;
 Iref := 1;
 for J1 := VALIDATE9MIN to VALIDATE9MAX do
  begin
   S[2] := Char(J1);
   for J2 := VALIDATE9MIN to VALIDATE9MAX do
    begin
     S[3] := Char(J2);
     for J3 := VALIDATE9MIN to VALIDATE9MAX do
      begin
       S[4] := Char(J3);
       for J4 := VALIDATE9MIN to VALIDATE9MAX do
        begin
         S[5] := Char(J4);
         try
          I := CharPosRevFunction(SearchChar, S);
          if I <> Iref then
           begin
            ErrorTrap(VALIDATENO, SearchChar, S);
            Result := False;
            Exit;
           end;
         except
          ErrorTrap(VALIDATENO, SearchChar, S);
          Result := False;
         end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate10 : Boolean;
var
 I, Iref, J1, J2, J3, J4 : Integer;
 S : String;
 SearchChar : Char;
const
 VALIDATE10MIN : Integer = 160;//Must be > #1 and <= 255 and < VALIDATE9MAX
 VALIDATE10MAX : Integer = 255;//Must be <= 255
 VALIDATENO : Cardinal = 10;

begin
 StatusBar1.SimpleText := 'Running Validate10';
 Update;
 Result := True;
 SearchChar := #1;
 SetLength(S, 6);
 S[1] := #1;
 S[2] := #1;
 Iref := 2;
 for J1 := VALIDATE10MIN to VALIDATE10MAX do
  begin
   S[3] := Char(J1);
   for J2 := VALIDATE10MIN to VALIDATE10MAX do
    begin
     S[4] := Char(J2);
     for J3 := VALIDATE10MIN to VALIDATE10MAX do
      begin
       S[5] := Char(J3);
       for J4 := VALIDATE10MIN to VALIDATE10MAX do
        begin
         S[6] := Char(J4);
         try
          I := CharPosRevFunction(SearchChar, S);
          if I <> Iref then
           begin
            ErrorTrap(VALIDATENO, SearchChar, S);
            Result := False;
            Exit;
           end;
         except
          ErrorTrap(VALIDATENO, SearchChar, S);
          Result := False;
         end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate11 : Boolean;
var
 I, Iref, J1, J2, J3, J4 : Integer;
 S : String;
 SearchChar : Char;
const
 VALIDATE11MIN : Integer = 160;//Must be > #2 and <= 255 and < VALIDATE9MAX
 VALIDATE11MAX : Integer = 215;//Must be <= 255
 VALIDATENO : Cardinal = 11;

begin
 StatusBar1.SimpleText := 'Running Validate11';
 Update;
 Result := True;
 SearchChar := #2;
 SetLength(S, 7);
 S[1] := #2;
 S[2] := #2;
 S[3] := #2;
 Iref := 3;
 for J1 := VALIDATE11MIN to VALIDATE11MAX do
  begin
   S[4] := Char(J1);
   for J2 := VALIDATE11MIN to VALIDATE11MAX do
    begin
     S[5] := Char(J2);
     for J3 := VALIDATE11MIN to VALIDATE11MAX do
      begin
       SetLength(S, 7);//Reset string length
       S[6] := Char(J3);
       for J4 := VALIDATE11MIN to VALIDATE11MAX do
        begin
         S[7] := Char(J4);
         try
          S := S + Char(Random(255-VALIDATE11MIN)+VALIDATE11MIN);//Always add a char in the range VALIDATE11MIN -> VALIDATE11MAX
          I := CharPosRevFunction(SearchChar, S);
          if I <> Iref then
           begin
            ErrorTrap(VALIDATENO, SearchChar, S);
            Result := False;
            Exit;
           end;
         except
          ErrorTrap(VALIDATENO, SearchChar, S);
          Result := False;
         end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate12 : Boolean;
var
 I, Iref, RunNo, CharIndex : Integer;
 S : String;
 SearchChar : Char;
 CharValue : Byte;
const
 VALIDATE12STRLEN : Integer = 2000;
 VALIDATE12RUNNOMAX : Integer = 1000000;
 VALIDATENO : Cardinal = 12;

begin
 StatusBar1.SimpleText := 'Running Validate12';
 Update;
 Result := True;
 SetLength(S, VALIDATE12STRLEN);
 for RunNo := 1 to VALIDATE12RUNNOMAX do
  begin
   CharIndex := Random(VALIDATE12STRLEN-1)+1;
   CharValue := Random(255);
   SearchChar := Char(Random(255));
   S[CharIndex] := Char(CharValue);
   Iref := CharPosRevRef(SearchChar, S);
   try
    I := CharPosRevFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S);
    Result := False;
   end;
  end;
end;

//Made by John O'Harrow

function TMainForm.Validate13 : Boolean;
var
  S: String;
  Ch: Char;
const
  VALIDATENO : Cardinal = 13;
begin
  SetLength(S, $01010101); {Sets All Bytes of Length Integer to 1}
  Fillchar(S[1], length(S), 0);
  Ch := #1;
  Result := CharPosRevFunction(Ch, S) = 0;
  if not Result then
    ErrorTrap(VALIDATENO, Ch, S);
end;

function GetRefCount(S : string) : Integer;
asm
   test eax,eax
   jz   @Exit
   mov  eax,[eax-8]
@Exit :
end;

//Validates that Refcount and Length of S is not modified

function TMainForm.Validate14 : Boolean;
var
 I, Iref, J, RefCountS, RefCountSold : Integer;
 S, Sold : String;
 SearchChar : Char;
const
 VALIDATE14MAX : Integer = 25500;
 VALIDATENO : Cardinal = 14;

begin
 StatusBar1.SimpleText := 'Running Validate14';
 Update;
 Result := True;
 SearchChar := #0;
 S := '';
 for J := 1 to VALIDATE14MAX do
  begin
   Sold := S;
   Iref := 0;//Never find #0, because we do not put it in S
   try
    I := CharPosRevFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
      Exit;
     end;
    if Length(S) <> Length(Sold) then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
      Exit;
     end;
    RefCountS := GetRefCount(S);
    RefCountSold := GetRefCount(Sold);
    if RefCountS <> RefCountSold then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S);
    Result := False;
   end;
   S := S + Char((J mod 255)+1);
  end;
end;

//Made by John O'Harrow
//Modified slightly be Dennis

function TMainForm.Validate15 : Boolean;
var
  S: String;
  Ch: Char;
  I,J: Integer;
const
  VALIDATENO : Cardinal = 15;
begin
  StatusBar1.SimpleText := 'Running Validate15';

  SetLength(S, $01010101); {Sets All Bytes of Length Integer to 1}
  Fillchar(S[1], length(S), 0);
  Ch := #1;
  Result := CharPosRevFunction(Ch, S) = 0;
  if not Result then
    ErrorTrap(VALIDATENO, Ch, S);
  if not Result then
    Exit;
  SetLength(S, $010101); {Sets Lower 3 Bytes of Length Integer to 1}
  Fillchar(S[1], length(S), 0);
  Ch := #1;
  Result := CharPosRevFunction(Ch, S) = 0;
  if not Result then
    ErrorTrap(VALIDATENO, Ch, S);
  if not Result then
    Exit;
  SetLength(S, $0101); {Sets Lower 2 Bytes of Length Integer to 1}
  Fillchar(S[1], length(S), 0);
  Ch := #1;
  Result := CharPosRevFunction(Ch, S) = 0;
  if not Result then
    ErrorTrap(VALIDATENO, Ch, S);
  if not Result then
    Exit;

  for I := 1 to 100 do
    begin
      SetLength(S, I);
      Fillchar(S[1], length(S), 0);
      Ch := #1;
      J := CharPosRevFunction(Ch, S);
      if J <> 0 then
       begin
        //The call to Errortrap increments the refcount field by one and therefore the bug that led us here migth not be recreated
        ErrorTrap(VALIDATENO, Ch, S);
        Result := False;
       end;
    end;
end;

//Validates that Refcount and Length of S is not modified

function TMainForm.Validate16 : Boolean;
var
 I, Iref, J, RefCountS, RefCountSold, K : Integer;
 S, Sold : String;
 SearchChar : Char;
const
 VALIDATE16MAX : Integer = 1700;
 VALIDATENO : Cardinal = 16;

begin
 StatusBar1.SimpleText := 'Running Validate16';
 Update;
 Result := True;
 S := '';
 for J := 1 to VALIDATE16MAX do
  begin
   for K := 1 to 255 do
    begin
     SearchChar := Char(K);
     Iref := 0;
     Sold := S;
     try
      I := CharPosRevFunction(SearchChar, S);
      if I <> Iref then
       begin
        ErrorTrap(VALIDATENO, SearchChar, S);
        Result := False;
        Exit;
       end;
      if Length(S) <> Length(Sold) then
       begin
        ErrorTrap(VALIDATENO, SearchChar, S);
        Result := False;
        Exit;
       end;
      RefCountS := GetRefCount(S);
      RefCountSold := GetRefCount(Sold);
      if RefCountS <> RefCountSold then
       begin
        ErrorTrap(VALIDATENO, SearchChar, S);
        Result := False;
        Exit;
       end;
     except
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
     end;
    end;
   S := S + #0;
  end;
end;

//Validates that Refcount and Length of S is not modified

function TMainForm.Validate17 : Boolean;
var
 I, Iref, J, RefCountS, RefCountSold, K : Integer;
 S, Sold : String;
 SearchChar : Char;
const
 VALIDATE17MAX : Integer = 20000;
 VALIDATENO : Cardinal = 17;

begin
 StatusBar1.SimpleText := 'Running Validate17';
 Update;
 Result := True;
 S := '';
 for J := 1 to VALIDATE17MAX do
  begin
   for K := 65 to 66 do
    begin
     SearchChar := Char(K);
     Iref := 0;
     Sold := S;
     try
      I := CharPosRevFunction(SearchChar, S);
      if I <> Iref then
       begin
        ErrorTrap(VALIDATENO, SearchChar, S);
        Result := False;
        Exit;
       end;
      if Length(S) <> Length(Sold) then
       begin
        ErrorTrap(VALIDATENO, SearchChar, S);
        Result := False;
        Exit;
       end;
      RefCountS := GetRefCount(S);
      RefCountSold := GetRefCount(Sold);
      if RefCountS <> RefCountSold then
       begin
        ErrorTrap(VALIDATENO, SearchChar, S);
        Result := False;
        Exit;
       end;
     except
      ErrorTrap(VALIDATENO, SearchChar, S);
      Result := False;
     end;
    end;
   S := S + #255;
  end;
end;

//Validates really long strings
//Validates that Refcount and Length of S is not modified

function TMainForm.Validate18 : Boolean;
var
 I, Iref, RefCountS, RefCountSold, K : Integer;
 S, Sold : String;
 SearchChar : Char;
const
 VALIDATE18STRINGLENGTHMAX : Integer = 123456789;
 VALIDATENO : Cardinal = 18;

begin
 StatusBar1.SimpleText := 'Running Validate18';
 Update;
 Result := True;
 S := #1;
 repeat
  for K := 100 to 105 do
   begin
    SearchChar := Char(K);
    Iref := 0;
    Sold := S;
    try
     I := CharPosRevFunction(SearchChar, S);
     if I <> Iref then
      begin
       ErrorTrap(VALIDATENO, SearchChar, S);
       Result := False;
       Exit;
      end;
     if Length(S) <> Length(Sold) then
      begin
       ErrorTrap(VALIDATENO, SearchChar, S);
       Result := False;
       Exit;
      end;
     RefCountS := GetRefCount(S);
     RefCountSold := GetRefCount(Sold);
     if RefCountS <> RefCountSold then
      begin
       ErrorTrap(VALIDATENO, SearchChar, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, SearchChar, S);
     Result := False;
    end;
   end;
  S := S + S; //Doubling the length each iteration
 until(Length(S) >= VALIDATE18STRINGLENGTHMAX);
end;

function TMainForm.Validate19 : Boolean;
const
  PAGE_SIZE : Cardinal = 4096;
var
  I, J : Cardinal;
  MemBlock, Page1: Pointer;
  Page2: Pointer;
  C,Dummy: Cardinal;
begin
  GetMem(MemBlock, PAGE_SIZE * 3);
  try
    Result := False;
    Page1  := Pointer((Cardinal(MemBlock) or (PAGE_SIZE-1))+1);
    Page2  := Pointer(Cardinal(Page1) + PAGE_SIZE);
    for J := 1 to 255 do
      begin
        PInteger(Cardinal(Page2))^ := 1; //RefCount
        PInteger(Cardinal(Page2)+4)^ := J; //Len
        for I := 0 to J do
          PChar(Cardinal(Page2) + 8 + I)^ := #0;
        try
          Win32Check(VirtualProtect(Page1, PAGE_SIZE, PAGE_NOACCESS, Dummy));
          try
            Result := True;
            C := Cardinal(Page2) + 8;
            CharPosRevFunction(#0, String(C));
            CharPosRevFunction(#1, String(C));
            CharPosRevFunction(#2, String(C));
            CharPosRevFunction(#3, String(C));
            CharPosRevFunction(#4, String(C));
            CharPosRevFunction(#5, String(C));
            CharPosRevFunction(#6, String(C));
            CharPosRevFunction(#7, String(C));
            CharPosRevFunction(#8, String(C));
          except
            Result := False;
            Exit;
          end;
        finally
          Win32Check(VirtualProtect(Page1, PAGE_SIZE, PAGE_EXECUTE_READWRITE, Dummy));
        end;
      end;
  finally
    FreeMem(MemBlock);
  end;
end;

function TMainForm.Validate20 : Boolean;
const
  PAGE_SIZE : Cardinal = 4096;
var
  I, J : Cardinal;
  MemBlock, Page1: Pointer;
  Page2: Pointer;
  C,Dummy: Cardinal;
begin
  GetMem(MemBlock, PAGE_SIZE * 3);
  try
    Result := False;
    Page1  := Pointer((Cardinal(MemBlock) or (PAGE_SIZE-1))+1);
    Page2  := Pointer(Cardinal(Page1) + PAGE_SIZE);
    for J := 1 to 255 do
      begin
        PInteger(Cardinal(Page2)-J-9)^ := 1; //RefCount
        PInteger(Cardinal(Page2)-J-5)^ := J; //Len
        for I := 0 to J do
          PChar(Cardinal(Page2)-I-1)^ := #0;
        try
          Win32Check(VirtualProtect(Page2, PAGE_SIZE, PAGE_NOACCESS, Dummy));
          try
            Result := True;
            C := Cardinal(Page2)-J-1;
            CharPosRevFunction(#1, String(C));
          except
            Result := False;
            Exit;
          end;
        finally
          Win32Check(VirtualProtect(Page2, PAGE_SIZE, PAGE_EXECUTE_READWRITE, Dummy));
        end;
      end;
  finally
    FreeMem(MemBlock);
  end;
end;

function TMainForm.Validate21 : Boolean;
var
 I, J, Iref, K  : Integer;
 S, S1, S2 : String;
 SearchChar : Char;
const
 VALIDATE21STRINGLENGTHMAX : Integer = 277;
 VALIDATENO : Cardinal = 21;

begin
 StatusBar1.SimpleText := 'Running Validate21';
 Update;
 Result := True;
 S1 := '';
 SetLength(S2,16);
 SearchChar := 'B';
 repeat
  for K := 0 to High(Word) do
   begin
    for J := 0 to 15 do
     begin
      if (K shr J) and 1 = 0 then
       S2[J+1] := 'A'
      else
       S2[J+1] := 'B'
     end;
    S := S2 + S1;
    Iref := CharPosRevRef(SearchChar, S);
    try
     I := CharPosRevFunction(SearchChar, S);
     if I <> Iref then
      begin
       ErrorTrap(VALIDATENO, SearchChar, S);
       Result := False;
       Exit;
      end;
    except
     ErrorTrap(VALIDATENO, SearchChar, S);
     Result := False;
    end;
   end;
  S1 := S1 + 'A';
 until (Length(S) > VALIDATE21STRINGLENGTHMAX);
end;

//Used in benchmark

procedure TMainForm.FillSubBenchmark1StringArrays;
var
 J : Integer;

begin
 //Allocate "enough" space
 SetLength(SearchCharArray,200);
 SetLength(StringArray,200);
 //Subbenchmark 1 strings
 J := 0;
 SearchCharArray[J]  := 'x';
 StringArray[J]  := '';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'x';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'xx';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'xX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'Xx';
 Inc(J);
 SearchCharArray[J]  := 'X';
 StringArray[J]  := 'X';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'X';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'xa';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'xAX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'xab';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'Axb';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'xabc';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := 'xabc';
 Inc(J);
 SearchCharArray[J]  := 'w';
 StringArray[J]  := 'xabc';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := '12xBC';
 Inc(J);
 SearchCharArray[J]  := 'w';
 StringArray[J]  := '12xaC';
 Inc(J);
 SearchCharArray[J]  := '2';
 StringArray[J]  := '12xaBC';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'xabcd';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdx098';
 Inc(J);
 SearchCharArray[J]  := 'w';
 StringArray[J]  := 'abcdx098';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdx+098';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'aBcDxaBcD';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := '123xabcde';
 Inc(J);
 SearchCharArray[J]  := 'X';
 StringArray[J]  := 'XAbcde';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := 'aX';
 Inc(J);
 SearchCharArray[J]  := 'b';
 StringArray[J]  := 'abX';
 Inc(J);
 SearchCharArray[J]  := 'c';
 StringArray[J]  := 'abcXwrt';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdXxaqwer';
 Inc(J);
 SearchCharArray[J]  := 'B';
 StringArray[J]  := 'aBCdXew';
 Inc(J);
 SearchCharArray[J]  := 'c';
 StringArray[J]  := 'abcdeX';
 Inc(J);
 SearchCharArray[J]  := 'd';
 StringArray[J]  := 'abcdefX';
 Inc(J);
 SearchCharArray[J]  := 'b';
 StringArray[J]  := 'abcdefgX';
 Inc(J);
 SearchCharArray[J]  := 'b';
 StringArray[J]  := 'abcdefghX';
 Inc(J);
 SearchCharArray[J]  := 'c';
 StringArray[J]  := 'abcdefghiX';
 Inc(J);
 SearchCharArray[J]  := 'd';
 StringArray[J]  := 'abcdefghijX';
 Inc(J);
 SearchCharArray[J]  := 'e';
 StringArray[J]  := 'abcdefghijkX';
 Inc(J);
 SearchCharArray[J]  := 'f';
 StringArray[J]  := 'abcdefghijkXPOIYTFVRE';
 Inc(J);
 SearchCharArray[J]  := 'g';
 StringArray[J]  := 'cdefghijkXPOIYTFVRE';
 Inc(J);
 SearchCharArray[J]  := '1';
 StringArray[J]  := 'abcdefghijklX';
 Inc(J);
 SearchCharArray[J]  := '2';
 StringArray[J]  := 'abcdefghijklmX';
 Inc(J);
 SearchCharArray[J]  := 'f';
 StringArray[J]  := 'abcdefghijklmnX';
 Inc(J);
 SearchCharArray[J]  := '7';
 StringArray[J]  := 'abcdefghijklmnoX';
 Inc(J);
 SearchCharArray[J]  := 'D';
 StringArray[J]  := 'ABCDEFGHIJKLMNOPX';
 Inc(J);
 SearchCharArray[J]  := 'g';
 StringArray[J]  := 'abcdefghijklmnopX';
 Inc(J);
 SearchCharArray[J]  := 'E';
 StringArray[J]  := 'ABCDEFGHIJKLMNOPX';
 Inc(J);
 SearchCharArray[J]  := 'k';
 StringArray[J]  := 'abcdefghijklmnopqX';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := 'abcdefghijklmnopqrX';
 Inc(J);
 SearchCharArray[J]  := 'D';
 StringArray[J]  := 'abcDEFghijklmnopqrX------';
 Inc(J);
 SearchCharArray[J]  := 'd';
 StringArray[J]  := 'abcdefghijklmnopqrsX';
 Inc(J);
 SearchCharArray[J]  := 'j';
 StringArray[J]  := 'abcdefghijklmnopqRSX--';
 Inc(J);
 SearchCharArray[J]  := 'd';
 StringArray[J]  := 'abcdefghijklmnopqrstX';
 Inc(J);
 SearchCharArray[J]  := 'q';
 StringArray[J]  := 'abcdefghijklmnopqrstuX';
 Inc(J);
 SearchCharArray[J]  := 'b';
 StringArray[J]  := 'abcdefgHIJklmnopqrstuX-';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := 'abcdefghijklmnopqrstuvX';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := '1234567890abcdefgwqrtyuior';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := '1234567890abcdefgwqrtyuiorx';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := '1234567890abcdefgwqrtyuiorxd';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := '1234567890abcdefgwqrtyuiorrxd';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := '1234567890abcdefgwqrtyuiorrxdsw';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := '1234567890abcdefgwqrtyuiorrxdssw';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := 'abcdefghijklmnopqrstuvwX';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := 'abcdefghijklmnopqrstuvwyX';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := 'abcdefghijklmnopqrstuvyzX';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := 'abcdeSDXvgt';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := 'abcdeSDXvgt';
 Inc(J);
 SearchCharArray[J]  := 'b';
 StringArray[J]  := 'abcdeS1234DXvgt345';
 Inc(J);
 SearchCharArray[J]  := '3';
 StringArray[J]  := '!"#abcdeS1234DXvgt345';
 Inc(J);
 SearchCharArray[J]  := 'd';
 StringArray[J]  := 'abcdefGHIJklmNOPX';
 Inc(J);
 SearchCharArray[J]  := 'a';
 StringArray[J]  := '!"#abcdeS1234DXvgt345';
 Inc(J);
 SearchCharArray[J]  := 'G';
 StringArray[J]  := '!"#abcdGtYhRRd54#545GFeS1234DXvgt345';
 Inc(J);
 SearchCharArray[J]  := 'A';
 StringArray[J]  := '!"#abcdGtYhRRd54#545GFeS1234DXvgt345';
 Inc(J);
 SearchCharArray[J]  := '&';
 StringArray[J]  := '!"#abcdGtYhRRd54#545GFeS1234DXvgt345';
 Inc(J);
 SearchCharArray[J]  := '&';
 StringArray[J]  := '!"#abcdGtYhRRd&&&&54#545GFeS1234DXvgt345';
 Inc(J);
 SearchCharArray[J]  := '&';
 StringArray[J]  := '!"#abcdGtYhRRd&&y&54#545GFeS15';
 Inc(J);
 SearchCharArray[J]  := '&';
 StringArray[J]  := '12345!"#abcdGtYhRRd&&y&54#545GFeS15';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'aX&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abxㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ�';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcx//////////////////////////////';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdx"""""""""""""""""""""""""""""4';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdex((((((((((((((((((((((((((((((';
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'ax&&&&&&&&&&&&&&&&&&&&&&&&&&&&&dddd&&';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijxㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ�';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdedftx/////////////////ddddd////////';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcde!"#�%&//)()=?x"""""""""""""""""""""';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'ABDCFERTYUUIOOPP휺bcdefx(((((((((((((((((';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'ABDCFERTYUUIOOPP휺bcdefx';
 Inc(J);
 SearchCharArray[J]  := 'A';
 StringArray[J]  := 'ABDCFERTYUUIOOPP휺bcdefX';
 Inc(J);
 SearchCharArray[J]  := 'B';
 StringArray[J]  := 'ABDCFERTYUUIOOPP휺bcdefX';
 //Adjust array sizes
 SetLength(SearchCharArray,J+1);
 SetLength(StringArray,J+1);
end;

procedure TMainForm.FillSubBenchmark2StringArrays;
var
 CharNo : Cardinal;
 Str : AnsiString;
 StrLen, StrNo, MatchIndex, I : Integer;
 FillChar : Char;

begin
 SetLength(SubBench2StrArray, NOOFSTRINGSSUBBENCH2);
 //Always match at SEARCHCHARSUBBENCH2 = F
 for StrNo := 0 to NOOFSTRINGSSUBBENCH2-1 do
  begin
   StrLen := Random(MAXSTRLENSUBBENCH2);
   SetLength(Str, StrLen);
   if StrLen > 0 then
    begin
     for CharNo := 1 to StrLen do
      begin
       FillChar := Char(Random(254)+1);
       if FillChar <> SEARCHCHARSUBBENCH2 then
        Str[CharNo] := FillChar
       else
        Str[CharNo] := 'X';
      end;
     I := Random(MaxInt);
     if I mod MATCHRATIO <> 0 then//Do not always insert MatchChar
      begin
       MatchIndex := Random(StrLen-1)+1;
       Str[MatchIndex] := SEARCHCHARSUBBENCH2;
      end;
     SubBench2StrArray[StrNo] := Str;
    end;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
 IniPath : AnsiString;

begin
 IniPath := ExtractFilePath(Application.ExeName);
 WriteIniFile(IniPath + INIFILENAME);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 CpuString : string;
 IniPath : AnsiString;


begin
 ClearAllEditBoxes;
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 120;
 ReportRichEdit.Paragraph.Tab[1] := 155;
 ReportRichEdit.Paragraph.Tab[2] := 200;
 ReportRichEdit.Paragraph.Tab[3] := 245;
 FillSubBenchmark1StringArrays;
 FillSubBenchmark2StringArrays;
 FillTestSetArray;
 if not QueryPerformanceFrequency(Frequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 SortFunctionArray;
 FillFunctionSelectionRadioGroup;
 IniPath := ExtractFilePath(Application.ExeName);
 ReadIniFile(IniPath + INIFILENAME);
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
 FunctionPointer : TCharPosRevFunction;
begin
 FunctionPointer := FunctionArray[FunctionSelectionRadioGroup.ItemIndex].FunctionPointer;
 CharPosRevFunction := FunctionPointer;
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

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1 : Integer;

begin
 BenchmarkAllButton.Caption := 'Running';
 Update;
 for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I1 := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkCharPosRev;
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
           Validate21;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Integer;
 FunctionName, CharPosRewFunctionAddressString : AnsiString;
 CharPosRewFunctionAddress : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_IDLE) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_IDLE failed');
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   CharPosRewFunctionAddress := Integer(@CharPosRevFunction);
   CharPosRewFunctionAddressString := IntToHex(CharPosRewFunctionAddress, 8);
   try
    if Validate then
     ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosRewFunctionAddressString[8] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosRewFunctionAddressString[8] + #9 + 'Failed');
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosRewFunctionAddressString[8] + #9 + 'Failed');
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
 ReportRichEdit.Print('CharPosRew Benchmark Results');
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

procedure TMainForm.RemoveSlowestFunctionVersionsButtonClick(Sender: TObject);
var
 LineNo1, LineNo2, FunctionNumber1, FunctionNumber2, LineCount : Integer;
 Line1, Line2 : AnsiString;

begin
 LineNo1 := 0;
 LineCount := ReportRichEdit.Lines.Count;
 while LineNo1 <= LineCount-1 do
  begin
   Line1 := ReportRichEdit.Lines[LineNo1];
   FunctionNumber1 := GetFunctionNumber(Line1);
   LineNo2 := LineNo1+1;
   while (LineNo2 <= ReportRichEdit.Lines.Count-1) do
    begin
     Line2 := ReportRichEdit.Lines[LineNo2];
     FunctionNumber2 := GetFunctionNumber(Line2);
     if FunctionNumber2 = FunctionNumber1 then
      begin
       ReportRichEdit.Lines.Delete(LineNo2);
       LineCount := ReportRichEdit.Lines.Count;
       Dec(LineNo2);
      end;
     Inc(LineNo2);
    end;
   Inc(LineNo1);
  end;
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
   FunctionAddress := Cardinal(@CharPosRevFunction);
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
 MainForm.FunctionSelectionRadioGroup.ItemIndex := IniFile.ReadInteger('Settings', 'SelectedFunction', 0);
 IniFile.Free;
end;

procedure TMainForm.WriteIniFile(FileName : AnsiString);
var
 IniFile : TIniFile;

begin
 IniFile := TIniFile.Create(FileName);
 IniFile.WriteInteger('Settings', 'SelectedFunction', MainForm.FunctionSelectionRadioGroup.ItemIndex);
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
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    ValidateAllButton.Click;
    Halt;
  end;
end;


end.
