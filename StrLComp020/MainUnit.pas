unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Math;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'StrLComp';

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
    J1Edit: TEdit;
    J2Edit: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
    AlignCheckButton: TButton;
    AlignCheckEdit: TEdit;
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
    procedure FormDestroy(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    lpFrequency : Int64;
    procedure ClearAllEditBoxes;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    function SubBenchmark1 : Cardinal;
    function SubBenchmark2 : Cardinal;
    function SubBenchmark3 : Cardinal;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
 MainForm: TMainForm;

implementation

uses
 FastcodeCPUID, SystemInfoUnit, StrLCompRTLUnit, StrLCompJOHUnit;

{$R *.dfm}

type
 TStrLCompFunction = function (const Str1, Str2: PChar; MaxLen: Cardinal): Integer;

var
 StrLCompFunction : TStrLCompFunction;
 SubBench1StringArray : array of string;
 SubBench2StringArray : array of string;
 SubBench3StringArray : array of string;

const
 SUBBENCH1STRARRAYSIZE : Cardinal = 80;
 SUBBENCH2STRARRAYSIZE : Cardinal = 100;//300;
 SUBBENCH3STRARRAYSIZE : Cardinal = 80;
 MAXSTRINGSIZE : Cardinal = 1000;
 //Adjusted such that each subbenchmark contributes evenly at a P41600A on the RTL function
 SUBBENCH1SCALE : Double = 258;
 SUBBENCH2SCALE : Double = 325;
 SUBBENCH3SCALE : Double = 255;
 MAXINT64 : int64= $7FFFFFFFFFFFFFFF;
 NOOFRERUNS : Cardinal = 5;//Must be at least 2 //Reruns
 MAXNOOFRUNS : Cardinal = 3000;
 SUBBENCH2MAXNOOFRUNS : Cardinal = 100;

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

function Validate1 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..1] of Char;
 I1, I2, I3 : Integer;
begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := #0;
 Str1Array[1] := #0;
 Str2Array[0] := #0;
 Str2Array[1] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;

 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := #0;
 Str1Array[1] := #0;
 Str2Array[0] := 'R';
 Str2Array[1] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'R';
 Str1Array[1] := #0;
 Str2Array[0] := #0;
 Str2Array[1] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[1] := #0;
 Str2Array[0] := 'A';
 Str2Array[1] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;
 Str1Array[0] := 'a';
 Str1Array[1] := #0;
 Str2Array[0] := 'A';
 Str2Array[1] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;
 Str1Array[0] := 'A';
 Str1Array[1] := #0;
 Str2Array[0] := 'a';
 Str2Array[1] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      Result := False;
   end;
end;

function Validate2 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..2] of Char;
 I1, I2, I3 : Integer;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[1] := 'B';
 Str1Array[2] := #0;
 Str2Array[0] := 'A';
 Str2Array[1] := 'B';
 Str2Array[2] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;
 Str1Array[0] := 'A';
 Str1Array[1] := 'b';
 Str1Array[2] := #0;
 Str2Array[0] := 'A';
 Str2Array[1] := 'B';
 Str2Array[2] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;
 Str1Array[0] := 'Z';
 Str1Array[1] := 'b';
 Str1Array[2] := #0;
 Str2Array[0] := 'A';
 Str2Array[1] := 'B';
 Str2Array[2] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;
 Str1Array[0] := 'A';
 Str1Array[1] := #0;
 Str1Array[2] := #0;
 Str2Array[0] := 'A';
 Str2Array[1] := 'B';
 Str2Array[2] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;
 Str1Array[0] := 'A';
 Str1Array[1] := 'b';
 Str1Array[2] := #0;
 Str2Array[0] := 'A';
 Str2Array[1] := #0;
 Str2Array[2] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      begin
       Result := False;
       Exit;
      end;
   end;
 Str1Array[0] := 'A';
 Str1Array[1] := 'B';
 Str1Array[2] := #0;
 Str2Array[0] := 'A';
 Str2Array[1] := 'b';
 Str2Array[2] := #0;
 for I3 := 0 to 2 do
   begin
     I1 := StrLComp(Str1, Str2, I3);
     I2 := StrLCompFunction(Str1, Str2, I3);
     if Sign(I1) <> Sign(I2) then
      Result := False;
   end;
end;

function Validate3 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J : Byte;
 C1 : Char;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J := 0 to 254 do
  begin
   C1 := Str2Array[J];
   Str2Array[J] := Char(Random(255));
   for I3 := 0 to 256 do
     begin
       I1 := StrLComp(Str1, Str2, I3);
       I2 := StrLCompFunction(Str1, Str2, I3);
       Str2Array[J] := C1;
       if Sign(I1) <> Sign(I2) then
        begin
         Result := False;
         Exit;
        end;
    end;
  end;
end;

function Validate4 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J1, J2 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J1 := 0 to 255 do
  begin
   Str1Array[0] := Char(J1);
   for I3 := 0 to 256 do
     begin
       I1 := StrLComp(Str1, Str2, I3);
       I2 := StrLCompFunction(Str1, Str2, I3);
       if Sign(I1) <> Sign(I2) then
        begin
         Result := False;
         Exit;
        end;
     end;
  end;
 for J2 := 0 to 255 do
  begin
   Str2Array[0] := Char(J2);
   for I3 := 0 to 256 do
     begin
       I1 := StrLComp(Str1, Str2, I3);
       I2 := StrLCompFunction(Str1, Str2, I3);
       if Sign(I1) <> Sign(I2) then
        begin
         Result := False;
         Exit;
        end;
     end;
  end;
end;

function Validate5 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J1, J2 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J1 := 0 to 255 do
  begin
   Str1Array[1] := Char(J1);
   for I3 := 0 to 256 do
     begin
       I1 := StrLComp(Str1, Str2, I3);
       I2 := StrLCompFunction(Str1, Str2, I3);
       if Sign(I1) <> Sign(I2) then
        begin
         Result := False;
         Exit;
        end;
     end;
  end;
 for J2 := 0 to 255 do
  begin
   Str2Array[1] := Char(J2);
   for I3 := 0 to 256 do
     begin
       I1 := StrLComp(Str1, Str2, I3);
       I2 := StrLCompFunction(Str1, Str2, I3);
       if Sign(I1) <> Sign(I2) then
        begin
         Result := False;
         Exit;
        end;
     end;
  end;
end;

function Validate6 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J1, J2 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J1 := 0 to 255 do
  begin
   for J2 := 0 to 255 do
    begin
     Str1Array[0] := Char(J1);
     Str2Array[0] := Char(J2);
     for I3 := 0 to 87 do
       begin
         I1 := StrLComp(Str1, Str2, I3*3);
         I2 := StrLCompFunction(Str1, Str2, I3*3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
       end;
    end;
  end;
end;

function Validate7 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J1, J2, J3, J4 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J1 := 0 to 25 do
  begin
   for J2 := 25 to 50 do
    begin
     for J3 := 50 to 75 do
      begin
       for J4 := 75 to 100 do
        begin
         Str1Array[0] := Char(J1);
         Str2Array[0] := Char(J2);
         Str1Array[1] := Char(J3);
         Str2Array[1] := Char(J4);
         I3 := 0;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 128;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 256;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;

        end;
      end;
    end;
  end;
end;

function Validate8 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J1, J2, J3, J4 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J1 := 0 to 25 do
  begin
   for J2 := 25 to 50 do
    begin
     for J3 := 50 to 75 do
      begin
       for J4 := 75 to 100 do
        begin
         Str1Array[1] := Char(J1);
         Str2Array[1] := Char(J2);
         Str1Array[2] := Char(J3);
         Str2Array[2] := Char(J4);
         I3 := 0;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 128;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 256;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

function Validate9 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J1, J2, J3, J4 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J1 := 0 to 25 do
  begin
   for J2 := 25 to 50 do
    begin
     for J3 := 50 to 75 do
      begin
       for J4 := 75 to 100 do
        begin
         Str1Array[2] := Char(J1);
         Str2Array[2] := Char(J2);
         Str1Array[3] := Char(J3);
         Str2Array[3] := Char(J4);
         I3 := 0;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 128;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 256;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

function Validate10 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J1, J2, J3, J4 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J1 := 0 to 25 do
  begin
   for J2 := 25 to 50 do
    begin
     for J3 := 50 to 75 do
      begin
       for J4 := 75 to 100 do
        begin
         Str1Array[3] := Char(J1);
         Str2Array[3] := Char(J2);
         Str1Array[4] := Char(J3);
         Str2Array[4] := Char(J4);
         I3 := 0;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 128;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 256;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

function Validate11 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J1, J2, J3, J4 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J1 := 0 to 25 do
  begin
   for J2 := 25 to 50 do
    begin
     for J3 := 50 to 75 do
      begin
       for J4 := 75 to 100 do
        begin
         Str1Array[4] := Char(J1);
         Str2Array[4] := Char(J2);
         Str1Array[5] := Char(J3);
         Str2Array[5] := Char(J4);
         I3 := 0;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 128;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
         I3 := 256;
         I1 := StrLComp(Str1, Str2, I3);
         I2 := StrLCompFunction(Str1, Str2, I3);
         if Sign(I1) <> Sign(I2) then
          begin
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

function Validate12 : Boolean;
var
 Str1, Str2 : PChar;
 Str1Array, Str2Array : array[0..255] of Char;
 I1, I2, I3 : Integer;
 B1, B2, J1, J2, J3, J4, J5, J6 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str2 := Str2Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 Str2Array[0] := 'A';
 Str2Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for B2 := 1 to 254 do
  begin
   Str2Array[B2] := Char(B2);
  end;
 for J1 := 0 to 7 do
  begin
   for J2 := 5 to 10 do
    begin
     for J3 := 50 to 55 do
      begin
       for J4 := 75 to 80 do
        begin
         for J5 := 110 to 125 do
          begin
           for J6 := 125 to 175 do
            begin
             Str1Array[5] := Char(J1);
             Str2Array[5] := Char(J2);
             Str1Array[6] := Char(J3);
             Str2Array[6] := Char(J4);
             Str1Array[7] := Char(J5);
             Str2Array[7] := Char(J6);
             I3 := 0;
             I1 := StrLComp(Str1, Str2, I3);
             I2 := StrLCompFunction(Str1, Str2, I3);
             if Sign(I1) <> Sign(I2) then
              begin
               Result := False;
               Exit;
              end;
             I3 := 128;
             I1 := StrLComp(Str1, Str2, I3);
             I2 := StrLCompFunction(Str1, Str2, I3);
             if Sign(I1) <> Sign(I2) then
              begin
               Result := False;
               Exit;
              end;
             I3 := 256;
             I1 := StrLComp(Str1, Str2, I3);
             I2 := StrLCompFunction(Str1, Str2, I3);
             if Sign(I1) <> Sign(I2) then
              begin
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

function Validate13 : Boolean;
var
 Str1 : PChar;
 Str1Array : array[0..255] of Char;
 I1, I3 : Integer;
 B1, J1, J2, J3, J4, J5, J6, J7 : Byte;

begin
 Result := True;
 Str1 := Str1Array;
 Str1Array[0] := 'A';
 Str1Array[255] := #0;
 for B1 := 1 to 254 do
  begin
   Str1Array[B1] := Char(B1);
  end;
 for J1 := 0 to 2 do
  begin
   for J2 := 0 to 5 do
    begin
     for J3 := 0 to 7 do
      begin
       for J4 := 0 to 11 do
        begin
         for J5 := 0 to 13 do
          begin
           for J6 := 0 to 17 do
            begin
             for J7 := 0 to 255 do
              begin
               Str1Array[0] := Char(J7);
               Str1Array[1] := Char(J6);
               Str1Array[2] := Char(J5);
               Str1Array[3] := Char(J4);
               Str1Array[4] := Char(J3);
               Str1Array[5] := Char(J2);
               Str1Array[6] := Char(J1);
               I3 := 0;
               I1 := StrLCompFunction(Str1, Str1, I3);
               if I1 <> 0 then
                begin
                 Result := False;
                 Exit;
                end;
               I3 := 100;
               I1 := StrLCompFunction(Str1, Str1, I3);
               if I1 <> 0 then
                begin
                 Result := False;
                 Exit;
                end;
               I3 := 256;
               I1 := StrLCompFunction(Str1, Str1, I3);
               if I1 <> 0 then
                begin
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
end;

function Validate14 : Boolean;
var
 Str1 : PChar;
 S1 : AnsiString;
 I1 : Integer;
 J1 : Integer;
  I3: Integer;
const
 MAXSTRINGSIZE : Integer = 2000;

begin
 Result := True;
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   Str1 := PChar(S1);
   for I3 := 0 to MAXSTRINGSIZE+1 do
     begin
       I1 := StrLCompFunction(Str1, Str1, I3);
       if I1 <> 0 then
        begin
         Result := False;
         Exit;
        end;
     end;
   S1 := S1 + Char(Random(255));
  end;
end;

function Validate15 : Boolean;
var
 Str1, Str2 : PChar;
 S1, S2 : AnsiString;
 I1, I2, I3, J1 : Integer;
 B1 : Byte;
const
 MAXSTRINGSIZE : Integer = 2000;

begin
 Result := True;
 S1 := 'x';
 S2 := 'y';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   Str1 := PChar(S1);
   Str2 := PChar(S2);
   for I3 := 0 to MAXSTRINGSIZE+1 do
     begin
       I1 := StrLComp(Str1, Str2, I3);
       I2 := StrLCompFunction(Str1, Str2, I3);
       if Sign(I1) <> Sign(I2) then
        begin
         Result := False;
         Exit;
        end;
     end;
   B1 := Random(255);
   if Odd(J1) then
    begin
     S1 := S1 + Char(B1);
     S2 := S2 + Char(B1);
    end
   else
    begin
     S1 := Char(B1) + S1;
     S2 := Char(B1) + S2;
    end;
  end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var
 J, J1, J2 : Integer;
 I1, I2, I3, NoOfRuns, RunNo : Cardinal;
 TicksArray : array of Int64;
 Str1, Str2 : PChar;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinTicks : Int64;
 RunTimeSec : Double;

begin
 SetLength(TicksArray, NOOFRERUNS);
 J1 := 0;
 J2 := 0;
 for RunNo := 1 to NOOFRERUNS do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for NoOfRuns := 1 to MAXNOOFRUNS do
    begin
     for I1 := 1 to SUBBENCH1STRARRAYSIZE-1 do
      begin
       Str1 := PChar(SubBench1StringArray[I1]);
       for I2 := 1 to SUBBENCH1STRARRAYSIZE-2 do
        begin
         Str2 := PChar(SubBench1StringArray[I2]);
         I3 := 1;
         J1 := StrLCompFunction(Str1, Str2, I3);
         J2 := StrLCompFunction(Str2, Str1, I3);
         I3 := 10;
         StrLCompFunction(Str1, Str2, I3);
         StrLCompFunction(Str2, Str1, I3);
         I3 := 100;
         StrLCompFunction(Str1, Str2, I3);
         StrLCompFunction(Str2, Str1, I3);
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
    raise Exception.Create('Tick counter wrapped around')
   else
    TicksArray[RunNo-1] := NoOfTicks;
  end;
 MainForm.J1Edit.Text := IntToStr(J1);
 MainForm.J2Edit.Text := IntToStr(J2);
 //Find the fastest run
 MinTicks := TicksArray[0];
 for J := 1 to NOOFRERUNS-1 do
  begin
   if (TicksArray[J] < MinTicks) then;
    MinTicks := TicksArray[J];
  end;
 RunTimeSec := MinTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmark2 : Cardinal;
var
 J, J1, J2 : Integer;
 I1, I2, I3, I4, NoOfRuns, RunNo : Cardinal;
 TicksArray : array of Int64;
 Str1, Str2 : PChar;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinTicks : Int64;
 C1 : Char;
 RunTimeSec : Double;

begin
 SetLength(TicksArray, NOOFRERUNS);
 J1 := 0;
 J2 := 0;
 SubBench2StringArray[1] := 'S';
 //Create some test strings
 for I1 := 2 to SUBBENCH2STRARRAYSIZE-1 do
  begin
   C1 := Char(Random(255));
   if C1 = #0 then
    C1 := 'X';
   SubBench2StringArray[I1] := SubBench2StringArray[I1-1] + C1;
  end;
 for RunNo := 1 to NOOFRERUNS do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for NoOfRuns := 1 to SUBBENCH2MAXNOOFRUNS do
    begin
     for I2 := 0 to SUBBENCH2STRARRAYSIZE-1 do
      begin
       Str1 := PChar(SubBench2StringArray[I2]);
       for I3 := 0 to SUBBENCH2STRARRAYSIZE-1 do
        begin
         Str2 := PChar(SubBench2StringArray[I3]);
         I4 := 1;
         J1 := StrLCompFunction(Str1, Str2, I4);
         J2 := StrLCompFunction(Str2, Str1, I4);
         I4 := 10;
         StrLCompFunction(Str1, Str2, I4);
         StrLCompFunction(Str2, Str1, I4);
         I4 := 50;
         StrLCompFunction(Str1, Str2, I4);
         StrLCompFunction(Str2, Str1, I4);
         I4 := 100;
         StrLCompFunction(Str1, Str2, I4);
         StrLCompFunction(Str2, Str1, I4);
         I4 := 500;
         StrLCompFunction(Str1, Str2, I4);
         StrLCompFunction(Str2, Str1, I4);
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
    raise Exception.Create('Tick counter wrapped around')
   else
    TicksArray[RunNo-1] := NoOfTicks;
  end;
 MainForm.J1Edit.Text := IntToStr(J1);
 MainForm.J2Edit.Text := IntToStr(J2);
 //Find the fastest run
 MinTicks := TicksArray[0];
 for J := 1 to NOOFRERUNS-1 do
  begin
   if (TicksArray[J] < MinTicks) then;
    MinTicks := TicksArray[J];
  end;
 RunTimeSec := MinTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

function TMainForm.SubBenchmark3 : Cardinal;
var
 J, J1, J2 : Integer;
 I1, I2, I3, NoOfRuns, RunNo : Cardinal;
 TicksArray : array of Int64;
 Str1, Str2 : PChar;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinTicks : Int64;
 RunTimeSec : Double;

begin
 SetLength(TicksArray, NOOFRERUNS);
 J1 := 0;
 J2 := 0;
 for RunNo := 1 to NOOFRERUNS do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for NoOfRuns := 1 to MAXNOOFRUNS do
    begin
     for I1 := 1 to SUBBENCH3STRARRAYSIZE-1 do
      begin
        Str1 := PChar(SubBench3StringArray[I1]);
        for I2 := 1 to SUBBENCH3STRARRAYSIZE-1 do
         begin
          Str2 := PChar(SubBench3StringArray[I2]);
          I3 := 1;
          J1 := StrLCompFunction(Str1, Str2, I3);
          J2 := StrLCompFunction(Str2, Str1, I3);
          I3 := 10;
          StrLCompFunction(Str1, Str2, I3);
          StrLCompFunction(Str2, Str1, I3);
          I3 := 100;
          StrLCompFunction(Str1, Str2, I3);
          StrLCompFunction(Str2, Str1, I3);
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
    raise Exception.Create('Tick counter wrapped around')
   else
    TicksArray[RunNo-1] := NoOfTicks;
  end;
 MainForm.J1Edit.Text := IntToStr(J1);
 MainForm.J2Edit.Text := IntToStr(J2);
 //Find the fastest run
 MinTicks := TicksArray[0];
 for J := 1 to NOOFRERUNS-1 do
  begin
   if (TicksArray[J] < MinTicks) then;
    MinTicks := TicksArray[J];
  end;
 RunTimeSec := MinTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH3SCALE);
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
  FunctionAddress := Cardinal(@StrLCompFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if Validate1 and Validate2 and Validate3 and Validate4 and Validate5 and
     Validate6 and Validate7 and Validate8 and Validate9 and Validate10 and
     Validate11 and Validate12 and Validate13 and Validate14 and Validate15 then
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
 FunctionAddress, SubBench1, SubBench2, SubBench3, Bench : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@StrLCompFunction);
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
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount :=5;
 ReportRichEdit.Paragraph.Tab[0] := 100;
 ReportRichEdit.Paragraph.Tab[1] := 120;
 ReportRichEdit.Paragraph.Tab[2] := 150;
 ReportRichEdit.Paragraph.Tab[3] := 180;
 ReportRichEdit.Paragraph.Tab[4] := 220;
 FunctionSelectionRadioGroupClick(nil);
 if not QueryPerformanceFrequency(lpFrequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(SubBench1StringArray, SUBBENCH1STRARRAYSIZE);
 SetLength(SubBench2StringArray, SUBBENCH2STRARRAYSIZE);
 SetLength(SubBench3StringArray, SUBBENCH3STRARRAYSIZE);
 //Create some test strings
 SubBench1StringArray[0] := '';
 SubBench1StringArray[1] := 'S';
 SubBench1StringArray[2] := 'XY';
 SubBench1StringArray[3] := 'ABC';
 SubBench1StringArray[4] := 'DEFG';
 SubBench1StringArray[5] := 'DEFGH';
 SubBench1StringArray[6] := 'ADEFGH';
 SubBench1StringArray[7] := 'ADEFGHI';
 SubBench1StringArray[8] := 'SWERfghy';
 SubBench1StringArray[9] := 'aqwedfgykj';
 SubBench1StringArray[10] := 'aqwedhhdsfj';
 SubBench1StringArray[11] := 'dddddddddddd';
 SubBench1StringArray[12] := 'dddddddddddda';
 SubBench1StringArray[13] := 'DDDDDDDDDDDDyy';
 SubBench1StringArray[14] := 'xDDDDDDDDDDDDjk';
 SubBench1StringArray[15] := '123456789asdfgwe';
 SubBench1StringArray[16] := '123456789asdfgert';
 SubBench1StringArray[17] := '123456789asdfguiop';
 SubBench1StringArray[18] := '12345678awsdfhjWERT';
 SubBench1StringArray[19] := 'abcdefghijdrtyuiPOIY';
 SubBench1StringArray[20] := 'ABCDEFGHIJQWERTY,.-¨+0';
 SubBench1StringArray[21] := 'ABCDEFjGHIJQWERTY,.-¨+0';
 SubBench1StringArray[22] := 'ABCDEFjGHiIJQWERTY,.-¨+0';
 SubBench1StringArray[23] := 'ABCDEFjGHiIJQWERTY,.-¨+0u';
 SubBench1StringArray[24] := 'AhBCDEFjGHiIJQWERTY,.-¨+0u';
 SubBench1StringArray[25] := 'aAaAaAaAaAaAaAaAaAaAaAaAaAa';
 SubBench1StringArray[26] := 'AaAaAaAaAaAaAaAaAaAaAaAaAaA';
 SubBench1StringArray[27] := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAA';
 SubBench1StringArray[28] := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa';
 SubBench1StringArray[29] := 'abcdefghijklmnopqrstuvxyz1234';
 SubBench1StringArray[30] := 'ABCDEFGHIJKLMNOPQRSTUVXYZ1234';
 SubBench1StringArray[31] := 'pokijuhytgfredswqazxbghuithdlm';
 SubBench1StringArray[32] := 'DERTFGYUIOPLKJHGFRDEWSQAZXCVFF';
 SubBench1StringArray[33] := 'qWsedRtfGGyuHjikNbvGt567Cde"#)(';
 SubBench1StringArray[34] := 'SWErff677))0+08751§qawrvnmd.-*¨,';
 SubBench1StringArray[35] := 'hdw3r6fkjg-.eoa8u633szwq1edcvythb';
 SubBench1StringArray[36] := 'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
 SubBench1StringArray[37] := 'ssssssssssssssssssssssssssssssssss';
 SubBench1StringArray[38] := 'SsSssSsSSsSsSsSsSsSsSsSsSsSsSsssSs';
 SubBench1StringArray[39] := 'sSsssssSssssSSSSSssSSssSssSSssssSs';
 SubBench1StringArray[40] := 'UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU';
 SubBench1StringArray[41] := 'UuUUuUuuUUuuUUuuUuuuuUUUuuuuUUUUuu';
 SubBench1StringArray[42] := 'UUUUUUUUUUUUUUUUUUytyrewqsdrrggghy';
 SubBench1StringArray[43] := 'POKIJuhytGFredsswqaZXcvbnMjL,.-_:;¨^';
 SubBench1StringArray[44] := 'gffseqgjsgdjbdjwgbdhgwqnfburefbjhgrhb';
 SubBench1StringArray[45] := 'htytfgqfetqyjhcbwjgerbfwebrhwbnbvskheh';
 SubBench1StringArray[46] := 'hhyrtyrndsbfjshfgiwlhjuhfygrtfdrqedaswp';
 SubBench1StringArray[47] := 'aqswdefrgthyjukilopMNBVCXZASQWEDRFGTHYUKOP';
 SubBench1StringArray[48] := 'drtGHYUJikloP!"#456778890?=)(/&%¤##""!vdfgrtyw';
 SubBench1StringArray[49] := 'QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ';
 SubBench1StringArray[50] := 'jhkgytd4527250c2.z-fmhcfu3t48nmzbducerdfsfsfsf24yenxznbcxms';
 SubBench1StringArray[51] := 'aqwe45tgbhuikhtrewsddwwww22335679´´¨''--.,mæølookjyffgfewqqazxsweed';
 SubBench1StringArray[52] := 'hytrewqasxxcvbhggyujjnmkiljgffdccdssggfdd';
 SubBench1StringArray[53] := 'iqwertyuiopasdfghjklzxvbnm098643211½szvcvt,løpoytedfbn';
 SubBench1StringArray[54] := 'hfhfhfhfhfhfhfhfhfhfhfhfhfhfhfhfhfhfhfhfhfhfhfhfh';
 SubBench1StringArray[55] := 'jdgdhftrgfhsduwjfhftythgjdkdiwjsgfuyejjhfgehfydvchfghvgfggvghfjhvcghfjhfhgdghdhd';
 SubBench1StringArray[56] := 'gdgdfrefsgsgsgd';
 SubBench1StringArray[57] := 'eqrwtetyrurtuhohpjhlhkfhdfgascz<vxbcnbv,mn,.x--¨+´0916354DWQERF';
 SubBench1StringArray[58] := 'VFGFREQQasdgHKKPPOiuuyDDDSwwwwDXdxssddxXXsssxXXXsssxxSSSSSSxxxxsssXXXssx';
 SubBench1StringArray[59] := 'jhwieruweryuwi21645yqwgdkjabgdzmrjhe72jsahdaw';
 SubBench1StringArray[60] := 'fafsgdshfdhfjgkjg';
 SubBench1StringArray[61] := 'jhutorlfjshwetegdghd';
 SubBench1StringArray[62] := 'okeriue84356hfbcnzt621h3vhfR##DG';
 SubBench1StringArray[63] := 'GD#"!#EFGVJT%fgdu2364trvjFD#¤!"DHH';
 SubBench1StringArray[64] := 'hdsg';
 SubBench1StringArray[65] := 'sd';
 SubBench1StringArray[66] := 'sd';
 SubBench1StringArray[67] := 'rtyu';
 SubBench1StringArray[68] := 'asfdsa';
 SubBench1StringArray[69] := 'asdadadaadf';
 SubBench1StringArray[70] := 'XXXXXXXXXXXXX';
 SubBench1StringArray[71] := 'XXXXXXXXXXXXXXXX';
 SubBench1StringArray[72] := 'XXXXXXXXXXXXXXXXXXXXX';
 SubBench1StringArray[73] := 'XXXXXXXXXXXXXXXXXXXXXXXX';
 SubBench1StringArray[74] := 'xxxxxxxxxxxxxxxxxxxxxxxxxx';
 SubBench1StringArray[75] := 'ccccccccccccccccc';
 SubBench1StringArray[76] := 'jrhushrfjshdjs';
 SubBench1StringArray[77] := 'hdsfhhdfhhd';
 SubBench1StringArray[78] := 'wsdqjh32';
 SubBench1StringArray[79] := 'sadastuo';
 //Create some test strings
 SubBench3StringArray[0] := 'Christensen Dennis';
 SubBench3StringArray[1] := 'Jensen Mariann';
 SubBench3StringArray[2] := 'Gobel Bent';
 SubBench3StringArray[3] := 'Kjær Jesper';
 SubBench3StringArray[4] := 'Jensen Erik';
 SubBench3StringArray[5] := 'Hansen Hans';
 SubBench3StringArray[6] := 'Andersen Else';
 SubBench3StringArray[7] := 'Andersen Svend Erik';
 SubBench3StringArray[8] := 'Thorpe Danny';
 SubBench3StringArray[9] := 'Gates Bill';
 SubBench3StringArray[10] := 'Nielsen Dorte';
 SubBench3StringArray[11] := 'Mathisen Polle';
 SubBench3StringArray[12] := 'Olsen Ole';
 SubBench3StringArray[13] := 'Madsen Arne';
 SubBench3StringArray[14] := 'Christensen Tommy';
 SubBench3StringArray[15] := 'Otto Steffen';
 SubBench3StringArray[16] := 'Jensen Niels Kjell';
 SubBench3StringArray[17] := 'Hansen Erna';
 SubBench3StringArray[18] := 'Rasmussen Susanne';
 SubBench3StringArray[19] := 'Ytting Hans';
 SubBench3StringArray[20] := 'Hyttel Mie';
 SubBench3StringArray[21] := 'Olsen Thomas';
 SubBench3StringArray[22] := 'Bager Dennis';
 SubBench3StringArray[23] := 'Lee Robert';
 SubBench3StringArray[24] := 'Woods Tiger';
 SubBench3StringArray[25] := 'Spodsberg Soren';
 SubBench3StringArray[26] := 'Downs Dan';
 SubBench3StringArray[27] := 'Larsen Kirsten';
 SubBench3StringArray[28] := 'Fugl Mette';
 SubBench3StringArray[29] := 'Eriksen Tom';
 SubBench3StringArray[30] := 'Larsen Diana';
 SubBench3StringArray[31] := 'Hansen Mary';
 SubBench3StringArray[32] := 'Frederik';
 SubBench3StringArray[33] := 'Jensen Camilla';
 SubBench3StringArray[34] := 'Jensen Erik';
 SubBench3StringArray[35] := 'Hansen Hans Peter';
 SubBench3StringArray[36] := 'Fisker Poul';
 SubBench3StringArray[37] := 'Andersen Svend Erik';
 SubBench3StringArray[38] := 'Petersen Henrik';
 SubBench3StringArray[39] := 'Petersen Jannie';
 SubBench3StringArray[40] := 'Hansen Bente';
 SubBench3StringArray[41] := 'Jester Anette';
 SubBench3StringArray[42] := 'Philip Kim';
 SubBench3StringArray[43] := 'Jensen Niels';
 SubBench3StringArray[44] := 'Sampras Pete';
 SubBench3StringArray[45] := 'Larsen Mads';
 SubBench3StringArray[46] := 'Ottke Svend';
 SubBench3StringArray[47] := 'Schumacher Ralph';
 SubBench3StringArray[48] := 'Kiesa Nikolas';
 SubBench3StringArray[49] := 'Riis Bjarne';
 SubBench3StringArray[50] := 'Selma Lagerlof';
 SubBench3StringArray[51] := 'Clemens Kappel';
 SubBench3StringArray[52] := 'Franz Kafka';
 SubBench3StringArray[53] := 'Ernest Hemingway';
 SubBench3StringArray[54] := 'Sigrid Undset';
 SubBench3StringArray[55] := 'John Hansen';
 SubBench3StringArray[56] := 'Howard Dean';
 SubBench3StringArray[57] := 'Steen Steensen Blicher';
 SubBench3StringArray[58] := 'Kjeld Mathiesen';
 SubBench3StringArray[59] := 'Keld Hatting';
 SubBench3StringArray[60] := 'Lauritzen Dennis';
 SubBench3StringArray[61] := 'Lauritzen Rikke';
 SubBench3StringArray[62] := 'Lauritzen Mikkel';
 SubBench3StringArray[63] := 'Lauritzen Bent';
 SubBench3StringArray[64] := 'Bang og Olufsen';
 SubBench3StringArray[65] := 'Citroen ZX';
 SubBench3StringArray[66] := 'Mercedes Mclaren';
 SubBench3StringArray[67] := 'Enzo Ferrari';
 SubBench3StringArray[68] := 'Lotus Elise';
 SubBench3StringArray[69] := 'Borhnsen Marina';
 SubBench3StringArray[70] := 'Collaitz Britta';
 SubBench3StringArray[71] := 'Will de Witt';
 SubBench3StringArray[72] := 'Myleus Jorgen';
 SubBench3StringArray[73] := 'Boks Tom';
 SubBench3StringArray[74] := 'Rask Mikael';
 SubBench3StringArray[75] := 'Kessler Mikkel';
 SubBench3StringArray[76] := 'Larsen Mads';
 SubBench3StringArray[77] := 'Mikkelborg Palle';
 SubBench3StringArray[78] := 'Margrethe Dronning';
 SubBench3StringArray[79] := 'Frederik Kronprins';

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
    1 : StrLCompFunction := StrLComp_RTL_a;
    2 : StrLCompFunction := StrLComp_RTL_b;
    3 : StrLCompFunction := StrLComp_RTL_c;
    4 : StrLCompFunction := StrLComp_RTL_d;
    5 : StrLCompFunction := StrLComp_JOH_PAS_1_a;
    6 : StrLCompFunction := StrLComp_JOH_PAS_1_b;
    7 : StrLCompFunction := StrLComp_JOH_PAS_1_c;
    8 : StrLCompFunction := StrLComp_JOH_PAS_1_d;
    9 : StrLCompFunction := StrLComp_JOH_IA32_1_a;
   10 : StrLCompFunction := StrLComp_JOH_IA32_1_b;
   11 : StrLCompFunction := StrLComp_JOH_IA32_1_c;
   12 : StrLCompFunction := StrLComp_JOH_IA32_1_d;
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
 for I := 4 to FunctionSelectionRadioGroup.Items.Count-1 do
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
 ReportRichEdit.Print('StrLComp Report');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 //for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I1 := 0 to 4 do
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
   FunctionAddress := Cardinal(@StrLCompFunction);
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
   if CharPos('_', S1) <> 0 then
    FunctionName1 := Copy(S1, 1, TabPos1-3)
   else
    FunctionName1 := Copy(S1, 1, TabPos1-1);
   FunctionAlignString1 := Copy(S1, TabPos1+1, 1);
   L := 1;
   AlignStringArray[L] := FunctionAlignString1;
   for K := J+1 to ReportRichEdit.Lines.Count do
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
       end;
     end;
  end;
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
