unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'LowerCase';

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
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
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
    Label10: TLabel;
    Label11: TLabel;
    SpreadTestBench1Edit: TEdit;
    SpreadTestBench2Edit: TEdit;
    AlignCheckButton: TButton;
    AlignCheckEdit: TEdit;
    procedure FormDestroy(Sender: TObject);
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
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure ClearAllEditBoxes;
    procedure InitializeArrays;
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
 SystemInfoUnit, FastCodeCPUID, LowerCaseDKCUnit, LowerCaseRTLUnit, LowerCaseShaUnit, LowerCase_JOH;

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
 TLowerCaseFunction = function (const S: string): string;

var
 LowerCaseFunction : TLowerCaseFunction;
 SubBench1StringArray : array of string;
 SubBench2StringArray : array of string;
 NoOfTicksArray : array of Int64;
 lpFrequency : Int64;
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
 SpreadTestBench1Edit.Text := '';
 SpreadTestBench2Edit.Text := '';
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
         SpreadTestBench1Edit.Text := BenchString1;
         SpreadTestBench2Edit.Text := BenchString2;
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
 S1, S2 : string;

begin
 S1 := '';
 S2 := LowerCaseFunction(S1);
 if S2 = '' then
  Result := True
 else
  Result := False;
end;

var
 S1Global, S2Global : string;

function Validate2 : Boolean;
begin
 S1Global := 'z';
 (PInteger(Integer(S1Global)-4))^ := 0;
 S2Global := LowerCaseFunction(S1Global);
 if S2Global = 'Z' then
  Result := False
 else
  Result := True;
end;

function Validate3 : Boolean;
var
 S1, S2, S3 : string;
 I : Byte;

begin
 Result := True;
 for I := 0 to 255 do
  begin
   S1 := Char(I);
   S2 := LowerCase(S1);
   S3 := LowerCaseFunction(S1);
   if S2 <> S3 then
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate4 : Boolean;
var
 S1, S2, S3 : string;
 I1, I2 : Byte;

begin
 Result := True;
 for I1 := 0 to 255 do
  begin
   for I2 := 0 to 255 do
    begin
     S1 := Char(I1) + Char(I2);
     S2 := LowerCase(S1);
     S3 := LowerCaseFunction(S1);
     if S2 <> S3 then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function Validate5 : Boolean;
var
 S1, S2, S3 : string;
 I1, I2, I3 : Byte;

begin
 Result := True;
 for I1 := 0 to 100 do
  begin
   for I2 := 100 to 200 do
    begin
     for I3 := 200 to 255 do
      begin
       S1 := Char(I1) + Char(I2)  + Char(I3);
       S2 := LowerCase(S1);
       S3 := LowerCaseFunction(S1);
       if S2 <> S3 then
        begin
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

begin
 Result := True;
 for I1 := 0 to 255 do
  begin
   S1 := S1 + Char(I1);
   S2 := LowerCase(S1);
   S3 := LowerCaseFunction(S1);
   if S2 <> S3 then
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate7 : Boolean;
var
 S1, S2, S3 : string;
 I1, I2, I3 : Byte;

begin
 Result := True;
 for I1 := 30 to 71 do
  begin
   for I2 := 70 to 100 do
    begin
     for I3 := 215 to 245 do
      begin
       S1 := S1 + Char(I1) + Char(I2)  + Char(I3);
       S2 := LowerCase(S1);
       S3 := LowerCaseFunction(S1);
       if S2 <> S3 then
        begin
         Result := False;
         Exit;
        end;
      end;
    end;
  end;
end;

function Validate8 : Boolean;
const
 maxlen=255;
var
 i, len, size: integer;
 s1, s2: string;
 p1, p2: pchar;

begin
 Result := True;
 for len := maxlen downto 1 do
  begin
   size := (len+4) and (-4);
   SetLength(s1, len); p1:=pointer(s1);
   FillChar(p1^,size,'A');
   p1[len] := #0;
   SetLength(s2, len);
   p2 := pointer(s2);
   Move(p1^,p2^,size);
   s2 := LowerCaseFunction(s1);
   if p2 <> Pointer(s2) then
    Exit; // result undefined, suppose true
   for i := len to size-1 do
    begin
     if p2[i]<>p1[i] then
      begin
       Result := False;
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
     S2 := LowerCase(S4);
     S3 := LowerCaseFunction(S4);
     if S2 <> S3 then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function Validate10 : Boolean;
var
 S2 : string;

begin
 Result := True;
 S2 := LowerCase('A');
 if S2 <> 'a' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('a');
 if S2 <> 'a' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('B');
 if S2 <> 'b' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('b');
 if S2 <> 'b' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('C');
 if S2 <> 'c' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('c');
 if S2 <> 'c' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('D');
 if S2 <> 'd' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('d');
 if S2 <> 'd' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('(');
 if S2 <> '(' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('z');
 if S2 <> 'z' then
  begin
   Result := False;
   Exit;
  end;
 S2 := LowerCase('Z');
 if S2 <> 'z' then
  begin
   Result := False;
  end;
end;

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
  mov  byte ptr [eax+11], 'A'
end;

function Validate13FreeMem(P: Pointer): Integer;
asm
  mov cl, [SaveChar]
  mov byte ptr [eax+11], cl
  jmp MMOld.FreeMem
end;

function Validate13ReallocMem(P: Pointer; Size: Integer): Pointer;
asm
  cmp byte ptr [eax+11], 'A'
  setz cl
  mov [Valid13], cl
  mov cl, [SaveChar]
  mov byte ptr [eax+11], cl
  call MMOld.ReallocMem
  mov  cl, byte ptr [eax+11]
  mov  [SaveChar], cl
  mov  byte ptr [eax+11], 'A'
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

{
Use with care !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}

function Validate11: Boolean;
var
  S1, S2 : string;
const
  VALIDATENO : Cardinal = 0;
begin
  try
    Result:=true;
    ToggleMM;

    //Working with RefCt=-1
    S1 := 'ABCDE';
    S2 := S1;
    if S2 = S1 then S2 := LowerCaseFunction(S1); //AV in invalid function

    //Working with RefCt>1
    UniqueString(S1);
    S2 := S1;
    if S2 = S1 then S2 := LowerCaseFunction(S1);
    Result:=Result and (PInteger(Integer(S1)-8)^=1);

    //Working with RefCt=1
    S1 := 'ABCDEFG';
    MMOpCount := 0;
    S2 := LowerCaseFunction(S1);
    Result:=Result and (MMOpCount=8);

    //Working with RefCt=1
    S1 := 'ABC';
    MMOpCount := 0;
    S2 := LowerCaseFunction(S1);
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
    if LowerCaseFunction('a') + 'b' = '' then
      Exit;
end;

function Validate13: Boolean;
begin
  GetMemoryManager(MMOld);
  SetMemoryManager(Validate13MM);
  DoValidate13;
  SetMemoryManager(MMOld);
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
  FunctionAddress := Cardinal(@LowerCaseFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if Validate1 and
     Validate2 and
     Validate3 and
     Validate4 and
     Validate5 and
     Validate6 and
     Validate7 and
     //and Validate8
     Validate9 and
     Validate11 and
     Validate10 and
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
  FunctionAddress := Cardinal(@LowerCaseFunction);
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
  FunctionAddress := Cardinal(@LowerCaseFunction);
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
  FunctionAddress := Cardinal(@LowerCaseFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]
                           + #9 + 'Failed'
                           + #9 + '9999'
                           + #9 + '9999');
 end;
end;
{
function TMainForm.SubBenchmark1 : Cardinal;
var
 S : string;
 I1, I2, I3, I4 : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;

begin
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
   for I2 := 0 to NOOFRUNS*SUB1NOOFRUNS do
    begin
     for I3 := 0 to SUBBENCH1ARRAYSIZE-1 do
      begin
       S := LowerCaseFunction(SubBench1StringArray[I3]);
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
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;
 NoOfTicksArray : array of Int64;

begin
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
   for I2 := 0 to NOOFRUNS*SUB2NOOFRUNS do
    begin
     for I3 := 0 to SUBBENCH2ARRAYSIZE-2 do
      begin
       S := LowerCaseFunction(SubBench2StringArray[I3]);
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
}

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
     S := LowerCaseFunction(SubBench1StringArray[I3]);
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
     S := LowerCaseFunction(SubBench2StringArray[I3]);
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

procedure TMainForm.InitializeArrays;
var
 I1 :Cardinal;

begin
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
end;

procedure TMainForm.FormCreate(Sender: TObject);
var  CpuString : string;
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount :=5;
 ReportRichEdit.Paragraph.Tab[0] := 120;
 ReportRichEdit.Paragraph.Tab[1] := 140;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 200;
 ReportRichEdit.Paragraph.Tab[4] := 240;
 InitializeArrays;
 FunctionSelectionRadioGroupClick(nil);
 if not QueryPerformanceFrequency(lpFrequency) then
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

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionRadioGroup.ItemIndex+1 of
  1 : LowerCaseFunction := LowerCase;  // "LowerCase_RTL_IA32_1"
  2 : LowerCaseFunction := LowerCase_RTL_PAS_1_a;
  3 : LowerCaseFunction := LowerCase_RTL_PAS_1_b;
  4 : LowerCaseFunction := LowerCase_RTL_PAS_1_c;
  5 : LowerCaseFunction := LowerCase_RTL_PAS_1_d;
  6 : LowerCaseFunction := LowerCase_DKC_Pas_1_a;
  7 : LowerCaseFunction := LowerCase_DKC_Pas_1_b;
  8 : LowerCaseFunction := LowerCase_DKC_Pas_1_c;
  9 : LowerCaseFunction := LowerCase_DKC_Pas_1_d;
  10 : LowerCaseFunction := LowerCase_DKC_IA32_1_a;
  11 : LowerCaseFunction := LowerCase_DKC_IA32_1_b;
  12 : LowerCaseFunction := LowerCase_DKC_IA32_1_c;
  13 : LowerCaseFunction := LowerCase_DKC_IA32_1_d;
  14 : LowerCaseFunction := LowerCase_Sha_Pas_2_a;
  15 : LowerCaseFunction := LowerCase_Sha_Pas_2_b;
  16 : LowerCaseFunction := LowerCase_Sha_Pas_2_c;
  17 : LowerCaseFunction := LowerCase_Sha_Pas_2_d;
  18 : LowerCaseFunction := LowerCase_JOH_PAS_2_a;
  19 : LowerCaseFunction := LowerCase_JOH_PAS_2_b;
  20 : LowerCaseFunction := LowerCase_JOH_PAS_2_c;
  21 : LowerCaseFunction := LowerCase_JOH_PAS_2_d;
  22 : LowerCaseFunction := LowerCase_JOH_IA32_2_a;
  23 : LowerCaseFunction := LowerCase_JOH_IA32_2_b;
  24 : LowerCaseFunction := LowerCase_JOH_IA32_2_c;
  25 : LowerCaseFunction := LowerCase_JOH_IA32_2_d;
  26 : LowerCaseFunction := LowerCase_JOH_IA32_3_a;
  27 : LowerCaseFunction := LowerCase_JOH_IA32_3_b;
  28 : LowerCaseFunction := LowerCase_JOH_IA32_3_c;
  29 : LowerCaseFunction := LowerCase_JOH_IA32_3_d;
  30 : LowerCaseFunction := LowerCase_JOH_MMX_2_a;
  31 : LowerCaseFunction := LowerCase_JOH_MMX_2_b;
  32 : LowerCaseFunction := LowerCase_JOH_MMX_2_c;
  33 : LowerCaseFunction := LowerCase_JOH_MMX_2_d;
  34 : LowerCaseFunction := LowerCase_JOH_SSE2_2_a;
  35 : LowerCaseFunction := LowerCase_JOH_SSE2_2_b;
  36 : LowerCaseFunction := LowerCase_JOH_SSE2_2_c;
  37 : LowerCaseFunction := LowerCase_JOH_SSE2_2_d;
  38 : LowerCaseFunction := LowerCase_DKC_IA32_4_a;
  39 : LowerCaseFunction := LowerCase_DKC_IA32_4_b;
  40 : LowerCaseFunction := LowerCase_DKC_IA32_4_c;
  41 : LowerCaseFunction := LowerCase_DKC_IA32_4_d;
  42 : LowerCaseFunction := LowerCase_DKC_IA32_13_a;
  43 : LowerCaseFunction := LowerCase_DKC_IA32_13_b;
  44 : LowerCaseFunction := LowerCase_DKC_IA32_13_c;
  45 : LowerCaseFunction := LowerCase_DKC_IA32_13_d;
  46 : LowerCaseFunction := LowerCase_DKC_IA32_14_a;
  47 : LowerCaseFunction := LowerCase_DKC_IA32_14_b;
  48 : LowerCaseFunction := LowerCase_DKC_IA32_14_c;
  49 : LowerCaseFunction := LowerCase_DKC_IA32_14_d;
  50 : LowerCaseFunction := LowerCase_DKC_IA32_18_a;
  51 : LowerCaseFunction := LowerCase_DKC_IA32_18_b;
  52 : LowerCaseFunction := LowerCase_DKC_IA32_18_c;
  53 : LowerCaseFunction := LowerCase_DKC_IA32_18_d;
  54 : LowerCaseFunction := LowerCase_JOH_IA32_4_a;
  55 : LowerCaseFunction := LowerCase_JOH_IA32_4_b;
  56 : LowerCaseFunction := LowerCase_JOH_IA32_4_c;
  57 : LowerCaseFunction := LowerCase_JOH_IA32_4_d;
  58 : LowerCaseFunction := LowerCase_JOH_IA32_5_a;
  59 : LowerCaseFunction := LowerCase_JOH_IA32_5_b;
  60 : LowerCaseFunction := LowerCase_JOH_IA32_5_c;
  61 : LowerCaseFunction := LowerCase_JOH_IA32_5_d;
  62 : LowerCaseFunction := LowerCase_JOH_IA32_6_a;
  63 : LowerCaseFunction := LowerCase_JOH_IA32_6_b;
  64 : LowerCaseFunction := LowerCase_JOH_IA32_6_c;
  65 : LowerCaseFunction := LowerCase_JOH_IA32_6_d;
  66 : LowerCaseFunction := LowerCase_LBG_Pas_1_a;
  67 : LowerCaseFunction := LowerCase_LBG_Pas_1_b;
  68 : LowerCaseFunction := LowerCase_LBG_Pas_1_c;
  69 : LowerCaseFunction := LowerCase_LBG_Pas_1_d;
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
 ReportRichEdit.Print('LowerCase Report');
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
   FunctionAddress := Cardinal(@LowerCaseFunction);
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
   FunctionName1 := Copy(S1, 1, TabPos1-1);
   FunctionAlignString1 := Copy(S1, TabPos1+1, 1);
   L := 1;
   AlignStringArray[L] := FunctionAlignString1;
   for K := J+1 to ReportRichEdit.Lines.Count do
    begin
     S2 := ReportRichEdit.Lines.Strings[K];
     TabPos2 := CharPos(#9, S2);
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
