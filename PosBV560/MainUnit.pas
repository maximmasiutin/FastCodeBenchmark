unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'Pos';

type
  TMainForm = class(TForm)
    CloseBitBtn: TBitBtn;
    ReportRichEdit: TRichEdit;
    SaveDialog1: TSaveDialog;
    RunAllBenchmarksButton: TButton;
    FunctionSelectRadioGroup: TRadioGroup;
    ProgressBar1: TProgressBar;
    AddressEdit: TEdit;
    Label2: TLabel;
    Panel1: TPanel;
    PrintSpeedButton: TSpeedButton;
    SaveAsSpeedButton: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ValidateAllButton: TButton;
    Run: TButton;
    BenchmarkPosRTLButton: TButton;
    ResultEdit: TEdit;
    ValidateButton: TButton;
    StatusBar1: TStatusBar;
    procedure FormDestroy(Sender: TObject);
    procedure RunClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure RunAllBenchmarksButtonClick(Sender: TObject);
    procedure FunctionSelectRadioGroupClick(Sender: TObject);
    procedure BenchmarkPosRTLButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure PrintSpeedButtonClick(Sender: TObject);
  private
   FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
   FResultList: TStringList;
   function SubBenchmark1 : Double;
   function SubBenchmark2 : Double;
   function  SubBenchmark2_JOH_PAS_6_Inlined : Double;
   function  SubBenchmark1_JOH_PAS_6_Inlined : Double;
   procedure FillTestStringArrays;
   procedure BenchmarkPosRTL;
   procedure BenchmarkPos;
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
   function Validate12: Boolean;
   function Validate13: Boolean;
   procedure SortRichEdit;
  public
    { Public declarations }
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, PosExJOHUnit, SystemInfoUnit, FastCodeCPUID, PosUnit, PosLPUnit, PosJOHUnit, PosShaUnit, PosShaUnit2;

type
 TPosFunction = function(const substr : AnsiString; const s : AnsiString ) : Integer;

var
 //Used in validation and benchmark
 SubStrArray : array[1..50] of String;
 StringArray : array[1..50] of String;
 PosFunction : TPosFunction;

const
 MAXNOOFRUNSSUB1 : Cardinal = 1683000;
 MAXNOOFRUNSSUB2 : Cardinal =  283000;
 SUBSTRARRAYSIZE : Cardinal = 50;
 STRINGARRAYSIZE : Cardinal = 50;
 RUNTIMESCALE : Cardinal = 100;

procedure TMainForm.BenchmarkPosRTL;
var
 FunctionName, PosFunctionAddressString : AnsiString;
 I, K1, K2, PosFunctionAddress : Integer;
 RunNo : Cardinal;
 StartTime1, EndTime1, RunTime1 : TDateTime;
 StartTime2, EndTime2, RunTime2 : TDateTime;
 RunTimeSec1, RunTimeSec2, RunTimeSecTotal : Double;

begin
 try
  FunctionName := FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex];
  I := 0;
  Update;
  PosFunctionAddress := Integer(@PosFunction);
  PosFunctionAddressString := IntToHex(PosFunctionAddress, 8);
  AddressEdit.Text := PosFunctionAddressString;
  Update;
  StartTime1 := Time;
  for RunNo := 1 to MAXNOOFRUNSSUB1 do
   begin
    for K1 := 1 to 35 do
     begin
      I := Pos(SubStrArray[K1], StringArray[K1]);
     end;
   end;
  EndTime1 := Time;
  RunTime1 := EndTime1 - StartTime1;
  StartTime2 := Time;
  for RunNo := 1 to MAXNOOFRUNSSUB2 do
   begin
    for K2 := 36 to SUBSTRARRAYSIZE do
     begin
      I := Pos(SubStrArray[K2], StringArray[K2]);
     end;
   end;
  EndTime2 := Time;
  RunTime2 := EndTime2 - StartTime2;
  RunTime1 := RunTime1*RUNTIMESCALE;
  RunTime2 := RunTime2*RUNTIMESCALE;
  RunTimeSec1 := (24 * 60 * 60 * RunTime1);
  RunTimeSec2 := (24 * 60 * 60 * RunTime2);
  RunTimeSecTotal := RunTimeSec1 + RunTimeSec2;
  ResultEdit.Text := IntToStr(I);
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                                     PosFunctionAddressString[8] + #9 +
                                     FloatToStrF(RunTimeSec1, ffFixed, 9, 0) + #9 +
                                     FloatToStrF(RunTimeSec2, ffFixed, 9, 0) + #9 +
                                     FloatToStrF(RunTimeSecTotal, ffFixed, 9, 0));
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                                     'Failed' + #9 +
                                     '9999' + #9 +
                                     '9999' + #9 +
                                     '9999');
 end;
end;

procedure TMainForm.BenchmarkPos;
var
 Bench, SubBench1, SubBench2 : Double;
 FunctionName, PosFunctionAddressString : AnsiString;
 PosFunctionAddress : Cardinal;

begin
 try
  FunctionName := FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex];
  PosFunctionAddress := Integer(@PosFunction);
  PosFunctionAddressString := IntToHex(PosFunctionAddress, 8);
  AddressEdit.Text := PosFunctionAddressString;
  Update;
  if FunctionName='Pos_JOH_PAS_6' then
   begin
    SubBench1 := SubBenchmark1_JOH_PAS_6_Inlined;
    SubBench2 := SubBenchmark2_JOH_PAS_6_Inlined;
   end
  else
   begin
    SubBench1 := SubBenchmark1;
    SubBench2 := SubBenchmark2;
   end;
  Bench := SubBench1 + SubBench2;
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                           PosFunctionAddressString[8] + #9 +
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
 I, K : Cardinal;
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 I := 0;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNSSUB1 do
  begin
   for K := 1 to 35 do
    begin
     I := PosFunction(SubStrArray[K], StringArray[K]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 ResultEdit.Text := IntToStr(I);
 RunTimeSec := (24 * 60 * 60 * RunTime);
 Result := RunTimeSec * RUNTIMESCALE;
end;

function TMainForm.SubBenchmark2 : Double;
var
 I, K : Cardinal;
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 I := 0;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNSSUB2 do
  begin
   for K := 36 to SUBSTRARRAYSIZE do
    begin
     I := PosFunction(SubStrArray[K], StringArray[K]);
    end;
  end;
 ResultEdit.Text := IntToStr(I);
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 * 60 * RunTime);
 Result := RunTimeSec * RUNTIMESCALE;
end;

procedure TMainForm.RunClick(Sender: TObject);
begin
 BenchmarkPos;
 if ReportRichEdit.Lines.Count > 1 then
  SortRichEdit;
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName : AnsiString;

begin
 try
  FunctionName := FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex];
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
     Validate13 then
   ReportRichEdit.Lines.Add(FunctionName + #9 + #9 + 'Passed')
  else
   ReportRichEdit.Lines.Add(FunctionName + #9 + #9 + 'Failed');
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + #9 + 'Failed');
 end;
end;

function TMainForm.Validate1 : Boolean;
var
 I, Iref, J, K : Integer;
 SubS, S : String;

begin
 try
  StatusBar1.SimpleText := 'Running Validate1';
  Update;
  Result := True;
  for K := 1 to SUBSTRARRAYSIZE do
   begin
    for J := 1 to STRINGARRAYSIZE do
     begin
      SubS := SubStrArray[J];
      S := StringArray[K];
      Iref := Pos(SubS, S);
      I := PosFunction(SubS, S);
      if I <> Iref then
       begin
        Result := False;
        Exit;
       end;
     end;
    end;
 except
  Result := False;
 end;
end;

function TMainForm.Validate2 : Boolean;
var
 I, Iref, J, K : Integer;
 SubS, S : String;
const
 VALIDATE2MIN : Integer = 1;
 VALIDATE2MAX : Integer = 255;

begin
 StatusBar1.SimpleText := 'Running Validate2';
 Update;
 Result := True;
 ProgressBar1.Max := VALIDATE2MAX;
 for K := VALIDATE2MIN to VALIDATE2MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   for J := VALIDATE2MIN to VALIDATE2MAX do
    begin
     SubS := Char(K);
     S := Char(J);
     Iref := Pos(SubS, S);
     I := PosFunction(SubS, S);
     if I <> Iref then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.Validate3 : Boolean;
var
 I, Iref, J, K, W : Integer;
 SubS, S : String;
const
 VALIDATE3MIN : Integer = 1;
 VALIDATE3MAX : Integer = 255;

begin
 StatusBar1.SimpleText := 'Running Validate3';
 Update;
 Result := True;
 ProgressBar1.Min := VALIDATE3MIN;
 ProgressBar1.Max := VALIDATE3MAX;
 for W := VALIDATE3MIN to VALIDATE3MAX do
  begin
   ProgressBar1.Position := W;
   Update;
   for K := VALIDATE3MIN to VALIDATE3MAX do
    begin
     for J := VALIDATE3MIN to VALIDATE3MAX do
      begin
       SubS := Char(K);
       S := Char(J) + Char(W);
       Iref := Pos(SubS, S);
       I := PosFunction(SubS, S);
       if I <> Iref then
        begin
         Result := False;
         Exit;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate4 : Boolean;
var
 I, Iref, J, K, W, Q : Integer;
 SubS, S : String;
const
 VALIDATE4MIN : Integer = 100;
 VALIDATE4MAX : Integer = 155;

begin
 StatusBar1.SimpleText := 'Running Validate4';
 Update;
 Result := True;
 ProgressBar1.Min := VALIDATE4MIN;
 ProgressBar1.Max := VALIDATE4MAX;
 for Q := VALIDATE4MIN to VALIDATE4MAX do
  begin
   ProgressBar1.Position := Q;
   for W := VALIDATE4MIN to VALIDATE4MAX do
    begin
     Update;
     for K := VALIDATE4MIN to VALIDATE4MAX do
      begin
       for J := VALIDATE4MIN to VALIDATE4MAX do
        begin
         SubS := Char(K) + Char(Q);
         S := Char(J) + Char(W);
         Iref := Pos(SubS, S);
         I := PosFunction(SubS, S);
         if I <> Iref then
          begin
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate5 : Boolean;
var
 I, Iref, J, K, W, Q : Integer;
 SubS, S : String;
const
 VALIDATE5MIN : Integer = 0;
 VALIDATE5MAX : Integer = 40;

begin
 StatusBar1.SimpleText := 'Running Validate5';
 Update;
 Result := True;
 ProgressBar1.Min := VALIDATE5MIN;
 ProgressBar1.Max := VALIDATE5MAX;
 for Q := VALIDATE5MIN to VALIDATE5MAX do
  begin
   ProgressBar1.Position := Q;
   for W := VALIDATE5MIN to VALIDATE5MAX do
    begin
     Update;
     for K := VALIDATE5MIN to VALIDATE5MAX do
      begin
       for J := VALIDATE5MIN to VALIDATE5MAX do
        begin
         SubS := Char(K);
         S := Char(J) + Char(W) + Char(Q);
         Iref := Pos(SubS, S);
         I := PosFunction(SubS, S);
         if I <> Iref then
          begin
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate6 : Boolean;
var
 I, Iref, J, K, W, Q, T : Integer;
 SubS, S : String;
const
 VALIDATE6MIN1 : Integer = 0;
 VALIDATE6MAX1 : Integer = 85;

begin
 StatusBar1.SimpleText := 'Running Validate6';
 Update;
 Result := True;
 ProgressBar1.Min := VALIDATE6MIN1;
 ProgressBar1.Max := VALIDATE6MAX1;
 for T := VALIDATE6MIN1 to VALIDATE6MAX1 do
  begin
   ProgressBar1.Position := T;
   for Q := 0 to 20 do
    begin
     Update;
     for W := 65 to 75 do
      begin
       for K := 65 to 75 do
        begin
         for J := 85 to 100 do
          begin
           SubS := Char(K);
           S := Char(J) + Char(W) + Char(Q) + Char(T);
           Iref := Pos(SubS, S);
           I := PosFunction(SubS, S);
           if I <> Iref then
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

function TMainForm.Validate7 : Boolean;
var
 I, Iref, J, K, W, Q, T, R : Integer;
 SubS, S : String;
const
 VALIDATE7MIN1 : Integer = 55;
 VALIDATE7MAX1 : Integer = 60;

begin
 StatusBar1.SimpleText := 'Running Validate7';
 Update;
 Result := True;
 ProgressBar1.Min := VALIDATE7MIN1;
 ProgressBar1.Max := VALIDATE7MAX1;
 for R := VALIDATE7MIN1 to VALIDATE7MAX1 do
  begin
   ProgressBar1.Position := R;
   for T := VALIDATE7MIN1 to VALIDATE7MAX1 do
    begin
     for Q := VALIDATE7MIN1 to VALIDATE7MAX1 do
      begin
       Update;
       for W := VALIDATE7MIN1 to VALIDATE7MAX1 do
        begin
         for K := VALIDATE7MIN1 to VALIDATE7MAX1 do
          begin
           for J := VALIDATE7MIN1 to VALIDATE7MAX1 do
            begin
             SubS := Char(K);
             S := Char(J) + Char(W) + Char(Q) + Char(T) + Char(R);
             Iref := Pos(SubS, S);
             I := PosFunction(SubS, S);
             if I <> Iref then
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

var
 SGlobal, SubGlobal : string;

function TMainForm.Validate8 : Boolean;
var
 I : Integer;

begin
 StatusBar1.SimpleText := 'Running Validate8';
 Update;
 SubGlobal := 'zz';
 SGlobal := 'zz';
 (PInteger(Integer(SubGlobal)-4))^ := 0;
 I := PosFunction(SubGlobal, SGlobal);
 //Cannot find empty substring in string -> I must be 0
 if I = 0 then
  Result := True
 else
  Result := False;
end;

function TMainForm.Validate9 : Boolean;
var
 I : Integer;

begin
 StatusBar1.SimpleText := 'Running Validate9';
 Update;
 SubGlobal := 'z';
 SGlobal := 'z';
 (PInteger(Integer(SGlobal)-4))^ := 0;
 I := PosFunction(SubGlobal, SGlobal);
 //Cannot find anything in empty string -> I must be 0
 if I = 0 then
  Result := True
 else
  Result := False;
end;

function TMainForm.Validate10 : Boolean;
var
 I : Integer;

begin
 StatusBar1.SimpleText := 'Running Validate10';
 Update;
 SubGlobal := 'z';
 SGlobal := 'z';
 (PInteger(Integer(SGlobal)-4))^ := 0;
 (PInteger(Integer(SubGlobal)-4))^ := 0;
 I := PosFunction(SubGlobal, SGlobal);
 //Cannot find empty substring in empty string -> I must be 0
 if I = 0 then
  Result := True
 else
  Result := False;
end;

var
  GlobalStr: AnsiString;

function TMainForm.Validate11 : Boolean;
begin
 StatusBar1.SimpleText := 'Running Validate11';
 Update;
 GlobalStr := '0';
 PInteger(Integer(GlobalStr)-4)^ := 0; {Set Length to 0}
 Result := PosFunction('0', GlobalStr) = 0;
 if not Result then
  Exit;
 Result := PosFunction(GlobalStr, '0') = 0;
 if not Result then
  Exit;
 Result := PosFunction(GlobalStr, GlobalStr) = 0;
end;

function TMainForm.Validate12 : Boolean;
var
 I, J, K : Integer;
 SubS, S : String;
const
 VALIDATE12MIN : Integer = 0;
 VALIDATE12MAX : Integer = 255;

begin
 StatusBar1.SimpleText := 'Running Validate12';
 Update;
 Result := True;
 ProgressBar1.Max := VALIDATE12MAX;
 for K := VALIDATE12MIN to VALIDATE12MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   S := '';
   for J := VALIDATE12MIN to VALIDATE12MAX do
    begin
     SubS := Char(K);
     S := Char(J) + S;
     I := PosFunction(SubS, S);
     if J < K then
      begin
       //No match possible
       if I <> 0 then
        begin
         Result := False;
         Exit;
        end;
      end
     else
      begin
       if I <> J-K+1 then
        begin
         Result := False;
         Exit;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate13 : Boolean;
var
 I, Iref, J, K : Integer;
 SubS, S : String;
const
 VALIDATE12MIN : Integer = 0;
 VALIDATE12MAX : Integer = 155;

begin
 StatusBar1.SimpleText := 'Running Validate13';
 Update;
 Result := True;
 ProgressBar1.Max := VALIDATE12MAX;
 for K := VALIDATE12MIN to VALIDATE12MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   S := '';
   SubS := '';
   for J := VALIDATE12MIN to VALIDATE12MAX do
    begin
     SubS := SubS + Char(K) + Char(J) + Char(Random(255));
     S := S + SubS + Char(J);
     Iref := Pos(SubS, S);
     I := PosFunction(SubS, S);
     if I <> Iref then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

procedure TMainForm.FillTestStringArrays;
var
 S : AnsiString;
 I : Integer;

begin
 //Subbenchmark 1

 SubStrArray[1]  := '';
 StringArray[1]  := '';

 SubStrArray[2]  := ' ';
 StringArray[2]  := ' ';

 SubStrArray[3]  := 'A';
 StringArray[3]  := 'B';

 SubStrArray[4]  := 'B';
 StringArray[4]  := 'AB';

 SubStrArray[5]  := 'x';
 StringArray[5]  := 'ab';

 SubStrArray[6]  := 'x';
 StringArray[6]  := 'abc';

 SubStrArray[7]  := 'c';
 StringArray[7]  := 'abc';

 SubStrArray[8]  := 'x';
 StringArray[8]  := 'abcde';

 SubStrArray[9]  := 'e';
 StringArray[9]  := 'abcde';

 SubStrArray[10]  := 'x';
 StringArray[10]  := 'abcdef';

 SubStrArray[11]  := 'f';
 StringArray[11]  := 'abcdef';

 SubStrArray[12]  := 'x';
 StringArray[12]  := 'abcdefg';

 SubStrArray[13]  := 'g';
 StringArray[13]  := 'abcdefg';

 SubStrArray[14]  := 'aa';
 StringArray[14]  := 'bbcc';

 SubStrArray[15]  := 'ab';
 StringArray[15]  := 'ABCab';

 SubStrArray[16]  := 'bcd';
 StringArray[16]  := 'abcd';

 SubStrArray[17]  := 'xxx';
 StringArray[17]  := 'abcde';

 SubStrArray[18]  := 'efg';
 StringArray[18]  := 'xxxxxxabcdefg';

 SubStrArray[19]  := 'yyy';
 StringArray[19]  := 'xxxxxxxabcdefg';

 SubStrArray[20]  := 'cd';
 StringArray[20]  := 'xxxxxxxxabcdefg';

 SubStrArray[21]  := 'yy';
 StringArray[21]  := 'xxxxxxxxabcdefg';

 SubStrArray[22]  := 'a';
 StringArray[22]  := 'abcdefg';

 SubStrArray[23]  := 'b';
 StringArray[23]  := 'abcdefg';

 SubStrArray[24]  := 'e';
 StringArray[24]  := 'abcdefg';

 SubStrArray[25]  := 'f';
 StringArray[25]  := 'abcdefg';

 SubStrArray[26]  := 'c.6';
 StringArray[26]  := 'Woman';

 SubStrArray[27]  := 'efg';
 StringArray[27]  := 'abcdefg';

 SubStrArray[28]  := 'efg';
 StringArray[28]  := 'xxxxxxxxxabcdefg';

 SubStrArray[29]  := 'Object';
 StringArray[29]  := 'DelphiObjectPascal';

 SubStrArray[30]  := 'e';
 StringArray[30]  := 'xxxxxxxxxxxxxxxxxxxx';

 SubStrArray[31]  := 'o W';
 StringArray[31]  := 'Hello World';

 SubStrArray[32]  := 'ey';
 StringArray[32]  := 'xxxexxxexxxxexxxxxxxxexx';

 SubStrArray[33]  := 'ey';
 StringArray[33]  := 'xxxexxxexxxxexxxxxxxxxxxey';

 SubStrArray[34]  := 'ens';
 StringArray[34]  := 'Dennis Kjaer Christensen';

 SubStrArray[35]  := 'ObjectPascalCox';
 StringArray[35]  := 'DelphiObjectPascalCompilerInlineAssembler';

 //Sub benchmark 2

 SubStrArray[36] := 'language';
 StringArray[36]  := 'Pascal is a wonderfull programming language';

 SubStrArray[37] := 'TTTTTT';
 StringArray[37]  := 'A cow jumps over a pig because it is lazy etc.';

 SubStrArray[38] := '1re dgfDG';
 StringArray[38] := 'ABCDEFGHIJQRSLPYTESD!"#¤%&//())=?`¨-.,~|}][{$£@½§abcdefghijklmnopqrst+uvw';

 SubStrArray[39] := 'file';
 StringArray[39] := 'cfsrjilchwe6384582c0rsor+02807fXEA#"!#&P=(=NJ CW#GYIYR/R&VRDES45x21a1re dgfDGDGHHHHHHH';

 SubStrArray[40] := 'GHHHHHHH';
 StringArray[40] := 'cfsrjiGDRtyr5413276in9pn  GFYFYt tr6544221YFHTTTTTTTTDDDWWWWfkjcsefkwhn,mnfvgnhgbjrcsfhbvajfWorldlchwe6384582c0rsor+02807fXEA#"!#&P=(=NJ CW#GYIYR/R&VRDES45x21a1re dgfDGDGHHHHHHH';

 SubStrArray[41] := 'The contents of this email and the attached file are for your exclusive use and should not be shared with others';
 StringArray[41] := 'The contents of this email and the attached file are for your exclusive use and should not be shared with others';

 SubStrArray[42] := 'The contents of this email and the attached file are for your exclusive use and should not be shared with others';
 StringArray[42] := 'XThe contents of this email and the attached file are for your exclusive use and should not be shared with others';

 SubStrArray[43] := 'The contents of this email and the attached file are for your exclusive use and should not be shared with others The contents of this email and the attached file are for your exclusive use and should not be shared with others';
 StringArray[43] := 'XThe contents of this email and the attached file are for your exclusive use and should not be shared with others XThe contents of this email and the attached file are for your exclusive use and should not be shared with others';

 SubStrArray[44] := 'ABC';
 StringArray[44] := 'ABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABX';

 SubStrArray[45] := 'ABCDEFG';
 StringArray[45] := 'xxxxCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFG';

 SubStrArray[46] := 'ABCDEFGHIJ';
 StringArray[46] := 'ABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIJ';

 SubStrArray[47] := 'ABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIAB';
 StringArray[47] := 'ABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIJ';

 SubStrArray[48] := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 StringArray[48] := 'lhfgRgjfjrt424189GVGDg65klækloytysweaweq1234sgfcnbjhg%¤%¤YVJVFHS#DSWERFHJOUYFDEQA"!E/&())JLPJVGDCXXSNBVCXDAZSERTGBAFDSVXXDAZDSAABCDEFGHIJKLMNOPQRSTUVWXYZ';

 SetLength(S, 255);
 for I := 1 to 255 do
 begin
  if Char(I) <> 'X' then
   S[I] := Char(I)
  else
   S[I] := 'W'
 end;

 SubStrArray[49] := 'XYZWQABGH';
 StringArray[49] := S + S + S + S + S + S + S + S + S + 'XYZWQABGH';

 SubStrArray[50] := S + S + 'XYZ';
 StringArray[50] := S + S + S + S + S + S + S + S + S + 'XYZWQABGH';
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
    MCW_EM = DWord($133f);
var CpuString : string;
begin
 AddressEdit.Text := '';
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 90;
 ReportRichEdit.Paragraph.Tab[1] := 125;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 225;
 FillTestStringArrays;
 PosFunction := Pos_RTL_IA32;

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
   PostMessage(Handle, WM_POSTPROCESSING, 0, 0);

 Set8087CW(MCW_EM);
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

procedure TMainForm.RunAllBenchmarksButtonClick(Sender: TObject);
var
 I1 : Integer;

begin
 RunAllBenchmarksButton.Caption := 'Running';
 for I1 := 0 to FunctionSelectRadioGroup.Items.Count-1 do
  begin
   FunctionSelectRadioGroup.ItemIndex := I1;
   BenchmarkPos;
   if ReportRichEdit.Lines.Count > 1 then
    SortRichEdit;
  end;
 RunAllBenchmarksButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.FunctionSelectRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectRadioGroup.ItemIndex of
    0 : PosFunction := Pos_RTL_IA32;
    1 : PosFunction := Pos_RTL_PAS;
    2 : PosFunction := Pos_DKC_PAS_65;
    3 : PosFunction := Pos_Sha_Pas_0;
    4 : PosFunction := Pos_Sha_Pas_1;
    5 : PosFunction := Pos_Sha_Pas_2;
    6 : PosFunction := Pos_Sha_Pas_3;
    7 : PosFunction := Pos_Sha_IA32_3;
    8 : PosFunction := Pos_Sha_IA32_4;
    9 : PosFunction := Pos_Sha_IA32_5;
   10 : PosFunction := Pos_JOH_PAS_3;
   11 : PosFunction := Pos_JOH_PAS_4;
   12 : PosFunction := Pos_JOH_MMX_3;
   13 : PosFunction := Pos_JOH_SSE_3;
   14 : PosFunction := Pos_JOH_SSE2_3;
   15 : PosFunction := Pos_JOH_IA32_5;
   16 : PosFunction := Pos_JOH_IA32_6;
   17 : PosFunction := Pos_JOH_PAS_6;
   18 : PosFunction := Pos_JOH_IA32_7;
  else
   raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.BenchmarkPosRTLButtonClick(Sender: TObject);
begin
 BenchmarkPosRTL;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Integer;
 FunctionName : AnsiString;

begin
 ValidateAllButton.Caption := 'Running';
  for I := 0 to FunctionSelectRadioGroup.Items.Count-1 do
   begin
    FunctionSelectRadioGroup.ItemIndex := I;
    FunctionName := FunctionSelectRadioGroup.Items[FunctionSelectRadioGroup.ItemIndex];
    try
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
        Validate13 then
      ReportRichEdit.Lines.Add(FunctionName + #9 + #9 + 'Passed')
     else
      ReportRichEdit.Lines.Add(FunctionName + #9 + #9 + 'Failed');
     Update;
    except
     ReportRichEdit.Lines.Add(FunctionName + #9 + #9 + 'Failed');
    end;
   end;
 ValidateAllButton.Caption := 'Validate All';
 StatusBar1.SimpleText := 'Validate All Completed';

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 try
  FResultList.Add(Format('Running "%s" validation version %s with compiler settings: "%s".', [ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 except end;
 try
  FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 except end;
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('Pos Benchmark Results');
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
    RunAllBenchmarksButton.Click;
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


function TMainForm.SubBenchmark1_JOH_PAS_6_Inlined : Double;
var
 I, K : Cardinal;
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 I := 0;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNSSUB1 do
  begin
   for K := 1 to 35 do
    begin
     I := Pos_JOH_PAS_6(SubStrArray[K], StringArray[K]);
    end;
  end;
 EndTime := Time;
 RunTime := EndTime - StartTime;
 ResultEdit.Text := IntToStr(I);
 RunTimeSec := (24 * 60 * 60 * RunTime);
 Result := RunTimeSec * RUNTIMESCALE;
end;

function TMainForm.SubBenchmark2_JOH_PAS_6_Inlined : Double;
var
 I, K : Cardinal;
 RunNo : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 RunTimeSec : Double;

begin
 I := 0;
 StartTime := Time;
 for RunNo := 1 to MAXNOOFRUNSSUB2 do
  begin
   for K := 36 to SUBSTRARRAYSIZE do
    begin
     I := Pos_JOH_PAS_6(SubStrArray[K], StringArray[K]);
    end;
  end;
 ResultEdit.Text := IntToStr(I);
 EndTime := Time;
 RunTime := EndTime - StartTime;
 RunTimeSec := (24 * 60 * 60 * RunTime);
 Result := RunTimeSec * RUNTIMESCALE;
end;


end.
