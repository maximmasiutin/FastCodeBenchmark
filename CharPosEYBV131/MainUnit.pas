unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'CharPosEY';

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
    CharPosEdit: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    ErrorTrapOnCheckBox: TCheckBox;
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
    procedure BenchTestButtonClick(Sender: TObject);
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure MaxSpreadBenchPercentageEditClick(Sender: TObject);
    procedure CleanResultsButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure ClearAllEditBoxes;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    function SubBenchmark1 : Cardinal;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
 MainForm: TMainForm;

implementation

uses
 FastcodeCPUID, SystemInfoUnit, CharPosEYDKCUnit, CharPosEYSHAUnit, CharPosEY_JOH, CharPosEY_JOH2;

{$R *.dfm}

const
 NOOFRUNS : Cardinal = 4000;
 NOOFRERUNS : Cardinal = 5;
 SUBBENCH1SCALE : Double = 500;
 PATTERNSIZE : Cardinal = 22;
 NOOFPATTERNS : Cardinal = 9;
 VALIDATE8MAX : Cardinal = 5000; //MAXCARDINAL
 VALIDATE13MAXSTRINGLENGTH : Cardinal = 1000;
 VALIDATE18SOURCESIZE : Cardinal = 1000000;
 VALIDATE19SOURCESIZE : Cardinal = 5000;
 VALIDATE20SOURCESIZE : Cardinal = 100;
 VALIDATE21SOURCESIZE : Cardinal = 10;
 VALIDATE25MAXOCCURRENCE : Integer = 10;
 VALIDATE25MAXSTARTPOS : Integer = 10;

type
 TCharPosEYFunction = function (const SearchCharacter : Char; const SourceString : AnsiString; Occurrence : Integer = 1; StartPos : Integer = 1) : Integer;

var
 CharPosEYFunction : TCharPosEYFunction;
 //For benchmark
 SourceString : AnsiString;
 SearchCharacter : Char;
 lpFrequency : Int64;
 NoOfTicksArray : array of Int64;

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

procedure ShowMessageBox(Heading, Text : AnsiString);
begin
 Application.MessageBox(PChar(Text), PChar(Heading));
end;

procedure ErrorTrap(ValidateFunction : Cardinal);
begin
 if MainForm.ErrorTrapOnCheckBox.Checked then
  ShowMessageBox('Validation Failure', 'ValidateFunction: ' + IntToStr(ValidateFunction));
end;

function Validate1 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos : Integer;
const
 VALIDATENO : Cardinal = 1;

begin
 SourceString := '';
 SearchCharacter := 'A';
 Occurrence := 0;
 CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
 if CharPos <> 0 then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate2 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos : Integer;
const
 VALIDATENO : Cardinal = 2;

begin
 SourceString := 'A';
 SearchCharacter := 'A';
 Occurrence := 0;
 CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
 if CharPos <> 0 then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate3 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos : Integer;
const
 VALIDATENO : Cardinal = 3;

begin
 SourceString := 'A';
 SearchCharacter := 'A';
 Occurrence := 1;
 CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
 if CharPos <> 1 then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate4 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos : Integer;
const
 VALIDATENO : Cardinal = 4;

begin
 SourceString := 'A';
 SearchCharacter := 'A';
 Occurrence := 2;
 CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
 if CharPos <> 0 then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate5 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos : Integer;
const
 VALIDATENO : Cardinal = 5;

begin
 SourceString := 'A';
 SearchCharacter := 'B';
 Occurrence := 0;
 CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
 if CharPos <> 0 then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate6 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos : Integer;
const
 VALIDATENO : Cardinal = 6;

begin
 SourceString := 'A';
 SearchCharacter := 'B';
 Occurrence := 1;
 CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
 if CharPos <> 0 then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate7 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos : Integer;
const
 VALIDATENO : Cardinal = 7;

begin
 SourceString := 'A';
 SearchCharacter := 'B';
 Occurrence := 2;
 CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
 if CharPos <> 0 then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate8 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos : Integer;
const
 VALIDATENO : Cardinal = 8;

begin
 SourceString := 'A';
 SearchCharacter := 'B';
 Result := True;
 for Occurrence := 0 to VALIDATE8MAX do
  begin
   CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
   if CharPos <> 0 then
    begin
     Result := False;
     ErrorTrap(VALIDATENO);
     Break;
    end;
  end;
end;

function Validate9 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 I, Occurrence, CharPos : Integer;
const
 VALIDATENO : Cardinal = 9;

begin
 SourceString := '';
 SearchCharacter := Char(1);
 Occurrence := 1;
 Result := True;
 for I := 2 to 255 do
  begin
   SourceString := SourceString + Char(I);
   CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
   if CharPos <> 0 then
    begin
     Result := False;
     ErrorTrap(VALIDATENO);
     Break;
    end;
  end;
end;

function Validate10 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter, C : Char;
 Occurrence, CharPos, I : Integer;
const
 VALIDATENO : Cardinal = 10;

begin
 SourceString := 'A';
 SearchCharacter := 'A';
 Occurrence := 1;
 Result := True;
 for I := 0 to 255 do
  begin
   CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
   if CharPos <> I+1 then
    begin
     Result := False;
     ErrorTrap(VALIDATENO);
     Break;
    end;
   C := Char(I);
   if C = 'A' then
    C := 'X';
   SourceString := C + SourceString;
  end;
end;

function Validate11 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter, C : Char;
 Occurrence, CharPos, I : Integer;
const
 VALIDATENO : Cardinal = 11;

begin
 SourceString := 'AA';
 SearchCharacter := 'A';
 Occurrence := 2;
 Result := True;
 for I := 0 to 255 do
  begin
   CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
   if CharPos <> I+2 then
    begin
     Result := False;
     ErrorTrap(VALIDATENO);
     Break;
    end;
   C := Char(I);
   if C = 'A' then
    C := 'X';
   SourceString := C + SourceString;
  end;
end;

function Validate12 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter, C : Char;
 Occurrence, CharPos, I1, I2 : Integer;
const
 VALIDATENO : Cardinal = 12;

begin
 Occurrence := 3;
 Result := True;
 for I1 := 0 to 255 do
  begin
   SourceString := Char(I1) + Char(I1) + Char(I1);
   SearchCharacter := Char(I1);
   for I2 := 0 to 255 do
    begin
     CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
     if CharPos <> I2+3 then
      begin
       Result := False;
       ErrorTrap(VALIDATENO);
       Exit;
      end;
     C := Char(I2);
     if C = SearchCharacter then
      C := Char(I2+1);
     SourceString := C + SourceString;
    end;
  end;
end;

function Validate13 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos, I1 : Integer;
const
 VALIDATENO : Cardinal = 13;

begin
 Result := True;
 SearchCharacter := 'x';
 for I1 := 1 to VALIDATE13MAXSTRINGLENGTH do
  begin
   SourceString := SourceString + SearchCharacter;
  end;
 for Occurrence := 1 to VALIDATE13MAXSTRINGLENGTH do
  begin
   CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
   if CharPos <> Occurrence then
    begin
     Result := False;
     ErrorTrap(VALIDATENO);
     Exit;
    end;
  end;
end;

function Validate14 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, CharPos, I1, I2 : Integer;
const
 VALIDATENO : Cardinal = 14;

begin
 Result := True;
 for I1 := 0 to 255 do
  begin
   SourceString := SourceString + Char(I1);
  end;
 Occurrence := 1;
 for I2 := 0 to 255 do
  begin
   SearchCharacter := Char(I2);
   CharPos := CharPosEYFunction(SearchCharacter,SourceString,  Occurrence);
   if CharPos <> I2+1 then
    begin
     Result := False;
     ErrorTrap(VALIDATENO);
     Exit;
    end;
  end;
end;

{$HINTS OFF}

function Validate15 : Boolean;
var
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter : Cardinal;
 X, Y, Z : Extended;
 Str : AnsiString;
 Chr : Char;
const
 VALIDATENO : Cardinal = 15;

begin
 Str := 'Welcome my dear - to the register check';
 Chr := 'A';
 asm
  mov EBXRegisterBefore, ebx
  mov EDIRegisterBefore, edi
  mov ESIRegisterBefore, esi
 end;
 //CharPosEYFunction(Chr, Str, 1, 1);
 asm
  push 1
  mov ecx,1
  mov edx,Str
  mov al, Chr
  call dword ptr [CharPosEYFunction]
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
   MainForm.ValidationEdit.Text := 'EBX, EDI or ESI register not preserved';
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  begin
   MainForm.ValidationEdit.Text := 'Passed register test';
   Result := True;
  end;
 try
  X := 2;
  Y := 3;
  Z := X * Y;
  if Z <> 6 then
   Z := 6;
 except
  MainForm.ValidationEdit.Text := 'EMMS is missing';
  Result := False;
  ErrorTrap(VALIDATENO);
 end;
end;

{$HINTS ON}

//Validation for correct handling of non nil zero length strings

var
 S1Global : AnsiString;

function Validate16 : Boolean;
var
 ChrPos : Integer;
const
 VALIDATENO : Cardinal = 16;

begin
 S1Global := 'z';
 (PInteger(Integer(S1Global)-4))^ := 0;
 ChrPos := CharPosEYFunction('z', S1Global, 1);
 if ChrPos <> 0 then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate17 : Boolean;
var
 Chr : Char;
 Str : AnsiString;
 CharPos1, CharPos2 : Integer;
 I1, I2, I3, I4, I5, I6, I7, I8, I9 : Byte;
const
 VALIDATENO : Cardinal = 17;

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
                   CharPos2 := CharPosEYFunction(Chr, Str, 1);
                   if CharPos1 <> CharPos2 then
                    begin
                     MainForm.ValidationEdit.Text := IntToStr(CharPos2) + ' <> ' + IntToStr(CharPos1);
                     MainForm.ValidationEdit.Color := clRed;
                     Result := False;
                     ErrorTrap(VALIDATENO);
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

function Validate18 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, StartPosition, CharPos, I1 : Integer;
const
 VALIDATENO : Cardinal = 18;

begin
 Sourcestring := '';
 SearchCharacter := 'S';
 for I1 := 1 to VALIDATE18SOURCESIZE do
  Sourcestring := Sourcestring + SearchCharacter;
 Occurrence := 1;
 Result := True;
 for StartPosition := 1 to Length(Sourcestring) do
  begin
   CharPos := CharPosEYFunction(SearchCharacter, SourceString,  Occurrence, StartPosition);
   if CharPos <> Integer(StartPosition) then
    begin
     Result := False;
     ErrorTrap(VALIDATENO);
     Exit;
    end;
  end;
end;

function Validate19 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, StartPosition, CharPos, I1 : Integer;
const
 VALIDATENO : Cardinal = 19;

begin
 Sourcestring := '';
 SearchCharacter := 'h';
 for I1 := 1 to VALIDATE19SOURCESIZE do
  Sourcestring := Sourcestring + SearchCharacter;
 Result := True;
 for StartPosition := 1 to VALIDATE19SOURCESIZE div 2 do
  begin
   for Occurrence := 1 to VALIDATE19SOURCESIZE div 2 do
    begin
     CharPos := CharPosEYFunction(SearchCharacter, SourceString,  Occurrence, StartPosition);
     if CharPos <> Integer(StartPosition + Occurrence - 1) then
      begin
       Result := False;
       ErrorTrap(VALIDATENO);
       Exit;
      end;
    end;
  end;
end;

function Validate20 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, StartPosition, CharPos, I1 : Integer;
const
 VALIDATENO : Cardinal = 20;

begin
 Sourcestring := '';
 SearchCharacter := 'Q';
 for I1 := 1 to VALIDATE20SOURCESIZE do
  Sourcestring := Sourcestring + SearchCharacter;
 Occurrence := 1;
 Result := True;
 for StartPosition := 0 downto -1000 do
  begin
   CharPos := CharPosEYFunction(SearchCharacter, SourceString,  Occurrence, StartPosition);
   if CharPos <> 0 then
    begin
     Result := False;
     ErrorTrap(VALIDATENO);
     Exit;
    end;
  end;
end;

function Validate21 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, StartPosition, CharPos, I1 : Integer;
const
 VALIDATENO : Cardinal = 21;

begin
 Sourcestring := '';
 SearchCharacter := 'y';
 for I1 := 1 to VALIDATE21SOURCESIZE do
  Sourcestring := Sourcestring + SearchCharacter;
 StartPosition := 1;
 Result := True;
 for Occurrence := 0 downto -1200 do
  begin
   CharPos := CharPosEYFunction(SearchCharacter, SourceString,  Occurrence, StartPosition);
   if CharPos <> 0 then
    begin
     Result := False;
     ErrorTrap(VALIDATENO);
     Exit;
    end;
  end;
end;

function Validate22 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, StartPosition, CharPos : Integer;
const
 VALIDATENO : Cardinal = 22;

begin
 SearchCharacter := #0;
 Sourcestring := 'abc';
 Occurrence := 1;
 StartPosition := 4;
 CharPos := CharPosEYFunction(SearchCharacter, SourceString,  Occurrence, StartPosition);
 if CharPos <> 0 then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate23 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, StartPosition, CharPos, Len, CharPosRef : Integer;
const
 VALIDATENO : Cardinal = 23;

begin
 SearchCharacter := #0;
 Len := 33;
 SetLength(Sourcestring, Len);
 FillChar(SourceString[1], Len, SearchCharacter);
 StartPosition := 1;
 Occurrence := 34;
 CharPosRef := StartPosition + Occurrence - 1;
 if CharPosRef > Len then
  CharPosRef := 0;
 CharPos := CharPosEYFunction(SearchCharacter, SourceString,  Occurrence, StartPosition);
 if CharPos <> CharPosRef then
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end
 else
  Result := True;
end;

function Validate24 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, StartPosition, CharPos, Len, CharPosRef : Integer;
const
 VALIDATENO : Cardinal = 24;

begin
 Result := True;
 SearchCharacter := #0;
 for Len:= 33 to 40 do
  begin;
   SetLength(Sourcestring, Len);
   FillChar(SourceString[1], Len, SearchCharacter);
   for StartPosition := 1 to 9 do
    begin
     for Occurrence := Len-7 to Len+1 do
      begin
       CharPos := CharPosEYFunction(SearchCharacter, SourceString, Occurrence, StartPosition);
       CharPosRef := StartPosition + Occurrence - 1;
       if CharPosRef > Len then
        CharPosRef := 0;
       if CharPos <> CharPosRef then
        begin
         Result := False;
         ErrorTrap(VALIDATENO);
         Exit;
        end;
      end;
    end;
  end;
end;

function Validate25 : Boolean;
var
 SourceString : AnsiString;
 SearchCharacter : Char;
 Occurrence, StartPosition, CharPos, CharPosRef, I1 : Integer;
const
 VALIDATENO : Cardinal = 25;

begin
 SourceString := '';
 Result := True;
 for Occurrence := 0 to VALIDATE25MAXOCCURRENCE do
  begin
   for StartPosition := 0 to VALIDATE25MAXSTARTPOS do
    begin
     for I1 := 0 to 255 do
      begin
       SearchCharacter := Char(I1);
       CharPosRef := CharPosEY_DKC_Pas_1(SearchCharacter, SourceString, Occurrence, StartPosition);
       CharPos := CharPosEYFunction(SearchCharacter, SourceString, Occurrence, StartPosition);
       if CharPosRef <> CharPos then
        begin
         Result := False;
         ErrorTrap(VALIDATENO);
         Exit;
        end;
       SourceString := SourceString + Char(I1) + Char(Random(255));
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
  FunctionAddress := Cardinal(@CharPosEYFunction);
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
     Validate16 and
     Validate17 and
     Validate18 and
     Validate19 and
     Validate20 and
     Validate21 and
     Validate22 and
     Validate23 and
     Validate24 and
     Validate25 then
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
  ReportRichEdit.Lines.Add(FunctionName
                    + #9 + FunctionAddressString[8]
                   + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 FunctionAddress, Bench : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@CharPosEYFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  BenchmarkButton.Caption := 'Running';
  Bench := SubBenchmark1;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + IntToStr(Bench));
  SortRichEdit;
  BenchmarkTest;
  AlignmentTest;
  BenchmarkButton.Caption := 'Benchmark';
 except
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           + #9 + '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var
 CharPos, StartPos, Occurrence : Integer;
 I3, I4, I5, I6 : Cardinal;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 Succes : Boolean;

begin
 CharPos := 1;//For compiler
 for I3 := 1 to NOOFRERUNS do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I4 := 1 to NOOFRUNS do
    begin
     for I5 := 1 to PATTERNSIZE do
      begin
       SearchCharacter := Char(I5);
       for StartPos := 1 to PATTERNSIZE do
        begin
         for Occurrence := 1 to NOOFPATTERNS do
          begin
           CharPos := CharPosEYFunction(SearchCharacter, SourceString, Occurrence, StartPos);
          end;
        end;
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
   NoOfTicksArray[I3-1] := NoOfTicks;
   CharPosEdit.Text := IntToStr(CharPos);//Fool compiler
  end;
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I6 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I6] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I6];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec * SUBBENCH1SCALE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 I1, I2 : Cardinal;
 Succes : Boolean;
 CpuString : string;
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 120;
 ReportRichEdit.Paragraph.Tab[1] := 180;
 FunctionSelectionRadioGroupClick(nil);
 for I1 := 1 to NOOFPATTERNS do
  begin
   for I2 := 1 to PATTERNSIZE do
    begin
     SourceString := SourceString + Char(I2);
    end;
  end;
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);

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
  1 : CharPosEYFunction := CharPosEY_Sha_Pas_1_a;
  2 : CharPosEYFunction := CharPosEY_Sha_Pas_1_b;
  3 : CharPosEYFunction := CharPosEY_Sha_Pas_1_c;
  4 : CharPosEYFunction := CharPosEY_Sha_Pas_1_d;
  5 : CharPosEYFunction := CharPosEY_Sha_Pas_2_a;
  6 : CharPosEYFunction := CharPosEY_Sha_Pas_2_b;
  7 : CharPosEYFunction := CharPosEY_Sha_Pas_2_c;
  8 : CharPosEYFunction := CharPosEY_Sha_Pas_2_d;
  9 : CharPosEYFunction := CharPosEY_Sha_Pas_3_a;
  10 : CharPosEYFunction := CharPosEY_Sha_Pas_3_b;
  11 : CharPosEYFunction := CharPosEY_Sha_Pas_3_c;
  12 : CharPosEYFunction := CharPosEY_Sha_Pas_3_d;
  13 : CharPosEYFunction := CharPosEY_Sha_Asm_1_a;
  14 : CharPosEYFunction := CharPosEY_Sha_Asm_1_b;
  15 : CharPosEYFunction := CharPosEY_Sha_Asm_1_c;
  16 : CharPosEYFunction := CharPosEY_Sha_Asm_1_d;
  17 : CharPosEYFunction := CharPosEY_DKC_Pas_6_a;
  18 : CharPosEYFunction := CharPosEY_DKC_Pas_6_b;
  19 : CharPosEYFunction := CharPosEY_DKC_Pas_6_c;
  20 : CharPosEYFunction := CharPosEY_DKC_Pas_6_d;
  21 : CharPosEYFunction := CharPosEY_DKC_IA32_16_a;
  22 : CharPosEYFunction := CharPosEY_DKC_IA32_16_b;
  23 : CharPosEYFunction := CharPosEY_DKC_IA32_16_c;
  24 : CharPosEYFunction := CharPosEY_DKC_IA32_16_d;
  25 : CharPosEYFunction := CharPosEY_DKC_IA32_18_a;
  26 : CharPosEYFunction := CharPosEY_DKC_IA32_18_b;
  27 : CharPosEYFunction := CharPosEY_DKC_IA32_18_c;
  28 : CharPosEYFunction := CharPosEY_DKC_IA32_18_d;
  29 : CharPosEYFunction := CharPosEY_DKC_IA32_19_a;
  30 : CharPosEYFunction := CharPosEY_DKC_IA32_19_b;
  31 : CharPosEYFunction := CharPosEY_DKC_IA32_19_c;
  32 : CharPosEYFunction := CharPosEY_DKC_IA32_19_d;
  33 : CharPosEYFunction := CharPosEY_JOH_PAS_a;
  34 : CharPosEYFunction := CharPosEY_JOH_PAS_b;
  35 : CharPosEYFunction := CharPosEY_JOH_PAS_c;
  36 : CharPosEYFunction := CharPosEY_JOH_PAS_d;
  37 : CharPosEYFunction := CharPosEY_JOH_IA32_a;
  38 : CharPosEYFunction := CharPosEY_JOH_IA32_b;
  39 : CharPosEYFunction := CharPosEY_JOH_IA32_c;
  40 : CharPosEYFunction := CharPosEY_JOH_IA32_d;
  41 : CharPosEYFunction := CharPosEY_JOH_PAS_2_a;
  42 : CharPosEYFunction := CharPosEY_JOH_PAS_2_b;
  43 : CharPosEYFunction := CharPosEY_JOH_PAS_2_c;
  44 : CharPosEYFunction := CharPosEY_JOH_PAS_2_d;
  45 : CharPosEYFunction := CharPosEY_JOH_IA32_2_a;
  46 : CharPosEYFunction := CharPosEY_JOH_IA32_2_b;
  47 : CharPosEYFunction := CharPosEY_JOH_IA32_2_c;
  48 : CharPosEYFunction := CharPosEY_JOH_IA32_2_d;
  49 : CharPosEYFunction := CharPosEY_JOH_PAS_1_a;
  50 : CharPosEYFunction := CharPosEY_JOH_PAS_1_b;
  51 : CharPosEYFunction := CharPosEY_JOH_PAS_1_c;
  52 : CharPosEYFunction := CharPosEY_JOH_PAS_1_d;
  53 : CharPosEYFunction := CharPosEY_JOH_PAS_3_a;
  54 : CharPosEYFunction := CharPosEY_JOH_PAS_3_b;
  55 : CharPosEYFunction := CharPosEY_JOH_PAS_3_c;
  56 : CharPosEYFunction := CharPosEY_JOH_PAS_3_d;
  57 : CharPosEYFunction := CharPosEY_JOH_IA32_1_a;
  58 : CharPosEYFunction := CharPosEY_JOH_IA32_1_b;
  59 : CharPosEYFunction := CharPosEY_JOH_IA32_1_c;
  60 : CharPosEYFunction := CharPosEY_JOH_IA32_1_d;
  61 : CharPosEYFunction := CharPosEY_JOH_IA32_3_a;
  62 : CharPosEYFunction := CharPosEY_JOH_IA32_3_b;
  63 : CharPosEYFunction := CharPosEY_JOH_IA32_3_c;
  64 : CharPosEYFunction := CharPosEY_JOH_IA32_3_d;
  65 : CharPosEYFunction := CharPosEY_JOH_PAS_4_a;
  66 : CharPosEYFunction := CharPosEY_JOH_PAS_4_b;
  67 : CharPosEYFunction := CharPosEY_JOH_PAS_4_c;
  68 : CharPosEYFunction := CharPosEY_JOH_PAS_4_d;
  69 : CharPosEYFunction := CharPosEY_JOH_IA32_4_a;
  70 : CharPosEYFunction := CharPosEY_JOH_IA32_4_b;
  71 : CharPosEYFunction := CharPosEY_JOH_IA32_4_c;
  72 : CharPosEYFunction := CharPosEY_JOH_IA32_4_d;
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
 //for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
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
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
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
 ReportRichEdit.Print('CharPosEY Report');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 //for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I1 := 1 to 3 do
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
