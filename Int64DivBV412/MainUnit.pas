unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'Int64Div';

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
    SpreadTestButton: TButton;
    CleanResultsButton: TButton;
    ZEdit: TEdit;
    Get8087CWEdit: TEdit;
    Set8087PrecisionRadioGroup: TRadioGroup;
    Label7: TLabel;
    ProgressBar1: TProgressBar;
    AboutSpeedButton: TSpeedButton;
    AlignCheckEdit: TEdit;
    AlignCheckButton: TButton;
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
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
    procedure Set8087PrecisionRadioGroupClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure AlignCheckButtonClick(Sender: TObject);
    procedure AlignmentTest;
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    NoOfTicksArray : array of Int64;
    lpFrequency : Int64;
    procedure ClearAllEditBoxes;
    function Validate1 : Boolean;
    function Validate2 : Boolean;
    function Validate3 : Boolean;
    function Validate4 : Boolean;
    function Validate5 : Boolean;
    function Validate6 : Boolean;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    function SubBenchmark1 : Cardinal;
    function SubBenchmark2 : Cardinal;
    function SubBenchmark3 : Cardinal;
    function SubBenchmark4 : Cardinal;
    function SubBenchmark1RTL : Cardinal;
    function SubBenchmark2RTL : Cardinal;
    function SubBenchmark3RTL : Cardinal;
    function SubBenchmark4RTL : Cardinal;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
 MainForm: TMainForm;

implementation

uses
 Int64DivRTLUnit, FastcodeCPUID, SystemInfoUnit, Int64DivDKCUnit, Int64DivAMDUnit,
 Math, Int64DivJOHUnit, Int64DivAnalysisUnit, AboutUnit;

{$R *.dfm}

const
 SUBBENCH1SCALE : Double = 300;
 SUBBENCH2SCALE : Double = 300;
 SUBBENCH3SCALE : Double = 300;
 SUBBENCH4SCALE : Double = 300;
 NOOFRERUNS : Cardinal = 3;
 MAXINT64 : Int64 = $7FFFFFFFFFFFFFFF;
 VALIDATE3YSTEPSIZE : Int64 = 97010203;
 VALIDATE3XSTEPSIZE : Int64 = 97003003;
 VALIDATE4YSTEPSIZE : Int64 = 970007000803;
 VALIDATE4XSTEPSIZE : Int64 = 970050000703;
 VALIDATE5XSTEPSIZE : Int64 = 9701000040003;
 VALIDATE5YSTEPSIZE : Int64 = 2;
 VALIDATE6MIN : Int64 = $7FFFFFFFFFFDFFFF;
 SUBBENCH1XMIN : Int64 = Low(Int64)+1;//Benchmark calls abs on X and will fail with X = Low(Int64)
 SUBBENCH1XMAX : Int64 = High(Int64);
 SUBBENCH1YMAX : Int64 = High(Int64);
 SUBBENCH1XSTEPSIZE : Int64 = 2100000000000000;
 SUBBENCH1YSTEPSIZE : Int64 = 2100000000000000;
 SUBBENCH2XMIN : Int64 = Low(Integer);
 SUBBENCH2XMAX : Int64 = High(Integer);
 SUBBENCH2YMIN : Int64 = Low(Integer);
 SUBBENCH2YMAX : Int64 = High(Integer);
 SUBBENCH2XSTEPSIZE : Int64 = 180000;
 SUBBENCH2YSTEPSIZE : Int64 = 180000;
 SUBBENCH3XMIN : Int64 = Low(Int64);
 SUBBENCH3XMAX : Int64 = High(Int64);
 SUBBENCH3YMIN : Int64 = Low(Integer);
 SUBBENCH3YMAX : Int64 = High(Integer);
 SUBBENCH3XSTEPSIZE : Int64 = 170000000000000;
 SUBBENCH3YSTEPSIZE : Int64 = 10000000;
 SUBBENCH4XMIN : Int64 = Low(Integer);
 SUBBENCH4XMAX : Int64 = High(Integer);
 SUBBENCH4YMIN : Int64 = Low(Int64);
 SUBBENCH4YMAX : Int64 = High(Int64);
 SUBBENCH4XSTEPSIZE : Int64 = 11000000;
 SUBBENCH4YSTEPSIZE : Int64 = 580000000000000;

type
 TInt64DivFunction = function (var X, Y : Int64): Int64;

var
 Int64DivFunction : TInt64DivFunction;
 X1, Y1, Z1 : Int64;

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
 Bench1Edit.Text := '';
 Bench2Edit.Text := '';
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

function TMainForm.Validate1 : Boolean;
var
 X, Y, Z : Int64;

begin
 Result := True;
 X := -10;
 Y := -5;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 2 then
  begin
   Result := False;
   Exit;
  end;
 X := -10;
 Y := 5;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> -2 then
  begin
   Result := False;
   Exit;
  end;
 X := 10;
 Y := -5;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> -2 then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Y := -5;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 0 then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Y := -1;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 1 then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Y := 1;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 1 then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Y := MAXINT64;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 0 then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Y := MAXINT64;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 0 then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Y := Low(Int64);
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 0 then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Y := Low(Int64);
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 0 then
  begin
   Result := False;
   Exit;
  end;
 X := Low(Int64);
 Y := Low(Int64);
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 1 then
  begin
   Result := False;
   Exit;
  end;
 X := 3;
 Y := 5;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> 0 then
  begin
   Result := False;
   Exit;
  end;
 X := MAXINT64;
 Y := 1;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> MAXINT64 then
  begin
   Result := False;
   Exit;
  end;
 X := MAXINT64;
 Y := -1;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 if Z <> -MAXINT64 then
  begin
   Result := False;
  end;
end;

function TMainForm.Validate2 : Boolean;
var
 X, Y, Z, Zref : Int64;

begin
 X := 2;
 Y := MAXINT;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X div Y
 else
  Z := Int64DivFunction(X, Y);
 Zref := X div Y;
 if Z = Zref then
  Result := True
 else
  Result := False;
end;

function TMainForm.Validate3 : Boolean;
var
 X, Y, Z1, Z2 : Int64;

begin
 Result := True;
 X := -MAXINT;
 while X <= MAXINT do
  begin
   Y := -MAXINT;
   while Y <= MAXINT do
    begin
     Z1 := X div Y;
     if FunctionSelectionRadioGroup.ItemIndex = 0 then
      Z2 := X div Y
     else
      Z2 := Int64DivFunction(X, Y);
     if Z1 <> Z2 then
      begin
       Result := False;
       Break;
      end;
     Inc(Y, VALIDATE3YSTEPSIZE);
    end;
   Inc(X, VALIDATE3XSTEPSIZE);
  end;
end;

function TMainForm.Validate4 : Boolean;
var
 X, Y, Z1, Z2, Ymin, Ymax : Int64;

begin
 Result := True;
 X := MAXINT64;
 while X >= MAXINT do
  begin
   Ymin := 1;
   Ymax := Round(MAXINT64/X);
   Y := Ymin;
   while Y <= Ymax do
    begin
     Z1 := X div Y;
     if FunctionSelectionRadioGroup.ItemIndex = 0 then
      Z2 := X div Y
     else
      Z2 := Int64DivFunction(X, Y);
     if Z1 <> Z2 then
      begin
       Result := False;
       Break;
      end;
     Inc(Y, VALIDATE4YSTEPSIZE);
    end;
   Dec(X, VALIDATE4XSTEPSIZE);
  end;
end;

function TMainForm.Validate5 : Boolean;
var
 X, Y, Z1, Z2, Ymin, Ymax : Int64;

begin
 Result := True;
 X := MAXINT64;
 while X >= MAXINT do
  begin
   Ymin := -Trunc(MAXINT64/X);
   Ymax := -1;
   Y := Ymin;
   while Y <= Ymax do
    begin
     Z1 := X div Y;
     if FunctionSelectionRadioGroup.ItemIndex = 0 then
      Z2 := X div Y
     else
      Z2 := Int64DivFunction(X, Y);
     if Z1 <> Z2 then
      begin
       Result := False;
       Break;
      end;
     Inc(Y, VALIDATE5YSTEPSIZE);
    end;
   Dec(X, VALIDATE5XSTEPSIZE);
  end;
end;

//Complete validation of the upper range [VALIDATE6MIN, MAXINT64]

function TMainForm.Validate6 : Boolean;
var
 X, Y, Z1, Z2 : Int64;
const
 PROGRESSBARSCALE : Int64 = Int64(MAXINT) * 10;

begin
 ProgressBar1.Min := 0;
 ProgressBar1.Max := MAXINT64 - VALIDATE6MIN;
 Result := True;
 X := MAXINT64;
 while X > VALIDATE6MIN do
  begin
   ProgressBar1.Position := MAXINT64 - X;
   Update;
   Y := MAXINT64;
   while Y > VALIDATE6MIN do
    begin
     Z1 := X div Y;
     if FunctionSelectionRadioGroup.ItemIndex = 0 then
      Z2 := X div Y
     else
      Z2 := Int64DivFunction(X, Y);
     if Z1 <> Z2 then
      begin
       Result := False;
       Break;
      end;
     Dec(Y);
    end;
   Dec(X);
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
  FunctionAddress := Cardinal(@Int64DivFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if Validate1 and
     Validate2 and
     Validate3 and
     Validate4 and
     Validate5 and
     Validate6 then
   begin
    ValidationEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Passed');
   end
  else
   begin
    ValidationEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed');
   end;
  ValidateButton.Caption := 'Validate';
 except
  ValidateButton.Caption := 'Validate';
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 FunctionAddress, Bench, SubBench1, SubBench2, SubBench3, SubBench4 : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;
 FunctionAddressChar : Char;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@Int64DivFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  FunctionAddressChar := FunctionAddressString[8];
  BenchmarkButton.Caption := 'Running';
  if FunctionSelectionRadioGroup.ItemIndex = 0 then
   begin
    SubBench1 := SubBenchmark1RTL;
    SubBench2 := SubBenchmark2RTL;
    SubBench3 := SubBenchmark3RTL;
    SubBench4 := SubBenchmark4RTL;
    Bench := SubBench1 + SubBench2 + SubBench3 + SubBench4;
   end
  else
   begin
    SubBench1 := SubBenchmark1;
    SubBench2 := SubBenchmark2;
    SubBench3 := SubBenchmark3;
    SubBench4 := SubBenchmark4;
    Bench := SubBench1 + SubBench2 + SubBench3 + SubBench4;
   end;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressChar
                           + #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(SubBench2)
                           + #9 + IntToStr(SubBench3)
                           + #9 + IntToStr(SubBench4)
                           + #9 + IntToStr(Bench));
  SortRichEdit;
  BenchmarkTest;
  AlignmentTest;
  BenchmarkButton.Caption := 'Benchmark';
 except
  FunctionAddress := Cardinal(@Int64DivFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  FunctionAddressChar := FunctionAddressString[8];
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressChar
                                        + #9 + '9999' + #9 + '9999'
                                        + #9 + '9999'+ #9 + '9999'
                                        + #9 + 'Failed');
 end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var
 I1, I4 : Cardinal;
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
   X1 := SUBBENCH1XMIN;
   while X1 <= SUBBENCH1XMAX-SUBBENCH1XSTEPSIZE do
    begin
     Y1 := X1;
     while Y1 <= SUBBENCH1YMAX-SUBBENCH1YSTEPSIZE do
      begin
       if (Y1 <> 0) and (Abs(X1) > Abs(Y1)) then
        Z1 := Int64DivFunction(X1, Y1);
       Inc(Y1, SUBBENCH1YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH1XSTEPSIZE);
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
 ZEdit.Text := IntToStr(Z1);
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
 I1, I4 : Cardinal;
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
   //X and Y positive
   Y1 := 1;
   while Y1 <= SUBBENCH2YMAX-SUBBENCH2YSTEPSIZE do
    begin
     X1 := Y1;
     while X1 <= SUBBENCH2XMAX-SUBBENCH2XSTEPSIZE do
      begin
       Z1 := Int64DivFunction(X1, Y1);
       Inc(X1, SUBBENCH2XSTEPSIZE);
      end;
     Inc(Y1, SUBBENCH2YSTEPSIZE);
    end;
   //X and Y negative
   X1 := SUBBENCH2XMIN;
   while X1 <= 0 do
    begin
     Y1 := X1;
     while Y1 <= -1 do
      begin
       Z1 := Int64DivFunction(X1, Y1);
       Inc(Y1, SUBBENCH2YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH2XSTEPSIZE);
    end;
   //X positive and Y negative
   X1 := 1;
   while X1 <= SUBBENCH2YMAX-SUBBENCH2YSTEPSIZE do
    begin
     Y1 := -X1;
     while Y1 <= -1 do
      begin
       Z1 := Int64DivFunction(X1, Y1);
       Inc(Y1, SUBBENCH2YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH2XSTEPSIZE);
    end;
   //X negative and Y positive
   X1 := SUBBENCH2XMIN;
   while X1 <= SUBBENCH2XMAX-SUBBENCH2XSTEPSIZE do
    begin
     Y1 := -X1;
     while Y1 <= -1 do
      begin
       Z1 := Int64DivFunction(X1, Y1);
       Inc(Y1, SUBBENCH2XSTEPSIZE);
      end;
     Inc(X1, SUBBENCH2YSTEPSIZE);
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
 ZEdit.Text := IntToStr(Z1);
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

function TMainForm.SubBenchmark3 : Cardinal;
var
 I1, I4 : Cardinal;
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
   X1 := SUBBENCH3XMIN;
   while X1 <= SUBBENCH3XMAX-SUBBENCH3XSTEPSIZE do
    begin
     Y1 := SUBBENCH3YMIN;
     while Y1 <= SUBBENCH3YMAX-SUBBENCH3YSTEPSIZE do
      begin
       if Y1 <> 0 then
        Z1 := Int64DivFunction(X1, Y1);
       Inc(Y1, SUBBENCH3YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH3XSTEPSIZE);
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
 ZEdit.Text := IntToStr(Z1);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH3SCALE);
end;

function TMainForm.SubBenchmark4 : Cardinal;
var
 I1, I4 : Cardinal;
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
   X1 := SUBBENCH4XMIN;
   while X1 <= SUBBENCH4XMAX-SUBBENCH4XSTEPSIZE do
    begin
     Y1 := SUBBENCH4YMIN;
     while Y1 <= SUBBENCH4YMAX-SUBBENCH4YSTEPSIZE do
      begin
       if Y1 <> 0 then
        Z1 := Int64DivFunction(X1, Y1);
       Inc(Y1, SUBBENCH4YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH4XSTEPSIZE);
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
 ZEdit.Text := IntToStr(Z1);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH4SCALE);
end;

function TMainForm.SubBenchmark1RTL : Cardinal;
var
 I1, I4 : Cardinal;
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
   X1 := SUBBENCH1XMIN;
   while X1 <= SUBBENCH1XMAX-SUBBENCH1XSTEPSIZE do
    begin
     Y1 := X1;
     while Y1 <= SUBBENCH1YMAX-SUBBENCH1YSTEPSIZE do
      begin
       if (Y1 <> 0) and (Abs(X1) > Abs(Y1)) then
        Z1 := X1 div Y1;
       Inc(Y1, SUBBENCH1YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH1XSTEPSIZE);
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
 ZEdit.Text := IntToStr(Z1);
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

function TMainForm.SubBenchmark2RTL : Cardinal;
var
 I1, I4 : Cardinal;
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
   //X and Y positive
   Y1 := 1;
   while Y1 <= SUBBENCH2YMAX-SUBBENCH2YSTEPSIZE do
    begin
     X1 := Y1;
     while X1 <= SUBBENCH2XMAX-SUBBENCH2XSTEPSIZE do
      begin
       Z1 := X1 div Y1;
       Inc(X1, SUBBENCH2XSTEPSIZE);
      end;
     Inc(Y1, SUBBENCH2YSTEPSIZE);
    end;
   //X and Y negative
   X1 := SUBBENCH2XMIN;
   while X1 <= 0 do
    begin
     Y1 := X1;
     while Y1 <= -1 do
      begin
       Z1 := X1 div Y1;
       Inc(Y1, SUBBENCH2YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH2XSTEPSIZE);
    end;
   //X positive and Y negative
   X1 := 1;
   while X1 <= SUBBENCH2YMAX-SUBBENCH2YSTEPSIZE do
    begin
     Y1 := -X1;
     while Y1 <= -1 do
      begin
       Z1 := X1 div Y1;
       Inc(Y1, SUBBENCH2YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH2XSTEPSIZE);
    end;
   //X negative and Y positive
   X1 := SUBBENCH2XMIN;
   while X1 <= SUBBENCH2XMAX-SUBBENCH2XSTEPSIZE do
    begin
     Y1 := -X1;
     while Y1 <= -1 do
      begin
       Z1 := X1 div Y1;
       Inc(Y1, SUBBENCH2XSTEPSIZE);
      end;
     Inc(X1, SUBBENCH2YSTEPSIZE);
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
 ZEdit.Text := IntToStr(Z1);
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

function TMainForm.SubBenchmark3RTL : Cardinal;
var
 I1, I4 : Cardinal;
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
   X1 := SUBBENCH3XMIN;
   while X1 <= SUBBENCH3XMAX-SUBBENCH3XSTEPSIZE do
    begin
     Y1 := SUBBENCH3YMIN;
     while Y1 <= SUBBENCH3YMAX-SUBBENCH3YSTEPSIZE do
      begin
       if Y1 <> 0 then
        Z1 := X1 div Y1;
       Inc(Y1, SUBBENCH3YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH3XSTEPSIZE);
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
 ZEdit.Text := IntToStr(Z1);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH3SCALE);
end;

function TMainForm.SubBenchmark4RTL : Cardinal;
var
 I1, I4 : Cardinal;
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
   X1 := SUBBENCH4XMIN;
   while X1 <= SUBBENCH4XMAX-SUBBENCH4XSTEPSIZE do
    begin
     Y1 := SUBBENCH4YMIN;
     while Y1 <= SUBBENCH4YMAX-SUBBENCH4YSTEPSIZE do
      begin
       if Y1 <> 0 then
        Z1 := X1 div Y1;
       Inc(Y1, SUBBENCH4YSTEPSIZE);
      end;
     Inc(X1, SUBBENCH4XSTEPSIZE);
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
 ZEdit.Text := IntToStr(Z1);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH4SCALE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 Succes : Boolean;
 CpuString : string;
begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 //Int64DivFunction := Int64Div_RTL_IA32_2;
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 5;
 ReportRichEdit.Paragraph.Tab[0] := 110;
 ReportRichEdit.Paragraph.Tab[1] := 130;
 ReportRichEdit.Paragraph.Tab[2] := 160;
 ReportRichEdit.Paragraph.Tab[3] := 190;
 ReportRichEdit.Paragraph.Tab[4] := 220;
 ReportRichEdit.Paragraph.Tab[5] := 260;
 FunctionSelectionRadioGroupClick(nil);
 Get8087CWEdit.Text := IntToStr(Get8087CW);
 SetLength(NoOfTicksArray, NOOFRERUNS);
 Set8087PrecisionRadioGroupClick(nil);

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
  1 : ;
  2 : Int64DivFunction := Int64Div_RTL_IA32_2_a;
  3 : Int64DivFunction := Int64Div_RTL_IA32_2_b;
  4 : Int64DivFunction := Int64Div_RTL_IA32_2_c;
  5 : Int64DivFunction := Int64Div_RTL_IA32_2_d;
  6 : Int64DivFunction := Int64Div_AMD_IA32_1_a;
  7 : Int64DivFunction := Int64Div_AMD_IA32_1_b;
  8 : Int64DivFunction := Int64Div_AMD_IA32_1_c;
  9 : Int64DivFunction := Int64Div_AMD_IA32_1_d;
  10 : Int64DivFunction := Int64Div_DKC_IA32_2_a;
  11 : Int64DivFunction := Int64Div_DKC_IA32_2_b;
  12 : Int64DivFunction := Int64Div_DKC_IA32_2_c;
  13 : Int64DivFunction := Int64Div_DKC_IA32_2_d;
  14 : Int64DivFunction := Int64Div_DKC_IA32ext_2_a;
  15 : Int64DivFunction := Int64Div_DKC_IA32ext_2_b;
  16 : Int64DivFunction := Int64Div_DKC_IA32ext_2_c;
  17 : Int64DivFunction := Int64Div_DKC_IA32ext_2_d;
  18 : Int64DivFunction := Int64Div_JOH_IA32_1_a;
  19 : Int64DivFunction := Int64Div_JOH_IA32_1_b;
  20 : Int64DivFunction := Int64Div_JOH_IA32_1_c;
  21 : Int64DivFunction := Int64Div_JOH_IA32_1_d;
  22 : Int64DivFunction := Int64Div_JOH_IA32_2_a;
  23 : Int64DivFunction := Int64Div_JOH_IA32_2_b;
  24 : Int64DivFunction := Int64Div_JOH_IA32_2_c;
  25 : Int64DivFunction := Int64Div_JOH_IA32_2_d;
  26 : Int64DivFunction := Int64Div_JOH_IA32_3_a;
  27 : Int64DivFunction := Int64Div_JOH_IA32_3_b;
  28 : Int64DivFunction := Int64Div_JOH_IA32_3_c;
  29 : Int64DivFunction := Int64Div_JOH_IA32_3_d;
  30 : Int64DivFunction := Int64Div_JOH_IA32_4_a;
  31 : Int64DivFunction := Int64Div_JOH_IA32_4_b;
  32 : Int64DivFunction := Int64Div_JOH_IA32_4_c;
  33 : Int64DivFunction := Int64Div_JOH_IA32_4_d;
  34 : Int64DivFunction := Int64Div_JOH_IA32_5_a;
  35 : Int64DivFunction := Int64Div_JOH_IA32_5_b;
  36 : Int64DivFunction := Int64Div_JOH_IA32_5_c;
  37 : Int64DivFunction := Int64Div_JOH_IA32_5_d;
  //10 : Int64DivFunction := Int64Div_Analyse;
 else
  raise Exception.Create('Invalid Function Number');
 end;
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
   FunctionAddress := Cardinal(@Int64DivFunction);
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
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_LOWEST) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_LOWEST failed');
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
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
 ReportRichEdit.Print('Int64Div Report');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
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
end;

procedure TMainForm.Set8087PrecisionRadioGroupClick(Sender: TObject);
begin
 case Set8087PrecisionRadioGroup.ItemIndex of
  0 : SetPrecisionMode(pmSingle);
  1 : SetPrecisionMode(pmDouble);
  2 : SetPrecisionMode(pmExtended);
 end;
 Get8087CWEdit.Text := IntToStr(Get8087CW); 
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
