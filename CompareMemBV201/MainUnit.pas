unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'CompareMem';


type
  TMainForm = class(TForm)
    ValidateButton: TButton;
    ValidationEdit: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    ReportRichEdit: TRichEdit;
    BenchmarkButton: TButton;
    RuntimeEdit: TEdit;
    FunctionSelectionRadioGroup: TRadioGroup;
    BenchmarkAllButton: TButton;
    Label2: TLabel;
    SpreadBench1Edit: TEdit;
    SpreadBench2Edit: TEdit;
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
    SpreadTestButton: TButton;
    CleanResultsButton: TButton;
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    ShowErrorDialogCheckBox: TCheckBox;
    AlignCheckButton: TButton;
    AlignCheckEdit: TEdit;
    SpeedButton1: TSpeedButton;
    procedure AlignCheckButtonClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure SaveReportSpeedButtonClick(Sender: TObject);
    procedure PrintReportSpeedButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure MaxSpreadBenchPercentageEditClick(Sender: TObject);
    procedure CleanResultsButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    NoOfTicksArray : array of Int64;
    lpFrequency : Int64;
    FResultList: TStringList;
    procedure ClearAllEditBoxes;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    function SubBenchmark1 : Cardinal;
    function SubBenchmark2 : Cardinal;
    function SubBenchmark3 : Cardinal;
  public
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
    { Public declarations }
  end;

var
 MainForm: TMainForm;

implementation

uses
 Math, SystemInfoUnit, FastCodeCPUID, CompareMemDKCUnit, CompareMemSHAUnit, CompareMemJOHUnit,
  CompareMemPLRUnit, AboutUnit;

{$R *.dfm}

const
 NOOFRERUNS : Cardinal = 2;
 SUB1NOOFRUNS : Cardinal = 20000000;
 SUB2NOOFRUNS : Cardinal = 50;
 SUB3NOOFRUNS : Cardinal = 3;
 SUBBENCH1SCALE : Double = 89;
 SUBBENCH2SCALE : Double = 137;
 SUBBENCH3SCALE : Double = 155;
 MAXMEMLENGTH : Integer = 4*1024*1024+15;//Add room for alignment ofset
 SPLITMEMSIZE1 : Integer = 200;
 SPLITMEMSIZE2 : Integer = 2000;
 SUBBENCH1MEMLENGTHSTEPSIZE : Double = 1.1;
 SUBBENCH2MEMLENGTHSTEPSIZE : Double = 1.1;
 SUBBENCH3MEMLENGTHSTEPSIZE : Double = 1.2;
 FILLBYTE : Byte = 0;

type
 TCompareMemFunction = function (P1, P2: Pointer; Length: Integer): Boolean;

var
 CompareMemFunction : TCompareMemFunction;
 Mem1, Mem2 : array of Byte;

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

procedure ErrorTrap(ValidateNo : Integer; P1, P2 : Pointer; Len : Integer);
begin
 CompareMemFunction(P1, P2, Len);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' Length: ' + IntToStr(Len)), 'Error');
end;

function Validate1 : Boolean;
var
 P1, P2 : Pointer;
 MemLength : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 VALIDATENO : Cardinal = 1;

begin
 MemLength := 2;
 SetLength(Mem1, MemLength);
 SetLength(Mem2, MemLength);
 FillChar(Mem1[0], MemLength, 'X');
 FillChar(Mem2[0], MemLength, 'X');
 P1 := Mem1;
 P2 := Mem2;
 CompareResult := CompareMemFunction(P1, P2, MemLength);
 if CompareResult = True then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, P1, P2, MemLength);
   Result := False;
  end;
end;

function Validate2 : Boolean;
var
 P1, P2 : Pointer;
 MemLength, MemLengthX : Integer;
 CompareResult, CompareResultRef : Boolean;
 Mem1, Mem2 : array of Byte;
const
 VALIDATENO : Cardinal = 2;

begin
 MemLength := 6;
 SetLength(Mem1, MemLength);
 SetLength(Mem2, MemLength);
 FillChar(Mem1[0], MemLength, 'X');
 FillChar(Mem2[0], MemLength, 'X');
 P1 := Mem1;
 P2 := Mem2;
 //Zero Length
 MemLengthX := 0;
 CompareResultRef := CompareMem(P1, P2, MemLengthX);
 CompareResult := CompareMemFunction(P1, P2, MemLengthX);
 if CompareResult = CompareResultRef then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, P1, P2, MemLength);
   Result := False;
  end;
end;

function Validate3 : Boolean;
var
 P1, P2 : Pointer;
 MemLength : Integer;
 CompareResult, CompareResultRef : Boolean;
 Mem1 : array of Byte;
const
 VALIDATENO : Cardinal = 3;

begin
 MemLength := 6;
 SetLength(Mem1, MemLength);
 //P1 := P2
 P1 := Mem1;
 P2 := P1;
 CompareResultRef := CompareMem(P1, P2, MemLength);
 CompareResult := CompareMemFunction(P1, P2, MemLength);
 if CompareResult = CompareResultRef then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, P1, P2, MemLength);
   Result := False;
  end;
end;

function Validate4 : Boolean;
var
 P1, P2 : Pointer;
 MemLength, MemLengthX : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 VALIDATENO : Cardinal = 4;

begin
 MemLength := 10;
 SetLength(Mem1, MemLength);
 SetLength(Mem2, MemLength);
 FillChar(Mem1[0], MemLength, 'X');
 FillChar(Mem2[0], MemLength, 'X');
 P1 := Mem1;
 P2 := Mem2;
 //Negative Length
 MemLengthX := -10;
 CompareResult := CompareMemFunction(P1, P2, MemLengthX);
 if CompareResult = True then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, P1, P2, MemLength);
   Result := False;
  end;
end;

function Validate5 : Boolean;
var
 P1, P2 : Pointer;
 MemLength, MemLengthX : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 VALIDATENO : Cardinal = 5;

begin
 MemLength := 10;
 SetLength(Mem1, MemLength);
 SetLength(Mem2, MemLength);
 FillChar(Mem1[0], MemLength, 'X');
 FillChar(Mem2[0], MemLength, 'A');
 P1 := Mem1;
 P2 := Mem2;
 //Negative Length
 MemLengthX := -10;
 CompareResult := CompareMemFunction(P1, P2, MemLengthX);
 if CompareResult = True then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, P1, P2, MemLength);
   Result := False;
  end;
end;

function Validate6 : Boolean;
var
 P1, P2 : Pointer;
 MemLength : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 VALIDATENO : Cardinal = 6;

begin
 MemLength := 10;
 SetLength(Mem1, MemLength);
 SetLength(Mem2, MemLength);
 FillChar(Mem1[0], MemLength, 'X');
 //Identical
 Move(Mem1[0], Mem2[0], MemLength);
 P1 := Mem1;
 P2 := Mem2;
 CompareResult := CompareMemFunction(P1, P2, MemLength);
 if CompareResult = True then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, P1, P2, MemLength);
   Result := False;
  end;
end;

function Validate7 : Boolean;
var
 P1, P2 : Pointer;
 MemLength : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 MAXMEMLENGTH : Integer = 1000;
 VALIDATENO : Cardinal = 7;
 Char1 : Char = '#';

begin
 Result := True;
 for MemLength := 1 to MAXMEMLENGTH do
  begin
   SetLength(Mem1, MemLength);
   SetLength(Mem2, MemLength);
   FillChar(Mem1[0], MemLength, Char1);
   //Identical
   Move(Mem1[0], Mem2[0], MemLength);
   P1 := Mem1;
   P2 := Mem2;
   CompareResult := CompareMemFunction(P1, P2, MemLength);
   if CompareResult <> True then
    begin
     ErrorTrap(VALIDATENO, P1, P2, MemLength);
     Result := False;
     Break;
    end;
  end;
end;

function Validate8 : Boolean;
var
 P1, P2 : Pointer;
 MemLength : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 MAXMEMLENGTH : Integer = 1000;
 VALIDATENO : Cardinal = 8;
 Char1 : Char = '#';
 Char2 : Char = '(';


begin
 Result := True;
 for MemLength := 1 to MAXMEMLENGTH do
  begin
   SetLength(Mem1, MemLength);
   SetLength(Mem2, MemLength);
   //Different
   FillChar(Mem1[0], MemLength, Char1);
   FillChar(Mem2[0], MemLength, Char2);
   P1 := Mem1;
   P2 := Mem2;
   CompareResult := CompareMemFunction(P1, P2, MemLength);
   if CompareResult <> False then
    begin
     ErrorTrap(VALIDATENO, P1, P2, MemLength);
     Result := False;
     Break;
    end;
  end;
end;

function Validate9 : Boolean;
var
 P1, P2 : Pointer;
 MemLength : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 MAXMEMLENGTH : Integer = 100000;
 VALIDATENO : Cardinal = 9;
 Char1 : Char = '1';
 Char2 : Char = 'h';

begin
 Result := True;
 for MemLength := MAXMEMLENGTH downto 1 do
  begin
   SetLength(Mem1, MemLength);
   SetLength(Mem2, MemLength);
   FillChar(Mem1[0], MemLength, Char1);
   Move(Mem1[0], Mem2[0], MemLength);
   Mem2[MemLength-1] := Ord(Char2);
   P1 := Mem1;
   P2 := Mem2;
   CompareResult := CompareMemFunction(P1, P2, MemLength);
   if CompareResult <> False then
    begin
     ErrorTrap(VALIDATENO, P1, P2, MemLength);
     Result := False;
     Break;
    end;
  end;
end;

function Validate10 : Boolean;
var
 P1, P2 : Pointer;
 MemLength, I : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 MAXMEMLENGTH : Integer = 3000;
 VALIDATENO : Cardinal = 10;
 Char1 : Char = 'a';
 Char2 : Char = 's';

begin
 Result := True;
 for MemLength := MAXMEMLENGTH downto 2 do
  begin
   SetLength(Mem1, MemLength);
   SetLength(Mem2, MemLength);
   FillChar(Mem1[0], MemLength, Char1);
   Move(Mem1[0], Mem2[0], MemLength);
   for I := 1 to MemLength do
    begin
     Mem2[MemLength-I] := Ord(Char2);
     P1 := Mem1;
     P2 := Mem2;
     CompareResult := CompareMemFunction(P1, P2, MemLength);
     if CompareResult <> False then
      begin
       ErrorTrap(VALIDATENO, P1, P2, MemLength);
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function Validate11 : Boolean;
var
 P1, P2 : Pointer;
 MemLength, I : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 MAXMEMLENGTH : Integer = 300;
 VALIDATENO : Cardinal = 11;
 Char1 : Char = 'A';
 Char2 : Char = 'Q';

begin
 Result := True;
 for MemLength := MAXMEMLENGTH downto 2 do
  begin
   SetLength(Mem1, MemLength);
   SetLength(Mem2, MemLength);
   FillChar(Mem1[0], MemLength, Char1);
   Move(Mem1[0], Mem2[0], MemLength);
   for I := 1 to MemLength do
    begin
     Mem2[MemLength-I] := Ord(Char2);
     P1 := Mem1;
     P2 := Mem2;
     CompareResult := CompareMemFunction(P1, P2, MemLength);
     if CompareResult <> False then
      begin
       ErrorTrap(VALIDATENO, P1, P2, MemLength);
       Result := False;
       Exit;
      end;
     Mem2[MemLength-I] := Ord(Char1);
    end;
  end;
end;

function Validate12 : Boolean;
var
 P1, P2 : Pointer;
 MemLength, I1, I2 : Integer;
 CompareResult : Boolean;
 Mem1, Mem2 : array of Byte;
const
 MAXMEMLENGTH : Integer = 100;
 VALIDATENO : Cardinal = 12;
 Char1 : Char = 'A';
 Char2 : Char = 'Q';

begin
 Result := True;
 for MemLength := MAXMEMLENGTH downto 2 do
  begin
   SetLength(Mem1, MemLength);
   SetLength(Mem2, MemLength);
   FillChar(Mem1[0], MemLength, Char1);
   Move(Mem1[0], Mem2[0], MemLength);
   for I1 := 0 to MemLength do
    for I2 := 0 to MemLength-I1-1 do
     begin
      FillChar(Mem1[I1], MemLength-I2-I1, Char2);
      P1 := Mem1;
      P2 := Mem2;
      CompareResult := CompareMemFunction(P1, P2, MemLength);
      if CompareResult <> False then
       begin
        ErrorTrap(VALIDATENO, P1, P2, MemLength);
        Result := False;
        Exit;
       end;
      Move(Mem2[0], Mem1[0], MemLength);
     end;
  end;
end;

function Validate13 : Boolean;
var
 P1, P2 : Pointer;
 MemLength, I1, I2, I3 : Integer;
 CompareResult, CompareResultRef : Boolean;
 Mem1, Mem2 : array of Byte;
const
 MAXMEMLENGTH : Integer = 113;
 VALIDATENO : Cardinal = 13;
 Char1 : Char = 'A';
 Char2 : Char = 'Q';

begin
 Result := True;
 for MemLength := MAXMEMLENGTH downto 2 do
  begin
   SetLength(Mem1, MemLength);
   SetLength(Mem2, MemLength);
   FillChar(Mem1[0], MemLength, Char1);
   Move(Mem1[0], Mem2[0], MemLength);
   for I1 := 0 to MemLength do
    for I2 := 0 to MemLength-I1-1 do
     begin
      for I3 := 0 to MemLength-1 do
       begin
        FillChar(Mem1[I1], MemLength-I2-I1, Char2);
        P1 := @Mem1[I3];
        P2 := @Mem2[I3];
        CompareResultRef := CompareMem(P1, P2, MemLength-I3);
        CompareResult := CompareMemFunction(P1, P2, MemLength-I3);
        if CompareResult <> CompareResultRef then
         begin
          ErrorTrap(VALIDATENO, P1, P2, MemLength);
          Result := False;
          Exit;
         end;
        Move(Mem2[0], Mem1[0], MemLength);
       end;
     end;
  end;
end;

function Validate14 : Boolean;
var
 P1, P2 : Pointer;
 MemLength, I1, I2, I3, I4, I5, I6, I7, I8 : Integer;
 CompareResult, CompareResultRef : Boolean;
 Mem1, Mem2 : array of Byte;
const
 MINMEMLENGTH : Integer = 4;
 MAXMEMLENGTH : Integer = 167;
 VALIDATENO : Cardinal = 14;
 PATTERNLEN : Integer = 4;
 Byte1 : Byte = 0;
 Byte2 : Byte = 255;

begin
 Result := True;
 for MemLength := MINMEMLENGTH to MAXMEMLENGTH do
  begin
   SetLength(Mem1, MemLength);
   SetLength(Mem2, MemLength);
   P1 := @Mem1[0];
   P2 := @Mem2[0];
   FillChar(Mem1[0], MemLength, Char(255));
   FillChar(Mem2[0], MemLength, Char(255));
   for I1 := 0 to 2 do
    for I2 := 0 to 2 do
     for I3 := 0 to 2 do
      for I4 := 0 to 2 do
       for I5 := 0 to 2 do
        for I6 := 0 to 10 do
         for I7 := 0 to 10 do
          for I8 := 0 to 10 do
           begin
            Mem1[MemLength-PATTERNLEN + 0] := I1;
            Mem2[MemLength-PATTERNLEN + 0] := I2;
            Mem1[MemLength-PATTERNLEN + 1] := I3;
            Mem2[MemLength-PATTERNLEN + 1] := I4;
            Mem1[MemLength-PATTERNLEN + 2] := I5;
            Mem2[MemLength-PATTERNLEN + 2] := I6;
            Mem1[MemLength-PATTERNLEN + 3] := I7;
            Mem2[MemLength-PATTERNLEN + 3] := I8;
            CompareResultRef := CompareMem(P1, P2, MemLength);
            CompareResult := CompareMemFunction(P1, P2, MemLength);
            if CompareResult <> CompareResultRef then
             begin
              ErrorTrap(VALIDATENO, P1, P2, MemLength);
              Result := False;
              Exit;
             end;
           end;
  end;
end;

function Validate15 : Boolean;
var
 P1, P2 : Pointer;
 FillByte : byte;
 MemLength, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16 : Integer;
 CompareResult, CompareResultRef : Boolean;
 Mem1, Mem2 : array of Byte;
const
 MINMEMLENGTH : Integer = 8;
 MAXMEMLENGTH : Integer = 267;
 VALIDATENO : Cardinal = 15;
 PATTERNLEN : Integer = 8;
 Byte1 : Byte = 0;
 Byte2 : Byte = 255;

begin
 Result := True;
 for MemLength := MINMEMLENGTH to MAXMEMLENGTH do
  begin
   SetLength(Mem1, MemLength);
   SetLength(Mem2, MemLength);
   P1 := @Mem1[0];
   P2 := @Mem2[0];
   FillByte := Random(255);
   FillChar(Mem1[0], MemLength, FillByte);
   FillChar(Mem2[0], MemLength, FillByte);
   for I1 := 0 to 1 do
    for I2 := 0 to 1 do
     for I3 := 0 to 1 do
      for I4 := 0 to 1 do
       for I5 := 0 to 1 do
        for I6 := 0 to 1 do
         for I7 := 0 to 1 do
          for I8 := 0 to 1 do
           for I9 := 0 to 1 do
            for I10 := 0 to 1 do
             for I11 := 0 to 1 do
              for I12 := 0 to 1 do
               for I13 := 0 to 1 do
                for I14 := 0 to 1 do
                 for I15 := 0 to 1 do
                  for I16 := 0 to 1 do
                   begin
                    Mem1[MemLength-PATTERNLEN + 0] := I1;
                    Mem2[MemLength-PATTERNLEN + 0] := I2;
                    Mem1[MemLength-PATTERNLEN + 1] := I3;
                    Mem2[MemLength-PATTERNLEN + 1] := I4;
                    Mem1[MemLength-PATTERNLEN + 2] := I5;
                    Mem2[MemLength-PATTERNLEN + 2] := I6;
                    Mem1[MemLength-PATTERNLEN + 3] := I7;
                    Mem2[MemLength-PATTERNLEN + 3] := I8;
                    Mem1[MemLength-PATTERNLEN + 4] := I9;
                    Mem2[MemLength-PATTERNLEN + 4] := I10;
                    Mem1[MemLength-PATTERNLEN + 5] := I11;
                    Mem2[MemLength-PATTERNLEN + 5] := I12;
                    Mem1[MemLength-PATTERNLEN + 6] := I13;
                    Mem2[MemLength-PATTERNLEN + 6] := I14;
                    Mem1[MemLength-PATTERNLEN + 7] := I15;
                    Mem2[MemLength-PATTERNLEN + 7] := I16;
                    CompareResultRef := CompareMem(P1, P2, MemLength);
                    CompareResult := CompareMemFunction(P1, P2, MemLength);
                    if CompareResult <> CompareResultRef then
                     begin
                      ErrorTrap(VALIDATENO, P1, P2, MemLength);
                      Result := False;
                      Exit;
                     end;
                   end;
  end;
end;

function Validate16 : Boolean;
const
  ValidateNo : cardinal = 16;

const
  delta= 31;

function InternalValidate(q1, q2: pchar; len: integer): boolean;
var
  ofs1, ofs2, maxlen, i: integer;
  adr1, adr2: pchar;
label
  BreakInternalValidation;
begin;
  Result:=false;
  adr1:=nil;
  adr2:=nil;
  try
    maxlen:=len+delta;
    while len<=maxlen do begin;        //Test all sizes in [len..len+delta]
      for ofs1:=0 to delta do begin;   //Test all addresses in [q1..q1+delta]
        if odd(integer(q1))
        then adr1:=q1+1-ofs1-len       //Right aligned buffer
        else adr1:=q1+ofs1;            //Left aligned buffer
        i:=len;
        while i>0 do begin;            //Fill buffer q1
          dec(i); adr1[i]:=chr(i);
          end;
        for ofs2:=0 to delta do begin; //Test all addresses in [q2..q2+delta]
          if odd(integer(q2))
          then adr2:=q2+1-ofs2-len     //Right aligned buffer
          else adr2:=q2+ofs2;          //Left aligned buffer
          i:=len;
          while i>0 do begin;          //Fill buffer q2
            dec(i); adr2[i]:=chr(i);
            end;
          Result:=CompareMemFunction(adr1, adr2, len);
          if not Result then goto BreakInternalValidation;
          end;
        end;
      inc(len);
      end;
BreakInternalValidation:
    except
      Result:=false;
    end;
  if not Result then ErrorTrap(ValidateNo, adr1, adr2, len);
  end;

const
  page= 4*1024;

function InternalTrigger(var p: pchar; var flags: dword): pchar;
var
  oldflags: dword;
  firstcall: boolean;
begin;
  firstcall:=(flags and PAGE_NOACCESS)<>0;

  if firstcall then GetMem(p,4*page);

  //Protect/unprotect the 1st page
  Result:=pchar(integer(p) and -page) + 1*page;
  VirtualProtect(Result,1,flags,@oldflags);

  //Protect/unprotect the 3th page
  Result:=pchar(integer(p) and -page) + 3*page;
  VirtualProtect(Result,1,flags,@flags);

  //Return address of 2nd (unprotected) page
  Result:=pchar(integer(p) and -page) + 2*page;

  if not firstcall then FreeMem(p);
  end;

const
  lengths: array[0..3] of integer = (0, 32, 64, 256);
var
  p1, p2, q1, q2: pchar;
  f1, f2: dword;
  i, len: integer;

begin;
  //Get two unprotected pages with protected borders
  f1:=PAGE_NOACCESS; q1:=InternalTrigger(p1, f1);
  f2:=PAGE_NOACCESS; q2:=InternalTrigger(p2, f2);

  //Test various lengths, offsets and alignments
  Result:=true;
  for i:=Low(lengths) to High(lengths) do begin;
    len:=lengths[i];
    if not InternalValidate(q1,        q2,        len)
    or not InternalValidate(q1,        q2+page-1, len)
    or not InternalValidate(q1+page-1, q2,        len)
    or not InternalValidate(q1+page-1, q2+page-1, len)
    then begin;
      Result:=false;
      break;
      end;
    end;

  //Free memory
  InternalTrigger(p1, f1);
  InternalTrigger(p2, f2);
end;

function Validate17 : Boolean;
var
 P1, P2 : Pointer;
 I1, I2, I3, Count, MaxCount : Integer;
 CompareResult, CompareResultRef : Boolean;
 Mem1, Mem2 : array of Byte;
 U : Byte;
const
 MAXMEMLENGTH : Integer = 200;
 VALIDATENO : Cardinal = 17;

begin
 SetLength(Mem1, MAXMEMLENGTH);
 SetLength(Mem2, MAXMEMLENGTH);
 for I1 := 0 to MAXMEMLENGTH-1 do
  begin
   U := Random(255);
   Mem1[I1] := U;
   if U < 124 then
    Mem2[I1] := U
   else
    Mem2[I1] := Random(255);
  end;
 Result := True;
 for I2 := 0 to MAXMEMLENGTH-1 do
  begin
   for I3 := 0 to MAXMEMLENGTH-1 do
    begin
     P1 := @Mem1[I2];
     P2 := @Mem2[I3];
     MaxCount := Min(MAXMEMLENGTH-I2, MAXMEMLENGTH-I3);
     for Count := 1 to MaxCount do
      begin
       CompareResultRef := CompareMem(P1, P2, Count);
       CompareResult := CompareMemFunction(P1, P2, Count);
       if CompareResult <> CompareResultRef then
        begin
         ErrorTrap(VALIDATENO, P1, P2, Count);
         Result := False;
         Exit;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  ValidateButton.Caption := 'Running';
  ValidationEdit.Color := clBlue;
  Update;
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@CompareMemFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
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
     Validate14 and
     Validate15 and
     Validate16 then
   begin
    ValidationEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + FunctionAddressString[8]
                     + #9 + 'Passed');
   end
  else
   begin
    ValidationEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + FunctionAddressString[8]
                     + #9 + 'Failed');
   end;
  ValidateButton.Caption := 'Validate';
 except
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@CompareMemFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName
                    + #9 + FunctionAddressString[8]
                   + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 FunctionAddress, SubBench1, SubBench2, SubBench3, Bench : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@CompareMemFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  BenchmarkButton.Caption := 'Running';
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  SubBench3 := SubBenchmark3;
  Bench := SubBench1 + SubBench2 + SubBench3;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(SubBench2)
                           + #9 + IntToStr(SubBench3)
                           + #9 + IntToStr(Bench));
  SortRichEdit;
  BenchmarkTest;
  AlignmentTest;
  BenchmarkButton.Caption := 'Benchmark';
 except
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@CompareMemFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var
 P1, P2 : Pointer;
 I1, I2, I3 : Cardinal;
 MemLength, Align1, Align2, MismatchIndex, K : Integer;
 Succes, CompRes1, CompRes2 : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec, MemLengthFP : Double;

begin
 CompRes1 := True;
 CompRes2 := True;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   FillChar(Mem1[0], MAXMEMLENGTH, FILLBYTE);
   FillChar(Mem2[0], MAXMEMLENGTH, FILLBYTE);
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   RandSeed := 0;//Same Random sequence everytime
   for I2 := 0 to SUB1NOOFRUNS do
    begin
     Align1 := Random(15);
     Align2 := Random(15);
     MemLength := Random(SPLITMEMSIZE1);
     MismatchIndex := Random(MemLength);
     Mem1[MismatchIndex] := Byte(Random(255));
     Mem2[MismatchIndex] := Byte(Random(255));
     P1 := @Mem1[Align1];
     P2 := @Mem2[Align2];
     CompRes1 := CompareMemFunction(P1, P2, MemLength);
     //Clear mismatch element and repeat benchmark => 50% weigth to mismatch and match terminated compares
     Mem1[MismatchIndex] := 0;
     Mem2[MismatchIndex] := 0;
     P1 := @Mem1[Align1];
     P2 := @Mem2[Align2];
     CompRes2 := CompareMemFunction(P1, P2, MemLength);
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
 Edit1.Text := BoolToStr(CompRes1);//Fool compiler
 Edit1.Text := BoolToStr(CompRes2);//Fool compiler
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I3 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I3] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I3];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmark2 : Cardinal;
var
 P1, P2 : Pointer;
 I1, I2, I3 : Cardinal;
 MemLength, Align1, Align2, MismatchIndex, K : Integer;
 Succes, CompRes1, CompRes2 : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec, MemLengthFP : Double;

begin
 CompRes1 := True;
 CompRes2 := True;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   FillChar(Mem1[0], MAXMEMLENGTH, FILLBYTE);
   FillChar(Mem2[0], MAXMEMLENGTH, FILLBYTE);
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to SUB2NOOFRUNS do
    begin
     MemLengthFP := SPLITMEMSIZE1; //The MemLength is the same for 15*16*15 calls in a row
     while MemLengthFP <= SPLITMEMSIZE2 do
      begin
       MemLength := Round(MemLengthFP);
       for K := 0 to 14 do
        begin
         //Add mismatch at MismatchIndex1 = random location in entire array
         MismatchIndex := Random(MemLength-1);
         Mem1[MismatchIndex] := 1;
         for Align1 := 0 to 15 do
          begin
           for Align2 := 0 to 15 do
            begin
             P1 := @Mem1[Align1];
             P2 := @Mem2[Align2];
             CompRes1 := CompareMemFunction(P1, P2, MemLength);
            end;
          end;
         //Clear mismatch element and repeat benchmark => 50% weigth to mismatch and match terminated compares
         Mem1[MismatchIndex] := 0;
         for Align1 := 0 to 15 do
          begin
           for Align2 := 0 to 15 do
            begin
             P1 := @Mem1[Align1];
             P2 := @Mem2[Align2];
             CompRes2 := CompareMemFunction(P1, P2, MemLength);
            end;
          end;
        end;
       MemLengthFP := MemLengthFP * SUBBENCH2MEMLENGTHSTEPSIZE;
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
 Edit1.Text := BoolToStr(CompRes1);//Fool compiler
 Edit1.Text := BoolToStr(CompRes2);//Fool compiler
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I3 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I3] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I3];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

function TMainForm.SubBenchmark3 : Cardinal;
var
 P1, P2 : Pointer;
 I1, I2, I3 : Cardinal;
 MemLength, Align1, Align2, MismatchIndex, K : Integer;
 Succes, CompRes1, CompRes2 : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec, MemLengthFP : Double;

begin
 CompRes1 := True;
 CompRes2 := True;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   FillChar(Mem1[0], MAXMEMLENGTH, FILLBYTE);
   FillChar(Mem2[0], MAXMEMLENGTH, FILLBYTE);
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   RandSeed := 0;//Same Random sequence every rerun
   for I2 := 0 to SUB3NOOFRUNS do
    begin
     MemLengthFP := SPLITMEMSIZE2;
     while MemLengthFP <= MAXMEMLENGTH do
      begin
       MemLength := Round(MemLengthFP);
       //15 mismatches per MemLength
       for K := 0 to 14 do
        begin
         //Linear distribution of mismatches
         MismatchIndex := Random(MemLength);
         //Add mismatch at MismatchIndex1
         Mem1[MismatchIndex] := 1;
         Align1 := Random(15);
         Align2 := Random(15);
         P1 := @Mem1[Align1];
         P2 := @Mem2[Align2];
         CompRes1 := CompareMemFunction(P1, P2, MemLength);
         //Clear mismatch element and repeat benchmark => 50% weigth to mismatch and match terminated compares
         Mem1[MismatchIndex] := 0;
         Align1 := Random(15);
         Align2 := Random(15);
         P1 := @Mem1[Align1];
         P2 := @Mem2[Align2];
         CompRes1 := CompareMemFunction(P1, P2, MemLength);
        end;
       MemLengthFP := MemLengthFP * SUBBENCH3MEMLENGTHSTEPSIZE;
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
 Edit1.Text := BoolToStr(CompRes1);//Fool compiler
 Edit1.Text := BoolToStr(CompRes2);//Fool compiler
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I3 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I3] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I3];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH3SCALE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 Succes : Boolean;
 CpuString : string;
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 5;
 ReportRichEdit.Paragraph.Tab[0] := 120;
 ReportRichEdit.Paragraph.Tab[1] := 140;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 200;
 ReportRichEdit.Paragraph.Tab[4] := 240;
 FunctionSelectionRadioGroupClick(nil);
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);

 //Arrays used for benchmarking
 SetLength(Mem1, MAXMEMLENGTH);
 SetLength(Mem2, MAXMEMLENGTH);

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
 case FunctionSelectionRadioGroup.ItemIndex+1 of
  1 : CompareMemFunction := CompareMem;
  2 : CompareMemFunction := CompareMem_DKC_Pas_9_a;
  3 : CompareMemFunction := CompareMem_DKC_Pas_9_b;
  4 : CompareMemFunction := CompareMem_DKC_Pas_9_c;
  5 : CompareMemFunction := CompareMem_DKC_Pas_9_d;
  6 : CompareMemFunction := CompareMem_DKC_IA32_6_a;
  7 : CompareMemFunction := CompareMem_DKC_IA32_6_b;
  8 : CompareMemFunction := CompareMem_DKC_IA32_6_c;
  9 : CompareMemFunction := CompareMem_DKC_IA32_6_d;
  10 : CompareMemFunction := CompareMem_DKC_IA32_7_a;
  11 : CompareMemFunction := CompareMem_DKC_IA32_7_b;
  12 : CompareMemFunction := CompareMem_DKC_IA32_7_c;
  13 : CompareMemFunction := CompareMem_DKC_IA32_7_d;
  14 : CompareMemFunction := CompareMem_DKC_MMX_1_a;
  15 : CompareMemFunction := CompareMem_DKC_MMX_1_b;
  16 : CompareMemFunction := CompareMem_DKC_MMX_1_c;
  17 : CompareMemFunction := CompareMem_DKC_MMX_1_d;
  18 : CompareMemFunction := CompareMem_DKC_SSE2_1_a;
  19 : CompareMemFunction := CompareMem_DKC_SSE2_1_b;
  20 : CompareMemFunction := CompareMem_DKC_SSE2_1_c;
  21 : CompareMemFunction := CompareMem_DKC_SSE2_1_d;
  22 : CompareMemFunction := CompareMem_DKC_SSE3_1_a;
  23 : CompareMemFunction := CompareMem_DKC_SSE3_1_b;
  24 : CompareMemFunction := CompareMem_DKC_SSE3_1_c;
  25 : CompareMemFunction := CompareMem_DKC_SSE3_1_d;
  26 : CompareMemFunction := CompareMem_Sha_Pas_4_a;
  27 : CompareMemFunction := CompareMem_Sha_Pas_4_b;
  28 : CompareMemFunction := CompareMem_Sha_Pas_4_c;
  29 : CompareMemFunction := CompareMem_Sha_Pas_4_d;
  30 : CompareMemFunction := CompareMem_Sha_IA32_4_a;
  31 : CompareMemFunction := CompareMem_Sha_IA32_4_b;
  32 : CompareMemFunction := CompareMem_Sha_IA32_4_c;
  33 : CompareMemFunction := CompareMem_Sha_IA32_4_d;
  34 : CompareMemFunction := CompareMem_Sha_IA32_5_a;
  35 : CompareMemFunction := CompareMem_Sha_IA32_5_b;
  36 : CompareMemFunction := CompareMem_Sha_IA32_5_c;
  37 : CompareMemFunction := CompareMem_Sha_IA32_5_d;
  38 : CompareMemFunction := CompareMem_JOH_IA32_1_a;
  39 : CompareMemFunction := CompareMem_JOH_IA32_1_b;
  40 : CompareMemFunction := CompareMem_JOH_IA32_1_c;
  41 : CompareMemFunction := CompareMem_JOH_IA32_1_d;
  42 : CompareMemFunction := CompareMem_PLR_IA32_1a;
  43 : CompareMemFunction := CompareMem_PLR_IA32_1b;
  44 : CompareMemFunction := CompareMem_PLR_IA32_1c;
  45 : CompareMemFunction := CompareMem_PLR_IA32_1d;
  46 : CompareMemFunction := CompareMem_PLR_IA32_2a;
  47 : CompareMemFunction := CompareMem_PLR_IA32_2b;
  48 : CompareMemFunction := CompareMem_PLR_IA32_2c;
  49 : CompareMemFunction := CompareMem_PLR_IA32_2d;
  50 : CompareMemFunction := CompareMem_PLR_IA32_3a;
  51 : CompareMemFunction := CompareMem_PLR_IA32_3b;
  52 : CompareMemFunction := CompareMem_PLR_IA32_3c;
  53 : CompareMemFunction := CompareMem_PLR_IA32_3d;
  54 : CompareMemFunction := CompareMem_DKC_SSE2_2_a;
  55 : CompareMemFunction := CompareMem_DKC_SSE2_2_b;
  56 : CompareMemFunction := CompareMem_DKC_SSE2_2_c;
  57 : CompareMemFunction := CompareMem_DKC_SSE2_2_d;
  58 : CompareMemFunction := CompareMem_DKC_SSE2_3_a;
  59 : CompareMemFunction := CompareMem_DKC_SSE2_3_b;
  60 : CompareMemFunction := CompareMem_DKC_SSE2_3_c;
  61 : CompareMemFunction := CompareMem_DKC_SSE2_3_d;
  62 : CompareMemFunction := CompareMem_DKC_SSE2_4_a;
  63 : CompareMemFunction := CompareMem_DKC_SSE2_4_b;
  64 : CompareMemFunction := CompareMem_DKC_SSE2_4_c;
  65 : CompareMemFunction := CompareMem_DKC_SSE2_4_d;
  66 : CompareMemFunction := CompareMem_DKC_SSE2_5_a;
  67 : CompareMemFunction := CompareMem_DKC_SSE2_5_b;
  68 : CompareMemFunction := CompareMem_DKC_SSE2_5_c;
  69 : CompareMemFunction := CompareMem_DKC_SSE2_5_d;
  70 : CompareMemFunction := CompareMem_DKC_SSE2_6_a;
  71 : CompareMemFunction := CompareMem_DKC_SSE2_6_b;
  72 : CompareMemFunction := CompareMem_DKC_SSE2_6_c;
  73 : CompareMemFunction := CompareMem_DKC_SSE2_6_d;
  74 : CompareMemFunction := CompareMem_DKC_SSE2_7_a;
  75 : CompareMemFunction := CompareMem_DKC_SSE2_7_b;
  76 : CompareMemFunction := CompareMem_DKC_SSE2_7_c;
  77 : CompareMemFunction := CompareMem_DKC_SSE2_7_d;
  78 : CompareMemFunction := CompareMem_DKC_SSE2_8_a;
  79 : CompareMemFunction := CompareMem_DKC_SSE2_8_b;
  80 : CompareMemFunction := CompareMem_DKC_SSE2_8_c;
  81 : CompareMemFunction := CompareMem_DKC_SSE2_8_d;
  82 : CompareMemFunction := CompareMem_DKC_SSE2_9_a;
  83 : CompareMemFunction := CompareMem_DKC_SSE2_9_b;
  84 : CompareMemFunction := CompareMem_DKC_SSE2_9_c;
  85 : CompareMemFunction := CompareMem_DKC_SSE2_9_d;
  86 : CompareMemFunction := CompareMem_DKC_SSE2_10_a;
  87 : CompareMemFunction := CompareMem_DKC_SSE2_10_b;
  88 : CompareMemFunction := CompareMem_DKC_SSE2_10_c;
  89 : CompareMemFunction := CompareMem_DKC_SSE2_10_d;
  90 : CompareMemFunction := CompareMem_DKC_SSE2_11_a;
  91 : CompareMemFunction := CompareMem_DKC_SSE2_11_b;
  92 : CompareMemFunction := CompareMem_DKC_SSE2_11_c;
  93 : CompareMemFunction := CompareMem_DKC_SSE2_11_d;
  94 : CompareMemFunction := CompareMem_DKC_SSE3_2_a;
  95 : CompareMemFunction := CompareMem_DKC_SSE3_2_b;
  96 : CompareMemFunction := CompareMem_DKC_SSE3_2_c;
  97 : CompareMemFunction := CompareMem_DKC_SSE3_2_d;
  98 : CompareMemFunction := CompareMem_DKC_SSE2_12_a;
  99 : CompareMemFunction := CompareMem_DKC_SSE2_12_b;
  100 : CompareMemFunction := CompareMem_DKC_SSE2_12_c;
  101 : CompareMemFunction := CompareMem_DKC_SSE2_12_d;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';
 Update;
 //for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   BenchmarkButtonClick(nil);
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
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 Update;
 //for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
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
 ReportRichEdit.Print('CompareMem Report');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 //for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I1 := 1 to 2 do
  begin
   for I2 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkButtonClick(nil);
     Update;
    end;
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkButtonClick(nil);
   Update;
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
   FunctionAddress := Cardinal(@CompareMemFunction);
   FunctionAddressString := IntToHex(FunctionAddress, 8);
   ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8]);
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

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
 AboutForm.ShowModal;
end;

procedure TMainForm.SpreadTestButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 for I := 1 to 20 do
  begin
   BenchmarkButtonClick(nil);
   Update;
  end;
end;

procedure TMainForm.MaxSpreadBenchPercentageEditClick(Sender: TObject);
begin
 MaxSpreadBenchPercentageEdit.SelectAll;
 MaxSpreadBenchPercentageEdit.CopyToClipboard;
end;

procedure TMainForm.CleanResultsButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 BenchmarkTest;
 AlignmentTest;
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
