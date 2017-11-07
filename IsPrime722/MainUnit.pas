unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'IsPrime';

type
  TMainForm = class(TForm)
    ValidateButton: TButton;
    ValidationEdit: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    ReportRichEdit: TRichEdit;
    BenchmarkButton: TButton;
    BenchmarkEdit: TEdit;
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
    PrimeEdit: TEdit;
    Label10: TLabel;
    ErrorEdit: TEdit;
    ValidateSubRangeButton: TButton;
    ProgressBar1: TProgressBar;
    RangeNoEdit: TEdit;
    MaxEdit: TEdit;
    MinEdit: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    RuntimeEdit: TEdit;
    SpeedEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    ReferenceFunctionEdit: TEdit;
    Label16: TLabel;
    ValidateSomeSubRangesButton: TButton;
    ProgressBar2: TProgressBar;
    TimeLabel: TLabel;
    ValidateSubrangeOneFunctionButton: TButton;
    ValidateAllSubrangesOneFunctionButton: TButton;
    AboutSpeedButton: TSpeedButton;
    ShowErrorDialogCheckBox: TCheckBox;
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
    procedure ValidateSubRangeButtonClick(Sender: TObject);
    procedure ValidateSomeSubRangesButtonClick(Sender: TObject);
    procedure BenchmarkEditClick(Sender: TObject);
    procedure ValidateSubrangeOneFunctionButtonClick(Sender: TObject);
    procedure ValidateAllSubrangesOneFunctionButtonClick(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    MaxSpeed : Double;
    ReferenceFunctionIndex : Cardinal;
    function Validate1 : Boolean;
    function Validate2 : Boolean;
    function Validate3 : Boolean;
    function Validate4 : Boolean;
    function Validate5 : Boolean;
    function Validate6 : Boolean;
    function Validate7 : Boolean;
    function Validate8 : Boolean;
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
 Rust : Cardinal;
 lpFrequency : Int64;

implementation

uses
 FastcodeCPUID, SystemInfoUnit, IsPrimeDKCUnit, IsPrimeJOHUnit, IsPrimeHRUnit,
 Math, IsPrimeCJGUnit, AboutUnit;

{$R *.dfm}

const
 MAXCARDINAL : Cardinal = $FFFFFFFF;
 MINSUBBENCH1NUMBER : Double = 1;
 MAXSUBBENCH1NUMBER : Double = $FFFFFFFF/3;
 MINSUBBENCH2NUMBER : Double = $FFFFFFFF/3;
 MAXSUBBENCH2NUMBER : Double = (2/3)*$FFFFFFFF;
 MINSUBBENCH3NUMBER : Double = (2/3)*$FFFFFFFF;
 MAXSUBBENCH3NUMBER : Double = $FFFFFFFF;
 SUBBENCH1STEPSIZE : Double = 1.00001;
 SUBBENCH2STEPSIZE : Double = 1.00001;
 SUBBENCH3STEPSIZE : Double = 1.00001;
 //Values are selected such that the fastest function in each subbenchmark
 //obtains a score of 300 on Opteron 240
 SUBBENCH1SCALE : Double = 1230;
 SUBBENCH2SCALE : Double = 21470;
 SUBBENCH3SCALE : Double = 35000;
 //**********************************
 NOOFRERUNS : Cardinal = 15;
 VALIDATE2MAX : Cardinal = 4000000;
 VALIDATE5MIN : Cardinal = 4000000;
 VALIDATE6MAX : Cardinal = 1000000;//The Sieve test
 VALIDATE3STEPSIZE : Cardinal = 114567;
 VALIDATE4STEPSIZE : Cardinal = 2;
 VALIDATE5STEPSIZE : Cardinal = 134567;
 VALIDATE8STEPSIZE : Cardinal = 376003;

type
 TIsPrimeFunction = function (Number : Cardinal) : Boolean;

var
 IsPrimeFunction, IsPrimeReferenceFunction : TIsPrimeFunction;

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
         if MaxSpread > 2 then
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

procedure ErrorTrap(ValidateNumber, Number : Cardinal);
//var
 //Prime : Boolean;

begin
 //Prime :=
 IsPrimeFunction(Number);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNumber) + ' Number: ' + IntToStr(Number)), 'Error');

end;

//Absolute validation on selected numbers

function TMainForm.Validate1 : Boolean;
var
 K : Cardinal;
 Prime : Boolean;
const
 ValidateNo : Cardinal = 1;

begin
 Result := True;
 K := 0;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 1;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 2;
 Prime := IsPrimeFunction(K);
 if Prime <> True then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 3;
 Prime := IsPrimeFunction(K);
 if Prime <> True then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 4;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 5;
 Prime := IsPrimeFunction(K);
 if Prime <> True then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 6;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 7;
 Prime := IsPrimeFunction(K);
 if Prime <> True then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 8;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 9;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 10;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 11;
 Prime := IsPrimeFunction(K);
 if Prime <> True then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 13;
 Prime := IsPrimeFunction(K);
 if Prime <> True then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 15;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 17;
 Prime := IsPrimeFunction(K);
 if Prime <> True then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 19;
 Prime := IsPrimeFunction(K);
 if Prime <> True then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 21;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 23;
 Prime := IsPrimeFunction(K);
 if Prime <> True then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 25;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := 27;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
   Exit;
  end;
 K := MAXCARDINAL;
 Prime := IsPrimeFunction(K);
 if Prime <> False then
  begin
   ErrorTrap(ValidateNo, K);
   Result := False;
   ErrorEdit.Text := IntToStr(K);
  end;
end;

//Complete relative validation up to VALIDATE2MAX

function TMainForm.Validate2 : Boolean;
var
 K : Cardinal;
 Prime1, Prime2 : Boolean;
const
 ValidateNo : Cardinal = 2;

begin
 Result := True;
 for K := 0 to VALIDATE2MAX do
  begin
   Prime1 := IsPrimeDKCPas3(K);
   try
    Prime2 := IsPrimeFunction(K);
   except
    ErrorTrap(ValidateNo, K);
    Raise;
   end;
   if Prime1 <> Prime2 then
    begin
     Result := False;
     ErrorTrap(ValidateNo, K);
     ErrorEdit.Text := IntToStr(K);
     Break;
    end;
  end;
end;

//Incomplete relative validation from VALIDATE2MAX to MAXCARDINAL

function TMainForm.Validate3 : Boolean;
var
 K : Cardinal;
 Prime1, Prime2 : Boolean;
const
 ValidateNo : Cardinal = 3;

begin
 Result := True;
 K := 1;
 while K < MAXCARDINAL - VALIDATE3STEPSIZE do
  begin
   Prime1 := IsPrime_HR_IA32_2(K);
   Prime2 := IsPrimeFunction(K);
   if Prime1 <> Prime2 then
    begin
     ErrorTrap(ValidateNo, K);
     Result := False;
     ErrorEdit.Text := IntToStr(K);
     Break;
    end;
   K := K + VALIDATE3STEPSIZE;
  end;
end;

//Incomplete relative validation from VALIDATE2MAX to MAXCARDINAL

function TMainForm.Validate4 : Boolean;
var
 K : Cardinal;
 Prime1, Prime2 : Boolean;
 K64 : Int64;
const
 ValidateNo : Cardinal = 4;

begin
 Result := True;
 K := VALIDATE2MAX;
 K64 := K;
 while K < MAXCARDINAL / VALIDATE4STEPSIZE do
  begin
   Prime1 := IsPrimeDKCPas3(K);
   Prime2 := IsPrimeFunction(K);
   if Prime1 <> Prime2 then
    begin
     ErrorTrap(ValidateNo, K);
     Result := False;
     ErrorEdit.Text := IntToStr(K);
     Break;
    end;
   K64 := K64 * VALIDATE4STEPSIZE-1;//Workaround for the Cardinal multiplication bug
   K := K64;
  end;
end;

//Incomplete relative validation from MAXCARDINAL downto VALIDATE5MIN

function TMainForm.Validate5 : Boolean;
var
 K : Cardinal;
 Prime1, Prime2 : Boolean;
const
 ValidateNo : Cardinal = 5;

begin
 Result := True;
 K := MAXCARDINAL;
 while K > VALIDATE5MIN do
  begin
   Prime1 := IsPrime_HR_IA32_2(K);
   Prime2 := IsPrimeFunction(K);
   if Prime1 <> Prime2 then
    begin
     ErrorTrap(ValidateNo, K);
     Result := False;
     ErrorEdit.Text := IntToStr(K);
     Break;
    end;
   K := K - VALIDATE5STEPSIZE;
  end;
end;

//Complete validation of numbers up to VALIDATE6MAX against results generated by use of the sieve of Erastostenes

function TMainForm.Validate6 : Boolean;
var
 I1, I2, I3, K, I2Max : Cardinal;
 Prime1, Prime2 : Boolean;
 PrimeArray : array of Cardinal;
const
 ValidateNo : Cardinal = 6;

begin
 Setlength(PrimeArray, VALIDATE6MAX+1);
 for I1 := 0 to VALIDATE6MAX do
  begin
   PrimeArray[I1] := I1;
  end;
 //1 is not prime -> remove from list
 PrimeArray[1] := 0;
 I2Max := Round(Sqrt(VALIDATE6MAX));
 //Remove non primes from list of primes by use of the sieve of Erastotenes
 for I2 := 2 to I2Max do
  begin
   if PrimeArray[I2] = 0 then
    Continue;
   for I3 := I2+1 to VALIDATE6MAX do
    begin
     if PrimeArray[I3] mod I2 = 0 then
      PrimeArray[I3] := 0;
    end;
  end;
 Result := True;
 for K := 0 to VALIDATE6MAX do
  begin
   if PrimeArray[K] = 0 then
    Prime1 := False
   else
    Prime1 := True;
   Prime2 := IsPrimeFunction(K);
   if Prime1 <> Prime2 then
    begin
     ErrorTrap(ValidateNo, K);
     Result := False;
     ErrorEdit.Text := IntToStr(K);
     Break;
    end;
  end;
end;

function TMainForm.Validate7 : Boolean;
var
 K, I, NoOfIterations : Cardinal;
 X, Validate7Min, Validate7Max, RangeNo : Int64;
 Prime1, Prime2 : Boolean;
 StartTime, RunTime : TDateTime;
 Speed : Double;
const
 NOFRANGES : Int64 = 100;
 PROGRESBARSCALE : Cardinal = 100000;
 ONE : Int64 = 1;
 ValidateNo : Cardinal = 7;

begin
 ReferenceFunctionEdit.Text := FunctionSelectionRadioGroup.Items[ReferenceFunctionIndex];
 Update;
 Speed := 0;
 StartTime := Time;
 I := 0;
 RangeNo := StrToInt(RangeNoEdit.Text);
 X := MAXCARDINAL div NOFRANGES;
 Validate7Min := (RangeNo-ONE) * X;
 if RangeNo < NOFRANGES then
  Validate7Max := (RangeNo) * (MAXCARDINAL div NOFRANGES)
 else
  Validate7Max := MAXCARDINAL;
 if RangeNo > NOFRANGES then
  raise Exception.Create('RangeNo max is ' + IntToStr(NOFRANGES));
 MinEdit.Text := IntToStr(Validate7Min);
 MaxEdit.Text := IntToStr(Validate7Max);
 //ReportRichEdit.Lines.Add('Min: ' + IntToStr(Validate8Min));
 //ReportRichEdit.Lines.Add('Max: ' + IntToStr(Validate8Max));
 //Update;
 if Validate7Min div PROGRESBARSCALE < ProgressBar1.Max then
  begin
   ProgressBar1.Min := Validate7Min div PROGRESBARSCALE;
   ProgressBar1.Max := Validate7Max div PROGRESBARSCALE;
  end
 else
  begin
   ProgressBar1.Max := Validate7Max div PROGRESBARSCALE;
   ProgressBar1.Min := Validate7Min div PROGRESBARSCALE;
  end;
 Result := True;
 K := Validate7Min;
 while K < Validate7Max do
  begin
   Prime1 := IsPrimeReferenceFunction(K);
   Prime2 := IsPrimeFunction(K);
   if Prime1 <> Prime2 then
    begin
     ErrorTrap(ValidateNo, K);
     Result := False;
     ErrorEdit.Text := IntToStr(K);
     Break;
    end;
   K := K+1;
   Inc(I);
   if I > 100000 then
    begin
     I := 0;
     ProgressBar1.Position := K div PROGRESBARSCALE;
     RunTime := Time - StartTime;
     RunTimeEdit.Text := TimeToStr(Runtime);
     NoOfIterations := K - Validate7Min;
     if RunTime > 0 then
      begin
       Speed := 0.001 * NoOfIterations / (Runtime*60*60*24);//1000 Iterations per sec
       SpeedEdit.Text := FloatToStrF(Speed, ffFixed, 9,0);
      end;
     Update;
    end;
  end;
 if (Result = True) and (Speed > MaxSpeed) then
  begin
   MaxSpeed := Speed;
   IsPrimeReferenceFunction := IsPrimeFunction;
   ReferenceFunctionIndex := FunctionSelectionRadioGroup.ItemIndex;
   ReferenceFunctionEdit.Text := FunctionSelectionRadioGroup.Items[ReferenceFunctionIndex];
  end;
end;

//Complete relative validation from VALIDATE8MIN to VALIDATE8MAX

function TMainForm.Validate8 : Boolean;
var
 X, IterationNo : Cardinal;
 Prime1, Prime2 : Boolean;
 ControlWordBefore, ControlWordAfter : Word;
 CW8087 : Word;
const
 ValidateNo : Cardinal = 8;

begin
 CW8087 := Get8087CW;
 Result := True;
 X := 1;
 IterationNo := 0;
 while X <= MAXCARDINAL - VALIDATE8STEPSIZE do
  begin
   Inc(IterationNo);
   if IterationNo = 1 then
    SetPrecisionMode(pmSingle)
   else if IterationNo = 2 then
    SetPrecisionMode(pmDouble)
   else if IterationNo = 3 then
    SetPrecisionMode(pmExtended)
   else if IterationNo = 4 then
    SetRoundMode(rmTruncate)
   else if IterationNo = 5 then
    SetRoundMode(rmNearest)
   else if IterationNo = 6 then
    SetRoundMode(rmUp)
   else if IterationNo = 7 then
    SetRoundMode(rmDown)
   else
    IterationNo := 0;
   ControlWordBefore := Get8087CW;
   Prime1 := IsPrime_HR_IA32_2(X);
   Prime2 := IsPrimeFunction(X);
   ControlWordAfter := Get8087CW;
   if Prime1 <> Prime2 then
    begin
     ErrorTrap(ValidateNo, X);
     Result := False;
     Break;
    end;
   if ControlWordBefore <> ControlWordAfter then
    begin
     ErrorTrap(ValidateNo, X);
     Result := False;
     Break;
    end;
   X := X + VALIDATE8STEPSIZE;
  end;
 Set8087CW(CW8087);
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
  FunctionAddress := Cardinal(@IsPrimeFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if Validate1 and
     Validate2 and
     Validate3 and
     Validate4 and
     Validate5 and
     Validate6 and
     //Validate7 and
     Validate8 then
   begin
    ValidationEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName
                     + #9 + 'Passed');
   end
  else
   begin
    ValidationEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName
                     + #9 + 'Failed');
   end;
  ValidateButton.Caption := 'Validate';
 except
  ReportRichEdit.Lines.Add(FunctionName
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
  FunctionAddress := Cardinal(@IsPrimeFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  BenchmarkButton.Caption := 'Running';
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  SubBench3 := SubBenchmark3;
  Bench := SubBench1 + SubBench2 + SubBench3;
  BenchmarkEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(SubBench2)
                           + #9 + IntToStr(SubBench3)
                           + #9 + IntToStr(Bench));
  SortRichEdit;
  BenchmarkTest;
  BenchmarkButton.Caption := 'Benchmark';
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
 I1, I4, Number : Cardinal;
 Succes, Prime : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec, NumberFP : Double;
 NoOfTicksArray : array of Int64;

begin
 Prime := False;
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NumberFP := MINSUBBENCH1NUMBER;
   Number := Round(NumberFP);
   while Number < MAXSUBBENCH1NUMBER do
    begin
     Prime := IsPrimeFunction(Number);
     NumberFP := NumberFP * SUBBENCH1STEPSIZE;
     Number := Round(NumberFP) + 1;
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
 PrimeEdit.Text := BoolToStr(Prime);
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
 I1, I4, Number : Cardinal;
 Succes, Prime : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec, NumberFP : Double;
 NoOfTicksArray : array of Int64;

begin
 Prime := False;
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NumberFP := MINSUBBENCH2NUMBER;
   Number := Round(NumberFP);
   while Number < MAXSUBBENCH2NUMBER do
    begin
     Prime := IsPrimeFunction(Number);
     NumberFP := NumberFP * SUBBENCH2STEPSIZE;
     Number := Round(NumberFP) + 1;
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
 PrimeEdit.Text := BoolToStr(Prime);
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
 I1, I4, Number : Cardinal;
 Succes, Prime : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec, NumberFP, MaxNumberFP : Double;
 NoOfTicksArray : array of Int64;

begin
 Prime := False;
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NumberFP := MINSUBBENCH3NUMBER;
   Number := Round(NumberFP);
   MaxNumberFP := MAXSUBBENCH3NUMBER/SUBBENCH3STEPSIZE;
   while NumberFP < MaxNumberFP do
    begin
     Prime := IsPrimeFunction(Number);
     NumberFP := NumberFP * SUBBENCH3STEPSIZE;
     Number := Round(NumberFP) + 1;
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
 PrimeEdit.Text := BoolToStr(Prime);
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
 IsPrimeFunction := IsPrime_JOH_Pas_6;
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 90;
 ReportRichEdit.Paragraph.Tab[1] := 120;
 ReportRichEdit.Paragraph.Tab[2] := 150;
 ReportRichEdit.Paragraph.Tab[3] := 200;
 FunctionSelectionRadioGroupClick(nil);
 RangeNoEdit.Text := '1';
 TimeLabel.Caption := '';
 if not QueryPerformanceFrequency(lpFrequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');

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
  1 : IsPrimeFunction := IsPrime_JOH_Pas_6;
  2 : IsPrimeFunction := IsPrime_JOH_IA32_6;
  3 : IsPrimeFunction := IsPrime_DKC_Pas_23;
  4 : IsPrimeFunction := IsPrime_DKC_Pas_24;
  5 : IsPrimeFunction := IsPrime_DKC_Pas_25;
  6 : IsPrimeFunction := IsPrime_DKC_Pas_26;
  7 : IsPrimeFunction := IsPrime_DKC_Pas_27;
  8 : IsPrimeFunction := IsPrime_DKC_IA32_9;
  9 : IsPrimeFunction := IsPrime_DKC_SSE_1;
  10 : IsPrimeFunction := IsPrime_DKC_SSE_2;
  11 : IsPrimeFunction := IsPrime_DKC_SSE_3;
  12 : IsPrimeFunction := IsPrime_DKC_SSE_4;
  13 : IsPrimeFunction := IsPrime_HR_IA32_1;
  14 : IsPrimeFunction := IsPrime_HR_IA32_2;
  15 : IsPrimeFunction := IsPrime_DKC_SSE_5;
  16 : IsPrimeFunction := IsPrime_DKC_SSE_6;
  17 : IsPrimeFunction := IsPrime_DKC_SSE_7;
  18 : IsPrimeFunction := IsPrime_JOH_IA32_8;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';
 Update;
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

procedure TMainForm.ValidateSubrangeOneFunctionButtonClick(Sender: TObject);
var
 FunctionName : AnsiString;
 OldCaption : AnsiString;

begin
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_LOWEST) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_LOWEST failed');
 IsPrimeReferenceFunction := IsPrime_HR_IA32_2;
// ReferenceFunctionIndex := 1;
 MaxSpeed := 0;
 OldCaption := ValidateAllSubRangesOneFunctionButton.Caption;
 ValidateAllSubRangesOneFunctionButton.Caption := 'Running';
 try

  ValidateButton.Caption := 'Running';

  ValidationEdit.Color := clBlue;
  Update;
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  if Validate7 then
   begin
    ValidationEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName
                     + #9 + 'Passed Range ' + RangeNoEdit.Text);
   end
  else
   begin
    ValidationEdit.Color := clRed;
    ReportRichEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName
                     + #9 + 'Failed Range ' + RangeNoEdit.Text);
   end;
  ValidateButton.Caption := 'Validate';
 except
  ReportRichEdit.Lines.Add(FunctionName
                   + #9 + 'Failed Range ' + RangeNoEdit.Text);
 end;
 ValidateAllSubRangesOneFunctionButton.Caption := OldCaption;
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
 ReportRichEdit.Print('IsPrime Report');
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

procedure TMainForm.ValidateAllSubrangesOneFunctionButtonClick(Sender: TObject);
var
 T : Cardinal;
 OldCaption : AnsiString;
const
 SUBRANGEMIN : Cardinal = 1; //1->100
 SUBRANGEMAX : Cardinal = 100;//1->100

begin
 OldCaption := ValidateAllSubrangesOneFunctionButton.Caption;
 ValidateAllSubrangesOneFunctionButton.Caption := 'Running';
 ProgressBar2.Min := SUBRANGEMIN;
 ProgressBar2.Max := SUBRANGEMAX;
 for T := SUBRANGEMIN to SUBRANGEMAX do
  begin
   RangeNoEdit.Text := IntToStr(T);
   Update;
   ValidateSubrangeOneFunctionButtonClick(nil);
   ProgressBar2.Position := T;
  end;
 ValidateAllSubrangesOneFunctionButton.Caption := OldCaption;
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

procedure TMainForm.ValidateSubRangeButtonClick(Sender: TObject);
var
 FunctionNo : Cardinal;
 FunctionName : AnsiString;
 OldCaption : AnsiString;

begin
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_LOWEST) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_LOWEST failed');
 IsPrimeReferenceFunction := IsPrime_HR_IA32_2;
// ReferenceFunctionIndex := 1;
 MaxSpeed := 0;
 OldCaption := ValidateSubRangeButton.Caption;
 ValidateSubRangeButton.Caption := 'Running';
 for FunctionNo := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   try
    FunctionSelectionRadioGroup.ItemIndex := FunctionNo;
    ValidateButton.Caption := 'Running';
    ValidationEdit.Color := clBlue;
    Update;
    FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
    if Validate7 then
     begin
      ValidationEdit.Color := clGreen;
      ReportRichEdit.Lines.Add(FunctionName
                       + #9 + 'Passed Range ' + RangeNoEdit.Text);
     end
    else
     begin
      ValidationEdit.Color := clRed;
      ReportRichEdit.Color := clRed;
      ReportRichEdit.Lines.Add(FunctionName
                       + #9 + 'Failed Range ' + RangeNoEdit.Text);
     end;
    ValidateButton.Caption := 'Validate';
   except
    ReportRichEdit.Lines.Add(FunctionName
                     + #9 + 'Failed Range ' + RangeNoEdit.Text);
   end;
  end;
 ValidateSubRangeButton.Caption := OldCaption;
end;

procedure TMainForm.ValidateSomeSubRangesButtonClick(Sender: TObject);
var
 T : Cardinal;
 OldCaption : AnsiString;
const
 SUBRANGEMIN : Cardinal = 1; //1->100
 SUBRANGEMAX : Cardinal = 100;//1->100

begin
 OldCaption := ValidateSomeSubRangesButton.Caption;
 ValidateSomeSubRangesButton.Caption := 'Running';
 ProgressBar2.Min := SUBRANGEMIN;
 ProgressBar2.Max := SUBRANGEMAX;
 for T := SUBRANGEMIN to SUBRANGEMAX do
  begin
   RangeNoEdit.Text := IntToStr(T);
   Update;
   ValidateSubRangeButtonClick(nil);
   ProgressBar2.Position := T;
  end;
 ValidateSomeSubRangesButton.Caption := OldCaption;
end;

procedure TMainForm.BenchmarkEditClick(Sender: TObject);
begin
 BenchmarkEdit.SelectAll;
 BenchmarkEdit.CopyToClipboard;
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
