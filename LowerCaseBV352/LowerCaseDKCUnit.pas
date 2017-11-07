unit LowerCaseDKCUnit;

interface

function LowerCase_DKC_Pas_1_a(const S: string): string;
function LowerCase_DKC_Pas_1_b(const S: string): string;
function LowerCase_DKC_Pas_1_c(const S: string): string;
function LowerCase_DKC_Pas_1_d(const S: string): string;
function LowerCase_DKC_IA32_1_a(const S: string): string;
function LowerCase_DKC_IA32_1_b(const S: string): string;
function LowerCase_DKC_IA32_1_c(const S: string): string;
function LowerCase_DKC_IA32_1_d(const S: string): string;
function LowerCase_DKC_IA32_4_a(const S: string): string;
function LowerCase_DKC_IA32_4_b(const S: string): string;
function LowerCase_DKC_IA32_4_c(const S: string): string;
function LowerCase_DKC_IA32_4_d(const S: string): string;
function LowerCase_DKC_IA32_13_a(const S: string): string;
function LowerCase_DKC_IA32_13_b(const S: string): string;
function LowerCase_DKC_IA32_13_c(const S: string): string;
function LowerCase_DKC_IA32_13_d(const S: string): string;
function LowerCase_DKC_IA32_14_a(const S: string): string;
function LowerCase_DKC_IA32_14_b(const S: string): string;
function LowerCase_DKC_IA32_14_c(const S: string): string;
function LowerCase_DKC_IA32_14_d(const S: string): string;
function LowerCase_DKC_IA32_18_a(const S: string): string;
function LowerCase_DKC_IA32_18_b(const S: string): string;
function LowerCase_DKC_IA32_18_c(const S: string): string;
function LowerCase_DKC_IA32_18_d(const S: string): string;

implementation

uses
 SysUtils;

var
 LookUpTable : array of Char;

procedure InitializeLookUpTable;
var
 I : Byte;
 S1, S2 : AnsiString;

begin
 SetLength(LookUpTable, 256);
 for I := 0 to 255 do
  begin
   S1 := Char(I);
   S2 := LowerCase(S1);
   LookUpTable[I] := S2[1];
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              9/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function LowerCase_DKC_Pas_1_a(const S: string): string;
var
 Max, CharNo : Cardinal;

begin
 Max := Length(S);
 SetLength(Result, Max);
 for CharNo := 1 to Max do
  begin
   if (Ord(S[CharNo]) >= Ord('A')) and (Ord(S[CharNo]) <= Ord('Z')) then
    Result[CharNo] := Char(Ord(S[CharNo]) + 32)
   else
    Result[CharNo] := S[CharNo];
  end;
end;

procedure Filler1;
asm
 nop
end;

function LowerCase_DKC_Pas_1_b(const S: string): string;
var
 Max, CharNo : Cardinal;

begin
 Max := Length(S);
 SetLength(Result, Max);
 for CharNo := 1 to Max do
  begin
   if (Ord(S[CharNo]) >= Ord('A')) and (Ord(S[CharNo]) <= Ord('Z')) then
    Result[CharNo] := Char(Ord(S[CharNo]) + 32)
   else
    Result[CharNo] := S[CharNo];
  end;
end;

procedure Filler2;
asm
 nop
end;

function LowerCase_DKC_Pas_1_c(const S: string): string;
var
 Max, CharNo : Cardinal;

begin
 Max := Length(S);
 SetLength(Result, Max);
 for CharNo := 1 to Max do
  begin
   if (Ord(S[CharNo]) >= Ord('A')) and (Ord(S[CharNo]) <= Ord('Z')) then
    Result[CharNo] := Char(Ord(S[CharNo]) + 32)
   else
    Result[CharNo] := S[CharNo];
  end;
end;

procedure Filler3;
asm
 nop
end;

function LowerCase_DKC_Pas_1_d(const S: string): string;
var
 Max, CharNo : Cardinal;

begin
 Max := Length(S);
 SetLength(Result, Max);
 for CharNo := 1 to Max do
  begin
   if (Ord(S[CharNo]) >= Ord('A')) and (Ord(S[CharNo]) <= Ord('Z')) then
    Result[CharNo] := Char(Ord(S[CharNo]) + 32)
   else
    Result[CharNo] := S[CharNo];
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              9/1 2004
//Optimized for:     P4
//Instructionset(s): IA32

function LowerCase_DKC_IA32_1_a(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 mov   ebx,eax
 test  eax,eax
 jz    @LStrLenExit
 mov   eax,[eax-$04]
@LStrLenExit :
 mov   esi,eax
 mov   edi,edx
 //SetLength(Result, Max);
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit1
 //PResult := Pointer(Result);
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 //until(CharNo >= Max);
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              9/1 2004
//Optimized for:     P4
//Instructionset(s): IA32

function LowerCase_DKC_IA32_1_b(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 mov   ebx,eax
 test  eax,eax
 jz    @LStrLenExit
 mov   eax,[eax-$04]
@LStrLenExit :
 mov   esi,eax
 mov   edi,edx
 //SetLength(Result, Max);
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit1
 //PResult := Pointer(Result);
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 //until(CharNo >= Max);
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              9/1 2004
//Optimized for:     P4
//Instructionset(s): IA32

function LowerCase_DKC_IA32_1_c(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 mov   ebx,eax
 test  eax,eax
 jz    @LStrLenExit
 mov   eax,[eax-$04]
@LStrLenExit :
 mov   esi,eax
 mov   edi,edx
 //SetLength(Result, Max);
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit1
 //PResult := Pointer(Result);
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 //until(CharNo >= Max);
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              9/1 2004
//Optimized for:     P4
//Instructionset(s): IA32

function LowerCase_DKC_IA32_1_d(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 mov   ebx,eax
 test  eax,eax
 jz    @LStrLenExit
 mov   eax,[eax-$04]
@LStrLenExit :
 mov   esi,eax
 mov   edi,edx
 //SetLength(Result, Max);
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit1
 //PResult := Pointer(Result);
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 //until(CharNo >= Max);
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/11 2004
//Instructionset(s): IA32

function LowerCase_DKC_IA32_4_a(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 //SetLength(Result, Max);
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 //PResult := Pointer(Result);
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

function LowerCase_DKC_IA32_4_b(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 //SetLength(Result, Max);
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 //PResult := Pointer(Result);
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

procedure Filler9;
asm
 nop
end;

function LowerCase_DKC_IA32_4_c(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 //SetLength(Result, Max);
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 //PResult := Pointer(Result);
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

function LowerCase_DKC_IA32_4_d(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 //SetLength(Result, Max);
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 //PResult := Pointer(Result);
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 sub   esi,1
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              17/11 2004
//Instructionset(s): IA32

function LowerCase_DKC_IA32_13_a(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

function LowerCase_DKC_IA32_13_b(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

procedure Filler15;
asm
 nop
end;

function LowerCase_DKC_IA32_13_c(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

function LowerCase_DKC_IA32_13_d(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              17/11 2004
//Instructionset(s): IA32

function LowerCase_DKC_IA32_14_a(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

function LowerCase_DKC_IA32_14_b(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

procedure Filler16;
asm
 nop
end;

function LowerCase_DKC_IA32_14_c(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

function LowerCase_DKC_IA32_14_d(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jbe   @Exit1
 movzx edx,[ebx+esi]
 movzx edx,[ecx+edx]
 mov   [edi+esi],dl
 movzx edx,[ebx+esi-1]
 movzx edx,[ecx+edx]
 mov   [edi+esi-1],dl
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/11 2004
//Instructionset(s): IA32

function LowerCase_DKC_IA32_18_a(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

function LowerCase_DKC_IA32_18_b(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

function LowerCase_DKC_IA32_18_c(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

function LowerCase_DKC_IA32_18_d(const S: string): string;
asm
 push  esi
 test  eax,eax
 jz    @SIsNil
 mov   esi,[eax-$04]
 test  esi,esi
 jbe   @SIsEmpty
 push  ebx
 push  edi
 mov   edi,edx
 mov   ebx,eax
 mov   eax,edx
 mov   edx,esi
 call  System.@LStrSetLength
 mov   edi,[edi]
 sub   ebx,1
 sub   edi,1
 mov   ecx,[LookUpTable]
@RepeatBegin :
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jbe   @Exit1
 movzx eax,[ebx+esi-1]
 movzx edx,[ecx+eax]
 movzx eax,[ebx+esi]
 mov   dh,[ecx+eax]
 mov   [edi+esi-1],dx
 sub   esi,2
 jnbe  @RepeatBegin
@Exit1 :
 pop   edi
 pop   ebx
 pop   esi
 ret
@SIsNil :
@SIsEmpty :
 mov   eax,edx
 xor   edx,edx
 call  System.@LStrSetLength
 pop   esi
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler9;
 Filler15;
 Filler16;

 InitializeLookUpTable;

end.
