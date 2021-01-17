unit MainUnit;

(*

Fastcode FillChar Benchmark and Validation Tool 
Support for the Win64 platform added by Maxim Masiutin <maxim@masiutin.com>

Version 2.0

Copyright (C) 2003-2013 Dennis Kjaer Christensen and contributors. All rights reserved
Copyright (C) 2017-2021 Maxim Masiutin. All rights reserved

revision history:
- November 7th, 2017: Added support for Win64 
- January 17th, 2021: Didn't compile under Delphi 10.3 for Win32; Button captions are now easier to understand

*)

interface

uses
  WinApi.Windows, WinApi.Messages, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Controls, System.Classes;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'FillChar';

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    CloseBitBtn: TBitBtn;
    FunctionSelectionRadioGroup: TRadioGroup;
    ValidateButton: TButton;
    ErrorEdit: TEdit;
    Label1: TLabel;
    BenchmarkButton: TButton;
    BenchmarkEdit: TEdit;
    Label2: TLabel;
    ReportRichEdit: TRichEdit;
    SaveReportSpeedButton: TSpeedButton;
    SaveDialog: TSaveDialog;
    BenchmarkAllButton: TButton;
    ValidateAllButton: TButton;
    ClearButton: TButton;
    PrintReportSpeedButton: TSpeedButton;
    Bench1Edit: TEdit;
    Bench2Edit: TEdit;
    MaxSpreadBenchPercentageEdit: TEdit;
    FunctionNameEdit: TEdit;
    SpreadTestButton: TButton;
    Bench1Label: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BenchTestButton: TButton;
    Label3: TLabel;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Clean: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure SaveReportSpeedButtonClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure PrintReportSpeedButtonClick(Sender: TObject);
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure BenchmarkEditClick(Sender: TObject);
    procedure CleanClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : AnsiString;
    FResultList: TStringList;
    procedure ClearAllEditBoxes;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    procedure CleanResultsRichEdit;
    function Validate1 : Boolean;
    function Validate2 : Boolean;
    function Validate3 : Boolean;
    function Validate4 : Boolean;
    function Validate5 : Boolean;
    function Validate6 : Boolean;
    function Validate7 : Boolean;
    function SubBenchmarkRTL1 : Cardinal;
    function SubBenchmarkRTL2 : Cardinal;
    function SubBenchmarkRTL3 : Cardinal;
    function SubBenchmarkRTL4 : Cardinal;
    function SubBenchmark1 : Cardinal;
    function SubBenchmark2 : Cardinal;
    function SubBenchmark3 : Cardinal;
    function SubBenchmark4 : Cardinal;
    procedure SortRichEdit;
  public
    { Public declarations }
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

uses
  Vcl.Graphics,
  System.SysUtils,
	SystemInfoUnit, FastCodeCPUID, FillCharUnit, FillCharJOHUnit, FillCharDKCUnit;

{$R *.dfm}

type
 TFillCharProcedure = procedure (var Dest; Count: NativeInt; Value: AnsiChar);

procedure FC_TokyoBugfixAVXEx(var Dest; Count: NativeInt; Value: AnsiChar);
begin
  System.FillChar(Dest, Count, Value);
end;

{$IFDEF WIN64}
procedure FillChar_J_BontesInternal(var Dest; Count: NativeInt; Value: AnsiChar);
//rcx = dest
//rdx=count
//r8b=value
asm
							.noframe
              .align 16
              movzx r8,r8b           //There's no need to optimize for count <= 3
              mov rax,$0101010101010101
              mov r9d,edx
              imul rax,r8            //fill rax with value.
              cmp rdx,59             //Use simple code for small blocks.
              jl  @Below32
@Above32:     mov r11,rcx
							mov r8b,7              //code shrink to help alignment.
							lea r9,[rcx+rdx]       //r9=end of array
              sub rdx,8
							rep mov [rcx],rax
              add rcx,8
              and r11,r8             //and 7 See if dest is aligned
              jz @tail
@NotAligned:  xor rcx,r11            //align dest
              lea rdx,[rdx+r11]
@tail:        test r9,r8             //and 7 is tail aligned?
              jz @alignOK
@tailwrite:   mov [r9-8],rax         //no, we need to do a tail write
              and r9,r8              //and 7
              sub rdx,r9             //dec(count, tailcount)
@alignOK:     mov r10,rdx
							and edx,(32+16+8)      //count the partial iterations of the loop
							mov r8b,64             //code shrink to help alignment.
              mov r9,rdx
              jz @Initloop64
@partialloop: shr r9,1              //every instruction is 4 bytes
							lea r11,[rip + @partial +(4*7)] //start at the end of the loop
              sub r11,r9            //step back as needed
              add rcx,rdx            //add the partial loop count to dest
              cmp r10,r8             //do we need to do more loops?
              jmp r11                //do a partial loop
@Initloop64:  shr r10,6              //any work left?
              jz @done               //no, return
              mov rdx,r10
              shr r10,(19-6)         //use non-temporal move for > 512kb
              jnz @InitFillHuge
@Doloop64:    add rcx,r8
							dec edx
              mov [rcx-64+00H],rax
              mov [rcx-64+08H],rax
              mov [rcx-64+10H],rax
              mov [rcx-64+18H],rax
              mov [rcx-64+20H],rax
							mov [rcx-64+28H],rax
              mov [rcx-64+30H],rax
              mov [rcx-64+38H],rax
              jnz @DoLoop64
@done:        rep ret
              //db $66,$66,$0f,$1f,$44,$00,$00 //nop7
@partial:     mov [rcx-64+08H],rax
              mov [rcx-64+10H],rax
							mov [rcx-64+18H],rax
							mov [rcx-64+20H],rax
              mov [rcx-64+28H],rax
              mov [rcx-64+30H],rax
              mov [rcx-64+38H],rax
              jge @Initloop64        //are we done with all loops?
              rep ret
              db $0F,$1F,$40,$00
@InitFillHuge:
@FillHuge:    add rcx,r8
              dec rdx
              db $48,$0F,$C3,$41,$C0 // movnti  [rcx-64+00H],rax
              db $48,$0F,$C3,$41,$C8 // movnti  [rcx-64+08H],rax
              db $48,$0F,$C3,$41,$D0 // movnti  [rcx-64+10H],rax
              db $48,$0F,$C3,$41,$D8 // movnti  [rcx-64+18H],rax
							db $48,$0F,$C3,$41,$E0 // movnti  [rcx-64+20H],rax
							db $48,$0F,$C3,$41,$E8 // movnti  [rcx-64+28H],rax
              db $48,$0F,$C3,$41,$F0 // movnti  [rcx-64+30H],rax
              db $48,$0F,$C3,$41,$F8 // movnti  [rcx-64+38H],rax
              jnz @FillHuge
@donefillhuge:mfence
              rep ret
              db $0F,$1F,$44,$00,$00  //db $0F,$1F,$40,$00
@Below32:     and  r9d,not(3)
              jz @SizeIs3
@FillTail:    sub   edx,4
							lea   r10,[rip + @SmallFill + (15*4)]
              sub   r10,r9
              jmp   r10
@SmallFill:   rep mov [rcx+56], eax
							rep mov [rcx+52], eax
							rep mov [rcx+48], eax
              rep mov [rcx+44], eax
              rep mov [rcx+40], eax
              rep mov [rcx+36], eax
              rep mov [rcx+32], eax
              rep mov [rcx+28], eax
              rep mov [rcx+24], eax
              rep mov [rcx+20], eax
              rep mov [rcx+16], eax
              rep mov [rcx+12], eax
              rep mov [rcx+08], eax
              rep mov [rcx+04], eax
							mov [rcx],eax
@Fallthough:  mov [rcx+rdx],eax  //unaligned write to fix up tail
							rep ret

@SizeIs3:     shl edx,2           //r9 <= 3  r9*4
              lea r10,[rip + @do3 + (4*3)]
              sub r10,rdx
              jmp r10
@do3:         rep mov [rcx+2],al
@do2:         mov [rcx],ax
              ret
@do1:         mov [rcx],al
              rep ret
@do0:         rep ret
end;

procedure FillChar_J_Bontes(var Dest; Count: NativeInt; Value: AnsiChar);
begin
	FillChar_J_BontesInternal(Dest, Count, Value);
end;
{$ENDIF}


const
 //Selected to achieve even contribution by subbenchmarks on P4 (1000 on P41600A)(should be on Blended?)
 RUNNOMAX1 : Cardinal = 700000;
 RUNNOMAX2 : Cardinal = 950;
 RUNNOMAX3 : Cardinal = 450;
 RUNNOMAX4 : Cardinal = 48;
 BENCHSCALE : Double = 200;
 SUBBENCH1WEIGTH : Cardinal = 1;
 SUBBENCH2WEIGTH : Cardinal = 1;
 SUBBENCH3WEIGTH : Cardinal = 1;
 SUBBENCH4WEIGTH : Cardinal = 1;
 MINCOUNTSUBBENCH1 : Cardinal = 0;
 MINCOUNTSUBBENCH2 : Cardinal = 30;
 MINCOUNTSUBBENCH3 : Cardinal = 2000;
 MINCOUNTSUBBENCH4 : Cardinal = 512000;
 //MAXCOUNTSUBBENCH1 : Cardinal = 30;//Controlled by size of static SubBench1Array
 //MAXCOUNTSUBBENCH2 : Cardinal = 2000;//Controlled by size of static SubBench2Array
 MAXCOUNTSUBBENCH3 : Cardinal = 512014;
 MAXCOUNTSUBBENCH4 : Cardinal = 2000014;
 COUNTGROWFACTOR : Double = 1.1;

var
 FillCharProcedure : TFillCharProcedure;
 SubBench1Array : array[1..44] of AnsiChar;
 SubBench2Array : array[1..2014] of AnsiChar;
 SubBench3Array : array of AnsiChar;
 SubBench4Array : array of AnsiChar;

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

function CharPos(Chr : AnsiChar; const Str : AnsiString) : Integer;
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

//Removes multiple results from same function. Preserves the fastest result.

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

procedure TMainForm.SortRichEdit;
var
 I2, I3, LineNo, X1, X2 : Integer;
 S1, S2, Bench1String, Bench2String : AnsiString;
 Bench1, Bench2 : Double;
 Swapped : Boolean;
 C1, C2 : AnsiChar;

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
		Bench1 := System.SysUtils.StrToFloat(Bench1String);
    Bench2 := System.SysUtils.StrToFloat(Bench2String);
    if Bench2 < Bench1 then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

//Finds the maximum spread in benchmarks for any function.

procedure TMainForm.BenchmarkTest;
var
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2 : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : AnsiChar;
 Tab1Pos1, Tab1Pos2 : Cardinal;

begin
 if ReportRichEdit.Lines.Count < 2 then
  Exit;
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
         MaxSpreadBenchPercentageEdit.Color := Vcl.Graphics.clGreen;
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

//Finds the maximum spread in benchmarks for any function.

procedure TMainForm.AlignmentTest;
var
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2,
 ShortFunctionName1, ShortFunctionName2 : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : AnsiChar;
 Tab1Pos1, Tab1Pos2 : Cardinal;

begin
 if ReportRichEdit.Lines.Count < 2 then
  Exit;
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
             Bench1Edit.Text := BenchString1;
             Bench2Edit.Text := BenchString2;
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

procedure _FillChar(var Dest; count: NativeInt; Value: AnsiChar);
begin
	System.FillChar(Dest, count, Value);
end;


procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionRadioGroup.ItemIndex+1 of
{$IFDEF WIN32}
	1 : FillCharProcedure := _FillChar;
	2 : FillCharProcedure := FillChar_RTL_Pas_1;
	3 : FillCharProcedure := FillChar_JOH_PAS_1_a;
  4 : FillCharProcedure := FillChar_JOH_PAS_1_b;
  5 : FillCharProcedure := FillChar_JOH_PAS_1_c;
  6 : FillCharProcedure := FillChar_JOH_PAS_1_d;
  7 : FillCharProcedure := FillChar_JOH_IA32_1_a;
  8 : FillCharProcedure := FillChar_JOH_IA32_1_b;
  9 : FillCharProcedure := FillChar_JOH_IA32_1_c;
  10 : FillCharProcedure := FillChar_JOH_IA32_1_d;
  11 : FillCharProcedure := FillChar_PLR_IA32_3_a;
  12 : FillCharProcedure := FillChar_PLR_IA32_3_b;
  13 : FillCharProcedure := FillChar_PLR_IA32_3_c;
  14 : FillCharProcedure := FillChar_PLR_IA32_3_d;
  15 : FillCharProcedure := FillChar_PLR_IA32_4_a;
  16 : FillCharProcedure := FillChar_PLR_IA32_4_b;
  17 : FillCharProcedure := FillChar_PLR_IA32_4_c;
  18 : FillCharProcedure := FillChar_PLR_IA32_4_d;
  19 : FillCharProcedure := FillChar_PLR_MMX_1_a;
  20 : FillCharProcedure := FillChar_PLR_MMX_1_b;
	21 : FillCharProcedure := FillChar_PLR_MMX_1_c;
  22 : FillCharProcedure := FillChar_PLR_MMX_1_d;
  23 : FillCharProcedure := FillChar_DKC_Pas_24_a;
  24 : FillCharProcedure := FillChar_JOH_MMX_1_a;
  25 : FillCharProcedure := FillChar_JOH_MMX_1_b;
  26 : FillCharProcedure := FillChar_JOH_MMX_1_c;
  27 : FillCharProcedure := FillChar_JOH_MMX_1_d;
  28 : FillCharProcedure := FillChar_JOH_SSE2_1_a;
  29 : FillCharProcedure := FillChar_JOH_SSE2_1_b;
  30 : FillCharProcedure := FillChar_JOH_SSE2_1_c;
  31 : FillCharProcedure := FillChar_JOH_SSE2_1_d;
  32 : FillCharProcedure := FillChar_DKC_MMX_11_a;
  33 : FillCharProcedure := FillChar_DKC_MMX_11_b;
  34 : FillCharProcedure := FillChar_DKC_MMX_11_c;
  35 : FillCharProcedure := FillChar_DKC_MMX_11_d;
  36 : FillCharProcedure := FillChar_JOH_IA32_3_a;
  37 : FillCharProcedure := FillChar_JOH_IA32_3_b;
  38 : FillCharProcedure := FillChar_JOH_IA32_3_c;
	39 : FillCharProcedure := FillChar_JOH_IA32_3_d;
  40 : FillCharProcedure := FillChar_DKC_IA32_20_a;
  41 : FillCharProcedure := FillChar_DKC_IA32_20_b;
  42 : FillCharProcedure := FillChar_DKC_IA32_20_c;
  43 : FillCharProcedure := FillChar_DKC_IA32_20_d;
  44 : FillCharProcedure := FillChar_JOH_IA32_2_a;
  45 : FillCharProcedure := FillChar_JOH_IA32_2_b;
  46 : FillCharProcedure := FillChar_JOH_IA32_2_c;
  47 : FillCharProcedure := FillChar_JOH_IA32_2_d;
  48 : FillCharProcedure := FillChar_DKC_SSE_9_a;
  49 : FillCharProcedure := FillChar_DKC_SSE_9_b;
  50 : FillCharProcedure := FillChar_DKC_SSE_9_c;
  51 : FillCharProcedure := FillChar_DKC_SSE_9_d;
  52 : FillCharProcedure := FillChar_JOH_SSE_1_a;
  53 : FillCharProcedure := FillChar_JOH_SSE_1_b;
  54 : FillCharProcedure := FillChar_JOH_SSE_1_c;
  55 : FillCharProcedure := FillChar_JOH_SSE_1_d;
  56 : FillCharProcedure := FillChar_DKC_SSE_14_a;
	57 : FillCharProcedure := FillChar_DKC_SSE_14_b;
  58 : FillCharProcedure := FillChar_DKC_SSE_14_c;
  59 : FillCharProcedure := FillChar_DKC_SSE_14_d;
  60 : FillCharProcedure := FillChar_DKC_SSE2_11_a;
  61 : FillCharProcedure := FillChar_DKC_SSE2_11_b;
  62 : FillCharProcedure := FillChar_DKC_SSE2_11_c;
  63 : FillCharProcedure := FillChar_DKC_SSE2_11_d;
	64 : FillCharProcedure := FillChar_CJG_Pas_5_a;
	65 : FillCharProcedure := FillChar_CJG_Pas_5_b;
	66 : FillCharProcedure := FillChar_CJG_Pas_5_c;
	67 : FillCharProcedure := FillChar_CJG_Pas_5_d;
	68 : FillCharProcedure := FillChar_DKC_SSE2_10_a;
	69 : FillCharProcedure := FillChar_DKC_SSE2_10_b;
	70 : FillCharProcedure := FillChar_DKC_SSE2_10_c;
	71 : FillCharProcedure := FillChar_DKC_SSE2_10_d;
	72 : FillCharProcedure := FillChar_DKC_MMX_12_a;
	73 : FillCharProcedure := FillChar_DKC_MMX_12_b;
	74 : FillCharProcedure := FillChar_DKC_MMX_12_c;
	75 : FillCharProcedure := FillChar_DKC_MMX_12_d;
	76 : FillCharProcedure := FillChar_JOH_MMX_4_a;
	77 : FillCharProcedure := FillChar_JOH_MMX_4_b;
	78 : FillCharProcedure := FillChar_JOH_MMX_4_c;
	79 : FillCharProcedure := FillChar_JOH_MMX_4_d;
	80 : FillCharProcedure := FillChar_DKC_Pas_24_b;
	81 : FillCharProcedure := FillChar_DKC_Pas_24_c;
	82 : FillCharProcedure := FillChar_DKC_Pas_24_d;
{$ELSE}
	2 : FillCharProcedure := FC_TokyoBugfixAVXEx;
	3 : FillCharProcedure := FillChar_J_Bontes;
{$ENDIF}
 else
  if FunctionSelectionRadioGroup.ItemIndex <> 0 then//RTL function selected
   raise Exception.Create('Invalid function');
 end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : AnsiString;
begin
{$IFDEF WIN64}
  FunctionSelectionRadioGroup.Items.Clear;
  FunctionSelectionRadioGroup.Items.Add('FC_TokyoBugfixAVXEx');
	FunctionSelectionRadioGroup.Items.Add('FillChar_J_Bontes');
  FunctionSelectionRadioGroup.ItemIndex := 0;
{$ENDIF}
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 FunctionSelectionRadioGroupClick(nil);
 ReportRichEdit.Paragraph.TabCount := 6;
 ReportRichEdit.Paragraph.Tab[0] := 100;
 ReportRichEdit.Paragraph.Tab[1] := 120;
 ReportRichEdit.Paragraph.Tab[2] := 150;
 ReportRichEdit.Paragraph.Tab[3] := 180;
 ReportRichEdit.Paragraph.Tab[4] := 210;
 ReportRichEdit.Paragraph.Tab[5] := 250;
 SetLength(SubBench3Array, MAXCOUNTSUBBENCH3);
 SetLength(SubBench4Array, MAXCOUNTSUBBENCH4);

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

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName, FunctionAddressString : AnsiString;
 FunctionAddress : Cardinal;

begin
 try

 if not SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_LOWEST) then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_LOWEST failed');
 //Add validation of all kinds of alignment
 //Add register test. EDI, ESI etc must be preserved
 FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
 FunctionAddress := Cardinal(@FillCharProcedure);
 FunctionAddressString := IntToHex(FunctionAddress, 8);

 if Validate1 and
    Validate2 and
    Validate3 and
    Validate4 and
    Validate5 and
    Validate6 and
    Validate7 then
  begin
   ErrorEdit.Color := clGreen;
   ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Passed')
  end
 else
  begin
   ErrorEdit.Color := clRed;
   ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Failed')
  end;
 except
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@FillCharProcedure);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName
                    + #9 + FunctionAddressString[8]
                   + #9 + 'Failed');
 end;
end;

function TMainForm.Validate1 : Boolean;
var
 Count, I : Integer;
 ChrVal : AnsiChar;
 XArray : array of AnsiChar;
const
 MAXCOUNT : Integer = 20000;
 BYTESAFTERFILL : Integer = 10;

begin
 try
  Result := True;
  SetLength(XArray, MAXCOUNT+BYTESAFTERFILL);
  for Count := 0 to MAXCOUNT-1 do
   begin
    FillChar(XArray[0], MAXCOUNT+BYTESAFTERFILL, 'X');
    ChrVal := 'A';
    if FunctionSelectionRadioGroup.ItemIndex = 0 then
     FillChar(XArray[BYTESAFTERFILL], Count, ChrVal)
    else
		 FillCharProcedure(XArray[BYTESAFTERFILL], Count, ChrVal);
    //Is the array filled
    for I := 10 to Count-1+BYTESAFTERFILL do
     begin
      if XArray[I] <> ChrVal then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Is something written before fill
    for I := 0 to BYTESAFTERFILL-1 do
     begin
      if XArray[I] = ChrVal then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Is something written after count
    for I := Count+BYTESAFTERFILL to MAXCOUNT+BYTESAFTERFILL-1 do
     begin
      if XArray[I] = ChrVal then
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
 pChr : PChar;
 CharArray : array of AnsiChar;
 Count, I : Integer;
 ChrVal : AnsiChar;

begin
 Count := 2;
 SetLength(CharArray, Count);
 ChrVal := 'U';
 pChr := @CharArray[0];
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  FillChar(pChr^, Count, ChrVal)
 else
  FillCharProcedure(pChr^, Count, ChrVal);
 Result := True;
 for I := 0 to Count-1 do
  begin
   if CharArray[I] <> ChrVal then
    begin
     Result := False;
     Break;
    end;
  end;
end;

function TMainForm.Validate3 : Boolean;
var
 CharArray : array[0..20] of AnsiChar;
 Count, I : Integer;
 ChrVal : AnsiChar;

begin
 Count := -2;
 ChrVal := 'U';
 //Initialize array
 for I := 0 to 20 do
  begin
   CharArray[I] := #0;
  end;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  FillChar(CharArray[10], Count, ChrVal)
 else
	FillCharProcedure(CharArray[10], Count, ChrVal);
 Result := True;
 //Is anything changed
 for I := 0 to 20 do
  begin
   if CharArray[I] <> #0 then
    begin
     Result := False;
     Exit;
    end;
  end;
end;

//Validates other alignments than 4

function TMainForm.Validate4 : Boolean;
var
 Count, I : Integer;
 ChrVal : AnsiChar;
 XArray : array of AnsiChar;
const
 MAXCOUNT : Integer = 2000;
 BYTESAFTERFILL : Integer = 10;
 ALIGNMENT : Integer = 1;//Misalignment!!!

begin
 try
  Result := True;
  SetLength(XArray, MAXCOUNT+BYTESAFTERFILL+ALIGNMENT);
  for Count := 0 to MAXCOUNT-1 do
   begin
    FillChar(XArray[0], MAXCOUNT+BYTESAFTERFILL+ALIGNMENT, 'X');
    ChrVal := 'A';
    if FunctionSelectionRadioGroup.ItemIndex = 0 then
     FillChar(XArray[BYTESAFTERFILL+ALIGNMENT], Count, ChrVal)
    else
     FillCharProcedure(XArray[BYTESAFTERFILL+ALIGNMENT], Count, ChrVal);
    //Is the array filled
    for I := 10+ALIGNMENT to Count-1+BYTESAFTERFILL+ALIGNMENT do
     begin
      if XArray[I] <> ChrVal then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Is something written before fill
    for I := 0 to BYTESAFTERFILL-1+ALIGNMENT do
     begin
      if XArray[I] = ChrVal then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Is something written after count
    for I := Count+BYTESAFTERFILL+ALIGNMENT to MAXCOUNT+BYTESAFTERFILL-1 do
     begin
      if XArray[I] = ChrVal then
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

function TMainForm.Validate5 : Boolean;
var
 Count, I : Integer;
 ChrVal : AnsiChar;
 XArray : array of AnsiChar;
const
 MAXCOUNT : Integer = 2000000;
 BYTESAFTERFILL : Integer = 10;

begin
 try
  Result := True;
  SetLength(XArray, MAXCOUNT+BYTESAFTERFILL);
  Count := 20000;
  while Count < MAXCOUNT-1 do
   begin
    FillChar(XArray[0], MAXCOUNT+BYTESAFTERFILL, 'X');
    ChrVal := 'A';
    if FunctionSelectionRadioGroup.ItemIndex = 0 then
     FillChar(XArray[BYTESAFTERFILL], Count, ChrVal)
    else
     FillCharProcedure(XArray[BYTESAFTERFILL], Count, ChrVal);
    //Is the array filled
    for I := 10 to Count-1+BYTESAFTERFILL do
     begin
      if XArray[I] <> ChrVal then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Is something written before fill
    for I := 0 to BYTESAFTERFILL-1 do
     begin
      if XArray[I] = ChrVal then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Is something written after count
    for I := Count+BYTESAFTERFILL to MAXCOUNT+BYTESAFTERFILL-1 do
     begin
      if XArray[I] = ChrVal then
       begin
        Result := False;
        Exit;
       end;
     end;
    Count := Round(Count * COUNTGROWFACTOR);
    //Ensure count stays within range. Esier to do this than correct while condition ;-)
    if Count >= MAXCOUNT-1 then
     Break;
   end;
 except
  Result := False;
 end;
end;

//Validates other alignments than 4

function TMainForm.Validate6 : Boolean;
var
 Count, I : Integer;
 ChrVal : AnsiChar;
 XArray : array of AnsiChar;
const
 MAXCOUNT : Integer = 2000;
 BYTESAFTERFILL : Integer = 10;
 ALIGNMENT : Integer = 2;//Misalignment!!!

begin
 try
  Result := True;
  SetLength(XArray, MAXCOUNT+BYTESAFTERFILL+ALIGNMENT);
  for Count := 0 to MAXCOUNT-1 do
   begin
    FillChar(XArray[0], MAXCOUNT+BYTESAFTERFILL+ALIGNMENT, 'X');
    ChrVal := 'A';
    if FunctionSelectionRadioGroup.ItemIndex = 0 then
     FillChar(XArray[BYTESAFTERFILL+ALIGNMENT], Count, ChrVal)
    else
     FillCharProcedure(XArray[BYTESAFTERFILL+ALIGNMENT], Count, ChrVal);
    //Is the array filled
    for I := 10+ALIGNMENT to Count-1+BYTESAFTERFILL+ALIGNMENT do
     begin
      if XArray[I] <> ChrVal then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Is something written before fill
    for I := 0 to BYTESAFTERFILL-1+ALIGNMENT do
     begin
      if XArray[I] = ChrVal then
       begin
        Result := False;
        Exit;
       end;
     end;
    //Is something written after count
    for I := Count+BYTESAFTERFILL+ALIGNMENT to MAXCOUNT+BYTESAFTERFILL-1 do
     begin
      if XArray[I] = ChrVal then
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

function TMainForm.Validate7 : Boolean;
var
 Count, I : Integer;
 ChrVal : AnsiChar;
 XArray : array of AnsiChar;
 Chr1 : Byte;
const
 MAXCOUNT : Integer = 120;
 BYTESAFTERFILL : Integer = 10;

begin
 try
  Result := True;
  SetLength(XArray, MAXCOUNT+BYTESAFTERFILL);
  for Chr1 := 0 to 255 do
   begin
    if AnsiChar(Chr1) = 'X' then//!!!!!!!!!!!!!!!!!
     Continue;
    ChrVal := AnsiChar(Chr1);
    for Count := 0 to MAXCOUNT-1 do //!!!!!!!!!!!!!!!
     begin
      FillChar(XArray[0], MAXCOUNT+BYTESAFTERFILL, 'X');
      if FunctionSelectionRadioGroup.ItemIndex = 0 then
       FillChar(XArray[BYTESAFTERFILL], Count, ChrVal)
      else
       FillCharProcedure(XArray[BYTESAFTERFILL], Count, ChrVal);
      //Is the array filled
      for I := 10 to Count-1+BYTESAFTERFILL do
       begin
        if XArray[I] <> ChrVal then
         begin
          Result := False;
          Exit;
         end;
       end;
      //Is something written before fill
      for I := 0 to BYTESAFTERFILL-1 do
       begin
        if XArray[I] = ChrVal then
         begin
          Result := False;
          Exit;
         end;
       end;
      //Is something written after count
      for I := Count+BYTESAFTERFILL to MAXCOUNT+BYTESAFTERFILL-1 do
       begin
        if XArray[I] = ChrVal then
         begin
          Result := False;
          Exit;
         end;
       end;
     end;
   end;
 except
  Result := False;
 end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var
 Count, MaxCount : Integer;
 ChrVal1, ChrVal2, ChrVal3, ChrVal4, ChrVal5, ChrVal6, ChrVal7 : AnsiChar;
 RunNo : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks : Int64;
 RunTimeSec : Double;

begin
 MaxCount := Length(SubBench1Array) - 14;//Make room for offset for misalignment
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 Succes := QueryPerformanceCounter(lpPerformanceCount);
 if Succes then
  StartCount := lpPerformanceCount
 else
  raise Exception.Create('QueryPerformanceCounter failed');
 ChrVal1 := 'S';
 ChrVal2 := 'B';
 ChrVal3 := 'X';
 ChrVal4 := 'v';
 ChrVal5 := 'A';
 ChrVal6 := 'Y';
 ChrVal7 := 'O';
 for RunNo := 1 to RUNNOMAX1 do
  begin
   for Count := MINCOUNTSUBBENCH1 to MaxCount do
    begin
     FillCharProcedure(SubBench1Array[1], Count, ChrVal1);
     FillCharProcedure(SubBench1Array[2], Count, ChrVal2);//Different alignment
		 FillCharProcedure(SubBench1Array[3], Count, ChrVal3);//Different alignment
     FillCharProcedure(SubBench1Array[4], Count, ChrVal4);//Different alignment
     FillCharProcedure(SubBench1Array[5], Count, ChrVal5);//Different alignment
     FillCharProcedure(SubBench1Array[6], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench1Array[7], Count, ChrVal7);//Different alignment
     FillCharProcedure(SubBench1Array[8], Count, ChrVal2);//Different alignment
     FillCharProcedure(SubBench1Array[9], Count, ChrVal3);//Different alignment
     FillCharProcedure(SubBench1Array[10], Count, ChrVal4);//Different alignment
     FillCharProcedure(SubBench1Array[11], Count, ChrVal5);//Different alignment
     FillCharProcedure(SubBench1Array[12], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench1Array[13], Count, ChrVal7);//Different alignment
     FillCharProcedure(SubBench1Array[14], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench1Array[15], Count, ChrVal7);//Different alignment
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
 RunTimeSec := NoOfTicks / lpFrequency;
 Result := Round(RunTimeSec * BENCHSCALE);
end;

function TMainForm.SubBenchmark2 : Cardinal;
var
 Count, MaxCount : Integer;
 ChrVal1, ChrVal2, ChrVal3, ChrVal4, ChrVal5, ChrVal6, ChrVal7 : AnsiChar;
 RunNo : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks : Int64;
 RunTimeSec : Double;

begin
 MaxCount := Length(SubBench2Array) - 14;//Make room for offset for misalignment
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 Succes := QueryPerformanceCounter(lpPerformanceCount);
 if Succes then
  StartCount := lpPerformanceCount
 else
  raise Exception.Create('QueryPerformanceCounter failed');
 ChrVal1 := 'S';
 ChrVal2 := 'B';
 ChrVal3 := 'X';
 ChrVal4 := 'v';
 ChrVal5 := 'A';
 ChrVal6 := 'Y';
 ChrVal7 := 'O';
 for RunNo := 1 to RUNNOMAX2 do
  begin
   for Count := MINCOUNTSUBBENCH2 to MaxCount do
    begin
		 FillCharProcedure(SubBench2Array[1], Count, ChrVal1);
     FillCharProcedure(SubBench2Array[2], Count, ChrVal2);//Different alignment
     FillCharProcedure(SubBench2Array[3], Count, ChrVal3);//Different alignment
     FillCharProcedure(SubBench2Array[4], Count, ChrVal4);//Different alignment
     FillCharProcedure(SubBench2Array[5], Count, ChrVal5);//Different alignment
     FillCharProcedure(SubBench2Array[6], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench2Array[7], Count, ChrVal7);//Different alignment
     FillCharProcedure(SubBench2Array[8], Count, ChrVal2);//Different alignment
     FillCharProcedure(SubBench2Array[9], Count, ChrVal3);//Different alignment
     FillCharProcedure(SubBench2Array[10], Count, ChrVal4);//Different alignment
     FillCharProcedure(SubBench2Array[11], Count, ChrVal5);//Different alignment
     FillCharProcedure(SubBench2Array[12], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench2Array[13], Count, ChrVal7);//Different alignment
     FillCharProcedure(SubBench2Array[14], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench2Array[15], Count, ChrVal7);//Different alignment
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
 RunTimeSec := NoOfTicks / lpFrequency;
 Result := Round(RunTimeSec * BENCHSCALE);
end;

function TMainForm.SubBenchmark3 : Cardinal;
var
 Count, MaxCount : Integer;
 ChrVal1, ChrVal2, ChrVal3, ChrVal4, ChrVal5, ChrVal6, ChrVal7 : AnsiChar;
 RunNo : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks : Int64;
 RunTimeSec : Double;

begin
 MaxCount := Length(SubBench3Array) - 14;//Make room for offset for misalignment
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 Succes := QueryPerformanceCounter(lpPerformanceCount);
 if Succes then
  StartCount := lpPerformanceCount
 else
  raise Exception.Create('QueryPerformanceCounter failed');
 ChrVal1 := 'S';
 ChrVal2 := 'B';
 ChrVal3 := 'X';
 ChrVal4 := 'v';
 ChrVal5 := 'A';
 ChrVal6 := 'Y';
 ChrVal7 := 'O';
 for RunNo := 1 to RUNNOMAX3 do
  begin
   Count := MINCOUNTSUBBENCH3;
   while Count < MaxCount do
    begin
		 FillCharProcedure(SubBench3Array[1], Count, ChrVal1);
     FillCharProcedure(SubBench3Array[2], Count, ChrVal2);//Different alignment
     FillCharProcedure(SubBench3Array[3], Count, ChrVal3);//Different alignment
     FillCharProcedure(SubBench3Array[4], Count, ChrVal4);//Different alignment
     FillCharProcedure(SubBench3Array[5], Count, ChrVal5);//Different alignment
     FillCharProcedure(SubBench3Array[6], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench3Array[7], Count, ChrVal7);//Different alignment
     FillCharProcedure(SubBench3Array[8], Count, ChrVal2);//Different alignment
     FillCharProcedure(SubBench3Array[9], Count, ChrVal3);//Different alignment
     FillCharProcedure(SubBench3Array[10], Count, ChrVal4);//Different alignment
     FillCharProcedure(SubBench3Array[11], Count, ChrVal5);//Different alignment
     FillCharProcedure(SubBench3Array[12], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench3Array[13], Count, ChrVal7);//Different alignment
     FillCharProcedure(SubBench3Array[14], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench3Array[15], Count, ChrVal7);//Different alignment
     Count := Round(Count * COUNTGROWFACTOR);
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
 RunTimeSec := NoOfTicks / lpFrequency;
 Result := Round(RunTimeSec * BENCHSCALE);
end;

function TMainForm.SubBenchmark4 : Cardinal;
var
 Count, MaxCount : Integer;
 ChrVal1, ChrVal2, ChrVal3, ChrVal4, ChrVal5, ChrVal6, ChrVal7 : AnsiChar;
 RunNo : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks : Int64;
 RunTimeSec : Double;

begin
 MaxCount := Length(SubBench4Array) - 14;//Make room for offset for misalignment
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 Succes := QueryPerformanceCounter(lpPerformanceCount);
 if Succes then
  StartCount := lpPerformanceCount
 else
  raise Exception.Create('QueryPerformanceCounter failed');
 ChrVal1 := 'S';
 ChrVal2 := 'B';
 ChrVal3 := 'X';
 ChrVal4 := 'v';
 ChrVal5 := 'A';
 ChrVal6 := 'Y';
 ChrVal7 := 'O';
 for RunNo := 1 to RUNNOMAX4 do
  begin
   Count := MINCOUNTSUBBENCH4;
   while Count < MaxCount do
    begin
     FillCharProcedure(SubBench4Array[1], Count, ChrVal1);
     FillCharProcedure(SubBench4Array[2], Count, ChrVal2);//Different alignment
     FillCharProcedure(SubBench4Array[3], Count, ChrVal3);//Different alignment
     FillCharProcedure(SubBench4Array[4], Count, ChrVal4);//Different alignment
     FillCharProcedure(SubBench4Array[5], Count, ChrVal5);//Different alignment
     FillCharProcedure(SubBench4Array[6], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench4Array[7], Count, ChrVal7);//Different alignment
     FillCharProcedure(SubBench4Array[8], Count, ChrVal2);//Different alignment
     FillCharProcedure(SubBench4Array[9], Count, ChrVal3);//Different alignment
     FillCharProcedure(SubBench4Array[10], Count, ChrVal4);//Different alignment
     FillCharProcedure(SubBench4Array[11], Count, ChrVal5);//Different alignment
     FillCharProcedure(SubBench4Array[12], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench4Array[13], Count, ChrVal7);//Different alignment
     FillCharProcedure(SubBench4Array[14], Count, ChrVal6);//Different alignment
     FillCharProcedure(SubBench4Array[15], Count, ChrVal7);//Different alignment
     Count := Round(Count * COUNTGROWFACTOR);
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
 RunTimeSec := NoOfTicks / lpFrequency;
 Result := Round(RunTimeSec * BENCHSCALE);
end;

//Exactly like SubBenchmark1 - just calls the RTL function without function pointer

function TMainForm.SubBenchmarkRTL1 : Cardinal;
var
 Count, MaxCount : Integer;
 ChrVal1, ChrVal2, ChrVal3, ChrVal4, ChrVal5, ChrVal6, ChrVal7 : AnsiChar;
 RunNo : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks : Int64;
 RunTimeSec : Double;

begin
 MaxCount := Length(SubBench1Array) - 14;//Make room for offset for misalignment
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 Succes := QueryPerformanceCounter(lpPerformanceCount);
 if Succes then
  StartCount := lpPerformanceCount
 else
  raise Exception.Create('QueryPerformanceCounter failed');
 ChrVal1 := 'S';
 ChrVal2 := 'B';
 ChrVal3 := 'X';
 ChrVal4 := 'v';
 ChrVal5 := 'A';
 ChrVal6 := 'Y';
 ChrVal7 := 'O';
 for RunNo := 1 to RUNNOMAX1 do
  begin
   for Count := MINCOUNTSUBBENCH1 to MaxCount do
    begin
     FillChar(SubBench1Array[1], Count, ChrVal1);
     FillChar(SubBench1Array[2], Count, ChrVal2);//Different alignment
     FillChar(SubBench1Array[3], Count, ChrVal3);//Different alignment
     FillChar(SubBench1Array[4], Count, ChrVal4);//Different alignment
     FillChar(SubBench1Array[5], Count, ChrVal5);//Different alignment
     FillChar(SubBench1Array[6], Count, ChrVal6);//Different alignment
     FillChar(SubBench1Array[7], Count, ChrVal7);//Different alignment
     FillChar(SubBench1Array[8], Count, ChrVal2);//Different alignment
     FillChar(SubBench1Array[9], Count, ChrVal3);//Different alignment
     FillChar(SubBench1Array[10], Count, ChrVal4);//Different alignment
     FillChar(SubBench1Array[11], Count, ChrVal5);//Different alignment
     FillChar(SubBench1Array[12], Count, ChrVal6);//Different alignment
     FillChar(SubBench1Array[13], Count, ChrVal7);//Different alignment
     FillChar(SubBench1Array[14], Count, ChrVal6);//Different alignment
     FillChar(SubBench1Array[15], Count, ChrVal7);//Different alignment
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
 RunTimeSec := NoOfTicks / lpFrequency;
 Result := Round(RunTimeSec * BENCHSCALE);
end;

function TMainForm.SubBenchmarkRTL2 : Cardinal;
var
 Count, MaxCount : Integer;
 ChrVal1, ChrVal2, ChrVal3, ChrVal4, ChrVal5, ChrVal6, ChrVal7 : AnsiChar;
 RunNo : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks : Int64;
 RunTimeSec : Double;

begin
 MaxCount := Length(SubBench2Array) - 14;//Make room for offset for misalignment
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 Succes := QueryPerformanceCounter(lpPerformanceCount);
 if Succes then
  StartCount := lpPerformanceCount
 else
  raise Exception.Create('QueryPerformanceCounter failed');
 ChrVal1 := 'S';
 ChrVal2 := 'B';
 ChrVal3 := 'X';
 ChrVal4 := 'v';
 ChrVal5 := 'A';
 ChrVal6 := 'Y';
 ChrVal7 := 'O';
 for RunNo := 1 to RUNNOMAX2 do
  begin
   for Count := MINCOUNTSUBBENCH2 to MaxCount do
    begin
     FillChar(SubBench2Array[1], Count, ChrVal1);
     FillChar(SubBench2Array[2], Count, ChrVal2);//Different alignment
     FillChar(SubBench2Array[3], Count, ChrVal3);//Different alignment
     FillChar(SubBench2Array[4], Count, ChrVal4);//Different alignment
     FillChar(SubBench2Array[5], Count, ChrVal5);//Different alignment
     FillChar(SubBench2Array[6], Count, ChrVal6);//Different alignment
     FillChar(SubBench2Array[7], Count, ChrVal7);//Different alignment
     FillChar(SubBench2Array[8], Count, ChrVal2);//Different alignment
     FillChar(SubBench2Array[9], Count, ChrVal3);//Different alignment
     FillChar(SubBench2Array[10], Count, ChrVal4);//Different alignment
     FillChar(SubBench2Array[11], Count, ChrVal5);//Different alignment
     FillChar(SubBench2Array[12], Count, ChrVal6);//Different alignment
     FillChar(SubBench2Array[13], Count, ChrVal7);//Different alignment
     FillChar(SubBench2Array[14], Count, ChrVal6);//Different alignment
     FillChar(SubBench2Array[15], Count, ChrVal7);//Different alignment
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
 RunTimeSec := NoOfTicks / lpFrequency;
 Result := Round(RunTimeSec * BENCHSCALE);
end;

function TMainForm.SubBenchmarkRTL3 : Cardinal;
var
 Count, MaxCount : Integer;
 ChrVal1, ChrVal2, ChrVal3, ChrVal4, ChrVal5, ChrVal6, ChrVal7 : AnsiChar;
 RunNo : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks : Int64;
 RunTimeSec : Double;

begin
 MaxCount := Length(SubBench3Array) - 14;//Make room for offset for misalignment
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 Succes := QueryPerformanceCounter(lpPerformanceCount);
 if Succes then
  StartCount := lpPerformanceCount
 else
  raise Exception.Create('QueryPerformanceCounter failed');
 ChrVal1 := 'S';
 ChrVal2 := 'B';
 ChrVal3 := 'X';
 ChrVal4 := 'v';
 ChrVal5 := 'A';
 ChrVal6 := 'Y';
 ChrVal7 := 'O';
 for RunNo := 1 to RUNNOMAX3 do
  begin
   Count := MINCOUNTSUBBENCH3;
   while Count < MaxCount do
    begin
     FillChar(SubBench3Array[1], Count, ChrVal1);
     FillChar(SubBench3Array[2], Count, ChrVal2);//Different alignment
     FillChar(SubBench3Array[3], Count, ChrVal3);//Different alignment
     FillChar(SubBench3Array[4], Count, ChrVal4);//Different alignment
     FillChar(SubBench3Array[5], Count, ChrVal5);//Different alignment
     FillChar(SubBench3Array[6], Count, ChrVal6);//Different alignment
     FillChar(SubBench3Array[7], Count, ChrVal7);//Different alignment
     FillChar(SubBench3Array[8], Count, ChrVal2);//Different alignment
     FillChar(SubBench3Array[9], Count, ChrVal3);//Different alignment
     FillChar(SubBench3Array[10], Count, ChrVal4);//Different alignment
     FillChar(SubBench3Array[11], Count, ChrVal5);//Different alignment
     FillChar(SubBench3Array[12], Count, ChrVal6);//Different alignment
     FillChar(SubBench3Array[13], Count, ChrVal7);//Different alignment
     FillChar(SubBench3Array[14], Count, ChrVal6);//Different alignment
     FillChar(SubBench3Array[15], Count, ChrVal7);//Different alignment
     Count := Round(Count * COUNTGROWFACTOR);
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
 RunTimeSec := NoOfTicks / lpFrequency;
 Result := Round(RunTimeSec * BENCHSCALE);
end;

function TMainForm.SubBenchmarkRTL4 : Cardinal;
var
 Count, MaxCount : Integer;
 ChrVal1, ChrVal2, ChrVal3, ChrVal4, ChrVal5, ChrVal6, ChrVal7 : AnsiChar;
 RunNo : Cardinal;
 Succes : Boolean;
 lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks : Int64;
 RunTimeSec : Double;

begin
 MaxCount := Length(SubBench4Array) - 14;//Make room for offset for misalignment
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 Succes := QueryPerformanceCounter(lpPerformanceCount);
 if Succes then
  StartCount := lpPerformanceCount
 else
  raise Exception.Create('QueryPerformanceCounter failed');
 ChrVal1 := 'S';
 ChrVal2 := 'B';
 ChrVal3 := 'X';
 ChrVal4 := 'v';
 ChrVal5 := 'A';
 ChrVal6 := 'Y';
 ChrVal7 := 'O';
 for RunNo := 1 to RUNNOMAX4 do
  begin
   Count := MINCOUNTSUBBENCH4;
   while Count < MaxCount do
    begin
     FillChar(SubBench4Array[1], Count, ChrVal1);
     FillChar(SubBench4Array[2], Count, ChrVal2);//Different alignment
     FillChar(SubBench4Array[3], Count, ChrVal3);//Different alignment
     FillChar(SubBench4Array[4], Count, ChrVal4);//Different alignment
     FillChar(SubBench4Array[5], Count, ChrVal5);//Different alignment
     FillChar(SubBench4Array[6], Count, ChrVal6);//Different alignment
     FillChar(SubBench4Array[7], Count, ChrVal7);//Different alignment
     FillChar(SubBench4Array[8], Count, ChrVal2);//Different alignment
     FillChar(SubBench4Array[9], Count, ChrVal3);//Different alignment
     FillChar(SubBench4Array[10], Count, ChrVal4);//Different alignment
     FillChar(SubBench4Array[11], Count, ChrVal5);//Different alignment
     FillChar(SubBench4Array[12], Count, ChrVal6);//Different alignment
     FillChar(SubBench4Array[13], Count, ChrVal7);//Different alignment
     FillChar(SubBench4Array[14], Count, ChrVal6);//Different alignment
     FillChar(SubBench4Array[15], Count, ChrVal7);//Different alignment
     Count := Round(Count * COUNTGROWFACTOR);
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
 RunTimeSec := NoOfTicks / lpFrequency;
 Result := Round(RunTimeSec * BENCHSCALE);
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 FunctionName, FunctionAddressString : AnsiString;
 FunctionAddress: NativeUInt;
 SubBench1, SubBench2, SubBench3, SubBench4, Bench : Cardinal;

begin
try
 if not SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
 FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
 FunctionAddress := NativeUInt(@FillCharProcedure);
 FunctionAddressString := IntToHex(FunctionAddress, 16);

 if FunctionSelectionRadioGroup.ItemIndex = 0 then//RTL function selected
  begin
   SubBench1 := SubBenchmarkRTL1;
   SubBench2 := SubBenchmarkRTL2;
   SubBench3 := SubBenchmarkRTL3;
   SubBench4 := SubBenchmarkRTL4;
  end
 else
  begin
   SubBench1 := SubBenchmark1;
   SubBench2 := SubBenchmark2;
   SubBench3 := SubBenchmark3;
   SubBench4 := SubBenchmark4;
  end;
   Bench := SubBench1 * SUBBENCH1WEIGTH
          + SubBench2 * SUBBENCH2WEIGTH
          + SubBench3 * SUBBENCH3WEIGTH
          + SubBench4 * SUBBENCH4WEIGTH;
 BenchmarkEdit.Text := IntToStr(Bench);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[16]
                                       + #9 + IntToStr(SubBench1)
                                       + #9 + IntToStr(SubBench2)
                                       + #9 + IntToStr(SubBench3)
                                       + #9 + IntToStr(SubBench4)
                                       + #9 + IntToStr(Bench));
 SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
except
 FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
 FunctionAddress := NativeUInt(@FillCharProcedure);
 FunctionAddressString := IntToHex(FunctionAddress, 16);
 ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed'
                                       + #9 + '99999'
                                       + #9 + '99999'
                                       + #9 + '99999'
                                       + #9 + '99999');
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

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';

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

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';

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

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.PrintReportSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('');
end;

procedure TMainForm.SpreadTestButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 for I := 0 to 10 do
  begin
   BenchmarkButtonClick(nil);
   SortRichEdit;
   BenchmarkTest;
   Update;
  end;
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 for I1 := 0 to 2 do
  begin
   for I2 := 0 to FunctionSelectionRadioGroup.Items.Count-1  do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkButtonClick(nil);
     Update;
    end;
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkButtonClick(nil);
   for I3 := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I3;
     BenchmarkButtonClick(nil);
     Update;
    end;
  end;
end;

procedure TMainForm.BenchmarkEditClick(Sender: TObject);
begin
 BenchmarkEdit.SelectAll;
 BenchmarkEdit.CopyToClipboard;
end;

procedure TMainForm.CleanClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 BenchmarkTest;
 AlignmentTest;
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


