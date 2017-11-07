unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'CharPosIEx';

type

 TCharPosIExFunction = function (C : Char; const S: string; Offset: Integer = 1) : Integer;

 TFunctionEntry = record
  FunctionName : AnsiString;
  FunctionPointer : TCharPosIExFunction;
 end;

 TTestSet = record
  SearchChar : Char;
  S : AnsiString;
  Offset, CorrectResult : Integer;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CleanButtonClick(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure RegisterFunction(FunctionName : AnsiString; FunctionPointer : TCharPosIExFunction);
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
   TestSetArray : array of TTestSet;
   procedure ReadIniFile(FileName : AnsiString);
   procedure WriteIniFile(FileName : AnsiString);
   procedure FillFunctionSelectionRadioGroup;
   function SubBenchmark1 : Double;
   function SubBenchmark2 : Double;
   procedure FillSubBenchmark1StringArrays;
   procedure FillSubBenchmark2StringArrays;
   procedure BenchmarkCharPosIEx;
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
 FastcodeCPUID, SystemInfoUnit, IniFiles, StrUtils, Math, CharPosIExDKCUnit, AboutUnit, CharPosIExRefUnit;

var
 //Used in validation and benchmark
 SearchCharArray : array of Char;
 StringArray : array of String;
 CharPosIExFunction : TCharPosIExFunction;
 FunctionArray : array of TFunctionEntry;
 SubBench2StrArray : array of string;

const
 NOOFRERUNS : Cardinal = 10;
 MAXNOOFRUNSSUB1 : Cardinal = 100000;
 MAXNOOFRUNSSUB2 : Cardinal =  90000;
 RUNTIMESCALE : Cardinal = 100;
 //Adjusted such that the two subbenches carries the same weigth on a blend of the 6 2006 CPU targets
 SUBBENCH1SCALE : Double = 1000;
 SUBBENCH2SCALE : Double = 980;
 INIFILENAME : AnsiString = 'CharPosIExBV.Ini';
 MAXSTRLENSUBBENCH2 : Integer = 177;
 SEARCHCHARSUBBENCH2 : Char = 'F';

function IsUpperCase(C : char) : Boolean;
begin
 if ('A' <= C) and (C <= 'Z') then
  Result := True
 else
  Result := false;
end;

function CharLowerCase(C : Char) : Char;
begin
 if ('A' <= C) and (C <= 'Z') then
  Result := Char(Ord(C) + 32)
 else
  Result := C;
end;

function CharUpperCase(C : Char) : Char;
begin
 if ('a' <= C) and (C <= 'z') then
  Result := Char(Ord(C) - 32)
 else
  Result := C;
end;

function InvertCase(C : Char) : Char; overload;
begin
 if IsUpperCase(C) then
  Result := CharLowerCase(C)
 else
  Result := CharUpperCase(C);
end;

function InvertCase(S : AnsiString) : AnsiString; overload;
var
 I: Integer;

begin
 Result := '';
 for I := 1 to Length(S) do
  begin
   Result := Result + InvertCase(S[I])
  end;
end;

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

procedure TMainForm.RegisterFunction(FunctionName : AnsiString; FunctionPointer : TCharPosIExFunction);
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
 repeat
  Swapped := False;
  for I1 := 0 to Length(FunctionArray)-2 do
   begin
    FunctionType1 := GetFunctionType(FunctionArray[I1].FunctionName);
    FunctionType2 := GetFunctionType(FunctionArray[I1+1].FunctionName);
    //Clumsy programming just to get started
    if (FunctionType2 = 'Pas') and (FunctionType1 = 'IA32') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'Pas') and (FunctionType1 = 'MMX') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'Pas') and (FunctionType1 = 'SSE') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'Pas') and (FunctionType1 = 'SSE2') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'Pas') and (FunctionType1 = 'SSE3') then
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

//TODO 1 -DKC: Add more validation testsets

procedure TMainForm.FillTestSetArray;
var
 Size : Integer;

begin
 Size := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'A';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'Z';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'a';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'a';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'A';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'Z';
 TestSetArray[Size-1].S := 'z';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := '@';
 TestSetArray[Size-1].S := '@';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'B';
 TestSetArray[Size-1].S := 'A';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'B';
 TestSetArray[Size-1].S := 'z';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'B';
 TestSetArray[Size-1].S := 'Bz';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'B';
 TestSetArray[Size-1].S := 'bB%';
 TestSetArray[Size-1].Offset := 3;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'Xaaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aXaaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaXaaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaXaaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaXaaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 5;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaXaaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 6;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaXaaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 7;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaaXaaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 8;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaaaXaaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 9;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaaaaXaaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 10;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaaaaaXaaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 11;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaaaaaaXaaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 12;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaaaaaaaXaaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 13;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaaaaaaaaXaa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 14;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaaaaaaaaaXa';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 15;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'X';
 TestSetArray[Size-1].S := 'aaaaaaaaaaaaaaaX';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 16;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := 0;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := -1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := MaxInt;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := Low(Integer);
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'a';
 TestSetArray[Size-1].Offset := 0;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'a';
 TestSetArray[Size-1].Offset := -1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'a';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'A';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'A';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'ba';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'bA';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BA';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'ba';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'bA';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BA';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'BA';
 TestSetArray[Size-1].Offset := 3;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'AA';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'AA';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'AAAAAAAAAA';
 TestSetArray[Size-1].Offset := 3;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'A';
 TestSetArray[Size-1].S := 'AAAAAAAAAA';
 TestSetArray[Size-1].Offset := 4;
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SearchChar := 'a';
 TestSetArray[Size-1].S := 'AAAAAAAAAAAAAAAAAAAAAAAAA';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
end;

procedure TMainForm.FillFunctionSelectionRadioGroup;
var
 I : Integer;

begin
 for I := 1 to Length(FunctionArray) do
  FunctionSelectionRadioGroup.Items.Add(FunctionArray[I-1].FunctionName);
 FunctionSelectionRadioGroup.ItemIndex := 0;
end;

procedure ErrorTrap(ValidateNo : Integer; C : Char; S : AnsiString; Offset : Integer);
begin
 CharPosIExFunction(C, S, Offset);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' SearchChar: ' + C + ' String: ' + S + ' Offset: ' + IntToStr(Offset)), 'Error');
end;

procedure TMainForm.BenchmarkCharPosIEx;
var
 Bench, SubBench1, SubBench2 : Double;
 FunctionName, CharPosIExFunctionAddressString : AnsiString;
 CharPosIExFunctionAddress : Cardinal;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  CharPosIExFunctionAddress := Integer(@CharPosIExFunction);
  CharPosIExFunctionAddressString := IntToHex(CharPosIExFunctionAddress, 8);
  Update;
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  Bench := SubBench1 + SubBench2;
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                           CharPosIExFunctionAddressString[8] + #9 +
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
 J, I1, I2, I3, I5, K : Cardinal;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;

begin
 I1 := 0;
 I2 := 0;
 I3 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB1 do
    begin
     //Use testset
     for K := 0 to Length(SearchCharArray) - 1 do
      begin
       I1 := CharPosIExFunction(SearchCharArray[K], StringArray[K], 1);
       I2 := CharPosIExFunction(SearchCharArray[K], StringArray[K], 2);
       I3 := CharPosIExFunction(SearchCharArray[K], StringArray[K], 3);
      end;
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
 ResultEdit.Text := IntToStr(I2);
 ResultEdit.Text := IntToStr(I3);
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
 I, J, I1, I2, I3, I4, I5 : Cardinal;
 RunNo : Cardinal;
 RunTimeSec : Double;
 Str : AnsiString;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 T, OffSet : Integer;

begin
 I1 := 0;
 I2 := 0;
 I3 := 0;
 I4 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB2 do
    begin
     Str := SEARCHCHARSUBBENCH2;
     I := 0;
     for T := 1 to MAXSTRLENSUBBENCH2 div 4 do
      begin
       //Same Offset used in 4 calls with different stringlengths.
       //Take second shortest strlength as max Offset and sometimes offset > strlength
       //Offset can also be zero
       //Most of the time 1 <= offset <= strlength
       //If Offset > pos(SearchChar) then CharPosIEx will terminate on not found
       OffSet := Random(Length(SubBench2StrArray[I+1]));
       I1 := CharPosIExFunction(SEARCHCHARSUBBENCH2, SubBench2StrArray[I], OffSet);
       Inc(I);
       I2 := CharPosIExFunction(SEARCHCHARSUBBENCH2, SubBench2StrArray[I], OffSet);
       Inc(I);
       I3 := CharPosIExFunction(SEARCHCHARSUBBENCH2, SubBench2StrArray[I], OffSet);
       Inc(I);
       I4 := CharPosIExFunction(SEARCHCHARSUBBENCH2, SubBench2StrArray[I], OffSet);
       Inc(I);
      end;
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
 ResultEdit.Text := IntToStr(I2);
 ResultEdit.Text := IntToStr(I3);
 ResultEdit.Text := IntToStr(I4);
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
 BenchmarkCharPosIEx;
 if ReportRichEdit.Lines.Count > 1 then
  SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
 BenchmarkButton.Caption := 'Benchmark';
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName, CharPosIExFunctionAddressString : AnsiString;
 CharPosIExFunctionAddress : Cardinal;

begin
 try
  ValidateButton.Caption := 'Running';
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  CharPosIExFunctionAddress := Integer(@CharPosIExFunction);
  CharPosIExFunctionAddressString := IntToHex(CharPosIExFunctionAddress, 8);
  if Validate then
   ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosIExFunctionAddressString[8] + #9 + 'Passed')
  else
   ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosIExFunctionAddressString[8] + #9 + 'Failed');
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosIExFunctionAddressString[8] + #9 + 'Failed');
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
    I := CharPosIExFunction(TestSetArray[TestNo].SearchChar,
                            TestSetArray[TestNo].S,
                            TestSetArray[TestNo].Offset);
    if I <> TestSetArray[TestNo].CorrectResult then
     begin
      ErrorTrap(VALIDATENO, TestSetArray[TestNo].SearchChar,
                            TestSetArray[TestNo].S,
                            TestSetArray[TestNo].Offset);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, TestSetArray[TestNo].SearchChar,
                          TestSetArray[TestNo].S,
                          TestSetArray[TestNo].Offset);
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
    I := CharPosIExFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S, 1);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S, 1);
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
 VALIDATE2MAX : Integer = 64;//Do not make bigger and generate 'a'
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
   Iref := J;//Always find SearchChar at the end of S, because we do not generate chars which has UpperCase/LowerCase
   try
    I := CharPosIExFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S, 1);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S, 1);
    Result := False;
   end;
  end;
end;

function TMainForm.Validate4 : Boolean;
var
 I, Iref, J : Integer;
 S : String;
 SearchChar : Char;
const
 VALIDATE2MAX : Integer = 674;
 VALIDATENO : Cardinal = 4;

begin
 StatusBar1.SimpleText := 'Running Validate4';
 Update;
 Result := True;
 S := 'X';
 for J := 1 to VALIDATE2MAX do
  begin
   SearchChar := 'X';
   S := 'C' + S;
   Iref := J+1;
   try
    I := CharPosIExFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S, 1);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S, 1);
    Result := False;
   end;
  end;
end;

function TMainForm.Validate5 : Boolean;
var
 I, Iref, J : Integer;
 S : String;
 SearchChar : Char;
const
 VALIDATE2MAX : Integer = 674;
 VALIDATENO : Cardinal = 5;

begin
 StatusBar1.SimpleText := 'Running Validate5';
 Update;
 Result := True;
 S := 'x';
 SearchChar := 'X';
 for J := 1 to VALIDATE2MAX do
  begin
   S := 'C' + S + 'b';
   Iref := J+1;
   try
    I := CharPosIExFunction(SearchChar, S);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, SearchChar, S, 1);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SearchChar, S, 1);
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
 Result := CharPosIExFunction('0', GlobalStr) = 0;
 if not Result then
  begin
   ErrorTrap(VALIDATENO, '0', GlobalStr, 1);
   Exit;
  end;
 { TODO 1 -oDKC -cQuestion : Is this test redundant }
 Result := CharPosIExFunction('0', GlobalStr) = 0;
 if not Result then
  ErrorTrap(VALIDATENO, '0', GlobalStr, 1);
end;

{$HINTS OFF}

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

{$HINTS ON}

function TMainForm.Validate8 : Boolean;
var
 I, Iref, J, OffSet : Integer;
 Str : String;
 SearchChar : Char;
const
 STRLENMAX : Integer = 3974;
 VALIDATENO : Cardinal = 8;
 MINOFFSET : Integer = -23;
 MAXOFFSET : Integer = 33;

begin
 StatusBar1.SimpleText := 'Running Validate8';
 Update;
 Result := True;
 Str := '';
 SearchChar := 'X';
 for J := 1 to STRLENMAX do
  begin
   for OffSet := MINOFFSET to MAXOFFSET do
    begin
     try
      I := CharPosIExFunction(SearchChar, Str, OffSet);
      if OffSet <= 0 then
       Iref := 0
      else if OffSet > Length(Str) then
       Iref := 0
      else
       Iref := OffSet;
      if I <> Iref then
       begin
        ErrorTrap(VALIDATENO, SearchChar, Str, OffSet);
        Result := False;
        Exit;
       end;
     except
      ErrorTrap(VALIDATENO, SearchChar, Str, OffSet);
      Result := False;
     end;
    end;
   Str := Str + 'x';
  end;
end;

function TMainForm.Validate9 : Boolean;
var
 I, Iref, J, OffSet : Integer;
 Str : String;
 SearchChar : Char;
const
 STRLENMAX : Integer = 33000;
 VALIDATENO : Cardinal = 9;
 MINOFFSET : Integer = 0;
 MAXOFFSET : Integer = 2;

begin
 StatusBar1.SimpleText := 'Running Validate9';
 Update;
 Result := True;
 Str := '';
 SearchChar := #0;
 Iref := 0;
 for J := 1 to STRLENMAX do
  begin
   for OffSet := MINOFFSET to MAXOFFSET do
    begin
     try
      I := CharPosIExFunction(SearchChar, Str, OffSet);
      if I <> Iref then
       begin
        ErrorTrap(VALIDATENO, SearchChar, Str, OffSet);
        Result := False;
        Exit;
       end;
     except
      ErrorTrap(VALIDATENO, SearchChar, Str, OffSet);
      Result := False;
     end;
    end;
   Str := Str + Char(Random(255)+1); //Never generate a #0
  end;
end;

function TMainForm.Validate10 : Boolean;
var
 I, Iref, J, OffSet : Integer;
 Str : String;
 SearchChar : Char;
const
 STRLENMAX : Integer = 1000;
 VALIDATENO : Cardinal = 10;
 MINOFFSET : Integer = 0;

begin
 StatusBar1.SimpleText := 'Running Validate10';
 Update;
 Result := True;
 Str := '';
 SearchChar := #0;
 for J := 1 to STRLENMAX do
  begin
   Str := Str + Char(Random(256));
   for OffSet := MINOFFSET to Length(Str)+1 do
    begin
     try
      Iref := CharPosIEx_Ref(SearchChar, Str, OffSet);
      I := CharPosIExFunction(SearchChar, Str, OffSet);
      if I <> Iref then
       begin
        ErrorTrap(VALIDATENO, SearchChar, Str, OffSet);
        Result := False;
        Exit;
       end;
     except
      ErrorTrap(VALIDATENO, SearchChar, Str, OffSet);
      Result := False;
     end;
    end;
  end;
end;

function TMainForm.Validate11 : Boolean;
var
 I, Iref, J, OffSet, Index, K : Integer;
 Str : String;
 SearchChar, NewChar : Char;
 SearchByte : Byte;
const
 STRLENMAX : Integer = 10;
 VALIDATENO : Cardinal = 11;
 MINOFFSET : Integer = 0;

begin
 StatusBar1.SimpleText := 'Running Validate11';
 Update;
 Result := True;
 for SearchByte := 0 to 255 do
  begin
   SearchChar := Char(SearchByte);
   Str := '';
   for J := 1 to STRLENMAX do
    begin
     Str := Str + 'w';
     for K := 1 to 10 do
      begin
       Index := Random(Length(Str)-1)+1;
       NewChar := Char(Random(256));
       Str[Index] := NewChar;
       for OffSet := MINOFFSET to Length(Str)+1 do
        begin
         try
          Iref := CharPosIEx_Ref(SearchChar, Str, OffSet);
          I := CharPosIExFunction(SearchChar, Str, OffSet);
          if I <> Iref then
           begin
            ErrorTrap(VALIDATENO, SearchChar, Str, OffSet);
            Result := False;
            Exit;
           end;
         except
          ErrorTrap(VALIDATENO, SearchChar, Str, OffSet);
          Result := False;
         end;
        end;
      end;
    end;
  end;
end;

//Made by John O'Harrow

function TMainForm.Validate12 : Boolean;
const
  PAGE_SIZE : Cardinal = 4096;
  S_LEN : Cardinal = 10;
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
    for J := 0 to 15 do
      begin
        for I := 0 to S_LEN-1 do
          PChar(Cardinal(Page2) - S_LEN - 1 - J + Cardinal(I))^ := Char((I+Ord('0')) and $FF);
        PChar(Cardinal(Page2) - 1-J)^ := #0;
        PInteger(Cardinal(Page2) - S_LEN - 4 - J)^ := S_LEN; {Length}
        PInteger(Cardinal(Page2) - S_LEN - 8 - J)^ := 1; {RefCount}
        try {Lock Second Page}
          Win32Check(VirtualProtect(Page2, PAGE_SIZE, PAGE_NOACCESS, Dummy));
          try
            Result := True;
            C := Cardinal(Page2) - S_LEN - J;
            CharPosIExFunction('X', String(C), 1);
          except
            Result := False;
            Exit;
          end;
        finally {Unlock Second Page}
          Win32Check(VirtualProtect(Page2, PAGE_SIZE, PAGE_EXECUTE_READWRITE, Dummy));
        end;
      end;
  finally
    FreeMem(MemBlock);
  end;
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
 StringArray[J]  := 'ax';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'AX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abx';
 Inc(J);
 SearchCharArray[J]  := 'X';
 StringArray[J]  := 'Abx';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcx';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'aBCx';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdx';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdx+098';
 Inc(J);
 SearchCharArray[J]  := 'X';
 StringArray[J]  := 'aBcDx';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdex';
 Inc(J);
 SearchCharArray[J]  := 'X';
 StringArray[J]  := 'AbcdeX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'aX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'aBCdXew';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdeX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefgX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghiX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijkX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijkXPOIYTFVRE';
 Inc(J);
 SearchCharArray[J]  := 'I';
 StringArray[J]  := 'cdefghijkXPOIYTFVRE';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnoX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'ABCDEFGHIJKLMNOPX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'ABCDEFGHIJKLMNOPX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqrX';
 Inc(J);
 SearchCharArray[J]  := 'X';
 StringArray[J]  := 'abcDEFghijklmnopqrX------';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqrsX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqRSX--';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqrstX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqrstuX';
 Inc(J);
 SearchCharArray[J]  := 'X';
 StringArray[J]  := 'abcdefgHIJklmnopqrstuX-';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqrstuvX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqrstuvwX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqrstuvwyX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijklmnopqrstuvyzX';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdeSDXvgt';
 Inc(J);
 SearchCharArray[J]  := 't';
 StringArray[J]  := 'abcdeSDXvgt';
 Inc(J);
 SearchCharArray[J]  := 't';
 StringArray[J]  := 'abcdeS1234DXvgt345';
 Inc(J);
 SearchCharArray[J]  := '3';
 StringArray[J]  := '!"#abcdeS1234DXvgt345';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefGHIJklmNOPX';
 Inc(J);
 SearchCharArray[J]  := 'G';
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
 StringArray[J]  := 'abXㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ�';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcX//////////////////////////////';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdX"""""""""""""""""""""""""""""';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdeX((((((((((((((((((((((((((((((((';
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'aX&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdefghijXㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ�';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcdedftX//////////////////////////////';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'abcde!"#�%&//)()=?X"""""""""""""""""""""""""""""';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'ABDCFERTYUUIOOPP휺bcdefX((((((((((((((((((((((((((((((((';
 Inc(J);
 SearchCharArray[J]  := 'x';
 StringArray[J]  := 'ABDCFERTYUUIOOPP휺bcdefX';
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
 I : Cardinal;
 Str : AnsiString;
 LowerFillChar, UpperFillChar, FillChr : Char;
 T : Integer;

begin
 Str := SEARCHCHARSUBBENCH2;
 I := 0;
 for T := 1 to MAXSTRLENSUBBENCH2 div 4 do
  begin
   FillChr := Chr(Random(255));
   //Make most chars a letter
   if Odd(T) then
    begin
     if FillChr < 'A' then
      FillChr := Char(Ord(FillChr) + Ord('A'))
     else if FillChr > 'z' then
      FillChr := Char(Ord(FillChr) - Ord('z'));
    end;
   if FillChr = SEARCHCHARSUBBENCH2 then
    FillChr := 'X';
   UpperFillChar := CharUpperCase(FillChr);
   LowerFillChar := CharLowerCase(FillChr);
   Str := UpperFillChar + Str;
   SetLength(SubBench2StrArray, I+1);
   SubBench2StrArray[I] := Str;
   Inc(I);
   Str := Str + LowerFillChar;
   SetLength(SubBench2StrArray, I+1);
   SubBench2StrArray[I] := Str;
   Inc(I);
   Str := LowerFillChar + Str;
   SetLength(SubBench2StrArray, I+1);
   SubBench2StrArray[I] := Str;
   Inc(I);
   Str := Str + UpperFillChar;
   SetLength(SubBench2StrArray, I+1);
   SubBench2StrArray[I] := Str;
   Inc(I);
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WriteIniFile(INIFILENAME);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
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
 FunctionPointer : TCharPosIExFunction;
begin
 FunctionPointer := FunctionArray[FunctionSelectionRadioGroup.ItemIndex].FunctionPointer;
 CharPosIExFunction := FunctionPointer;
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
   BenchmarkCharPosIEx;
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
           Validate12;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Integer;
 FunctionName, CharPosIExFunctionAddressString : AnsiString;
 CharPosIExFunctionAddress : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   CharPosIExFunctionAddress := Integer(@CharPosIExFunction);
   CharPosIExFunctionAddressString := IntToHex(CharPosIExFunctionAddress, 8);
   try
    if Validate then
     ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosIExFunctionAddressString[8] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosIExFunctionAddressString[8] + #9 + 'Failed');
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionName + #9 + CharPosIExFunctionAddressString[8] + #9 + 'Failed');
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
 ReportRichEdit.Print('CharPosIEx Benchmark Results');
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
   FunctionAddress := Cardinal(@CharPosIExFunction);
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
