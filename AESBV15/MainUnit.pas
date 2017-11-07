unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

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
    Label10: TLabel;
    ShowErrorDialogCheckBox: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label20: TLabel;
    Label22: TLabel;
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
    procedure ClearAllEditBoxes;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    function SubBenchmark1 : Cardinal;
    function SubBenchmark2 : Cardinal;
    function SubBenchmark3 : Cardinal;
    function SubBenchmark4 : Cardinal;
    function SubBenchmark5 : Cardinal;
    function SubBenchmark6 : Cardinal;
    function SubBenchmark7 : Cardinal;
    function SubBenchmark8 : Cardinal;
  public
    { Public declarations }
  end;

var
 MainForm: TMainForm;

implementation

uses
 AESReferenceWrapperUnit, AESTurboLockUnit, AESLBGUnit, AESWEUnit, AES_JOH,
 AESDKCUnit16, AESDKCUnit19, AESDKCUnit20, AESDKCUnit21, AESDKCUnit22,
  AESDKCUnit23, AESWE6, AESDKCUnit24, AESDKCUnit25, AESDKCUnit26,
  AESDKCUnit27, AESDKCUnit28, AES_JOH_2, AESDKCUnit29, AESDKCUnit30,
  AESDKCUnit31, AESDKCUnit32, AESDKCUnit33, AESDKCUnit34, AESDKCUnit35,
  AESDKCUnit36, AESDKCUnit37, AESDKCUnit38, AESDKCUnit39;

{$R *.dfm}

const
 MAXWORD : Word = $FFFF;
 NOOFRUNS : Cardinal = 100000;
 NOOFRERUNS : Cardinal = 10;
 MAXVALIDATE8 : Byte = 255;
 MAXVALIDATE9 : Byte = 255;
 MAXVALIDATE10 : Byte = 255;
 MAXVALIDATE11 : Byte = 255;
 MAXVALIDATE12 : Byte = 255;
 MAXVALIDATE13 : Byte = 255;
 MAXVALIDATE14 : Byte = 255;
 MINVALIDATE15 : Byte = 2;
 MAXVALIDATE15 : Byte = 3;
 MINVALIDATE16 : Byte = 3;
 MAXVALIDATE16 : Byte = 4;
 MINVALIDATE17 : Byte = 4;
 MAXVALIDATE17 : Byte = 5;
 MINVALIDATE18 : Byte = 13;
 MAXVALIDATE18 : Byte = 14;
 MINVALIDATE19 : Byte = 252;
 MAXVALIDATE19 : Byte = 253;
 MINVALIDATE20 : Byte = 113;
 MAXVALIDATE20 : Byte = 114;
 VALIDATE11BLOCKPOS : Byte = 2;
 VALIDATE10BLOCKPOS : Byte = 1;
 VALIDATE21MAXRUNNO : Cardinal = 20000;
 VALIDATE22MAXRUNNO : Cardinal = 20000;
 VALIDATE23MAXRUNNO : Cardinal = 20000;

type
 TAESMakeContextProcedure = procedure (const Key; KeySize : Cardinal);
 TAESEncryptProcedure = procedure (var Block);
 TAESDecryptProcedure = procedure (var Block);

var
 AESEncryptProcedure : TAESEncryptProcedure;
 AESDecryptProcedure : TAESDecryptProcedure;
 AESMakeContextProcedure : TAESMakeContextProcedure;
 NoOfTicksArray : array of Int64;
 lpFrequency : Int64;
 //SubBench1Block : array[0..31] of Byte;//16 byte data + 15 bytes max room for alignment
 //SubBench2Block : array[0..31] of Byte;//16 byte data + 15 bytes max room for alignment
 //SubBench3Block : array[0..31] of Byte;//16 byte data + 15 bytes max room for alignment
 //SubBench4Block : array[0..31] of Byte;//16 byte data + 15 bytes max room for alignment
 //SubBench5Block : array[0..31] of Byte;//16 byte data + 15 bytes max room for alignment
 //SubBench6Block : array[0..31] of Byte;//16 byte data + 15 bytes max room for alignment
 //SubBench7Block : array[0..31] of Byte;//16 byte data + 15 bytes max room for alignment
 //SubBench8Block : array[0..31] of Byte;//16 byte data + 15 bytes max room for alignment
 SubBenchBlock : array[0..31] of Byte;//16 byte data + 15 bytes max room for alignment
 BlockOffset16ByteAlign : Integer;
 BlockOffset8ByteAlign : Integer;
 BlockOffset4ByteAlign : Integer;
 BlockOffsetNonAlign : Integer;

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

procedure ClearNoOfTicksArray;
var
 I : Cardinal;

begin
 for I := 0 to High(NoOfTicksArray) do
  NoOfTicksArray[I] := 0;
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
    if Bench2 > Bench1 then //Bigger is better
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

procedure ErrorTrap(ValidateNo : Cardinal);
begin
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo)), 'Error');
end;

//*****************************************************************************
//Validate 1 to 6 validates against official reference vectors from the
//Rijndael/AES authors. Vectors are copied from their book "The Design of Rijndael"
//Bloksize is 128 bit. Keysizes are 128, 192 and 256 bit. Mode is encryption (only)
//*****************************************************************************

function Validate1 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 VALIDATENO : Cardinal = 1;

begin
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 KeySize := 4;
 AESMakeContextProcedure(Key, KeySize);
 Block[0] := 0;
 Block[1] := 0;
 Block[2] := 0;
 Block[3] := 0;
 Block[4] := 0;
 Block[5] := 0;
 Block[6] := 0;
 Block[7] := 0;
 Block[8] := 0;
 Block[9] := 0;
 Block[10] := 0;
 Block[11] := 0;
 Block[12] := 0;
 Block[13] := 0;
 Block[14] := 0;
 Block[15] := 0;
 AESEncryptProcedure(Block);
 if (Block[0] = $66) and
    (Block[1] = $E9) and
    (Block[2] = $4B) and
    (Block[3] = $D4) and
    (Block[4] = $EF) and
    (Block[5] = $8A) and
    (Block[6] = $2C) and
    (Block[7] = $3B) and
    (Block[8] = $88) and
    (Block[9] = $4C) and
    (Block[10] = $FA) and
    (Block[11] = $59) and
    (Block[12] = $CA) and
    (Block[13] = $34) and
    (Block[14] = $2B) and
    (Block[15] = $2E) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

function Validate2 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 VALIDATENO : Cardinal = 2;

begin
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 Block[0] := $66;
 Block[1] := $E9;
 Block[2] := $4B;
 Block[3] := $D4;
 Block[4] := $EF;
 Block[5] := $8A;
 Block[6] := $2C;
 Block[7] := $3B;
 Block[8] := $88;
 Block[9] := $4C;
 Block[10] := $FA;
 Block[11] := $59;
 Block[12] := $CA;
 Block[13] := $34;
 Block[14] := $2B;
 Block[15] := $2E;
 KeySize := 4;
 AESMakeContextProcedure(Key, KeySize);
 AESEncryptProcedure(Block);
 if (Block[0] = $F7) and
    (Block[1] = $95) and
    (Block[2] = $BD) and
    (Block[3] = $4A) and
    (Block[4] = $52) and
    (Block[5] = $E2) and
    (Block[6] = $9E) and
    (Block[7] = $D7) and
    (Block[8] = $13) and
    (Block[9] = $D3) and
    (Block[10] = $13) and
    (Block[11] = $FA) and
    (Block[12] = $20) and
    (Block[13] = $E9) and
    (Block[14] = $8D) and
    (Block[15] = $BC) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

function Validate3 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
const
 VALIDATENO : Cardinal = 3;

begin
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 Key[9] := 0;
 Key[10] := 0;
 Key[11] := 0;
 Key[12] := 0;
 KeySize := 6;
 AESMakeContextProcedure(Key, KeySize);
 Block[0] := 0;
 Block[1] := 0;
 Block[2] := 0;
 Block[3] := 0;
 Block[4] := 0;
 Block[5] := 0;
 Block[6] := 0;
 Block[7] := 0;
 Block[8] := 0;
 Block[9] := 0;
 Block[10] := 0;
 Block[11] := 0;
 Block[12] := 0;
 Block[13] := 0;
 Block[14] := 0;
 Block[15] := 0;
 AESEncryptProcedure(Block);
 if (Block[0] = $AA) and
    (Block[1] = $E0) and
    (Block[2] = $69) and
    (Block[3] = $92) and
    (Block[4] = $AC) and
    (Block[5] = $BF) and
    (Block[6] = $52) and
    (Block[7] = $A3) and
    (Block[8] = $E8) and
    (Block[9] = $F4) and
    (Block[10] = $A9) and
    (Block[11] = $6E) and
    (Block[12] = $C9) and
    (Block[13] = $30) and
    (Block[14] = $0B) and
    (Block[15] = $D7) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

function Validate4 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
const
 VALIDATENO : Cardinal = 4;

begin
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 Key[9] := 0;
 Key[10] := 0;
 Key[11] := 0;
 Key[12] := 0;
 Block[0] := $AA;
 Block[1] := $E0;
 Block[2] := $69;
 Block[3] := $92;
 Block[4] := $AC;
 Block[5] := $BF;
 Block[6] := $52;
 Block[7] := $A3;
 Block[8] := $E8;
 Block[9] := $F4;
 Block[10] := $A9;
 Block[11] := $6E;
 Block[12] := $C9;
 Block[13] := $30;
 Block[14] := $0B;
 Block[15] := $D7;
 KeySize := 6;
 AESMakeContextProcedure(Key, KeySize);
 AESEncryptProcedure(Block);
 if (Block[0] = $52) and
    (Block[1] = $F6) and
    (Block[2] = $74) and
    (Block[3] = $B7) and
    (Block[4] = $B9) and
    (Block[5] = $03) and
    (Block[6] = $0F) and
    (Block[7] = $DA) and
    (Block[8] = $B1) and
    (Block[9] = $3D) and
    (Block[10] = $18) and
    (Block[11] = $DC) and
    (Block[12] = $21) and
    (Block[13] = $4E) and
    (Block[14] = $B3) and
    (Block[15] = $31) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

function Validate5 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
const
 VALIDATENO : Cardinal = 5;

begin
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 Key[9] := 0;
 Key[10] := 0;
 Key[11] := 0;
 Key[12] := 0;
 Key[13] := 0;
 Key[14] := 0;
 Key[15] := 0;
 Key[16] := 0;
 KeySize := 8;
 AESMakeContextProcedure(Key, KeySize);
 Block[0] := 0;
 Block[1] := 0;
 Block[2] := 0;
 Block[3] := 0;
 Block[4] := 0;
 Block[5] := 0;
 Block[6] := 0;
 Block[7] := 0;
 Block[8] := 0;
 Block[9] := 0;
 Block[10] := 0;
 Block[11] := 0;
 Block[12] := 0;
 Block[13] := 0;
 Block[14] := 0;
 Block[15] := 0;
 AESEncryptProcedure(Block);
 if (Block[0] = $DC) and
    (Block[1] = $95) and
    (Block[2] = $C0) and
    (Block[3] = $78) and
    (Block[4] = $A2) and
    (Block[5] = $40) and
    (Block[6] = $89) and
    (Block[7] = $89) and
    (Block[8] = $AD) and
    (Block[9] = $48) and
    (Block[10] = $A2) and
    (Block[11] = $14) and
    (Block[12] = $92) and
    (Block[13] = $84) and
    (Block[14] = $20) and
    (Block[15] = $87) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

function Validate6 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
const
 VALIDATENO : Cardinal = 6;

begin
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 Key[9] := 0;
 Key[10] := 0;
 Key[11] := 0;
 Key[12] := 0;
 Key[13] := 0;
 Key[14] := 0;
 Key[15] := 0;
 Key[16] := 0;
 Block[0] := $DC;
 Block[1] := $95;
 Block[2] := $C0;
 Block[3] := $78;
 Block[4] := $A2;
 Block[5] := $40;
 Block[6] := $89;
 Block[7] := $89;
 Block[8] := $AD;
 Block[9] := $48;
 Block[10] := $A2;
 Block[11] := $14;
 Block[12] := $92;
 Block[13] := $84;
 Block[14] := $20;
 Block[15] := $87;
 KeySize := 8;
 AESMakeContextProcedure(Key, KeySize);
 AESEncryptProcedure(Block);
 if (Block[0] = $08) and
    (Block[1] = $C3) and
    (Block[2] = $74) and
    (Block[3] = $84) and
    (Block[4] = $8C) and
    (Block[5] = $22) and
    (Block[6] = $82) and
    (Block[7] = $33) and
    (Block[8] = $C2) and
    (Block[9] = $B3) and
    (Block[10] = $4F) and
    (Block[11] = $33) and
    (Block[12] = $2B) and
    (Block[13] = $D2) and
    (Block[14] = $E9) and
    (Block[15] = $D3) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

//*****************************************************************************
//Validate 7 validates against official reference vectors from the
//Rijndael/AES authors.
//Bloksize is 128 bit. Keysizes is 128. Mode is encryption (only)
//*****************************************************************************

function Validate7 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..16] of Byte;//16 * 8 = 128 bit = KeySize = 4
const
 VALIDATENO : Cardinal = 7;

begin
 Key[1] := $2b;
 Key[2] := $7e;
 Key[3] := $15;
 Key[4] := $16;
 Key[5] := $28;
 Key[6] := $ae;
 Key[7] := $d2;
 Key[8] := $a6;
 Key[9] := $ab;
 Key[10] := $f7;
 Key[11] := $15;
 Key[12] := $88;
 Key[13] := $09;
 Key[14] := $cf;
 Key[15] := $4f;
 Key[16] := $3c;
 KeySize := 4;
 AESMakeContextProcedure(Key, KeySize);
 Block[0] := $32;
 Block[1] := $43;
 Block[2] := $f6;
 Block[3] := $a8;
 Block[4] := $88;
 Block[5] := $5a;
 Block[6] := $30;
 Block[7] := $8d;
 Block[8] := $31;
 Block[9] := $31;
 Block[10] := $98;
 Block[11] := $a2;
 Block[12] := $e0;
 Block[13] := $37;
 Block[14] := $07;
 Block[15] := $34;
 AESEncryptProcedure(Block);
 if (Block[0] = $39) and
    (Block[1] = $25) and
    (Block[2] = $84) and
    (Block[3] = $1d) and
    (Block[4] = $02) and
    (Block[5] = $dc) and
    (Block[6] = $09) and
    (Block[7] = $fb) and
    (Block[8] = $dc) and
    (Block[9] = $11) and
    (Block[10] = $85) and
    (Block[11] = $97) and
    (Block[12] = $19) and
    (Block[13] = $6a) and
    (Block[14] = $0b) and
    (Block[15] = $32) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

function Validate8 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 VALIDATENO : Cardinal = 8;

begin
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 Block[0] := $F7;
 Block[1] := $95;
 Block[2] := $BD;
 Block[3] := $4A;
 Block[4] := $52;
 Block[5] := $E2;
 Block[6] := $9E;
 Block[7] := $D7;
 Block[8] := $13;
 Block[9] := $D3;
 Block[10] := $13;
 Block[11] := $FA;
 Block[12] := $20;
 Block[13] := $E9;
 Block[14] := $8D;
 Block[15] := $BC;
 KeySize := 4;
 AESMakeContextProcedure(Key, KeySize);
 AESDecryptProcedure(Block);
 if (Block[0] = $66) and
    (Block[1] = $E9) and
    (Block[2] = $4B) and
    (Block[3] = $D4) and
    (Block[4] = $EF) and
    (Block[5] = $8A) and
    (Block[6] = $2C) and
    (Block[7] = $3B) and
    (Block[8] = $88) and
    (Block[9] = $4C) and
    (Block[10] = $FA) and
    (Block[11] = $59) and
    (Block[12] = $CA) and
    (Block[13] = $34) and
    (Block[14] = $2B) and
    (Block[15] = $2E) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

function Validate9 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
const
 VALIDATENO : Cardinal = 9;

begin
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 Key[9] := 0;
 Key[10] := 0;
 Key[11] := 0;
 Key[12] := 0;
 KeySize := 6;
 AESMakeContextProcedure(Key, KeySize);
 Block[0] := 0;
 Block[1] := 0;
 Block[2] := 0;
 Block[3] := 0;
 Block[4] := 0;
 Block[5] := 0;
 Block[6] := 0;
 Block[7] := 0;
 Block[8] := 0;
 Block[9] := 0;
 Block[10] := 0;
 Block[11] := 0;
 Block[12] := 0;
 Block[13] := 0;
 Block[14] := 0;
 Block[15] := 0;
 AESEncryptProcedure(Block);
 if (Block[0] = $AA) and
    (Block[1] = $E0) and
    (Block[2] = $69) and
    (Block[3] = $92) and
    (Block[4] = $AC) and
    (Block[5] = $BF) and
    (Block[6] = $52) and
    (Block[7] = $A3) and
    (Block[8] = $E8) and
    (Block[9] = $F4) and
    (Block[10] = $A9) and
    (Block[11] = $6E) and
    (Block[12] = $C9) and
    (Block[13] = $30) and
    (Block[14] = $0B) and
    (Block[15] = $D7) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

function Validate10 : Boolean;
var
 KeySize : Longint;
 Block : TAESBlock;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 VALIDATENO : Cardinal = 10;

begin
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 KeySize := 4;
 AESMakeContextProcedure(Key, KeySize);
 Block[0] := $66;
 Block[1] := $E9;
 Block[2] := $4B;
 Block[3] := $D4;
 Block[4] := $EF;
 Block[5] := $8A;
 Block[6] := $2C;
 Block[7] := $3B;
 Block[8] := $88;
 Block[9] := $4C;
 Block[10] := $FA;
 Block[11] := $59;
 Block[12] := $CA;
 Block[13] := $34;
 Block[14] := $2B;
 Block[15] := $2E;
 AESDecryptProcedure(Block);
 if (Block[0] = 0) and
    (Block[1] = 0) and
    (Block[2] = 0) and
    (Block[3] = 0) and
    (Block[4] = 0) and
    (Block[5] = 0) and
    (Block[6] = 0) and
    (Block[7] = 0) and
    (Block[8] = 0) and
    (Block[9] = 0) and
    (Block[10] = 0) and
    (Block[11] = 0) and
    (Block[12] = 0) and
    (Block[13] = 0) and
    (Block[14] = 0) and
    (Block[15] = 0) then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO);
  end;
end;

function Validate11 : Boolean;
var
 I1, I2, I3 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Encrypt : Boolean;
 Block1, Block2 : TAESBlock;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 VALIDATENO : Cardinal = 11;

begin
 Result := True;
 Key[1] := 0;
 Key[2] := 0;
 Key[3] := 0; //Error if = 1
 Key[4] := 0; //Error if = 1
 Key[5] := 0; //Error if = 1
 Key[6] := 0; //Error if = 1
 Key[7] := 0; //Error if = 1
 Key[8] := 0; //Error if = 1
 KeySize := 4;
 Encrypt := False;
 InitEncryptAES(Key, KeySize, Context, Encrypt);
 AESMakeContextProcedure(Key, KeySize);
 for I2 := 0 to MAXVALIDATE9 do
  begin
   Block1[0] := I2;
   Block2[0] := I2;
   for I1 := 1 to 15 do
    begin
     Block1[I1] := I1;
     Block2[I1] := I1;
    end;
   EncryptAES_REF_PAS_2(Context, Block1);
   AESDecryptProcedure(Block2);
   for I3 := 0 to 15 do
    begin
     if (Block1[I3] <> Block2[I3]) then
      begin
       Result := False;
       ErrorTrap(VALIDATENO);
       Exit;
      end;
    end;
  end;
end;

function Validate12 : Boolean;
var
 I1, I2, I3 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Encrypt : Boolean;
 Block1, Block2 : TAESBlock;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 VALIDATENO : Cardinal = 12;

begin
 Result := True;
 Key[1] := 1;
 Key[2] := 1;
 Key[3] := 1;
 Key[4] := 0;
 Key[5] := 0;
 Key[6] := 0;
 Key[7] := 0;
 Key[8] := 0;
 KeySize := 4;
 Encrypt := True;
 InitEncryptAES(Key, KeySize, Context, Encrypt);
 AESMakeContextProcedure(Key, KeySize);
 for I2 := 0 to MAXVALIDATE10 do
  begin
   Block1[VALIDATE10BLOCKPOS] := I2;
   Block2[VALIDATE10BLOCKPOS] := I2;
   for I1 := 0 to 15 do
    begin
     if I1 <> VALIDATE10BLOCKPOS then
      begin
       Block1[I1] := I1;
       Block2[I1] := I1;
      end;
    end;
   EncryptAES_REF_PAS_2(Context, Block1);
   AESEncryptProcedure(Block2);
   for I3 := 0 to 15 do
    begin
     if (Block1[I3] <> Block2[I3]) then
      begin
       Result := False;
       ErrorTrap(VALIDATENO);
       Exit;
      end;
    end;
  end;
end;

function Validate13 : Boolean;
var
 I1, I2, I3 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Encrypt : Boolean;
 Block1, Block2 : TAESBlock;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
const
 VALIDATENO : Cardinal = 13;

begin
 Result := True;
 Key[1] := 111;
 Key[2] := 222;
 Key[3] := 333;
 Key[4] := 2222;
 Key[5] := 3333;
 Key[6] := 44444;
 Key[7] := 55555;
 Key[8] := 33333;
 Key[9] := 3333;
 Key[10] := 44444;
 Key[11] := 55555;
 Key[12] := 33333;
 KeySize := 6;
 Encrypt := False;
 InitEncryptAES(Key, KeySize, Context, Encrypt);
 AESMakeContextProcedure(Key, KeySize);
 for I2 := 0 to MAXVALIDATE11 do
  begin
   Block1[VALIDATE11BLOCKPOS] := I2;
   Block2[VALIDATE11BLOCKPOS] := I2;
   for I1 := 0 to 15 do
    begin
     if I1 <> VALIDATE11BLOCKPOS then
      begin
       Block1[I1] := I1;
       Block2[I1] := I1;
      end;
    end;
   EncryptAES_REF_PAS_2(Context, Block1);
   AESDecryptProcedure(Block2);
   for I3 := 0 to 15 do
    begin
     if (Block1[I3] <> Block2[I3]) then
      begin
       Result := False;
       ErrorTrap(VALIDATENO);
       Exit;
      end;
    end;
  end;
end;

function Validate14 : Boolean;
var
 I1, I2, I3 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Encrypt : Boolean;
 Block1, Block2 : TAESBlock;
 BlockPos : Byte;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 VALIDATENO : Cardinal = 14;

begin
 Result := True;
 Key[1] := 77;
 Key[2] := 88;
 Key[3] := 378;
 Key[4] := 222;
 Key[5] := 333;
 Key[6] := 4444;
 Key[7] := 5555;
 Key[8] := 33333;
 KeySize := 4;
 Encrypt := False;
 InitEncryptAES(Key, KeySize, Context, Encrypt);
 AESMakeContextProcedure(Key, KeySize);
 for BlockPos := 0 to 15 do
  begin
   for I2 := 0 to MAXVALIDATE12 do
    begin
     Block1[BlockPos] := I2;
     Block2[BlockPos] := I2;
     for I1 := 0 to 15 do
      begin
       if I1 <> BlockPos then
        begin
         Block1[I1] := I1;
         Block2[I1] := I1;
        end;
      end;
     EncryptAES_REF_PAS_2(Context, Block1);
     AESDecryptProcedure(Block2);
     for I3 := 0 to 15 do
      begin
       if (Block1[I3] <> Block2[I3]) then
        begin
         Result := False;
         ErrorTrap(VALIDATENO);
         Exit;
        end;
      end;
    end;
  end;
end;

function Validate15 : Boolean;
var
 I1, I2, I3 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Encrypt : Boolean;
 Block1, Block2 : TAESBlock;
 BlockPos : Byte;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
const
 VALIDATENO : Cardinal = 15;

begin
 Result := True;
 Key[1] := 111;
 Key[2] := 222;
 Key[3] := 333;
 Key[4] := 2222;
 Key[5] := 3333;
 Key[6] := 44444;
 Key[7] := 55555;
 Key[8] := 33333;
 Key[9] := 3333;
 Key[10] := 44444;
 Key[11] := 55555;
 Key[12] := 33333;
 KeySize := 6;
 Encrypt := False;
 InitEncryptAES(Key, KeySize, Context, Encrypt);
 AESMakeContextProcedure(Key, KeySize);
 for BlockPos := 0 to 15 do
  begin
   for I2 := 0 to MAXVALIDATE11 do
    begin
     Block1[BlockPos] := I2;
     Block2[BlockPos] := I2;
     for I1 := 0 to 15 do
      begin
       if I1 <> BlockPos then
        begin
         Block1[I1] := I1;
         Block2[I1] := I1;
        end;
      end;
     EncryptAES_REF_PAS_2(Context, Block1);
     AESDecryptProcedure(Block2);
     for I3 := 0 to 15 do
      begin
       if (Block1[I3] <> Block2[I3]) then
        begin
         Result := False;
         ErrorTrap(VALIDATENO);
         Exit;
        end;
      end;
    end;
  end;
end;

function Validate16 : Boolean;
var
 I1, I2, I3 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Encrypt : Boolean;
 Block1, Block2 : TAESBlock;
 BlockPos : Byte;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
const
 VALIDATENO : Cardinal = 16;

begin
 Result := True;
 Key[1] := 111;
 Key[2] := 222;
 Key[3] := 333;
 Key[4] := 2222;
 Key[5] := 3333;
 Key[6] := 44444;
 Key[7] := 55555;
 Key[8] := 33333;
 Key[9] := 3333;
 Key[10] := 1936;
 Key[11] := 55555;
 Key[12] := 33333;
 Key[13] := 3333;
 Key[14] := 19357;
 Key[15] := 19743;
 Key[16] := 33333;
 KeySize := 8;
 Encrypt := False;  //Testing decryption
 InitEncryptAES(Key, KeySize, Context, Encrypt);
 AESMakeContextProcedure(Key, KeySize);
 for BlockPos := 0 to 15 do
  begin
   for I2 := 0 to MAXVALIDATE14 do
    begin
     Block1[BlockPos] := I2;
     Block2[BlockPos] := I2;
     for I1 := 0 to 15 do
      begin
       if I1 <> BlockPos then
        begin
         Block1[I1] := I1;
         Block2[I1] := I1;
        end;
      end;
     EncryptAES_REF_PAS_2(Context, Block1);
     AESDecryptProcedure(Block2);
     for I3 := 0 to 15 do
      begin
       if (Block1[I3] <> Block2[I3]) then
        begin
         Result := False;
         ErrorTrap(VALIDATENO);
         Exit;
        end;
      end;
    end;
  end;
end;

function Validate17 : Boolean;
var
 I1, I2, I3, I4, I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16,I17 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Block1, Block2 : TAESBlock;
 BlockPos : Byte;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 ENCRYPT : Boolean = False;
 VALIDATENO : Cardinal = 17;

begin
 Result := True;
 KeySize := 4;
 for I1 := MINVALIDATE15 to MAXVALIDATE15 do
  begin
   for I2 := MINVALIDATE15 to MAXVALIDATE15 do
    begin
     for I3 := MINVALIDATE15 to MAXVALIDATE15 do
      begin
       for I4 := MINVALIDATE15 to MAXVALIDATE15 do
        begin
         for I5 := MINVALIDATE15 to MAXVALIDATE15 do
          begin
           for I6 := MINVALIDATE15 to MAXVALIDATE15 do
            begin
             for I7 := MINVALIDATE15 to MAXVALIDATE15 do
              begin
               for I8 := MINVALIDATE15 to MAXVALIDATE15 do
                begin
                 for I9 := MINVALIDATE15 to MAXVALIDATE15 do
                  begin
                   for I10 := MINVALIDATE15 to MAXVALIDATE15 do
                    begin
                     for I11 := MINVALIDATE15 to MAXVALIDATE15 do
                      begin
                       for I12 := MINVALIDATE15 to MAXVALIDATE15 do
                        begin
                         for I13 := MINVALIDATE15 to MAXVALIDATE15 do
                          begin
                           for I14 := MINVALIDATE15 to MAXVALIDATE15 do
                            begin
                             for I15 := MINVALIDATE15 to MAXVALIDATE15 do
                              begin
                               for I16 := MINVALIDATE15 to MAXVALIDATE15 do
                                begin
                                 Key[1] := Random(MAXWORD);
                                 Key[2] := Random(MAXWORD);
                                 Key[3] := Random(MAXWORD);
                                 Key[4] := Random(MAXWORD);
                                 Key[5] := Random(MAXWORD);
                                 Key[6] := Random(MAXWORD);
                                 Key[7] := Random(MAXWORD);
                                 Key[8] := Random(MAXWORD);
                                 InitEncryptAES(Key, KeySize, Context, Encrypt);
                                 AESMakeContextProcedure(Key, KeySize);
                                 Block1[0] := I1;
                                 Block2[0] := I1;
                                 Block1[1] := I2;
                                 Block2[1] := I2;
                                 Block1[2] := I3;
                                 Block2[2] := I3;
                                 Block1[3] := I4;
                                 Block2[3] := I4;
                                 Block1[4] := I5;
                                 Block2[4] := I5;
                                 Block1[5] := I6;
                                 Block2[5] := I6;
                                 Block1[6] := I7;
                                 Block2[6] := I7;
                                 Block1[7] := I8;
                                 Block2[7] := I8;
                                 Block1[8] := I9;
                                 Block2[8] := I9;
                                 Block1[9] := I10;
                                 Block2[9] := I10;
                                 Block1[10] := I11;
                                 Block2[10] := I11;
                                 Block1[11] := I12;
                                 Block2[11] := I12;
                                 Block1[12] := I13;
                                 Block2[12] := I13;
                                 Block1[13] := I14;
                                 Block2[13] := I14;
                                 Block1[14] := I15;
                                 Block2[14] := I15;
                                 Block1[15] := I16;
                                 Block2[15] := I16;
                                 EncryptAES_REF_PAS_2(Context, Block1);
                                 AESDecryptProcedure(Block2);
                                 for I17 := 0 to 15 do
                                  begin
                                   if (Block1[I17] <> Block2[I17]) then
                                    begin
                                     ErrorTrap(VALIDATENO);
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
 I1, I2, I3, I4, I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16,I17 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Block1, Block2 : TAESBlock;
 BlockPos : Byte;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
const
 ENCRYPT : Boolean = False;
 VALIDATENO : Cardinal = 18;

begin
 Result := True;
 KeySize := 6;
 for I1 := MINVALIDATE16 to MAXVALIDATE16 do
  begin
   for I2 := MINVALIDATE16 to MAXVALIDATE16 do
    begin
     for I3 := MINVALIDATE16 to MAXVALIDATE16 do
      begin
       for I4 := MINVALIDATE16 to MAXVALIDATE16 do
        begin
         for I5 := MINVALIDATE16 to MAXVALIDATE16 do
          begin
           for I6 := MINVALIDATE16 to MAXVALIDATE16 do
            begin
             for I7 := MINVALIDATE16 to MAXVALIDATE16 do
              begin
               for I8 := MINVALIDATE16 to MAXVALIDATE16 do
                begin
                 for I9 := MINVALIDATE16 to MAXVALIDATE16 do
                  begin
                   for I10 := MINVALIDATE16 to MAXVALIDATE16 do
                    begin
                     for I11 := MINVALIDATE16 to MAXVALIDATE16 do
                      begin
                       for I12 := MINVALIDATE16 to MAXVALIDATE16 do
                        begin
                         for I13 := MINVALIDATE16 to MAXVALIDATE16 do
                          begin
                           for I14 := MINVALIDATE16 to MAXVALIDATE16 do
                            begin
                             for I15 := MINVALIDATE16 to MAXVALIDATE16 do
                              begin
                               for I16 := MINVALIDATE16 to MAXVALIDATE16 do
                                begin
                                 Key[1] := Random(MAXWORD);
                                 Key[2] := Random(MAXWORD);
                                 Key[3] := Random(MAXWORD);
                                 Key[4] := Random(MAXWORD);
                                 Key[5] := Random(MAXWORD);
                                 Key[6] := Random(MAXWORD);
                                 Key[7] := Random(MAXWORD);
                                 Key[8] := Random(MAXWORD);
                                 Key[9] := Random(MAXWORD);
                                 Key[10] := Random(MAXWORD);
                                 Key[11] := Random(MAXWORD);
                                 Key[12] := Random(MAXWORD);
                                 InitEncryptAES(Key, KeySize, Context, Encrypt);
                                 AESMakeContextProcedure(Key, KeySize);
                                 Block1[0] := I1;
                                 Block2[0] := I1;
                                 Block1[1] := I2;
                                 Block2[1] := I2;
                                 Block1[2] := I3;
                                 Block2[2] := I3;
                                 Block1[3] := I4;
                                 Block2[3] := I4;
                                 Block1[4] := I5;
                                 Block2[4] := I5;
                                 Block1[5] := I6;
                                 Block2[5] := I6;
                                 Block1[6] := I7;
                                 Block2[6] := I7;
                                 Block1[7] := I8;
                                 Block2[7] := I8;
                                 Block1[8] := I9;
                                 Block2[8] := I9;
                                 Block1[9] := I10;
                                 Block2[9] := I10;
                                 Block1[10] := I11;
                                 Block2[10] := I11;
                                 Block1[11] := I12;
                                 Block2[11] := I12;
                                 Block1[12] := I13;
                                 Block2[12] := I13;
                                 Block1[13] := I14;
                                 Block2[13] := I14;
                                 Block1[14] := I15;
                                 Block2[14] := I15;
                                 Block1[15] := I16;
                                 Block2[15] := I16;
                                 EncryptAES_REF_PAS_2(Context, Block1);
                                 AESDecryptProcedure(Block2);
                                 for I17 := 0 to 15 do
                                  begin
                                   if (Block1[I17] <> Block2[I17]) then
                                    begin
                                     ErrorTrap(VALIDATENO);
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

function Validate19 : Boolean;
var
 I1, I2, I3, I4, I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16,I17 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Block1, Block2 : TAESBlock;
 BlockPos : Byte;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
const
 ENCRYPT : Boolean = False;
 VALIDATENO : Cardinal = 19;

begin
 Result := True;
 KeySize := 8;
 for I1 := MINVALIDATE17 to MAXVALIDATE17 do
  begin
   for I2 := MINVALIDATE17 to MAXVALIDATE17 do
    begin
     for I3 := MINVALIDATE17 to MAXVALIDATE17 do
      begin
       for I4 := MINVALIDATE17 to MAXVALIDATE17 do
        begin
         for I5 := MINVALIDATE17 to MAXVALIDATE17 do
          begin
           for I6 := MINVALIDATE17 to MAXVALIDATE17 do
            begin
             for I7 := MINVALIDATE17 to MAXVALIDATE17 do
              begin
               for I8 := MINVALIDATE17 to MAXVALIDATE17 do
                begin
                 for I9 := MINVALIDATE17 to MAXVALIDATE17 do
                  begin
                   for I10 := MINVALIDATE17 to MAXVALIDATE17 do
                    begin
                     for I11 := MINVALIDATE17 to MAXVALIDATE17 do
                      begin
                       for I12 := MINVALIDATE17 to MAXVALIDATE17 do
                        begin
                         for I13 := MINVALIDATE17 to MAXVALIDATE17 do
                          begin
                           for I14 := MINVALIDATE17 to MAXVALIDATE17 do
                            begin
                             for I15 := MINVALIDATE17 to MAXVALIDATE17 do
                              begin
                               for I16 := MINVALIDATE17 to MAXVALIDATE17 do
                                begin
                                 Key[1] := Random(MAXWORD);
                                 Key[2] := Random(MAXWORD);
                                 Key[3] := Random(MAXWORD);
                                 Key[4] := Random(MAXWORD);
                                 Key[5] := Random(MAXWORD);
                                 Key[6] := Random(MAXWORD);
                                 Key[7] := Random(MAXWORD);
                                 Key[8] := Random(MAXWORD);
                                 Key[9] := Random(MAXWORD);
                                 Key[10] := Random(MAXWORD);
                                 Key[11] := Random(MAXWORD);
                                 Key[12] := Random(MAXWORD);
                                 Key[13] := Random(MAXWORD);
                                 Key[14] := Random(MAXWORD);
                                 Key[15] := Random(MAXWORD);
                                 Key[16] := Random(MAXWORD);
                                 InitEncryptAES(Key, KeySize, Context, Encrypt);
                                 AESMakeContextProcedure(Key, KeySize);
                                 Block1[0] := I1;
                                 Block2[0] := I1;
                                 Block1[1] := I2;
                                 Block2[1] := I2;
                                 Block1[2] := I3;
                                 Block2[2] := I3;
                                 Block1[3] := I4;
                                 Block2[3] := I4;
                                 Block1[4] := I5;
                                 Block2[4] := I5;
                                 Block1[5] := I6;
                                 Block2[5] := I6;
                                 Block1[6] := I7;
                                 Block2[6] := I7;
                                 Block1[7] := I8;
                                 Block2[7] := I8;
                                 Block1[8] := I9;
                                 Block2[8] := I9;
                                 Block1[9] := I10;
                                 Block2[9] := I10;
                                 Block1[10] := I11;
                                 Block2[10] := I11;
                                 Block1[11] := I12;
                                 Block2[11] := I12;
                                 Block1[12] := I13;
                                 Block2[12] := I13;
                                 Block1[13] := I14;
                                 Block2[13] := I14;
                                 Block1[14] := I15;
                                 Block2[14] := I15;
                                 Block1[15] := I16;
                                 Block2[15] := I16;
                                 EncryptAES_REF_PAS_2(Context, Block1);
                                 AESDecryptProcedure(Block2);
                                 for I17 := 0 to 15 do
                                  begin
                                   if (Block1[I17] <> Block2[I17]) then
                                    begin
                                     ErrorTrap(VALIDATENO);
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

function Validate20 : Boolean;
var
 I1, I2, I3, I4, I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16,I17 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Block1, Block2 : TAESBlock;
 BlockPos : Byte;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 ENCRYPT : Boolean = True;
 VALIDATENO : Cardinal = 20;

begin
 Result := True;
 KeySize := 4;
 for I1 := MINVALIDATE18 to MAXVALIDATE18 do
  begin
   for I2 := MINVALIDATE18 to MAXVALIDATE18 do
    begin
     for I3 := MINVALIDATE18 to MAXVALIDATE18 do
      begin
       for I4 := MINVALIDATE18 to MAXVALIDATE18 do
        begin
         for I5 := MINVALIDATE18 to MAXVALIDATE18 do
          begin
           for I6 := MINVALIDATE18 to MAXVALIDATE18 do
            begin
             for I7 := MINVALIDATE18 to MAXVALIDATE18 do
              begin
               for I8 := MINVALIDATE18 to MAXVALIDATE18 do
                begin
                 for I9 := MINVALIDATE18 to MAXVALIDATE18 do
                  begin
                   for I10 := MINVALIDATE18 to MAXVALIDATE18 do
                    begin
                     for I11 := MINVALIDATE18 to MAXVALIDATE18 do
                      begin
                       for I12 := MINVALIDATE18 to MAXVALIDATE18 do
                        begin
                         for I13 := MINVALIDATE18 to MAXVALIDATE18 do
                          begin
                           for I14 := MINVALIDATE18 to MAXVALIDATE18 do
                            begin
                             for I15 := MINVALIDATE18 to MAXVALIDATE18 do
                              begin
                               for I16 := MINVALIDATE18 to MAXVALIDATE18 do
                                begin
                                 Key[1] := Random(MAXWORD);
                                 Key[2] := Random(MAXWORD);
                                 Key[3] := Random(MAXWORD);
                                 Key[4] := Random(MAXWORD);
                                 Key[5] := Random(MAXWORD);
                                 Key[6] := Random(MAXWORD);
                                 Key[7] := Random(MAXWORD);
                                 Key[8] := Random(MAXWORD);
                                 InitEncryptAES(Key, KeySize, Context, Encrypt);
                                 AESMakeContextProcedure(Key, KeySize);
                                 Block1[0] := I1;
                                 Block2[0] := I1;
                                 Block1[1] := I2;
                                 Block2[1] := I2;
                                 Block1[2] := I3;
                                 Block2[2] := I3;
                                 Block1[3] := I4;
                                 Block2[3] := I4;
                                 Block1[4] := I5;
                                 Block2[4] := I5;
                                 Block1[5] := I6;
                                 Block2[5] := I6;
                                 Block1[6] := I7;
                                 Block2[6] := I7;
                                 Block1[7] := I8;
                                 Block2[7] := I8;
                                 Block1[8] := I9;
                                 Block2[8] := I9;
                                 Block1[9] := I10;
                                 Block2[9] := I10;
                                 Block1[10] := I11;
                                 Block2[10] := I11;
                                 Block1[11] := I12;
                                 Block2[11] := I12;
                                 Block1[12] := I13;
                                 Block2[12] := I13;
                                 Block1[13] := I14;
                                 Block2[13] := I14;
                                 Block1[14] := I15;
                                 Block2[14] := I15;
                                 Block1[15] := I16;
                                 Block2[15] := I16;
                                 EncryptAES_REF_PAS_2(Context, Block1);
                                 AESEncryptProcedure(Block2);
                                 for I17 := 0 to 15 do
                                  begin
                                   if (Block1[I17] <> Block2[I17]) then
                                    begin
                                     ErrorTrap(VALIDATENO);
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

function Validate21 : Boolean;
var
 I1, I2, I3, I4, I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16,I17 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Block1, Block2 : TAESBlock;
 BlockPos : Byte;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
const
 ENCRYPT : Boolean = True;
 VALIDATENO : Cardinal = 21;

begin
 Result := True;
 KeySize := 6;
 for I1 := MINVALIDATE19 to MAXVALIDATE19 do
  begin
   for I2 := MINVALIDATE19 to MAXVALIDATE19 do
    begin
     for I3 := MINVALIDATE19 to MAXVALIDATE19 do
      begin
       for I4 := MINVALIDATE19 to MAXVALIDATE19 do
        begin
         for I5 := MINVALIDATE19 to MAXVALIDATE19 do
          begin
           for I6 := MINVALIDATE19 to MAXVALIDATE19 do
            begin
             for I7 := MINVALIDATE19 to MAXVALIDATE19 do
              begin
               for I8 := MINVALIDATE19 to MAXVALIDATE19 do
                begin
                 for I9 := MINVALIDATE19 to MAXVALIDATE19 do
                  begin
                   for I10 := MINVALIDATE19 to MAXVALIDATE19 do
                    begin
                     for I11 := MINVALIDATE19 to MAXVALIDATE19 do
                      begin
                       for I12 := MINVALIDATE19 to MAXVALIDATE19 do
                        begin
                         for I13 := MINVALIDATE19 to MAXVALIDATE19 do
                          begin
                           for I14 := MINVALIDATE19 to MAXVALIDATE19 do
                            begin
                             for I15 := MINVALIDATE19 to MAXVALIDATE19 do
                              begin
                               for I16 := MINVALIDATE19 to MAXVALIDATE19 do
                                begin
                                 Key[1] := Random(MAXWORD);
                                 Key[2] := Random(MAXWORD);
                                 Key[3] := Random(MAXWORD);
                                 Key[4] := Random(MAXWORD);
                                 Key[5] := Random(MAXWORD);
                                 Key[6] := Random(MAXWORD);
                                 Key[7] := Random(MAXWORD);
                                 Key[8] := Random(MAXWORD);
                                 Key[9] := Random(MAXWORD);
                                 Key[10] := Random(MAXWORD);
                                 Key[11] := Random(MAXWORD);
                                 Key[12] := Random(MAXWORD);
                                 InitEncryptAES(Key, KeySize, Context, Encrypt);
                                 AESMakeContextProcedure(Key, KeySize);
                                 Block1[0] := I1;
                                 Block2[0] := I1;
                                 Block1[1] := I2;
                                 Block2[1] := I2;
                                 Block1[2] := I3;
                                 Block2[2] := I3;
                                 Block1[3] := I4;
                                 Block2[3] := I4;
                                 Block1[4] := I5;
                                 Block2[4] := I5;
                                 Block1[5] := I6;
                                 Block2[5] := I6;
                                 Block1[6] := I7;
                                 Block2[6] := I7;
                                 Block1[7] := I8;
                                 Block2[7] := I8;
                                 Block1[8] := I9;
                                 Block2[8] := I9;
                                 Block1[9] := I10;
                                 Block2[9] := I10;
                                 Block1[10] := I11;
                                 Block2[10] := I11;
                                 Block1[11] := I12;
                                 Block2[11] := I12;
                                 Block1[12] := I13;
                                 Block2[12] := I13;
                                 Block1[13] := I14;
                                 Block2[13] := I14;
                                 Block1[14] := I15;
                                 Block2[14] := I15;
                                 Block1[15] := I16;
                                 Block2[15] := I16;
                                 EncryptAES_REF_PAS_2(Context, Block1);
                                 AESEncryptProcedure(Block2);
                                 for I17 := 0 to 15 do
                                  begin
                                   if (Block1[I17] <> Block2[I17]) then
                                    begin
                                     ErrorTrap(VALIDATENO);
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

function Validate22 : Boolean;
var
 I1, I2, I3, I4, I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16,I17 : Cardinal;
 KeySize : Longint;
 Context : TAESContext;
 Block1, Block2 : TAESBlock;
 BlockPos : Byte;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
const
 ENCRYPT : Boolean = True;
 VALIDATENO : Cardinal = 22;

begin
 Result := True;
 KeySize := 8;
 for I1 := MINVALIDATE20 to MAXVALIDATE20 do
  begin
   for I2 := MINVALIDATE20 to MAXVALIDATE20 do
    begin
     for I3 := MINVALIDATE20 to MAXVALIDATE20 do
      begin
       for I4 := MINVALIDATE20 to MAXVALIDATE20 do
        begin
         for I5 := MINVALIDATE20 to MAXVALIDATE20 do
          begin
           for I6 := MINVALIDATE20 to MAXVALIDATE20 do
            begin
             for I7 := MINVALIDATE20 to MAXVALIDATE20 do
              begin
               for I8 := MINVALIDATE20 to MAXVALIDATE20 do
                begin
                 for I9 := MINVALIDATE20 to MAXVALIDATE20 do
                  begin
                   for I10 := MINVALIDATE20 to MAXVALIDATE20 do
                    begin
                     for I11 := MINVALIDATE20 to MAXVALIDATE20 do
                      begin
                       for I12 := MINVALIDATE20 to MAXVALIDATE20 do
                        begin
                         for I13 := MINVALIDATE20 to MAXVALIDATE20 do
                          begin
                           for I14 := MINVALIDATE20 to MAXVALIDATE20 do
                            begin
                             for I15 := MINVALIDATE20 to MAXVALIDATE20 do
                              begin
                               for I16 := MINVALIDATE20 to MAXVALIDATE20 do
                                begin
                                 Key[1] := Random(MAXWORD);
                                 Key[2] := Random(MAXWORD);
                                 Key[3] := Random(MAXWORD);
                                 Key[4] := Random(MAXWORD);
                                 Key[5] := Random(MAXWORD);
                                 Key[6] := Random(MAXWORD);
                                 Key[7] := Random(MAXWORD);
                                 Key[8] := Random(MAXWORD);
                                 Key[9] := Random(MAXWORD);
                                 Key[10] := Random(MAXWORD);
                                 Key[11] := Random(MAXWORD);
                                 Key[12] := Random(MAXWORD);
                                 Key[13] := Random(MAXWORD);
                                 Key[14] := Random(MAXWORD);
                                 Key[15] := Random(MAXWORD);
                                 Key[16] := Random(MAXWORD);
                                 InitEncryptAES(Key, KeySize, Context, Encrypt);
                                 AESMakeContextProcedure(Key, KeySize);
                                 Block1[0] := I1;
                                 Block2[0] := I1;
                                 Block1[1] := I2;
                                 Block2[1] := I2;
                                 Block1[2] := I3;
                                 Block2[2] := I3;
                                 Block1[3] := I4;
                                 Block2[3] := I4;
                                 Block1[4] := I5;
                                 Block2[4] := I5;
                                 Block1[5] := I6;
                                 Block2[5] := I6;
                                 Block1[6] := I7;
                                 Block2[6] := I7;
                                 Block1[7] := I8;
                                 Block2[7] := I8;
                                 Block1[8] := I9;
                                 Block2[8] := I9;
                                 Block1[9] := I10;
                                 Block2[9] := I10;
                                 Block1[10] := I11;
                                 Block2[10] := I11;
                                 Block1[11] := I12;
                                 Block2[11] := I12;
                                 Block1[12] := I13;
                                 Block2[12] := I13;
                                 Block1[13] := I14;
                                 Block2[13] := I14;
                                 Block1[14] := I15;
                                 Block2[14] := I15;
                                 Block1[15] := I16;
                                 Block2[15] := I16;
                                 EncryptAES_REF_PAS_2(Context, Block1);
                                 AESEncryptProcedure(Block2);
                                 for I17 := 0 to 15 do
                                  begin
                                   if (Block1[I17] <> Block2[I17]) then
                                    begin
                                     ErrorTrap(VALIDATENO);
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

function Validate23 : Boolean;
var
 KeySize : Longint;
 Context1, Context2 : TAESContext;
 Encrypt : Boolean;
 Block1, Block2 : TAESBlock;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
 I1, I2, RunNo : Cardinal;
 B1 : Byte;
const
 VALIDATENO : Cardinal = 23;

begin
 Result := True;
 for RunNo := 1 to VALIDATE21MAXRUNNO do
  begin
   for I1 := 1 to 8 do
    begin
     Key[I1] := Random(High(Word));
    end;
   KeySize := 4;
   Encrypt := True;
   InitEncryptAES(Key, KeySize, Context1, Encrypt);
   Encrypt := False;
   InitEncryptAES(Key, KeySize, Context2, Encrypt);
   for I2 := 0 to 15 do
    begin
     B1 := Random(High(Byte));
     Block1[I2] := B1;
     Block2[I2] := B1;
    end;
   //Encrypt
   AESEncryptProcedure(Block1);
   //And decrypt
   AESDecryptProcedure(Block1);
   //Are we back?
   if not CompareMem(@Block1[0], @Block2[0], 16) then
    begin
     ErrorTrap(VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
end;

function Validate24 : Boolean;
var
 KeySize : Longint;
 Context1, Context2 : TAESContext;
 Encrypt : Boolean;
 Block1, Block2 : TAESBlock;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
 I1, I2, RunNo : Cardinal;
 B1 : Byte;
const
 VALIDATENO : Cardinal = 24;

begin
 Result := True;
 for RunNo := 1 to VALIDATE22MAXRUNNO do
  begin
   for I1 := 1 to 12 do
    begin
     Key[I1] := Random(High(Word));
    end;
   KeySize := 6;
   Encrypt := True;
   InitEncryptAES(Key, KeySize, Context1, Encrypt);
   Encrypt := False;
   InitEncryptAES(Key, KeySize, Context2, Encrypt);
   for I2 := 0 to 15 do
    begin
     B1 := Random(High(Byte));
     Block1[I2] := B1;
     Block2[I2] := B1;
    end;
   //Encrypt
   AESEncryptProcedure(Block1);
   //And decrypt
   AESDecryptProcedure(Block1);
   //Are we back?
   if not CompareMem(@Block1[0], @Block2[0], 16) then
    begin
     ErrorTrap(VALIDATENO);
     Result := False;
     Exit;
    end;
  end;
end;

function Validate25 : Boolean;
var
 KeySize : Longint;
 Context1, Context2 : TAESContext;
 Encrypt : Boolean;
 Block1, Block2 : TAESBlock;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
 I1, I2, RunNo : Cardinal;
 B1 : Byte;
const
 VALIDATENO : Cardinal = 25;

begin
 Result := True;
 for RunNo := 1 to VALIDATE23MAXRUNNO do
  begin
   for I1 := 1 to 16 do
    begin
     Key[I1] := Random(High(Word));
    end;
   KeySize := 8;
   Encrypt := True;
   InitEncryptAES(Key, KeySize, Context1, Encrypt);
   Encrypt := False;
   InitEncryptAES(Key, KeySize, Context2, Encrypt);
   for I2 := 0 to 15 do
    begin
     B1 := Random(High(Byte));
     Block1[I2] := B1;
     Block2[I2] := B1;
    end;
   //Encrypt
   AESEncryptProcedure(Block1);
   //And decrypt
   AESDecryptProcedure(Block1);
   //Are we back?
   if not CompareMem(@Block1[0], @Block2[0], 16) then
    begin
     ErrorTrap(VALIDATENO);
     Result := False;
     Exit;
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
  FunctionAddress := Cardinal(@AESEncryptProcedure);
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
                    + #9 + FunctionAddressString[8]
                   + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 SubBench1, SubBench2, SubBench3, SubBench4, SubBench5, SubBench6, SubBench7,
 SubBench8, Bench : Cardinal;
 FunctionName : AnsiString;

begin
 try
  ClearNoOfTicksArray;
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  BenchmarkButton.Caption := 'Running';
  SubBench1 := SubBenchmark1;//Encrypt BlockSize = 16 byte = 128 bit, Keysize = 4 = 128 bit, 16 byte aligned context & Block
  SubBench2 := SubBenchmark2;//Decrypt BlockSize = 16 byte = 128 bit, Keysize = 4 = 128 bit, 16 byte aligned context & Block
  SubBench3 := SubBenchmark3;//Encrypt BlockSize = 16 byte = 128 bit, Keysize = 6 = 192 bit, 8 byte aligned context & Block
  SubBench4 := SubBenchmark4;//Decrypt BlockSize = 16 byte = 128 bit, Keysize = 6 = 192 bit, 8 byte aligned context & Block
  SubBench5 := SubBenchmark5;//Encrypt BlockSize = 16 byte = 128 bit, Keysize = 8 = 256 bit, 4 byte aligned context & Block
  SubBench6 := SubBenchmark6;//Decrypt BlockSize = 16 byte = 128 bit, Keysize = 8 = 256 bit, 4 byte aligned context & Block
  SubBench7 := SubBenchmark7;//Encrypt BlockSize = 16 byte = 128 bit, Keysize = 8 = 256 bit, unaligned context & Block
  SubBench8 := SubBenchmark8;//Decrypt BlockSize = 16 byte = 128 bit, Keysize = 8 = 256 bit, unaligned context & Block
  //Average number of bits per second
  Bench := (SubBench1 + SubBench2 + SubBench3 + SubBench4
          + SubBench5 + SubBench6 + SubBench7 + SubBench8) div 8;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + IntToStr(SubBench1)
                           + #9 + IntToStr(SubBench2)
                           + #9 + IntToStr(SubBench3)
                           + #9 + IntToStr(SubBench4)
                           + #9 + IntToStr(SubBench5)
                           + #9 + IntToStr(SubBench6)
                           + #9 + IntToStr(SubBench7)
                           + #9 + IntToStr(SubBench8)
                           + #9 + IntToStr(Bench));
  SortRichEdit;
  BenchmarkTest;
  BenchmarkButton.Caption := 'Benchmark';
 except
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999'
                           + #9 + '9999'
                           + #9 + '9999'
                           + #9 + '9999'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var
 J, I1, I2, I4, BlockSize, NoOfBlocks, MBits, MBitsPerSec : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 I, BlockOffset : Integer;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 KEYSIZE : Longint = 4;

begin
 ClearNoOfTicksArray;
 FillChar(SubBenchBlock[0], 31, #0);
 BlockOffset := BlockOffset16ByteAlign;
 for J := 1 to Length(Key) do
  begin
   Key[J] := J;
  end;
 AESMakeContextProcedure(Key, KeySize);
 //No need to fill block with data, but do it anyway
 for I := 0 to 15 do
  begin
   SubBenchBlock[I+BlockOffset] := I+1;
  end;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     AESEncryptProcedure(SubBenchBlock[BlockOffset]);
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
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 BlockSize := 128;
 NoOfBlocks := NOOFRUNS;
 MBits := BlockSize * NoOfBlocks div 1024 div 1024;
 MBitsPerSec := Round(MBits / RunTimeSec);
 Result := MBitsPerSec;
end;

function TMainForm.SubBenchmark2 : Cardinal;
var
 J, I1, I2, I4, BlockSize, NoOfBlocks, MBits, MBitsPerSec : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 I, BlockOffset : Integer;
 Key : array[1..8] of Word;//8 * 16 = 128 bit = KeySize = 4
const
 KEYSIZE : Longint = 4;

begin
 FillChar(SubBenchBlock[0], 31, #0);
 BlockOffset := BlockOffset16ByteAlign;
 for J := 1 to Length(Key) do
  begin
    Key[J] := J;
  end;
 AESMakeContextProcedure(Key, KeySize);
 //No need to fill block with data, but do it anyway
 for I := 0 to 15 do
  begin
   SubBenchBlock[I+BlockOffset] := I;
  end;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     AESDecryptProcedure(SubBenchBlock[BlockOffset]);
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
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 BlockSize := 128;
 NoOfBlocks := NOOFRUNS;
 MBits := BlockSize * NoOfBlocks div 1024 div 1024;
 MBitsPerSec := Round(MBits / RunTimeSec);
 Result := MBitsPerSec;
end;

function TMainForm.SubBenchmark3 : Cardinal;
var
 J, I1, I2, I4, BlockSize, NoOfBlocks, MBits, MBitsPerSec : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 I, BlockOffset : Integer;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
const
 KEYSIZE : Longint = 6;

begin
 FillChar(SubBenchBlock[0], 31, #0);
 BlockOffset := BlockOffset8ByteAlign;
 for J := 1 to Length(Key) do
  begin
   Key[J] := J;
  end;
 AESMakeContextProcedure(Key, KeySize);
 //No need to fill block with data, but do it anyway
 for I := 0 to 15 do
  begin
   SubBenchBlock[I+BlockOffset] := I;
  end;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     AESEncryptProcedure(SubBenchBlock[BlockOffset]);
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
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 BlockSize := 128;
 NoOfBlocks := NOOFRUNS;
 MBits := BlockSize * NoOfBlocks div 1024 div 1024;
 MBitsPerSec := Round(MBits / RunTimeSec);
 Result := MBitsPerSec;
end;

function TMainForm.SubBenchmark4 : Cardinal;
var
 J, I1, I2, I4, BlockSize, NoOfBlocks, MBits, MBitsPerSec : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 I, BlockOffset : Integer;
 Key : array[1..12] of Word;//12 * 16 = 192 bit = KeySize = 6
const
 KEYSIZE : Longint = 6;

begin
 FillChar(SubBenchBlock[0], 31, #0);
 BlockOffset := BlockOffset8ByteAlign;
 for J := 1 to Length(Key) do
  begin
   Key[J] := J;
  end;
 AESMakeContextProcedure(Key, KeySize);
 //No need to fill block with data, but do it anyway
 for I := 0 to 15 do
  begin
   SubBenchBlock[I+BlockOffset] := I;
  end;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     AESDecryptProcedure(SubBenchBlock[BlockOffset]);
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
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 BlockSize := 128;
 NoOfBlocks := NOOFRUNS;
 MBits := BlockSize * NoOfBlocks div 1024 div 1024;
 MBitsPerSec := Round(MBits / RunTimeSec);
 Result := MBitsPerSec;
end;

function TMainForm.SubBenchmark5 : Cardinal;
var
 J, I1, I2, I4, BlockSize, NoOfBlocks, MBits, MBitsPerSec : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 I, BlockOffset : Integer;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
const
 KEYSIZE : Longint = 8;

begin
 FillChar(SubBenchBlock[0], 31, #0);
 BlockOffset := BlockOffset4ByteAlign;
 for J := 1 to Length(Key) do
  begin
    Key[J] := J;
  end;
 AESMakeContextProcedure(Key, KeySize);
 //No need to fill block with data, but do it anyway
 for I := 0 to 15 do
  begin
   SubBenchBlock[I+BlockOffset] := I;
  end;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     AESEncryptProcedure(SubBenchBlock[BlockOffset]);
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
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 BlockSize := 128;
 NoOfBlocks := NOOFRUNS;
 MBits := BlockSize * NoOfBlocks div 1024 div 1024;
 MBitsPerSec := Round(MBits / RunTimeSec);
 Result := MBitsPerSec;
end;

function TMainForm.SubBenchmark6 : Cardinal;
var
 J, I1, I2, I4, BlockSize, NoOfBlocks, MBits, MBitsPerSec : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 I, BlockOffset : Integer;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
const
 KEYSIZE : Longint = 8;

begin
 FillChar(SubBenchBlock[0], 31, #0);
 BlockOffset := BlockOffset4ByteAlign;
 for J := 1 to Length(Key) do
  begin
   Key[J] := J;
  end;
 AESMakeContextProcedure(Key, KeySize);
 //No need to fill block with data, but do it anyway
 for I := 0 to 15 do
  begin
   SubBenchBlock[I+BlockOffset] := I;
  end;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     AESDecryptProcedure(SubBenchBlock[BlockOffset]);
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
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 BlockSize := 128;
 NoOfBlocks := NOOFRUNS;
 MBits := BlockSize * NoOfBlocks div 1024 div 1024;
 MBitsPerSec := Round(MBits / RunTimeSec);
 Result := MBitsPerSec;
end;

function TMainForm.SubBenchmark7 : Cardinal;
var
 J, I1, I2, I4, BlockSize, NoOfBlocks, MBits, MBitsPerSec : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 I, BlockOffset : Integer;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
const
 KEYSIZE : Longint = 8;

begin
 FillChar(SubBenchBlock[0], 31, #0);
 BlockOffset := BlockOffsetNonAlign;
 for J := 1 to Length(Key) do
  begin
   Key[J] := J;
  end;
 AESMakeContextProcedure(Key, KeySize);
 //No need to fill block with data, but do it anyway
 for I := 0 to 15 do
  begin
   SubBenchBlock[I+BlockOffset] := I;
  end;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     AESEncryptProcedure(SubBenchBlock[BlockOffset]);
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
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 BlockSize := 128;
 NoOfBlocks := NOOFRUNS;
 MBits := BlockSize * NoOfBlocks div 1024 div 1024;
 MBitsPerSec := Round(MBits / RunTimeSec);
 Result := MBitsPerSec;
end;

function TMainForm.SubBenchmark8 : Cardinal;
var
 J, I1, I2, I4, BlockSize, NoOfBlocks, MBits, MBitsPerSec : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 I, BlockOffset : Integer;
 Key : array[1..16] of Word;//16 * 16 = 256 bit = KeySize = 8
const
 KEYSIZE : Longint = 8;

begin
 FillChar(SubBenchBlock[0], 31, #0);
 BlockOffset := BlockOffsetNonAlign;
 for J := 1 to Length(Key) do
  begin
   Key[J] := J;
  end;
 AESMakeContextProcedure(Key, KeySize);
 //No need to fill block with data, but do it anyway
 for I := 0 to 15 do
  begin
   SubBenchBlock[I+BlockOffset] := I;
  end;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 0 to NOOFRUNS do
    begin
     AESDecryptProcedure(SubBenchBlock[BlockOffset]);
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
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 BlockSize := 128;
 NoOfBlocks := NOOFRUNS;
 MBits := BlockSize * NoOfBlocks div 1024 div 1024;
 MBitsPerSec := Round(MBits / RunTimeSec);
 Result := MBitsPerSec;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 BlockOffset : Integer;
 BlockAddress, BlockAddressAlignment : Cardinal;

begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 9;
 ReportRichEdit.Paragraph.Tab[0] := 110;
 ReportRichEdit.Paragraph.Tab[1] := 140;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 200;
 ReportRichEdit.Paragraph.Tab[4] := 230;
 ReportRichEdit.Paragraph.Tab[5] := 260;
 ReportRichEdit.Paragraph.Tab[6] := 290;
 ReportRichEdit.Paragraph.Tab[7] := 320;
 ReportRichEdit.Paragraph.Tab[8] := 360;
 FunctionSelectionRadioGroupClick(nil);
 if not QueryPerformanceFrequency(lpFrequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 //Calculate alignments for subbenchmarks
 BlockOffset := -1;
 repeat
  Inc(BlockOffset);
  BlockAddress := Cardinal(@SubBenchBlock[BlockOffset]);
  BlockAddressAlignment := BlockAddress and $0000000F;
 until(BlockAddressAlignment = 0);
 if BlockOffset > 15 then
  raise Exception.Create('Alignment ran of end');
 BlockOffset16ByteAlign := BlockOffset;
 if BlockOffset < 8 then
  BlockOffset8ByteAlign := BlockOffset + 8
 else
  BlockOffset8ByteAlign := BlockOffset - 8;
 if BlockOffset < 4 then
  BlockOffset4ByteAlign := BlockOffset + 4
 else
  BlockOffset4ByteAlign := BlockOffset - 4;
 if BlockOffset < 1 then
  BlockOffsetNonAlign := BlockOffset + 1
 else
  BlockOffsetNonAlign := BlockOffset - 1;
end;

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionRadioGroup.ItemIndex+1 of
  1 :
   begin
    AESMakeContextProcedure := MakeContextsAES_Ref_PAS_3;
    AESEncryptProcedure := EncryptAES_Ref_PAS_3;
    AESDecryptProcedure := DecryptAES_Ref_PAS_3;
   end;
  2 :
   begin
    AESMakeContextProcedure := MakeContextsAES_LockBox_PAS_1;
    AESEncryptProcedure := EncryptAES_LockBox_PAS_1;
    AESDecryptProcedure := DecryptAES_LockBox_PAS_1;
   end;
  3 :
   begin
    AESMakeContextProcedure := MakeContextsAES_WE_PAS_5;
    AESEncryptProcedure := EncryptAES_WE_PAS_5;
    AESDecryptProcedure := DecryptAES_WE_PAS_5;
   end;
  4 :
   begin
    AESMakeContextProcedure := InitAES_JOH_PAS;
    AESEncryptProcedure := EncryptAES_JOH_PAS;
    AESDecryptProcedure := DecryptAES_JOH_PAS;
   end;
  5 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_PAS_33;
    AESEncryptProcedure := EncryptAES_DKC_PAS_33;
    AESDecryptProcedure := DecryptAES_DKC_PAS_33;
   end;
  6 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_PAS_37;
    AESEncryptProcedure := EncryptAES_DKC_PAS_37;
    AESDecryptProcedure := DecryptAES_DKC_PAS_37;
   end;
  7 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_PAS_38;
    AESEncryptProcedure := EncryptAES_DKC_PAS_38;
    AESDecryptProcedure := DecryptAES_DKC_PAS_38;
   end;
  8 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_PAS_39;
    AESEncryptProcedure := EncryptAES_DKC_PAS_39;
    AESDecryptProcedure := DecryptAES_DKC_PAS_39;
   end;
  9 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_IA32_1;
    AESEncryptProcedure := EncryptAES_DKC_IA32_1;
    AESDecryptProcedure := DecryptAES_DKC_IA32_1;
   end;
  10 :
   begin
    AESMakeContextProcedure := MakeContextsAES_WE_PAS_6;
    AESEncryptProcedure := EncryptAES_WE_PAS_6;
    AESDecryptProcedure := DecryptAES_WE_PAS_6;
   end;
  11 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_PAS_40;
    AESEncryptProcedure := EncryptAES_DKC_PAS_40;
    AESDecryptProcedure := DecryptAES_DKC_PAS_40;
   end;
  12 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_IA32_2;
    AESEncryptProcedure := EncryptAES_DKC_IA32_2;
    AESDecryptProcedure := DecryptAES_DKC_IA32_2;
   end;
  13 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_IA32_3;
    AESEncryptProcedure := EncryptAES_DKC_IA32_3;
    AESDecryptProcedure := DecryptAES_DKC_IA32_3;
   end;
  14 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_PAS_41;
    AESEncryptProcedure := EncryptAES_DKC_PAS_41;
    AESDecryptProcedure := DecryptAES_DKC_PAS_41;
   end;
  15 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_PAS_42;
    AESEncryptProcedure := EncryptAES_DKC_PAS_42;
    AESDecryptProcedure := DecryptAES_DKC_PAS_42;
   end;
  16 :
   begin
    AESMakeContextProcedure := InitAES_JOH_PAS_2;
    AESEncryptProcedure := EncryptAES_JOH_PAS_2;
    AESDecryptProcedure := DecryptAES_JOH_PAS_2;
   end;
  17 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_MMX_1;
    AESEncryptProcedure := EncryptAES_DKC_MMX_1;
    AESDecryptProcedure := DecryptAES_DKC_MMX_1;
   end;
  18 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_SSE_1;
    AESEncryptProcedure := EncryptAES_DKC_SSE_1;
    AESDecryptProcedure := DecryptAES_DKC_SSE_1;
   end;
  19 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_SSE2_3;
    AESEncryptProcedure := EncryptAES_DKC_SSE2_3;
    AESDecryptProcedure := DecryptAES_DKC_SSE2_3;
   end;
  20 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_SSE2_1;
    AESEncryptProcedure := EncryptAES_DKC_SSE2_1;
    AESDecryptProcedure := DecryptAES_DKC_SSE2_1;
   end;
  21 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_SSE2_2;
    AESEncryptProcedure := EncryptAES_DKC_SSE2_2;
    AESDecryptProcedure := DecryptAES_DKC_SSE2_2;
   end;
  22 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_SSE2_4;
    AESEncryptProcedure := EncryptAES_DKC_SSE2_4;
    AESDecryptProcedure := DecryptAES_DKC_SSE2_4;
   end;
  23 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_SSE_2;
    AESEncryptProcedure := EncryptAES_DKC_SSE_2;
    AESDecryptProcedure := DecryptAES_DKC_SSE_2;
   end;
  24 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_IA32_4;
    AESEncryptProcedure := EncryptAES_DKC_IA32_4;
    AESDecryptProcedure := DecryptAES_DKC_IA32_4;
   end;
  25 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_MMX_2;
    AESEncryptProcedure := EncryptAES_DKC_MMX_2;
    AESDecryptProcedure := DecryptAES_DKC_MMX_2;
   end;
  26 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_IA32_5;
    AESEncryptProcedure := EncryptAES_DKC_IA32_5;
    AESDecryptProcedure := DecryptAES_DKC_IA32_5;
   end;
  27 :
   begin
    AESMakeContextProcedure := MakeContextsAES_DKC_IA32_6;
    AESEncryptProcedure := EncryptAES_DKC_IA32_6;
    AESDecryptProcedure := DecryptAES_DKC_IA32_6;
   end;
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
 //for I := 1 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I := FunctionSelectionRadioGroup.Items.Count-1 downto 2 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionSelectionRadioGroupClick(nil);
   BenchmarkButtonClick(nil);
   Update;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';
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
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := 'AESBenchReport.Txt';
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintReportSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('AES Report');
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
   for I2 := 1 to FunctionSelectionRadioGroup.Items.Count-1 do
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

end.
