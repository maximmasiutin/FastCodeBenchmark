unit MainUnit;

{$IFDEF VER170}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 18.0}
    {$WARN SYMBOL_DEPRECATED OFF}
  {$IFEND}
{$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'UpperCase';

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
    BenchTest1Button: TButton;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpreadTestButton: TButton;
    CleanResultsButton: TButton;
    BenchTest2Button: TButton;
    Label10: TLabel;
    Label11: TLabel;
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
    AlignCheckButton: TButton;
    AlignCheckEdit: TEdit;
    ShowErrorDialogCheckBox: TCheckBox;
    Label12: TLabel;
    AboutSpeedButton: TSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure SaveReportSpeedButtonClick(Sender: TObject);
    procedure PrintReportSpeedButtonClick(Sender: TObject);
    procedure BenchTest1ButtonClick(Sender: TObject);
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure MaxSpreadBenchPercentageEditClick(Sender: TObject);
    procedure CleanResultsButtonClick(Sender: TObject);
    procedure BenchTest2ButtonClick(Sender: TObject);
    procedure AlignCheckButtonClick(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    function SubBenchmark1 : Cardinal;
    function SubBenchmark2 : Cardinal;
  public
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
    { Public declarations }
  end;

var
 MainForm: TMainForm;

implementation

uses
 FastcodeCPUID, SystemInfoUnit, UpperCaseRTLUnit, UpperCaseDKCUnit, UpperCaseJOHUnit, UpperCaseSHAUnit,
  AboutUnit;

{$R *.dfm}

const
 NOOFRUNS : Cardinal = 6000;
 SUB1NOOFRUNS : Cardinal = 30;
 SUB2NOOFRUNS : Cardinal = 1;
 SUBBENCH1SCALE : Double = 113;
 SUBBENCH2SCALE : Double = 154;
 SUBBENCH1ARRAYSIZE : Cardinal = 75;
 SUBBENCH2ARRAYSIZE : Cardinal = 1500;
 MAXSTRINGLENGTH : Integer = 100;
 NOOFRERUNS : Cardinal = 8;

type
 TUpperCaseFunction = function (const S: string): string;

var
 UpperCaseFunction : TUpperCaseFunction;
 SubBench1StringArray : array of string;
 SubBench2StringArray : array of string;
 lpFrequency : Int64;
 NoOfTicksArray : array of Int64;

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
 MaxSpreadBenchPercentageEdit.Color := clInfoBk;
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

procedure ErrorTrap(S : AnsiString; ValidateNo : Cardinal);
begin
 UpperCaseFunction(S);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' String: ' + S), 'Error');
end;

function Validate1 : Boolean;
var
 S1, S2 : string;
const
 VALIDATENO : Cardinal = 1;

begin
 S1 := '';
 S2 := UpperCaseFunction(S1);
 if S2 <> '' then
  begin
   ErrorTrap(S1, VALIDATENO);
   Result := False;
  end
 else
  Result := True;
end;

var
 S1Global, S2Global : string;

function Validate2 : Boolean;
const
 VALIDATENO : Cardinal = 2;

begin
 S1Global := 'z';
 (PInteger(Integer(S1Global)-4))^ := 0;
 S2Global := UpperCaseFunction(S1Global);
 if S2Global = 'Z' then
  begin
   ErrorTrap(S1Global, VALIDATENO);
   Result := False;
  end
 else
  Result := True;
end;

function Validate3 : Boolean;
var
 S1, S2, S3 : string;
 I : Byte;
const
 VALIDATENO : Cardinal = 3;

begin
 try
  Result := True;
  for I := 0 to 255 do
   begin
    S1 := Char(I);
    S2 := UpperCase(S1);
    S3 := UpperCaseFunction(S1);
    if S2 <> S3 then
     begin
      ErrorTrap(S1, VALIDATENO);
      Result := False;
      Break;
     end;
   end;
 except
  ErrorTrap(S1, VALIDATENO);
  Result := False;
 end;
end;

function Validate4 : Boolean;
var
 S1, S2, S3 : string;
 I1, I2 : Byte;
const
 VALIDATENO : Cardinal = 4;

begin
 try
  Result := True;
  for I1 := 0 to 255 do
   begin
    for I2 := 0 to 255 do
     begin
      S1 := Char(I1) + Char(I2);
      S2 := UpperCase(S1);
      S3 := UpperCaseFunction(S1);
      if S2 <> S3 then
       begin
        ErrorTrap(S1, VALIDATENO);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrap(S1, VALIDATENO);
  Result := False;
 end;
end;

function Validate5 : Boolean;
var
 S1, S2, S3 : string;
 I1, I2, I3 : Byte;
const
 VALIDATENO : Cardinal = 5;

begin
 Result := True;
 for I1 := 0 to 100 do
  begin
   for I2 := 80 to 200 do
    begin
     for I3 := 180 to 255 do
      begin
       S1 := Char(I1) + Char(I2)  + Char(I3);
       S2 := UpperCase(S1);
       S3 := UpperCaseFunction(S1);
       if S2 <> S3 then
        begin
         ErrorTrap(S1, VALIDATENO);
         Result := False;
         Exit;
        end;
      end;
    end;
  end;
end;

function Validate6 : Boolean;
var
 S1, S2, S3 : string;
 I1 : Byte;
const
 VALIDATENO : Cardinal = 6;

begin
 try
  Result := True;
  for I1 := 0 to 255 do
   begin
    S1 := S1 + Char(I1);
    S2 := UpperCase(S1);
    S3 := UpperCaseFunction(S1);
    if S2 <> S3 then
     begin
      ErrorTrap(S1, VALIDATENO);
      Result := False;
      Break;
     end;
   end;
 except
  ErrorTrap(S1, VALIDATENO);
  Result := False;
 end;
end;

function Validate7 : Boolean;
var
 S1, S2, S3 : string;
 I1, I2, I3 : Byte;
const
 VALIDATENO : Cardinal = 7;

begin
 Result := True;
 for I1 := 60 to 70 do
  begin
   for I2 := 90 to 98 do
    begin
     for I3 := 245 to 255 do
      begin
       S1 := S1 + Char(I1) + Char(I2)  + Char(I3);
       S2 := UpperCase(S1);
       S3 := UpperCaseFunction(S1);
       if S2 <> S3 then
        begin
         ErrorTrap(S1, VALIDATENO);
         Result := False;
         Exit;
        end;
      end;
    end;
  end;
end;

function Validate8 : Boolean;
const
 MAXLEN = 255;
 VALIDATENO : Cardinal = 8;

var
  I, Len, Size: integer;
  S1, S2: string;
  p1, p2: pchar;

begin
 Result := True;
 for Len := MaxLen downto 1 do
  begin
   Size := (Len + 4) and (-4);
   SetLength(s1, Len);
   p1 := pointer(S1);
   Fillchar(p1^,size,'a');
   p1[len] := #0;
   SetLength(s2, len);
   p2 := pointer(S2);
   Move(p1^,p2^,size);
   S2 := UpperCaseFunction(S1);
   if p2 <> pointer(S2) then
    Exit; // result undefined, suppose true
   for i := Len to Size - 1 do
    begin
     if p2[i] <> p1[i] then
      begin
       ErrorTrap(S1, VALIDATENO);
       Result:=false;
       Exit;
      end;
    end;
  end;
end;

//Should validate all possible alignments of source string
//Does only validate 4 byte aligned strings

function Validate9 : Boolean;
var
 S1, S2, S3, S4 : string;
 I1, I2 : Cardinal;
 PC1 : PChar;
const
 VALIDATENO : Cardinal = 9;

begin
 Randomize;
 Result := True;
 for I1 := 0 to 255 do
  begin
   S1 := S1 + Char(Random(255));
   for I2 := 0 to Length(S1) do
    begin
     PC1 := PChar(S1);
     Inc(PC1,I2);
     S4 := PC1; //Creates a new 4 byte aligned string
     S2 := UpperCase(S4);
     S3 := UpperCaseFunction(S4);
     if S2 <> S3 then
      begin
       ErrorTrap(S1, VALIDATENO);
       Result := False;
       Break;
      end;
    end;
  end;
end;

function Validate10 : Boolean;
var
 S1, S2, S3 : string;
 I1, I2, I3, I4, I5, I6, I7, I8 : Byte;
const
 VALIDATENO : Cardinal = 10;

begin
 Result := True;
 I2 := 0;
 I3 := 0;
 I4 := 0;
 I5 := 0;
 I6 := 0;
 I7 := 0;
 I8 := 0;
 for I1 := 0 to 255 do
  begin
   S1 := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6) + Char(I7) + Char(I8);
   S2 := UpperCase(S1);
   S3 := UpperCaseFunction(S1);
   if S2 <> S3 then
    begin
     ErrorTrap(S1, VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
 I1 := 0;
 I3 := 0;
 I4 := 0;
 I5 := 0;
 I6 := 0;
 I7 := 0;
 I8 := 0;
 for I2 := 0 to 255 do
  begin
   S1 := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6) + Char(I7) + Char(I8);
   S2 := UpperCase(S1);
   S3 := UpperCaseFunction(S1);
   if S2 <> S3 then
    begin
     ErrorTrap(S1, VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
 I1 := 0;
 I2 := 0;
 I4 := 0;
 I5 := 0;
 I6 := 0;
 I7 := 0;
 I8 := 0;
 for I3 := 0 to 255 do
  begin
   S1 := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6) + Char(I7) + Char(I8);
   S2 := UpperCase(S1);
   S3 := UpperCaseFunction(S1);
   if S2 <> S3 then
    begin
     ErrorTrap(S1, VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
 I1 := 0;
 I2 := 0;
 I3 := 0;
 I5 := 0;
 I6 := 0;
 I7 := 0;
 I8 := 0;
 for I4 := 0 to 255 do
  begin
   S1 := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6) + Char(I7) + Char(I8);
   S2 := UpperCase(S1);
   S3 := UpperCaseFunction(S1);
   if S2 <> S3 then
    begin
     ErrorTrap(S1, VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
 I1 := 0;
 I2 := 0;
 I3 := 0;
 I4 := 0;
 I6 := 0;
 I7 := 0;
 I8 := 0;
 for I5 := 0 to 255 do
  begin
   S1 := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6) + Char(I7) + Char(I8);
   S2 := UpperCase(S1);
   S3 := UpperCaseFunction(S1);
   if S2 <> S3 then
    begin
     ErrorTrap(S1, VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
 I1 := 0;
 I2 := 0;
 I3 := 0;
 I4 := 0;
 I5 := 0;
 I7 := 0;
 I8 := 0;
 for I6 := 0 to 255 do
  begin
   S1 := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6) + Char(I7) + Char(I8);
   S2 := UpperCase(S1);
   S3 := UpperCaseFunction(S1);
   if S2 <> S3 then
    begin
     ErrorTrap(S1, VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
 I1 := 0;
 I2 := 0;
 I3 := 0;
 I4 := 0;
 I5 := 0;
 I6 := 0;
 I8 := 0;
 for I7 := 0 to 255 do
  begin
   S1 := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6) + Char(I7) + Char(I8);
   S2 := UpperCase(S1);
   S3 := UpperCaseFunction(S1);
   if S2 <> S3 then
    begin
     ErrorTrap(S1, VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
 I1 := 0;
 I2 := 0;
 I3 := 0;
 I4 := 0;
 I5 := 0;
 I6 := 0;
 I7 := 0;
 for I8 := 0 to 255 do
  begin
   S1 := Char(I1) + Char(I2) + Char(I3) + Char(I4) + Char(I5) + Char(I6) + Char(I7) + Char(I8);
   S2 := UpperCase(S1);
   S3 := UpperCaseFunction(S1);
   if S2 <> S3 then
    begin
     ErrorTrap(S1, VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
end;

function Validate11 : Boolean;
var
 S1, S2 : string;
 Len1, Len2, I : Integer;
const
 VALIDATENO : Cardinal = 11;

begin
 Result := True;
 S1 := '';
 for I := 0 to 156 do
  begin
   S1 := S1 + 'A';
   S2 := UpperCaseFunction(S1);
   Len1 := Length(S2);
   Len2 := StrLen(PChar(S2));
   if Len1 <> Len2 then
    begin
     ErrorTrap(S1, VALIDATENO);
     Result := False;
     Break;
    end;
  end;
end;

//Use with care

{
> > Two notes about that validation.
> >
> > 1) It is bad idea to run benchmark after validation,
> > because ReallocMem changed and functions will run slower.
> > You can fix it changing ReallocMem back (if MMRealloc<>nil)
> > before start of benchmark.
> >
> > 2) If validation returned 'true' then the function is valid,
> > but if validation returned 'false' then the function MAY BE invalid.
> > You must take look at the function and test it.
> > For example, the function may set Result:='' and then call
> > SetLength(Result). The validation returns 'false' on such functions.
>
> Is it possible to fix those two problems by changing the validation
> function?


I have changed the validation.

1) First problem fixed. We change MM back on exit from validation.

2) Second problem is a bit complex, but it is minimized.
In the new validation we count all MM function calls.
When old result length is not siutable for new result
the function under validation normally can do
1 call of ReallocMem(8 points) or group of 2 calls:
FreeMem(5 poins) and GetMem(3 points).
If it is so then function is valid, else it is probably invalid.

regards,
Aleksandr
}

var
  MMOld: TMemoryManager;
  MMOpCount: integer;
  MMChanged: boolean= false;

  Valid13: Boolean;
  SaveChar: Byte;

function Validate13GetMem(Size: Integer): Pointer;
asm
  call MMOld.GetMem
  mov  cl, byte ptr [eax+11]
  mov  [SaveChar], cl
  mov  byte ptr [eax+11], 'a'
end;

function Validate13FreeMem(P: Pointer): Integer;
asm
  mov cl, [SaveChar]
  mov byte ptr [eax+11], cl
  jmp MMOld.FreeMem
end;

function Validate13ReallocMem(P: Pointer; Size: Integer): Pointer;
asm
  cmp byte ptr [eax+11], 'a'
  setz cl
  mov [Valid13], cl
  mov cl, [SaveChar]
  mov byte ptr [eax+11], cl
  call MMOld.ReallocMem
  mov  cl, byte ptr [eax+11]
  mov  [SaveChar], cl
  mov  byte ptr [eax+11], 'a'
end;

var
  Validate13MM: TMemoryManager=
    (GetMem    : Validate13GetMem;
     FreeMem   : Validate13FreeMem;
     ReallocMem: Validate13ReallocMem);

function MyGetMem(Size: Integer): Pointer;
asm
  add MMOpCount, 3
  jmp MMOld.GetMem
end;

function MyFreeMem(P: Pointer): Integer;
asm
  add MMOpCount, 5
  jmp MMOld.FreeMem
end;

function MyReallocMem(P: Pointer; Size: Integer): Pointer;
asm
  add MMOpCount, 8
  jmp MMOld.ReallocMem
end;

var
  MMNew: TMemoryManager=
  (GetMem: MyGetMem; FreeMem: MyFreeMem; ReallocMem: MyReallocMem);

procedure ToggleMM;
begin
  if MMChanged then begin
    MMChanged := false;
    SetMemoryManager(MMOld);
  end
  else begin
    mmChanged := true;
    GetMemoryManager(MMOld);
    SetMemoryManager(MMNew);
  end;
end;

function Validate12: Boolean;
var
  S1, S2 : string;
const
  VALIDATENO : Cardinal = 0;
begin
  try
    Result:=true;
    ToggleMM;

    //Working with RefCt=-1
    S1 := 'abcde';
    S2 := S1;
    if S2 = S1 then S2 := UpperCaseFunction(S1); //AV in invalid function

    //Working with RefCt>1
    UniqueString(S1);
    S2 := S1;
    if S2 = S1 then S2 := UpperCaseFunction(S1);
    Result:=Result and (PInteger(Integer(S1)-8)^=1);

    //Working with RefCt=1
    S1 := 'abcdefg';
    MMOpCount := 0;
    S2 := UpperCaseFunction(S1);
    Result:=Result and (MMOpCount=8);

    //Working with RefCt=1
    S1 := 'abc';
    MMOpCount := 0;
    S2 := UpperCaseFunction(S1);
    Result:=Result and (MMOpCount=8);

    ToggleMM;
  except
    ToggleMM;
    Result := false;
  end;
end;

procedure DoValidate13;
var
  I: integer;

begin
  for I := 1 to 2 do
    if UpperCaseFunction('a') + 'b' = '' then
      Exit;
end;

function Validate13: Boolean;
const
 VALIDATENO : Cardinal = 13;

begin
  GetMemoryManager(MMOld);
  SetMemoryManager(Validate13MM);
  DoValidate13;
  SetMemoryManager(MMOld);
  if not Valid13 then
   ErrorTrap('a', VALIDATENO);
  Result := Valid13;
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
  FunctionAddress := Cardinal(@UpperCaseFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if Validate1 and
     Validate2 and
     Validate3 and
     Validate4 and
     Validate5 and
     Validate6 and
     Validate7 and
     Validate9 and
     Validate10 and
     Validate12 and //See comments
     Validate11 and
     Validate13 then
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
    FunctionAddress := Cardinal(@UpperCaseFunction);
    FunctionAddressString := IntToHex(FunctionAddress, 8);
    ReportRichEdit.Lines.Add(FunctionName
                      + #9 + FunctionAddressString[8]
                     + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 FunctionAddress, SubBench1, SubBench2, Bench : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@UpperCaseFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  BenchmarkButton.Caption := 'Running';
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  Bench := SubBench1 + SubBench2;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(SubBench2)
                           + #9 + IntToStr(Bench));
  SortRichEdit;
  BenchmarkTest;
  AlignmentTest;
  BenchmarkButton.Caption := 'Benchmark';
 except
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@UpperCaseFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var
 S : string;
 I1, I2, I3, I4 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS*SUB1NOOFRUNS do
    for I3 := 0 to SUBBENCH1ARRAYSIZE-1 do
     S := UpperCaseFunction(SubBench1StringArray[I3]);
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

function TMainForm.SubBenchmark2 : Cardinal;
var
 S : string;
 I1, I2, I3, I4 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS*SUB2NOOFRUNS do
    for I3 := 0 to SUBBENCH2ARRAYSIZE-2 do
     S := UpperCaseFunction(SubBench2StringArray[I3]);
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
 I1 :Cardinal;
 CpuString : string;
begin
 UpperCaseFunction := UpperCase;
 ReportRichEdit.Clear;
 ValidationEdit.Text := '';
 RuntimeEdit.Text := '';
 SpreadBench1Edit.Text := '';
 SpreadBench2Edit.Text := '';
 AlignSpreadBench1Edit.Text := '';
 AlignSpreadBench2Edit.Text := '';
 FunctionNameEdit.Text := '';
 MaxSpreadBenchPercentageEdit.Text := '';
 AlignMaxSpreadBenchPercentageEdit.Text := '';
 AlignFunctionName1Edit.Text := '';
 AlignFunctionName2Edit.Text := '';
 ReportRichEdit.Paragraph.TabCount :=5;
 ReportRichEdit.Paragraph.Tab[0] := 120;
 ReportRichEdit.Paragraph.Tab[1] := 140;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 200;
 ReportRichEdit.Paragraph.Tab[4] := 240;
 SetLength(SubBench1StringArray, SUBBENCH1ARRAYSIZE);
 SetLength(SubBench2StringArray, SUBBENCH2ARRAYSIZE);
 SubBench1StringArray[0] := '';
 SubBench1StringArray[1] := 'A';
 SubBench1StringArray[2] := 'aA';
 SubBench1StringArray[3] := 'B';
 SubBench1StringArray[4] := 'bB';
 SubBench1StringArray[5] := 'z';
 SubBench1StringArray[6] := 'Zz';
 SubBench1StringArray[7] := '+';
 SubBench1StringArray[8] := '-8u';
 SubBench1StringArray[9] := 'aa';
 SubBench1StringArray[10] := 'BBsd';
 SubBench1StringArray[11] := 'Cc';
 SubBench1StringArray[12] := 'aAa';
 SubBench1StringArray[13] := 'poiY';
 SubBench1StringArray[14] := 'PO';
 SubBench1StringArray[15] := '123';
 SubBench1StringArray[16] := 'AAAA';
 SubBench1StringArray[17] := 'uuuuu';
 SubBench1StringArray[18] := 'eRe';
 SubBench1StringArray[19] := 'yTRr';
 SubBench1StringArray[20] := '0OI';
 SubBench1StringArray[21] := 'hy657ytF';
 SubBench1StringArray[22] := 'uytr';
 SubBench1StringArray[23] := 'QWrtyB';
 SubBench1StringArray[24] := 'kuWRwyiI';
 SubBench1StringArray[25] := 'o9i8uy65tr43ws';
 SubBench1StringArray[26] := 'AAAAAAAAAAAAAAAAAAAAAAA';
 SubBench1StringArray[27] := 'aQwE26hY7K7kq1W3@£$€{{]]liutWER';
 SubBench1StringArray[28] := 'AQWETYUIIPaqwertyuiqWeRtCz';
 SubBench1StringArray[29] := 'aaaaaaaaaaaaaaaaaaaaDDDDDDDDDDD';
 SubBench1StringArray[30] := 'Dennis';
 SubBench1StringArray[31] := 'Kjaer';
 SubBench1StringArray[32] := 'Christensen';
 SubBench1StringArray[33] := 'Bill';
 SubBench1StringArray[34] := 'Gates';
 SubBench1StringArray[34] := 'Aleksandr';
 SubBench1StringArray[36] := 'Sharahov';
 SubBench1StringArray[37] := 'Eric Grange';
 SubBench1StringArray[38] := 'Pierre Le Riche';
 SubBench1StringArray[39] := 'Robert Houdini';
 SubBench1StringArray[40] := 'Ralf Schumacher';
 SubBench1StringArray[41] := 'John Kaster';
 SubBench1StringArray[42] := 'Allen Bauer';
 SubBench1StringArray[43] := 'Danny Thorpe';
 SubBench1StringArray[44] := 'Mariann Jensen';
 SubBench1StringArray[45] := 'AaAaAaAAaAaAaaAAaaAA';
 SubBench1StringArray[46] := 'AqWaSweDrfTgJ';
 SubBench1StringArray[47] := 'Marina Bornhsen';
 SubBench1StringArray[48] := 'Susanne Andersen';
 SubBench1StringArray[49] := 'Georg Jensen';
 SubBench1StringArray[50] := 'JENS JENSEN';
 SubBench1StringArray[51] := 'hans hansen';
 SubBench1StringArray[52] := 'Microsoft';
 SubBench1StringArray[53] := 'Frank Borland';
 SubBench1StringArray[54] := 'hhhhhhhhhhhhhhhhhhhhh';
 SubBench1StringArray[55] := 'hhhhhhhhhhhhhhhhhhhh';
 SubBench1StringArray[56] := 'hhhhhhhhhhhhhhhhhhh';
 SubBench1StringArray[57] := 'hhhhhhhhhhhhhhhhhh';
 SubBench1StringArray[58] := 'hhhhhhhhhhhhhhhhh';
 SubBench1StringArray[59] := 'hhhhhhhhhhhhhhhh';
 SubBench1StringArray[60] := 'hhhhhhhhhhhhhhh';
 SubBench1StringArray[61] := 'hhhhhhhhhhhhhh';
 SubBench1StringArray[62] := 'hhhhhhhhhhhhh';
 SubBench1StringArray[63] := 'hhhhhhhhhhhh';
 SubBench1StringArray[64] := 'hhhhhhhhhhh';
 SubBench1StringArray[65] := 'hhhhhhhhhh';
 SubBench1StringArray[66] := 'hhhhhhhhh';
 SubBench1StringArray[67] := 'hhhhhhhh';
 SubBench1StringArray[68] := 'hhhhhhh';
 SubBench1StringArray[69] := 'hhhhhh';
 SubBench1StringArray[70] := 'hhhhh';
 SubBench1StringArray[71] := 'hhhh';
 SubBench1StringArray[72] := 'hhh';
 SubBench1StringArray[73] := 'hh';
 SubBench1StringArray[74] := 'h';
 SubBench2StringArray[0] := 'ASFghjhkUYTrVdrtyyhHGF';//This is minimum string lenght for SubBench 2
 for I1 := 1 to SUBBENCH2ARRAYSIZE-1 do
  begin
   SubBench2StringArray[I1] := SubBench2StringArray[I1-1] + Char(I1);
   if Length(SubBench2StringArray[I1]) > MAXSTRINGLENGTH then
    SubBench2StringArray[I1] := SubBench2StringArray[0];
  end;
 FunctionSelectionRadioGroupClick(nil);
 if not QueryPerformanceFrequency(lpFrequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);

 Caption := Format('%s   (%s with %s) (%s : %s)', [Caption, SystemInfoCompiler, SystemInfoCompileFlags, FastCodeTargetStr[FastCodeTarget], SystemInfoCPU]);

 case FastCodeTarget of
  fctIA32,
  fctMMX,
  fctSSE,
  fctSSE2 : CpuString := Format('%s_%s_F%d_M%d', [FastCodeTargetStr[FastCodeTarget], VendorStr[CPU.Vendor], CPU.EffFamily, CPU.EffModel ]);
  else CpuString := FastCodeTargetStr[FastCodeTarget];
 end;

 FValidationFileName := Format('%s_%s_Validation_%s.txt', [CHALLENGE_NAME, SystemInfoVersion, CpuString]);
 FBenchmarkFileName := Format('%s_%s_Benchmark_%s.txt', [CHALLENGE_NAME, SystemInfoVersion, CpuString]);
 FResultsFileName  := Format('%s_%s_Results_%s.txt', [CHALLENGE_NAME, SystemInfoVersion, CpuString]);

 FResultList := TStringList.Create;

 if ParamCount > 0 then
   PostMessage(Handle, WM_POSTPROCESSING, 0, 0)
end;

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionRadioGroup.ItemIndex of
  0 : UpperCaseFunction := UpperCase; //"UpperCase_RTL_IA32_1"
  1 : UpperCaseFunction := UpperCase_RTL_PAS_a;
  2 : UpperCaseFunction := UpperCase_RTL_PAS_b;
  3 : UpperCaseFunction := UpperCase_RTL_PAS_c;
  4 : UpperCaseFunction := UpperCase_RTL_PAS_d;
  5 : UpperCaseFunction := UpperCase_DKC_Pas_32_a;
  6 : UpperCaseFunction := UpperCase_DKC_Pas_32_b;
  7 : UpperCaseFunction := UpperCase_DKC_Pas_32_c;
  8 : UpperCaseFunction := UpperCase_DKC_Pas_32_d;
  9 : UpperCaseFunction := UpperCase_DKC_IA32_18_a;
  10 : UpperCaseFunction := UpperCase_DKC_IA32_18_b;
  11 : UpperCaseFunction := UpperCase_DKC_IA32_18_c;
  12 : UpperCaseFunction := UpperCase_DKC_IA32_18_d;
  13 : UpperCaseFunction := UpperCase_DKC_IA32_21_a;
  14 : UpperCaseFunction := UpperCase_DKC_IA32_21_b;
  15 : UpperCaseFunction := UpperCase_DKC_IA32_21_c;
  16 : UpperCaseFunction := UpperCase_DKC_IA32_21_d;
  17 : UpperCaseFunction := UpperCase_DKC_MMX_54_a;
  18 : UpperCaseFunction := UpperCase_DKC_MMX_54_b;
  19 : UpperCaseFunction := UpperCase_DKC_MMX_54_c;
  20 : UpperCaseFunction := UpperCase_DKC_MMX_54_d;
  21 : UpperCaseFunction := UpperCase_DKC_MMX_56_a;
  22 : UpperCaseFunction := UpperCase_DKC_MMX_56_b;
  23 : UpperCaseFunction := UpperCase_DKC_MMX_56_c;
  24 : UpperCaseFunction := UpperCase_DKC_MMX_56_d;
  25 : UpperCaseFunction := UpperCase_DKC_MMX_59_a;
  26 : UpperCaseFunction := UpperCase_DKC_MMX_59_b;
  27 : UpperCaseFunction := UpperCase_DKC_MMX_59_c;
  28 : UpperCaseFunction := UpperCase_DKC_MMX_59_d;
  29 : UpperCaseFunction := UpperCase_DKC_MMX_62_a;
  30 : UpperCaseFunction := UpperCase_DKC_MMX_62_b;
  31 : UpperCaseFunction := UpperCase_DKC_MMX_62_c;
  32 : UpperCaseFunction := UpperCase_DKC_MMX_62_d;
  33 : UpperCaseFunction := UpperCase_DKC_SSE_3_a;
  34 : UpperCaseFunction := UpperCase_DKC_SSE_3_b;
  35 : UpperCaseFunction := UpperCase_DKC_SSE_3_c;
  36 : UpperCaseFunction := UpperCase_DKC_SSE_3_d;
  37 : UpperCaseFunction := UpperCase_DKC_SSE_4_a;
  38 : UpperCaseFunction := UpperCase_DKC_SSE_4_b;
  39 : UpperCaseFunction := UpperCase_DKC_SSE_4_c;
  40 : UpperCaseFunction := UpperCase_DKC_SSE_4_d;
  41 : UpperCaseFunction := UpperCase_DKC_SSE2_6_a;
  42 : UpperCaseFunction := UpperCase_DKC_SSE2_6_b;
  43 : UpperCaseFunction := UpperCase_DKC_SSE2_6_c;
  44 : UpperCaseFunction := UpperCase_DKC_SSE2_6_d;
  45 : UpperCaseFunction := UpperCase_DKC_SSE2_7_a;
  46 : UpperCaseFunction := UpperCase_DKC_SSE2_7_b;
  47 : UpperCaseFunction := UpperCase_DKC_SSE2_7_c;
  48 : UpperCaseFunction := UpperCase_DKC_SSE2_7_d;
  49 : UpperCaseFunction := UpperCase_DKC_SSE3_1_a;
  50 : UpperCaseFunction := UpperCase_DKC_SSE3_1_b;
  51 : UpperCaseFunction := UpperCase_DKC_SSE3_1_c;
  52 : UpperCaseFunction := UpperCase_DKC_SSE3_1_d;
  53 : UpperCaseFunction := UpperCase_DKC_SSE3_5_a;
  54 : UpperCaseFunction := UpperCase_DKC_SSE3_5_b;
  55 : UpperCaseFunction := UpperCase_DKC_SSE3_5_c;
  56 : UpperCaseFunction := UpperCase_DKC_SSE3_5_d;
  57 : UpperCaseFunction := UpperCase_JOH_IA32_1_a;
  58 : UpperCaseFunction := UpperCase_JOH_IA32_1_b;
  59 : UpperCaseFunction := UpperCase_JOH_IA32_1_c;
  60 : UpperCaseFunction := UpperCase_JOH_IA32_1_d;
  61 : UpperCaseFunction := UpperCase_JOH_IA32_0_a;
  62 : UpperCaseFunction := UpperCase_JOH_IA32_0_b;
  63 : UpperCaseFunction := UpperCase_JOH_IA32_0_c;
  64 : UpperCaseFunction := UpperCase_JOH_IA32_0_d;
  65 : UpperCaseFunction := UpperCase_JOH_PAS_1_a;
  66 : UpperCaseFunction := UpperCase_JOH_PAS_1_b;
  67 : UpperCaseFunction := UpperCase_JOH_PAS_1_c;
  68 : UpperCaseFunction := UpperCase_JOH_PAS_1_d;
  69 : UpperCaseFunction := UpperCase_JOH_MMX_1_a;
  70 : UpperCaseFunction := UpperCase_JOH_MMX_1_b;
  71 : UpperCaseFunction := UpperCase_JOH_MMX_1_c;
  72 : UpperCaseFunction := UpperCase_JOH_MMX_1_d;
  73 : UpperCaseFunction := UpperCase_JOH_SSE2_1_a;
  74 : UpperCaseFunction := UpperCase_JOH_SSE2_1_b;
  75 : UpperCaseFunction := UpperCase_JOH_SSE2_1_c;
  76 : UpperCaseFunction := UpperCase_JOH_SSE2_1_d;
  77 : UpperCaseFunction := UpperCase_JOH_IA32_2_a;
  78 : UpperCaseFunction := UpperCase_JOH_IA32_2_b;
  79 : UpperCaseFunction := UpperCase_JOH_IA32_2_c;
  80 : UpperCaseFunction := UpperCase_JOH_IA32_2_d;
  81 : UpperCaseFunction := UpperCase_JOH_SSE_2_a;
  82 : UpperCaseFunction := UpperCase_JOH_SSE_2_b;
  83 : UpperCaseFunction := UpperCase_JOH_SSE_2_c;
  84 : UpperCaseFunction := UpperCase_JOH_SSE_2_d;
  85 : UpperCaseFunction := UpperCase_JOH_SSE2_2_a;
  86 : UpperCaseFunction := UpperCase_JOH_SSE2_2_b;
  87 : UpperCaseFunction := UpperCase_JOH_SSE2_2_c;
  88 : UpperCaseFunction := UpperCase_JOH_SSE2_2_d;
  89 : UpperCaseFunction := UpperCase_JOH_MMX_3_a;
  90 : UpperCaseFunction := UpperCase_JOH_MMX_3_b;
  91 : UpperCaseFunction := UpperCase_JOH_MMX_3_c;
  92 : UpperCaseFunction := UpperCase_JOH_MMX_3_d;
  93 : UpperCaseFunction := UpperCase_JOH_IA32_3_a;
  94 : UpperCaseFunction := UpperCase_JOH_IA32_3_b;
  95 : UpperCaseFunction := UpperCase_JOH_IA32_3_c;
  96 : UpperCaseFunction := UpperCase_JOH_IA32_3_d;
  97 : UpperCaseFunction := UpperCase_JOH_IA32_4_a;
  98 : UpperCaseFunction := UpperCase_JOH_IA32_4_b;
  99 : UpperCaseFunction := UpperCase_JOH_IA32_4_c;
  100 : UpperCaseFunction := UpperCase_JOH_IA32_4_d;
  101 : UpperCaseFunction := UpperCase_JOH_IA32_5_a;
  102 : UpperCaseFunction := UpperCase_JOH_IA32_5_b;
  103 : UpperCaseFunction := UpperCase_JOH_IA32_5_c;
  104 : UpperCaseFunction := UpperCase_JOH_IA32_5_d;
  105 : UpperCaseFunction := UpperCase_JOH_IA32_6_a;
  106 : UpperCaseFunction := UpperCase_JOH_IA32_6_b;
  107 : UpperCaseFunction := UpperCase_JOH_IA32_6_c;
  108 : UpperCaseFunction := UpperCase_JOH_IA32_6_d;
  109 : UpperCaseFunction := UpperCase_LBG_Pas_1_a;
  110 : UpperCaseFunction := UpperCase_LBG_Pas_1_b;
  111 : UpperCaseFunction := UpperCase_LBG_Pas_1_c;
  112 : UpperCaseFunction := UpperCase_LBG_Pas_1_d;
  113 : UpperCaseFunction := UpperCase_LBG_Pas_2_a;
  114 : UpperCaseFunction := UpperCase_LBG_Pas_2_b;
  115 : UpperCaseFunction := UpperCase_LBG_Pas_2_c;
  116 : UpperCaseFunction := UpperCase_LBG_Pas_2_d;
  117 : UpperCaseFunction := UpperCase_LBG_Pas_3_a;
  118 : UpperCaseFunction := UpperCase_LBG_Pas_3_b;
  119 : UpperCaseFunction := UpperCase_LBG_Pas_3_c;
  120 : UpperCaseFunction := UpperCase_LBG_Pas_3_d;
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
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   BenchmarkButtonClick(nil);
   Update;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), SystemInfoVersion, SystemInfoCompileFlags]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPU]));
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
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_BELOW_NORMAL) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_BELOW_NORMAL failed');
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   ValidateButtonClick(nil);
   Update;
  end;
 ValidateAllButton.Caption := 'Validate All';

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), SystemInfoVersion, SystemInfoCompileFlags]));
 //FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.Add(Format('OS: "%s". CPU :"%s".', [SystemInfoWindows, SystemInfoCPU]));
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
 ReportRichEdit.Print('UpperCase Report');
end;

procedure TMainForm.BenchTest1ButtonClick(Sender: TObject);
var
 I1 : Cardinal;

begin
 BenchTest1Button.Caption := 'Running';
 Update;
 for I1 := 1 to 3 do
  begin
   BenchmarkAllButtonClick(nil);
  end;
 BenchTest1Button.Caption := 'Bench Test 1';
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

procedure TMainForm.BenchTest2ButtonClick(Sender: TObject);
var
 I1 : Cardinal;

begin
 BenchTest2Button.Caption := 'Running';
 Update;
 for I1 := 1 to 3 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkButtonClick(nil);
   BenchmarkAllButtonClick(nil);
  end;
 BenchTest2Button.Caption := 'Bench Test 2';
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
   FunctionAddress := Cardinal(@UpperCaseFunction);
   FunctionAddressString := IntToHex(FunctionAddress, 8);
   ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]);
  end;
 for J := 0 to ReportRichEdit.Lines.Count do
  begin
   for T := 1 to 4 do
    AlignStringArray[T] := '';
   S1 := ReportRichEdit.Lines.Strings[J];
   TabPos1 := CharPos(#9, S1);
   FunctionName1 := Copy(S1, 1, TabPos1-3);
   FunctionAlignString1 := Copy(S1, TabPos1+1, 1);
   L := 1;
   AlignStringArray[L] := FunctionAlignString1;
   for K := J+1 to ReportRichEdit.Lines.Count do
    begin
     S2 := ReportRichEdit.Lines.Strings[K];
     TabPos2 := CharPos(#9, S1);
     FunctionName2 := Copy(S2, 1, TabPos2-3);
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
       end;
     end;
  end;
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
