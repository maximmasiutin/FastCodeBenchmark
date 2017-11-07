unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'RoundToEx';

type
  TMainForm = class(TForm)
    ValidateButton: TButton;
    ValidationEdit: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    ReportRichEdit: TRichEdit;
    BenchmarkButton: TButton;
    RuntimeEdit: TEdit;
    DoubleFunctionSelectionRadioGroup: TRadioGroup;
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
    ShowErrorDialogCheckBox: TCheckBox;
    Set8087PrecisionRadioGroup: TRadioGroup;
    SetRoundModeRadioGroup: TRadioGroup;
    YEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DoubleFunctionSelectionRadioGroupClick(Sender: TObject);
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
    procedure SetRoundModeRadioGroupClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure ClearAllEditBoxes;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
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
 RoundToEXDKCUnit, FastcodeCPUID, SystemInfoUnit, Math, RoundToEXRefUnit, RoundToEX_JOH;

{$R *.dfm}

const
 SUBBENCH1SCALE : Double = 800;
 SUBBENCH2SCALE : Double = 2800;
 SUBBENCH3SCALE : Double = 2900;
 SUBBENCH1ARRAYSIZE : Cardinal = 30;
 NOOFRERUNS : Cardinal = 4;
 SUBBENCH1NOOFRUNS : Cardinal = 800;
 SUBBENCH2NOOFRUNS : Cardinal = 80;
 SUBBENCH3NOOFRUNS : Cardinal = 80;
 //Limit from John Herbster
 //EXTENDEDLIMIT : Extended = 1.0842021725e-19;
 EXTENDEDLIMIT : Extended = 2.05e-19;
 VALIDATE10STEPSIZE : Extended = 1.01;
 VALIDATE11STEPSIZE : Extended = 1.01;
 VALIDATE12STEPSIZE : Extended = 1.01;
 VALIDATE13STEPSIZE : Extended = 1E-13;
 VALIDATE14STEPSIZE : Extended = 1.01;
 VALIDATE15STEPSIZE : Extended = 1.01;
 VALIDATE16STEPSIZE : Extended = 1.01;
 VALIDATE17STEPSIZE : Extended = 1.01;

type
 TRoundToEXFunction = function (const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;

var
 RoundToExFunction : TRoundToEXFunction;

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
         Bench1Edit.Text := BenchString1;
         Bench2Edit.Text := BenchString2;
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

procedure ErrorTrap(ValidateNo, Digits : Integer; X : Double);
begin
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' at X = ' + FloatToStrF(X, ffExponent, 18, 4) + ' with digits = ' + IntToStr(Digits)), 'Error');
end;

function Validate1 : Boolean;
var
 X, Y : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 1;

begin
 Result := True;
 X := 1234567;
 Digits := 3;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1235000) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := -2;
 X := 1.234;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1.23) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := -2;
 X := 1.235;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1.24) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 0;
 X := 1.5;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 2) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 0;
 X := 2.5;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 2) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := -2;
 X := 1.245;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1.24) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 1;
 X := 25;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 20) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 3;
 X := 4500;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 4000) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
end;

function Validate2 : Boolean;
var
 X, Y : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 2;

begin
 Result := True;
 Digits := 0;
 X := 1234567890;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1234567890) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 1;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1234567890) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := -1;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1234567890) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 2;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1234567900) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := -2;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1234567890) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 3;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1234568000) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := -3;
 Y := RoundToEXFunction(X, Digits);
 if Abs((Y - 1234567890) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
end;

function Validate3 : Boolean;
var
 X, Y : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 3;

begin
 Result := True;
 Digits := 0;
 X := 1.2E1;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E1) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 1;
 X := 1.23E2;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E2) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 2;
 X := 1.234E3;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E3) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 3;
 X := 1.2345E4;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E4) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 4;
 X := 1.23456E5;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E5) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 5;
 X := 1.234567E6;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E6) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 6;
 X := 1.2345678E7;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E7) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 7;
 X := 1.23456789E8;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E8) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 8;
 X := 1.234567890E9;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E9) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 9;
 X := 1.2345678901E10;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E10) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 10;
 X := 1.23456789012E11;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E11) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 11;
 X := 1.234567890123E12;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E12) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 12;
 X := 1.2345678901234E13;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E13) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 13;
 X := 1.23456789012345E14;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E14) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 14;
 X := 1.234567890123456E15;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E15) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 15;
 X := 1.2345678901234567E16;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E16) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 16;
 X := 1.23456789012345678E17;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E17) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 17;
 X := 1.23456789012345678E18;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E18) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 18;
 X := 1.23456789012345678E19;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E19) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 19;
 X := 1.23456789012345678E20;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E20) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 20;
 X := 1.23456789012345678E21;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E21) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   //Exit;
  end;
{ Digits := 21;
 X := 1.23456789012345678E22;
 Y := RoundToEXFunction(X, Digits);
 if (Abs(Y - 1.2E22) / Y) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
   Exit;
  end;
 Digits := 22;
 X := 1.23456789012345678E23;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E23) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 23;
 X := 1.23456789012345678E24;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E24) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 24;
 X := 1.23456789012345678E25;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E25) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 25;
 X := 1.23456789012345678E26;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E26) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 26;
 X := 1.23456789012345678E27;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E27) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 27;
 X := 1.23456789012345678E28;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E28) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 28;
 X := 1.23456789012345678E29;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E29) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 29;
 X := 1.23456789012345678E30;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E30) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 30;
 X := 1.23456789012345678E31;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E31) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 31;
 X := 1.23456789012345678E32;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E32) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 32;
 X := 1.23456789012345678E33;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E33) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 33;
 X := 1.23456789012345678E34;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E34) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 34;
 X := 1.23456789012345678E35;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E35) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 35;
 X := 1.23456789012345678E36;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E36) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 36;
 X := 1.23456789012345678E37;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E37) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
 Digits := 37;
 X := 1.23456789012345678E38;
 Y := RoundToEXFunction(X, Digits);
 if ((Abs(Y - 1.2E38) / Y) > EXTENDEDLIMIT) then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;}
end;

function Validate4 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 4;

begin
 Result := True;
 Digits := 0;
 X := 2160134979.3;
 Y1 := RoundToEX_Ref(X, Digits);
 Y2 := RoundToEXFunction(X, Digits);
 if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
  begin
   ErrorTrap(ValidateNo, Digits, X);
   Result := False;
  end;
end;

function Validate5 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 5;

begin
  X := 9E18;
  Digits := 0;

 try
  Result := True;
  Y1 := RoundToEX_Ref(X, Digits);
  Y2 := RoundToEXFunction(X, Digits);
  if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
   begin
    ErrorTrap(ValidateNo, Digits, X);
    Result := False;
   end;
 except
  ErrorTrap(ValidateNo, Digits, X);
  Result := False;
 end;
end;

function Validate6 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 6;

begin
 Digits := 0;
 X := 5E-324;
 try
  Result := True;
  Y1 := RoundToEX_Ref(X, Digits);
  Y2 := RoundToEXFunction(X, Digits);
  if Abs(Y1 - Y2) > EXTENDEDLIMIT then
   begin
    ErrorTrap(ValidateNo, Digits, X);
    Result := False;
   end;
 except
  ErrorTrap(ValidateNo, Digits, X);
  Result := False;
 end;
end;

function Validate7 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 7;

begin
 Digits := 1;
 X := 9.22E19;
 try
  Result := True;
  Y1 := RoundToEX_Ref(X, Digits);
  Y2 := RoundToEXFunction(X, Digits);
  if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
   begin
    ErrorTrap(ValidateNo, Digits, X);
    Result := False;
   end;
 except
  ErrorTrap(ValidateNo, Digits, X);
  Result := False;
 end;
end;

function Validate8 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 8;

begin
 Digits := -1;
 X := 9.22E17;
 try
  Result := True;
  Y1 := RoundToEX_Ref(X, Digits);
  Y2 := RoundToEXFunction(X, Digits);
  if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
   begin
    ErrorTrap(ValidateNo, Digits, X);
    Result := False;
   end;
 except
  ErrorTrap(ValidateNo, Digits, X);
  Result := False;
 end;
end;

function Validate9 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 9;

begin
 Digits := 20;
 X := 9.22E37;
 try
  Result := True;
  Y1 := RoundToEX_Ref(X, Digits);
  Y2 := RoundToEXFunction(X, Digits);
  if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
   begin
    ErrorTrap(ValidateNo, Digits, X);
    Result := False;
   end;
 except
  ErrorTrap(ValidateNo, Digits, X);
  Result := False;
 end;
end;

function Validate10 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 10;

begin
 Result := True;
 Digits := 0;
 X := 5E-32;
 while X < 1E18 do
  begin
   Y1 := RoundToEX_Ref(X, Digits);
   Y2 := RoundToEXFunction(X, Digits);
   if Y1 <> 0 then
    begin
     if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end
   else
    begin
     if Abs(Y1 - Y2) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end;
   X := X * VALIDATE10STEPSIZE;
  end;
end;

function Validate11 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 11;

begin
 Result := True;
 Digits := 1;
 X := 0.1;
 while X < 1E1 do
  begin
   Y1 := RoundToEX_Ref(X, Digits);
   Y2 := RoundToEXFunction(X, Digits);
   if Y1 <> 0 then
    begin
     if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end
   else
    begin
     if Abs(Y1 - Y2) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end;
   X := X * VALIDATE11STEPSIZE;
  end;
end;

function Validate12 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 12;

begin
 Result := True;
 Digits := -1;
 X := 1E7;
 while X < 1E9 do
  begin
   Y1 := RoundToEX_Ref(X, Digits);
   Y2 := RoundToEXFunction(X, Digits);
   if Y1 <> 0 then
    begin
     if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end
   else
    begin
     if Abs(Y1 - Y2) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end;
   X := X * VALIDATE12STEPSIZE;
  end;
end;

function Validate13 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
 CW8087 : Word;
const
 ValidateNo : Integer = 13;

begin
 Result := True;
 Digits := -2;
 X      := 1.24499999999;
 while X < 1.24500000001 do
  begin
   Y1 := RoundToEX_Ref(X, Digits);
   Y2 := RoundToEXFunction(X, Digits);
   if Y1 <> 0 then
    begin
     if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end
   else
    begin
     if Abs(Y1 - Y2) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end;
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   X := X + VALIDATE13STEPSIZE;
   Set8087CW(CW8087);
  end;
end;

function Validate14 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 14;

begin
 Result := True;
 Digits := 0;
 X := 2160134979.3;
 while X < 1E18 do
  begin
   Y1 := RoundToEX_Ref(X, Digits);
   Y2 := RoundToEXFunction(X, Digits);
   if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
    begin
     ErrorTrap(ValidateNo, Digits, X);
     Result := False;
     Exit;
    end;
   X := X * VALIDATE14STEPSIZE;
  end;
end;

function Validate15 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 15;

begin
 Result := True;
 for Digits := 0 to 20 do
  begin
   X := 5E-320;
   while X < 1E18 do
    begin
     Y1 := RoundToEX_Ref(X, Digits);
     Y2 := RoundToEXFunction(X, Digits);
     if Y1 <> 0 then
      begin
       if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
        begin
         ErrorTrap(ValidateNo, Digits, X);
         Result := False;
         Exit;
        end;
      end
     else
      begin
       if Abs(Y1 - Y2) > EXTENDEDLIMIT then
        begin
         ErrorTrap(ValidateNo, Digits, X);
         Result := False;
         Exit;
        end;
      end;
     X := X * VALIDATE15STEPSIZE;
    end;
  end;
end;

function Validate16 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 16;

begin
 Result := True;
 for Digits := 0 downto -15 do
  begin
   X := 1E-2;
   while X < 1E2 do
    begin
     Y1 := RoundToEX_Ref(X, Digits);
     Y2 := RoundToEXFunction(X, Digits);
     if Y1 <> 0 then
      begin
       if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
        begin
         ErrorTrap(ValidateNo, Digits, X);
         RoundToEXFunction(X, Digits);
         Result := False;
         Exit;
        end;
      end
     else
      begin
       if Abs(Y1 - Y2) > EXTENDEDLIMIT then
        begin
         ErrorTrap(ValidateNo, Digits, X);
         Result := False;
         Exit;
        end;
      end;
     X := X * VALIDATE16STEPSIZE;
    end;
  end;
end;

function Validate17 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 17;

begin
 Result := True;
 for Digits := -15 downto -20 do
  begin
   X := 1E-37;
   while X < 1E-20 do
    begin
     Y1 := RoundToEX_Ref(X, Digits);
     Y2 := RoundToEXFunction(X, Digits);
     if Y1 <> 0 then
      begin
       if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
        begin
         ErrorTrap(ValidateNo, Digits, X);
         Result := False;
         Exit;
        end;
      end
     else
      begin
       if Abs(Y1 - Y2) > EXTENDEDLIMIT then
        begin
         ErrorTrap(ValidateNo, Digits, X);
         Result := False;
         Exit;
        end;
      end;
     X := X * VALIDATE16STEPSIZE;
    end;
  end;
end;

function Validate18 : Boolean;
var
 X, Y1, Y2 : Extended;
 Digits : TRoundToEXRangeExtended;
 CW8087 : Word;
const
 ValidateNo : Integer = 18;

begin
 Result := True;
 Digits := 0;
 X := -5E-2;
 while X > -1E18 do
  begin
   CW8087 := Get8087CW;
   SetRoundMode(rmNearest);
   Y1 := Round(X);//Bad Round !!!!!!!!
   Set8087CW(CW8087);
   Y2 := RoundToEXFunction(X, Digits);
   if Y1 <> 0 then
    begin
     if Abs((Y1 - Y2) / Y1) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end
   else
    begin
     if Abs(Y1 - Y2) > EXTENDEDLIMIT then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       Exit;
      end;
    end;
   X := X * VALIDATE17STEPSIZE;
  end;
end;

function Validate19 : Boolean;
var
 I1, I2, I3 : Integer;
 X, Y, Yref : Extended;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 19;

begin
 Result := True;
 Digits := 1;
 I1 := 10;
 while I1 < 1000 do
  begin
   X := I1;
   I2 := I1 mod 10;
   I3 := 10 - I2;
   if I2 < 5 then
    Yref := I1 - I2
   else if I2 = 5 then
    begin
     if Odd((I1 - I2) div 10) then
      Yref := I1 + I3
     else
      Yref := I1 - I2;
    end
   else
    Yref := I1 + I3;
   Y := RoundToEXFunction(X, Digits);
   if Y <> Yref then
    begin
     ErrorTrap(ValidateNo, Digits, X);
     Result := False;
     Exit;
    end;
   I1 := I1 + 1;
  end;
end;

//Validate that the function does not change the FPU controlword

function Validate20 : Boolean;
var
 X : Extended;
 J1, J2 : Cardinal;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 20;

begin
 X := 100;
 Digits := 1;
 Result := True;
 PrecisionIndex := MainForm.Set8087PrecisionRadioGroup.ItemIndex;
 RoundModeIndex := MainForm.SetRoundModeRadioGroup.ItemIndex;
 for J1 := 0 to MainForm.Set8087PrecisionRadioGroup.Items.Count-1 do
  begin
   MainForm.Set8087PrecisionRadioGroup.ItemIndex := J1;
   for J2 := 0 to MainForm.SetRoundModeRadioGroup.Items.Count-1 do
    begin
     MainForm.SetRoundModeRadioGroup.ItemIndex := J2;
     MainForm.Update;
     Sleep(100);
     ControlWordBefore := Get8087CW;
     RoundToEXFunction(X, Digits);
     ControlWordAfter := Get8087CW;
     if ControlWordBefore <> ControlWordAfter then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       MainForm.Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
       MainForm.SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
       Exit;
      end;
    end;
  end;
 MainForm.Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
 MainForm.SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
end;

//Validate that the function works regardless of the FPU controlword setting

function Validate21 : Boolean;
var
 I1, I2, I3 : Integer;
 X, Y, Yref : Extended;
 Digits : TRoundToEXRangeExtended;
 J1, J2 : Cardinal;
 PrecisionIndex, RoundModeIndex : Integer;
const
 ValidateNo : Integer = 21;

begin
 Result := True;
 PrecisionIndex := MainForm.Set8087PrecisionRadioGroup.ItemIndex;
 RoundModeIndex := MainForm.SetRoundModeRadioGroup.ItemIndex;
 for J1 := 0 to MainForm.Set8087PrecisionRadioGroup.Items.Count-1 do
  begin
   MainForm.Set8087PrecisionRadioGroup.ItemIndex := J1;
   for J2 := 0 to MainForm.SetRoundModeRadioGroup.Items.Count-1 do
    begin
     MainForm.SetRoundModeRadioGroup.ItemIndex := J2;
     MainForm.Update;
     Sleep(100);
     Result := True;
     Digits := 1;
     I1 := 10;
     while I1 < 1000 do
      begin
       X := I1;
       I2 := I1 mod 10;
       I3 := 10 - I2;
       if I2 < 5 then
        Yref := I1 - I2
       else if I2 = 5 then
        begin
         if Odd((I1 - I2) div 10) then
          Yref := I1 + I3
         else
          Yref := I1 - I2;
        end
       else
        Yref := I1 + I3;
       Y := RoundToEXFunction(X, Digits);
       if Y <> Yref then
        begin
         ErrorTrap(ValidateNo, Digits, X);
         Result := False;
         Exit;
        end;
       I1 := I1 + 1;
      end;
    end;
  end;
 MainForm.Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
 MainForm.SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
end;

//Validate that the function does not change the FPU controlword on owerflow

function Validate22 : Boolean;
var
 X : Extended;
 J1, J2 : Cardinal;
 ControlWordBefore, ControlWordAfter : Word;
 PrecisionIndex, RoundModeIndex : Integer;
 Digits : TRoundToEXRangeExtended;
const
 ValidateNo : Integer = 22;

begin
 X := 10E18;
 Digits := 0;
 Result := True;
 PrecisionIndex := MainForm.Set8087PrecisionRadioGroup.ItemIndex;
 RoundModeIndex := MainForm.SetRoundModeRadioGroup.ItemIndex;
 for J1 := 0 to MainForm.Set8087PrecisionRadioGroup.Items.Count-1 do
  begin
   MainForm.Set8087PrecisionRadioGroup.ItemIndex := J1;
   for J2 := 0 to MainForm.SetRoundModeRadioGroup.Items.Count-1 do
    begin
     MainForm.SetRoundModeRadioGroup.ItemIndex := J2;
     MainForm.Update;
     Sleep(100);
     ControlWordBefore := Get8087CW;
     try
      RoundToEXFunction(X, Digits);
     except
      //Ignore exception
     end;
     ControlWordAfter := Get8087CW;
     if ControlWordBefore <> ControlWordAfter then
      begin
       ErrorTrap(ValidateNo, Digits, X);
       Result := False;
       MainForm.Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
       MainForm.SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
       Exit;
      end;
    end;
  end;
 MainForm.Set8087PrecisionRadioGroup.ItemIndex := PrecisionIndex;
 MainForm.SetRoundModeRadioGroup.ItemIndex := RoundModeIndex;
end;

function Validate23 : Boolean;
var
 X : Extended;
 Digits : Integer;
const
 ValidateNo : Integer = 23;

begin
 Result := False;
 Digits := High(TRoundToEXRangeExtended)+1;
 X := 1;
 try
  RoundToEXFunction(X, Digits);
  ErrorTrap(ValidateNo, Digits, X);
 except
  Result := True;
 end;
end;

function Validate24 : Boolean;
var
 X : Extended;
 Digits : Integer;
const
 ValidateNo : Integer = 24;

begin
 Result := False;
 Digits := Low(TRoundToEXRangeExtended)-1;
 X := 1;
 try
  RoundToEXFunction(X, Digits);
  ErrorTrap(ValidateNo, Digits, X);
 except
  Result := True;
 end;
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName : AnsiString;

begin
 try
  try
   ValidateButton.Enabled := False;
   ValidateButton.Caption := 'Running';
   ValidationEdit.Color := clBlue;
   Update;
   FunctionName := DoubleFunctionSelectionRadioGroup.Items[DoubleFunctionSelectionRadioGroup.ItemIndex];
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
      Validate24 then
    begin
     ValidationEdit.Color := clGreen;
     ReportRichEdit.Lines.Add(FunctionName + #9 + 'Passed');
    end
   else
    begin
     ValidationEdit.Color := clRed;
     ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed');
    end;
  finally
   ValidateButton.Caption := 'Validate';
   ValidateButton.Enabled := true;
  end;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 SubBench1, SubBench2, SubBench3, Bench : Cardinal;
 FunctionName : AnsiString;

begin
 try
  try
   FunctionName := DoubleFunctionSelectionRadioGroup.Items[DoubleFunctionSelectionRadioGroup.ItemIndex];
   BenchmarkButton.Enabled := False;
   BenchmarkButton.Caption := 'Running';
   SubBench1 := SubBenchmark1;
   SubBench2 := SubBenchmark2;
   SubBench3 := SubBenchmark3;
   Bench := SubBench1 + SubBench2 + SubBench3;
   RuntimeEdit.Text := IntToStr(Bench);
   ReportRichEdit.Lines.Add(FunctionName
                            + #9 + IntToStr(SubBench1)
                            + #9 + IntToStr(SubBench2)
                            + #9 + IntToStr(SubBench3)
                            + #9 + IntToStr(Bench));
   SortRichEdit;
   BenchmarkTest;
  finally
   BenchmarkButton.Caption := 'Benchmark';
   BenchmarkButton.Enabled := True;
  end;
 except
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var
 X, Y : Extended;
 I1, I2, I4 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;
 Digits : Integer;

begin
 Y := 0;
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
   for I2 := 0 to  SUBBENCH1NOOFRUNS do
    begin
     for Digits := -3 to 3 do
      begin
       X := 1;
       while X < 2 do
        begin
         Y := RoundToEXFunction(X, Digits);
         X := X * 1.002;
        end;
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   YEdit.Text := FloatToStr(Y);//For the compiler
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
 X, Y : Extended;
 I1, I2, I4 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;
 Digits : Integer;

begin
 Y := 0;
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
   for I2 := 0 to SUBBENCH2NOOFRUNS do
    begin
     for Digits := 0 to 20 do
      begin
       X := 1;
       while X < 2 do
        begin
         Y := RoundToEXFunction(X, Digits);
         X := X * 1.002;
        end;
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   YEdit.Text := FloatToStr(Y);//For the compiler
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

function TMainForm.SubBenchmark3 : Cardinal;
var
 X, Y : Extended;
 I1, I2, I4 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;
 Digits : Integer;

begin
 Y := 0;
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
   for I2 := 0 to SUBBENCH3NOOFRUNS do
    begin
     for Digits := 0 downto -20 do
      begin
       X := 1E-20;
       while X < 2E-20 do
        begin
         Y := RoundToEXFunction(X, Digits);
         X := X * 1.002;
        end;
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   YEdit.Text := FloatToStr(Y);//For the compiler
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
 Result := Round(RunTimeSec*SUBBENCH3SCALE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 110;
 ReportRichEdit.Paragraph.Tab[1] := 140;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 210;
 DoubleFunctionSelectionRadioGroupClick(nil);
 SetRoundModeRadioGroupClick(nil);
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

procedure TMainForm.DoubleFunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case DoubleFunctionSelectionRadioGroup.ItemIndex+1 of
  1 : RoundToEXFunction := RoundToEX_Ref;
  2 : RoundToEXFunction := RoundToEX_DKC_Pas_1;
  3 : RoundToEXFunction := RoundToEX_DKC_Pas_2;
  4 : RoundToEXFunction := RoundToEX_DKC_Pas_3;
  5 : RoundToEXFunction := RoundToEX_DKC_Pas_4;
  6 : RoundToEXFunction := RoundToEX_DKC_IA32_1;
  7 : RoundToEXFunction := RoundToEX_DKC_IA32_2;
  8 : RoundToEXFunction := RoundToEX_DKC_IA32_3;
  9 : RoundToEXFunction := RoundToEX_DKC_IA32_4;
  10 : RoundToEXFunction := RoundToEX_JOH_PAS_1;
  11 : RoundToEXFunction := RoundToEX_JOH_PAS_2;
  12 : RoundToEXFunction := RoundToEX_JOH_IA32_1;
  13 : RoundToEXFunction := RoundToEX_JOH_IA32_2;
  14 : RoundToEXFunction := RoundToEX_JOH_IA32_3;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 try
  BenchmarkAllButton.Enabled := False;
  BenchmarkAllButton.Caption := 'Running';
  Update;
  if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) = False then
   raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
  for I := 0 to DoubleFunctionSelectionRadioGroup.Items.Count-1 do
   begin
    DoubleFunctionSelectionRadioGroup.ItemIndex := I;
    BenchmarkButtonClick(nil);
    Update;
   end;
 finally
  BenchmarkAllButton.Caption := 'Benchmark All';
  BenchmarkAllButton.Enabled := True;

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
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 try
  ValidateAllButton.Enabled := False;
  ValidateAllButton.Caption := 'Running';
  Update;
  for I := 0 to DoubleFunctionSelectionRadioGroup.Items.Count-1 do
   begin
    DoubleFunctionSelectionRadioGroup.ItemIndex := I;
    ValidateButtonClick(nil);
    Update;
   end;
 finally
  ValidateAllButton.Caption := 'Validate All';
  ValidateAllButton.Enabled := True;

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
 end;
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

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 //for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I1 := 1 to 10 do
  begin
   for I2 := 0 to DoubleFunctionSelectionRadioGroup.Items.Count-1 do
    begin
     DoubleFunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkButtonClick(nil);
     Update;
    end;
   DoubleFunctionSelectionRadioGroup.ItemIndex := I1;
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

{
procedure TMainForm.Button1Click(Sender: TObject);
var
 X, Xold : Extended;
 Digits : Integer;
const
 XSTEPSIZE : Extended = 1.0000001;

begin
 for Digits := -37 to 0 do
  begin
   X := -1E-20;
   while X < MAXEXTENDED do
    begin
     Xold := X;
     X := X * XSTEPSIZE;
     try
      RoundToEX_Ref(X, Digits);
     except
      ReportRichEdit.Lines.Add('Digits: ' + IntToStr(Digits) + #9 + ' Xmin: ' + FloatToStrF(Xold, ffExponent, 18, 2));
      Update;
      Break;
     end;
    end;
   X := 1E-20;
   while X < MAXEXTENDED do
    begin
     Xold := X;
     X := X * XSTEPSIZE;
     try
      RoundToEX_Ref(X, Digits);
     except
      ReportRichEdit.Lines.Add('Digits: ' + IntToStr(Digits) + #9 + ' Xmax: ' + FloatToStrF(Xold, ffExponent, 18, 2));
      Update;
      Break;
     end;
    end;
  end;
 for Digits := 0 to 37 do
  begin
   X := -1E18;
   while X < MAXEXTENDED do
    begin
     Xold := X;
     X := X * XSTEPSIZE;
     try
      RoundToEX_Ref(X, Digits);
     except
      ReportRichEdit.Lines.Add('Digits: ' + IntToStr(Digits) + #9 + ' Xmin: ' + FloatToStrF(Xold, ffExponent, 18, 2));
      Update;
      Break;
     end;
    end;
   X := 1E18;
   while X < MAXEXTENDED do
    begin
     Xold := X;
     X := X * XSTEPSIZE;
     try
      RoundToEX_Ref(X, Digits);
     except
      ReportRichEdit.Lines.Add('Digits: ' + IntToStr(Digits) + #9 + ' Xmax: ' + FloatToStrF(Xold, ffExponent, 18, 2));
      Update;
      Break;
     end;
    end;
  end;
end;
}
{
Digits: -37	 Xmin: -9,22337184688646911E-19
Digits: -37	 Xmax: 9,22337184688646911E-19
Digits: -36	 Xmin: -9,22337177195127558E-18
Digits: -36	 Xmax: 9,22337177195127558E-18
Digits: -35	 Xmin: -9,22337169701608094E-17
Digits: -35	 Xmax: 9,22337169701608094E-17
Digits: -34	 Xmin: -9,22337162208088710E-16
Digits: -34	 Xmax: 9,22337162208088710E-16
Digits: -33	 Xmin: -9,22337154714569392E-15
Digits: -33	 Xmax: 9,22337154714569392E-15
Digits: -32	 Xmin: -9,22337147221050154E-14
Digits: -32	 Xmax: 9,22337147221050154E-14
Digits: -31	 Xmin: -9,22337139727530871E-13
Digits: -31	 Xmax: 9,22337139727530871E-13
Digits: -30	 Xmin: -9,22337132234011880E-12
Digits: -30	 Xmax: 9,22337132234011880E-12
Digits: -29	 Xmin: -9,22337124740492711E-11
Digits: -29	 Xmax: 9,22337124740492711E-11
Digits: -28	 Xmin: -9,22337117246973770E-10
Digits: -28	 Xmax: 9,22337117246973770E-10
Digits: -27	 Xmin: -9,22337201987165870E-09
Digits: -27	 Xmax: 9,22337201987165870E-09
Digits: -26	 Xmin: -9,22337194493646520E-08
Digits: -26	 Xmax: 9,22337194493646520E-08
Digits: -25	 Xmin: -9,22337187000126938E-07
Digits: -25	 Xmax: 9,22337187000126938E-07
Digits: -24	 Xmin: -9,22337179506607522E-06
Digits: -24	 Xmax: 9,22337179506607522E-06
Digits: -23	 Xmin: -9,22337172013088061E-05
Digits: -23	 Xmax: 9,22337172013088061E-05
Digits: -22	 Xmin: -9,22337164519568847E-04
Digits: -22	 Xmax: 9,22337164519568847E-04
Digits: -21	 Xmin: -9,22337157026049539E-03
Digits: -21	 Xmax: 9,22337157026049539E-03
Digits: -20	 Xmin: -9,22337149532530280E-02
Digits: -20	 Xmax: 9,22337149532530280E-02
Digits: -19	 Xmin: -9,22337142039011315E-01
Digits: -19	 Xmax: 9,22337142039011315E-01
Digits: -18	 Xmin: -9,22337134545492269E+00
Digits: -18	 Xmax: 9,22337134545492269E+00
Digits: -17	 Xmin: -9,22337127051973083E+01
Digits: -17	 Xmax: 9,22337127051973083E+01
Digits: -16	 Xmin: -9,22337119558454082E+02
Digits: -16	 Xmax: 9,22337119558454082E+02
Digits: -15	 Xmin: -9,22337112064935225E+03
Digits: -15	 Xmax: 9,22337112064935225E+03
Digits: -14	 Xmin: -9,22337196805126671E+04
Digits: -14	 Xmax: 9,22337196805126671E+04
Digits: -13	 Xmin: -9,22337189311607092E+05
Digits: -13	 Xmax: 9,22337189311607092E+05
Digits: -12	 Xmin: -9,22337181818087473E+06
Digits: -12	 Xmax: 9,22337181818087473E+06
Digits: -11	 Xmin: -9,22337174324568182E+07
Digits: -11	 Xmax: 9,22337174324568182E+07
Digits: -10	 Xmin: -9,22337166831048734E+08
Digits: -10	 Xmax: 9,22337166831048734E+08
Digits: -9	 Xmin: -9,22337159337529426E+09
Digits: -9	 Xmax: 9,22337159337529426E+09
Digits: -8	 Xmin: -9,22337151844010115E+10
Digits: -8	 Xmax: 9,22337151844010115E+10
Digits: -7	 Xmin: -9,22337144350491009E+11
Digits: -7	 Xmax: 9,22337144350491009E+11
Digits: -6	 Xmin: -9,22337136856971977E+12
Digits: -6	 Xmax: 9,22337136856971977E+12
Digits: -5	 Xmin: -9,22337129363452913E+13
Digits: -5	 Xmax: 9,22337129363452913E+13
Digits: -4	 Xmin: -9,22337121869934026E+14
Digits: -4	 Xmax: 9,22337121869934026E+14
Digits: -3	 Xmin: -9,22337114376415071E+15
Digits: -3	 Xmax: 9,22337114376415071E+15
Digits: -2	 Xmin: -9,22337199116606936E+16
Digits: -2	 Xmax: 9,22337199116606936E+16
Digits: -1	 Xmin: -9,22337191623087460E+17
Digits: -1	 Xmax: 9,22337191623087460E+17
Digits: 0	 Xmin: -9,22337184129568043E+18
Digits: 0	 Xmax: 9,22337184129568043E+18
Digits: 0	 Xmin: -9,22337192182166248E+18
Digits: 0	 Xmax: 9,22337192182166248E+18
Digits: 1	 Xmin: -9,22337184688646844E+19
Digits: 1	 Xmax: 9,22337184688646844E+19
Digits: 2	 Xmin: -9,22337177195127267E+20
Digits: 2	 Xmax: 9,22337177195127267E+20
Digits: 3	 Xmin: -9,22337169701607696E+21
Digits: 3	 Xmax: 9,22337169701607696E+21
Digits: 4	 Xmin: -9,22337162208088368E+22
Digits: 4	 Xmax: 9,22337162208088368E+22
Digits: 5	 Xmin: -9,22337154714569107E+23
Digits: 5	 Xmax: 9,22337154714569107E+23
Digits: 6	 Xmin: -9,22337147221049964E+24
Digits: 6	 Xmax: 9,22337147221049964E+24
Digits: 7	 Xmin: -9,22337139727530850E+25
Digits: 7	 Xmax: 9,22337139727530850E+25
Digits: 8	 Xmin: -9,22337132234011639E+26
Digits: 8	 Xmax: 9,22337132234011639E+26
Digits: 9	 Xmin: -9,22337124740492667E+27
Digits: 9	 Xmax: 9,22337124740492667E+27
Digits: 10	 Xmin: -9,22337117246973724E+28
Digits: 10	 Xmax: 9,22337117246973724E+28
Digits: 11	 Xmin: -9,22337201987165826E+29
Digits: 11	 Xmax: 9,22337201987165826E+29
Digits: 12	 Xmin: -9,22337194493646276E+30
Digits: 12	 Xmax: 9,22337194493646276E+30
Digits: 13	 Xmin: -9,22337187000126868E+31
Digits: 13	 Xmax: 9,22337187000126868E+31
Digits: 14	 Xmin: -9,22337179506607424E+32
Digits: 14	 Xmax: 9,22337179506607424E+32
Digits: 15	 Xmin: -9,22337172013088045E+33
Digits: 15	 Xmax: 9,22337172013088045E+33
Digits: 16	 Xmin: -9,22337164519568705E+34
Digits: 16	 Xmax: 9,22337164519568705E+34
Digits: 17	 Xmin: -9,22337157026049430E+35
Digits: 17	 Xmax: 9,22337157026049430E+35
Digits: 18	 Xmin: -9,22337149532530098E+36
Digits: 18	 Xmax: 9,22337149532530098E+36
Digits: 19	 Xmin: -9,22337142039010765E+37
Digits: 19	 Xmax: 9,22337142039010765E+37
Digits: 20	 Xmin: -9,22337134545491563E+38
Digits: 20	 Xmax: 9,22337134545491563E+38
Digits: 21	 Xmin: -9,22337127051972590E+39
Digits: 21	 Xmax: 9,22337127051972590E+39
Digits: 22	 Xmin: -9,22337119558453469E+40
Digits: 22	 Xmax: 9,22337119558453469E+40
Digits: 23	 Xmin: -9,22337112064934557E+41
Digits: 23	 Xmax: 9,22337112064934557E+41
Digits: 24	 Xmin: -9,22337196805126138E+42
Digits: 24	 Xmax: 9,22337196805126138E+42
Digits: 25	 Xmin: -9,22337189311606482E+43
Digits: 25	 Xmax: 9,22337189311606482E+43
Digits: 26	 Xmin: -9,22337181818086876E+44
Digits: 26	 Xmax: 9,22337181818086876E+44
Digits: 27	 Xmin: -9,22337174324567317E+45
Digits: 27	 Xmax: 9,22337174324567317E+45
Digits: 28	 Xmin: -9,22337166831047764E+46
Digits: 28	 Xmax: 9,22337166831047764E+46
Digits: 29	 Xmin: -9,22337159337528505E+47
Digits: 29	 Xmax: 9,22337159337528505E+47
Digits: 30	 Xmin: -9,22337151844009381E+48
Digits: 30	 Xmax: 9,22337151844009381E+48
Digits: 31	 Xmin: -9,22337144350490168E+49
Digits: 31	 Xmax: 9,22337144350490168E+49
Digits: 32	 Xmin: -9,22337136856971024E+50
Digits: 32	 Xmax: 9,22337136856971024E+50
Digits: 33	 Xmin: -9,22337129363451968E+51
Digits: 33	 Xmax: 9,22337129363451968E+51
Digits: 34	 Xmin: -9,22337121869932909E+52
Digits: 34	 Xmax: 9,22337121869932909E+52
Digits: 35	 Xmin: -9,22337114376413732E+53
Digits: 35	 Xmax: 9,22337114376413732E+53
Digits: 36	 Xmin: -9,22337199116605454E+54
Digits: 36	 Xmax: 9,22337199116605454E+54
Digits: 37	 Xmin: -9,22337191623086027E+55
Digits: 37	 Xmax: 9,22337191623086027E+55
}
procedure TMainForm.Set8087PrecisionRadioGroupClick(Sender: TObject);
begin
 case Set8087PrecisionRadioGroup.ItemIndex of
  0 : SetPrecisionMode(pmSingle);
  1 : SetPrecisionMode(pmDouble);
  2 : SetPrecisionMode(pmExtended);
 end;
end;

procedure TMainForm.SetRoundModeRadioGroupClick(Sender: TObject);
begin
 case SetRoundModeRadioGroup.ItemIndex of
  0 : SetRoundMode(rmNearest);
  1 : SetRoundMode(rmDown);
  2 : SetRoundMode(rmUp);
  3 : SetRoundMode(rmTruncate);
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
