unit UpperCaseDKCUnit;

interface

function UpperCase_DKC_Pas_32_a(const S: string): string;
function UpperCase_DKC_Pas_32_b(const S: string): string;
function UpperCase_DKC_Pas_32_c(const S: string): string;
function UpperCase_DKC_Pas_32_d(const S: string): string;
function UpperCase_DKC_IA32_10_a(const S: string): string;
function UpperCase_DKC_IA32_10_b(const S: string): string;
function UpperCase_DKC_IA32_10_c(const S: string): string;
function UpperCase_DKC_IA32_10_d(const S: string): string;
function UpperCase_DKC_IA32_18_a(const S: string): string;
function UpperCase_DKC_IA32_18_b(const S: string): string;
function UpperCase_DKC_IA32_18_c(const S: string): string;
function UpperCase_DKC_IA32_18_d(const S: string): string;
function UpperCase_DKC_SSE3_1_a(const S: string): string;
function UpperCase_DKC_SSE3_1_b(const S: string): string;
function UpperCase_DKC_SSE3_1_c(const S: string): string;
function UpperCase_DKC_SSE3_1_d(const S: string): string;
function UpperCase_DKC_SSE2_6_a(const S: string): string;
function UpperCase_DKC_SSE2_6_b(const S: string): string;
function UpperCase_DKC_SSE2_6_c(const S: string): string;
function UpperCase_DKC_SSE2_6_d(const S: string): string;
function UpperCase_DKC_MMX_34_a(const S: string): string;
function UpperCase_DKC_MMX_34_b(const S: string): string;
function UpperCase_DKC_MMX_34_c(const S: string): string;
function UpperCase_DKC_MMX_34_d(const S: string): string;
function UpperCase_DKC_MMX_35_a(const S: string): string;
function UpperCase_DKC_MMX_35_b(const S: string): string;
function UpperCase_DKC_MMX_35_c(const S: string): string;
function UpperCase_DKC_MMX_35_d(const S: string): string;
function UpperCase_DKC_MMX_36_a(const S: string): string;
function UpperCase_DKC_MMX_36_b(const S: string): string;
function UpperCase_DKC_MMX_36_c(const S: string): string;
function UpperCase_DKC_MMX_36_d(const S: string): string;

function UpperCase_DKC_IA32_19_a(const S: string): string;
function UpperCase_DKC_IA32_19_b(const S: string): string;
function UpperCase_DKC_IA32_19_c(const S: string): string;
function UpperCase_DKC_IA32_19_d(const S: string): string;
function UpperCase_DKC_IA32_21_a(const S: string): string;
function UpperCase_DKC_IA32_21_b(const S: string): string;
function UpperCase_DKC_IA32_21_c(const S: string): string;
function UpperCase_DKC_IA32_21_d(const S: string): string;
function UpperCase_DKC_MMX_48_a(const S: string): string;
function UpperCase_DKC_MMX_48_b(const S: string): string;
function UpperCase_DKC_MMX_48_c(const S: string): string;
function UpperCase_DKC_MMX_48_d(const S: string): string;
function UpperCase_DKC_MMX_49_a(const S: string): string;
function UpperCase_DKC_MMX_49_b(const S: string): string;
function UpperCase_DKC_MMX_49_c(const S: string): string;
function UpperCase_DKC_MMX_49_d(const S: string): string;

function UpperCase_DKC_MMX_54_a(const S: string): string;
function UpperCase_DKC_MMX_54_b(const S: string): string;
function UpperCase_DKC_MMX_54_c(const S: string): string;
function UpperCase_DKC_MMX_54_d(const S: string): string;
function UpperCase_DKC_MMX_56_a(const S: string): string;
function UpperCase_DKC_MMX_56_b(const S: string): string;
function UpperCase_DKC_MMX_56_c(const S: string): string;
function UpperCase_DKC_MMX_56_d(const S: string): string;
function UpperCase_DKC_MMX_59_a(const S: string): string;
function UpperCase_DKC_MMX_59_b(const S: string): string;
function UpperCase_DKC_MMX_59_c(const S: string): string;
function UpperCase_DKC_MMX_59_d(const S: string): string;
function UpperCase_DKC_MMX_62_a(const S: string): string;
function UpperCase_DKC_MMX_62_b(const S: string): string;
function UpperCase_DKC_MMX_62_c(const S: string): string;
function UpperCase_DKC_MMX_62_d(const S: string): string;
function UpperCase_DKC_SSE_3_a(const S: string): string;
function UpperCase_DKC_SSE_3_b(const S: string): string;
function UpperCase_DKC_SSE_3_c(const S: string): string;
function UpperCase_DKC_SSE_3_d(const S: string): string;
function UpperCase_DKC_SSE_4_a(const S: string): string;
function UpperCase_DKC_SSE_4_b(const S: string): string;
function UpperCase_DKC_SSE_4_c(const S: string): string;
function UpperCase_DKC_SSE_4_d(const S: string): string;
function UpperCase_DKC_SSE2_7_a(const S: string): string;
function UpperCase_DKC_SSE2_7_b(const S: string): string;
function UpperCase_DKC_SSE2_7_c(const S: string): string;
function UpperCase_DKC_SSE2_7_d(const S: string): string;
function UpperCase_DKC_SSE3_5_a(const S: string): string;
function UpperCase_DKC_SSE3_5_b(const S: string): string;
function UpperCase_DKC_SSE3_5_c(const S: string): string;
function UpperCase_DKC_SSE3_5_d(const S: string): string;

implementation

uses
 SysUtils;

var
 LookUpTable : array of Char;
LookUpTable2 : array[0..255] of Char;

procedure InitializeLookUpTable;
var
 I : Byte;
 S1, S2 : AnsiString;

begin
 SetLength(LookUpTable, 256);
 for I := 0 to 255 do
  begin
   S1 := Char(I);
   S2 := UpperCase(S1);
   LookUpTable[I] := S2[1];
  end;
end;

procedure InitializeLookUpTable2;
var
 I : Byte;

begin
 for I := 0 to 255 do
  begin
   if (Char(I) >= 'a') and (Char(I) <= 'z') then
    LookUpTable2[I] := Char(I - 32)
   else
    LookUpTable2[I] := Char(I);
  end;
end;


//Author:            Dennis Kjaer Christensen
//Date:              1/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function UpperCase_DKC_Pas_32_a(const S: string): string;
var
 Max, CharNo : Cardinal;
 pResult : PChar;

begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max > 0 then
  begin
   pResult := PChar(Result);
   CharNo := 0;
   repeat
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
   until(CharNo >= Max);
  end;
end;

function UpperCase_DKC_Pas_32_b(const S: string): string;
var
 Max, CharNo : Cardinal;
 pResult : PChar;

begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max > 0 then
  begin
   pResult := PChar(Result);
   CharNo := 0;
   repeat
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
   until(CharNo >= Max);
  end;
end;

procedure Filler2;
asm
 nop
end;


function UpperCase_DKC_Pas_32_c(const S: string): string;
var
 Max, CharNo : Cardinal;
 pResult : PChar;

begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max > 0 then
  begin
   pResult := PChar(Result);
   CharNo := 0;
   repeat
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
   until(CharNo >= Max);
  end;
end;

function UpperCase_DKC_Pas_32_d(const S: string): string;
var
 Max, CharNo : Cardinal;
 pResult : PChar;

begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max > 0 then
  begin
   pResult := PChar(Result);
   CharNo := 0;
   repeat
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
   until(CharNo >= Max);
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function UpperCase_DKC_IA32_10_a(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],dl
 add   eax,1
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

function UpperCase_DKC_IA32_10_b(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],dl
 add   eax,1
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

procedure Filler1;
asm
 nop
end;

function UpperCase_DKC_IA32_10_c(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],dl
 add   eax,1
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

function UpperCase_DKC_IA32_10_d(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],dl
 add   eax,1
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              7/10 2003
//Optimized for:     P4
//Instructionset(s): IA32

function UpperCase_DKC_IA32_18_a(const S: string): string;
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

function UpperCase_DKC_IA32_18_b(const S: string): string;
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
 movzx   edx,[ecx+edx]
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

function UpperCase_DKC_IA32_18_c(const S: string): string;
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
 movzx   edx,[ecx+edx]
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

function UpperCase_DKC_IA32_18_d(const S: string): string;
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
 movzx   edx,[ecx+edx]
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
//Date:              27/7 2006
//Instructionset(s): IA32, MMX

function UpperCase_DKC_MMX_34_a(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 test      eax,eax
 jz        @NilString
 mov       ecx,[eax-$04]
 test      ecx,ecx
 jbe       @NonNilEmptyString
 push      ebx
 push      esi
 push      edi
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       esi,ecx
 mov       edx,ecx
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 sub       esi,eax
 cmp       esi,3
 jbe       @ByteUpper2
 add       esi,eax
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
 jmp       @L1
@ByteUpper2 :
 add       esi,eax
@L1 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/7 2006
//Instructionset(s): IA32, MMX

function UpperCase_DKC_MMX_34_b(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 test      eax,eax
 jz        @NilString
 mov       ecx,[eax-$04]
 test      ecx,ecx
 jbe       @NonNilEmptyString
 push      ebx
 push      esi
 push      edi
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       esi,ecx
 mov       edx,ecx
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 sub       esi,eax
 cmp       esi,3
 jbe       @ByteUpper2
 add       esi,eax
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
 jmp       @L1
@ByteUpper2 :
 add       esi,eax
@L1 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/7 2006
//Instructionset(s): IA32, MMX

function UpperCase_DKC_MMX_34_c(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 test      eax,eax
 jz        @NilString
 mov       ecx,[eax-$04]
 test      ecx,ecx
 jbe       @NonNilEmptyString
 push      ebx
 push      esi
 push      edi
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       esi,ecx
 mov       edx,ecx
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 sub       esi,eax
 cmp       esi,3
 jbe       @ByteUpper2
 add       esi,eax
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
 jmp       @L1
@ByteUpper2 :
 add       esi,eax
@L1 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/7 2006
//Instructionset(s): IA32, MMX

function UpperCase_DKC_MMX_34_d(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 test      eax,eax
 jz        @NilString
 mov       ecx,[eax-$04]
 test      ecx,ecx
 jbe       @NonNilEmptyString
 push      ebx
 push      esi
 push      edi
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       esi,ecx
 mov       edx,ecx
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 sub       esi,eax
 cmp       esi,3
 jbe       @ByteUpper2
 add       esi,eax
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
 jmp       @L1
@ByteUpper2 :
 add       esi,eax
@L1 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
end;




//Author:            Dennis Kjaer Christensen
//Date:              16/6 2005
//Instructionset(s): IA32, SSE2

function UpperCase_DKC_SSE2_6_a(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push    ebx
 push    esi
 push    edi
 mov     edi,edx
 mov     ebx,eax
 //Max := Length(S);
 test    eax,eax
 jz      @LStrLenExit
 mov     eax,[eax-$04]
@LStrLenExit :
 //SetLength(Result, Max);
 mov     esi,eax
 mov     eax,edi
 mov     edx,esi
 call    System.@LStrSetLength
 //if Max > 0 then
 test    esi,esi
 jbe     @Exit
 //PResult := Pointer(Result);
 mov     edi,[edi]
 //CharNo := 0;
 xor     eax,eax
 cmp     esi,32
 jb      @SmallBegin
 sub     esi,15
 movdqu  xmm2,Const1
 movdqu  xmm3,Const2
 movdqu  xmm4,Const3
 //UpperCase first 16 chars
 movdqu  xmm0,[ebx]
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi],xmm0
 //Align   Source
 mov     ecx,ebx
 and     ecx,15
 sub     ecx,16
 sub     eax,ecx
@RepeatBigBegin :
 movdqa  xmm0,[ebx+eax]
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi+eax],xmm0
 add     eax,16
 //until(CharNo >= Max);
 cmp     esi,eax
 jnbe    @RepeatBigBegin
 add     esi,15
 cmp     esi,eax
 jbe     @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@RepeatBegin :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @RepeatBegin
@Exit :
 pop     edi
 pop     esi
 pop     ebx
end;

function UpperCase_DKC_SSE2_6_b(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push    ebx
 push    esi
 push    edi
 mov     edi,edx
 mov     ebx,eax
 //Max := Length(S);
 test    eax,eax
 jz      @LStrLenExit
 mov     eax,[eax-$04]
@LStrLenExit :
 //SetLength(Result, Max);
 mov     esi,eax
 mov     eax,edi
 mov     edx,esi
 call    System.@LStrSetLength
 //if Max > 0 then
 test    esi,esi
 jbe     @Exit
 //PResult := Pointer(Result);
 mov     edi,[edi]
 //CharNo := 0;
 xor     eax,eax
 cmp     esi,32
 jb      @SmallBegin
 sub     esi,15
 movdqu  xmm2,Const1
 movdqu  xmm3,Const2
 movdqu  xmm4,Const3
 //UpperCase first 16 chars
 movdqu  xmm0,[ebx]
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi],xmm0
 //Align   Source
 mov     ecx,ebx
 and     ecx,15
 sub     ecx,16
 sub     eax,ecx
@RepeatBigBegin :
 movdqa  xmm0,[ebx+eax]
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi+eax],xmm0
 add     eax,16
 //until(CharNo >= Max);
 cmp     esi,eax
 jnbe    @RepeatBigBegin
 add     esi,15
 cmp     esi,eax
 jbe     @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@RepeatBegin :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @RepeatBegin
@Exit :
 pop     edi
 pop     esi
 pop     ebx
end;

function UpperCase_DKC_SSE2_6_c(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push    ebx
 push    esi
 push    edi
 mov     edi,edx
 mov     ebx,eax
 //Max := Length(S);
 test    eax,eax
 jz      @LStrLenExit
 mov     eax,[eax-$04]
@LStrLenExit :
 //SetLength(Result, Max);
 mov     esi,eax
 mov     eax,edi
 mov     edx,esi
 call    System.@LStrSetLength
 //if Max > 0 then
 test    esi,esi
 jbe     @Exit
 //PResult := Pointer(Result);
 mov     edi,[edi]
 //CharNo := 0;
 xor     eax,eax
 cmp     esi,32
 jb      @SmallBegin
 sub     esi,15
 movdqu  xmm2,Const1
 movdqu  xmm3,Const2
 movdqu  xmm4,Const3
 //UpperCase first 16 chars
 movdqu  xmm0,[ebx]
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi],xmm0
 //Align   Source
 mov     ecx,ebx
 and     ecx,15
 sub     ecx,16
 sub     eax,ecx
@RepeatBigBegin :
 movdqa  xmm0,[ebx+eax]
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi+eax],xmm0
 add     eax,16
 //until(CharNo >= Max);
 cmp     esi,eax
 jnbe    @RepeatBigBegin
 add     esi,15
 cmp     esi,eax
 jbe     @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@RepeatBegin :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @RepeatBegin
@Exit :
 pop     edi
 pop     esi
 pop     ebx
end;

function UpperCase_DKC_SSE2_6_d(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push    ebx
 push    esi
 push    edi
 mov     edi,edx
 mov     ebx,eax
 //Max := Length(S);
 test    eax,eax
 jz      @LStrLenExit
 mov     eax,[eax-$04]
@LStrLenExit :
 //SetLength(Result, Max);
 mov     esi,eax
 mov     eax,edi
 mov     edx,esi
 call    System.@LStrSetLength
 //if Max > 0 then
 test    esi,esi
 jbe     @Exit
 //PResult := Pointer(Result);
 mov     edi,[edi]
 //CharNo := 0;
 xor     eax,eax
 cmp     esi,32
 jb      @SmallBegin
 sub     esi,15
 movdqu  xmm2,Const1
 movdqu  xmm3,Const2
 movdqu  xmm4,Const3
 //UpperCase first 16 chars
 movdqu  xmm0,[ebx]
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi],xmm0
 //Align   Source
 mov     ecx,ebx
 and     ecx,15
 sub     ecx,16
 sub     eax,ecx
@RepeatBigBegin :
 movdqa  xmm0,[ebx+eax]
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi+eax],xmm0
 add     eax,16
 //until(CharNo >= Max);
 cmp     esi,eax
 jnbe    @RepeatBigBegin
 add     esi,15
 cmp     esi,eax
 jbe     @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@RepeatBegin :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @RepeatBegin
@Exit :
 pop     edi
 pop     esi
 pop     ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              16/6 2005
//Instructionset(s): IA32, SSE2, SSE3

function UpperCase_DKC_SSE3_1_a(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push    ebx
 push    esi
 push    edi
 mov     edi,edx
 mov     ebx,eax
 //Max := Length(S);
 test    eax,eax
 jz      @LStrLenExit
 mov     eax,[eax-$04]
@LStrLenExit :
 //SetLength(Result, Max);
 mov     esi,eax
 mov     eax,edi
 mov     edx,esi
 call    System.@LStrSetLength
 //if Max > 0 then
 test    esi,esi
 jbe     @Exit
 //PResult := Pointer(Result);
 mov     edi,[edi]
 //CharNo := 0;
 xor     eax,eax
 cmp     esi,16
 jb      @SmallBegin
 sub     esi,15
 movdqu  xmm2,Const1
 movdqu  xmm3,Const2
 movdqu  xmm4,Const3
@RepeatBigBegin :
 //lddqu   xmm0,[ebx+eax]
 db $F2 db $0F db $F0 db $04 db $18
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi+eax],xmm0
 add     eax,16
 //until(CharNo >= Max);
 cmp     esi,eax
 jnbe    @RepeatBigBegin
 add     esi,15
 cmp     esi,eax
 jbe     @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@RepeatBegin :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @RepeatBegin
@Exit :
 pop     edi
 pop     esi
 pop     ebx
end;

function UpperCase_DKC_SSE3_1_b(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push    ebx
 push    esi
 push    edi
 mov     edi,edx
 mov     ebx,eax
 //Max := Length(S);
 test    eax,eax
 jz      @LStrLenExit
 mov     eax,[eax-$04]
@LStrLenExit :
 //SetLength(Result, Max);
 mov     esi,eax
 mov     eax,edi
 mov     edx,esi
 call    System.@LStrSetLength
 //if Max > 0 then
 test    esi,esi
 jbe     @Exit
 //PResult := Pointer(Result);
 mov     edi,[edi]
 //CharNo := 0;
 xor     eax,eax
 cmp     esi,16
 jb      @SmallBegin
 sub     esi,15
 movdqu  xmm2,Const1
 movdqu  xmm3,Const2
 movdqu  xmm4,Const3
@RepeatBigBegin :
 //lddqu   xmm0,[ebx+eax]
 db $F2 db $0F db $F0 db $04 db $18
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi+eax],xmm0
 add     eax,16
 //until(CharNo >= Max);
 cmp     esi,eax
 jnbe    @RepeatBigBegin
 add     esi,15
 cmp     esi,eax
 jbe     @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@RepeatBegin :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @RepeatBegin
@Exit :
 pop     edi
 pop     esi
 pop     ebx
end;

function UpperCase_DKC_SSE3_1_c(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push    ebx
 push    esi
 push    edi
 mov     edi,edx
 mov     ebx,eax
 //Max := Length(S);
 test    eax,eax
 jz      @LStrLenExit
 mov     eax,[eax-$04]
@LStrLenExit :
 //SetLength(Result, Max);
 mov     esi,eax
 mov     eax,edi
 mov     edx,esi
 call    System.@LStrSetLength
 //if Max > 0 then
 test    esi,esi
 jbe     @Exit
 //PResult := Pointer(Result);
 mov     edi,[edi]
 //CharNo := 0;
 xor     eax,eax
 cmp     esi,16
 jb      @SmallBegin
 sub     esi,15
 movdqu  xmm2,Const1
 movdqu  xmm3,Const2
 movdqu  xmm4,Const3
@RepeatBigBegin :
 //lddqu   xmm0,[ebx+eax]
 db $F2 db $0F db $F0 db $04 db $18
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi+eax],xmm0
 add     eax,16
 //until(CharNo >= Max);
 cmp     esi,eax
 jnbe    @RepeatBigBegin
 add     esi,15
 cmp     esi,eax
 jbe     @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@RepeatBegin :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @RepeatBegin
@Exit :
 pop     edi
 pop     esi
 pop     ebx
end;

function UpperCase_DKC_SSE3_1_d(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push    ebx
 push    esi
 push    edi
 mov     edi,edx
 mov     ebx,eax
 //Max := Length(S);
 test    eax,eax
 jz      @LStrLenExit
 mov     eax,[eax-$04]
@LStrLenExit :
 //SetLength(Result, Max);
 mov     esi,eax
 mov     eax,edi
 mov     edx,esi
 call    System.@LStrSetLength
 //if Max > 0 then
 test    esi,esi
 jbe     @Exit
 //PResult := Pointer(Result);
 mov     edi,[edi]
 //CharNo := 0;
 xor     eax,eax
 cmp     esi,16
 jb      @SmallBegin
 sub     esi,15
 movdqu  xmm2,Const1
 movdqu  xmm3,Const2
 movdqu  xmm4,Const3
@RepeatBigBegin :
 //lddqu   xmm0,[ebx+eax]
 db $F2 db $0F db $F0 db $04 db $18
 movdqa  xmm1,xmm0
 paddb   xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb xmm1,xmm4
 pand    xmm1,xmm3        //char3 = char3 and 7Fh
 psubb   xmm0,xmm1        //char = char - char3
 movdqu  [edi+eax],xmm0
 add     eax,16
 //until(CharNo >= Max);
 cmp     esi,eax
 jnbe    @RepeatBigBegin
 add     esi,15
 cmp     esi,eax
 jbe     @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@RepeatBegin :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @RepeatBegin
@Exit :
 pop     edi
 pop     esi
 pop     ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/7 2006
//Instructionset(s): IA32, MMX

function UpperCase_DKC_MMX_35_a(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @ByteUpper2
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper2 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


function UpperCase_DKC_MMX_35_b(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @ByteUpper2
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper2 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

procedure Filler3;
asm
 nop
end;

function UpperCase_DKC_MMX_35_c(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @ByteUpper2
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper2 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

function UpperCase_DKC_MMX_35_d(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @ByteUpper2
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper2 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/7 2006
//Instructionset(s): IA32, MMX

function UpperCase_DKC_MMX_36_a(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @ByteUpper2
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper2 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/7 2006
//Instructionset(s): IA32, MMX

function UpperCase_DKC_MMX_36_b(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @ByteUpper2
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper2 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/7 2006
//Instructionset(s): IA32, MMX

function UpperCase_DKC_MMX_36_c(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @ByteUpper2
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper2 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/7 2006
//Instructionset(s): IA32, MMX

function UpperCase_DKC_MMX_36_d(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 //SetLength(Result, Max);
 call      System.@LStrSetLength
 //PResult := Pointer(Result);
 mov       edi,[edi]
 //CharNo := 0;
 xor       eax,eax
 cmp       esi,16
 jae       @BigBegin
 cmp       esi,3
 jbe       @ByteUpper
 sub       esi,3
 push      ebp
@RepeatBegin :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
 pop       edi
 pop       esi
 pop       ebx
 ret
@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
 //UpperCase first 8 chars
 movq      mm0,[ebx]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi],mm0
 //Align   Source
 mov       ecx,ebx
 and       ecx,7
 add       eax,ecx
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 //until(CharNo >= Max);
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @ByteUpper2
 sub       esi,3
 push      ebp
@RepeatBegin2 :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @RepeatBegin2
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@ByteUpper2 :
 mov       ecx,[LookUpTable]
@ByteLoop2 :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop2
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32
//Size 141 bytes

function UpperCase_DKC_IA32_19_a(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 cmp   dl,$61
 jb    @L1
 cmp   dl,$7a
 jnbe  @L1
 sub   dl,$20
@L1 :
 mov   [edi+eax],dl
 add   eax,1
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

procedure Filler4;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32
//Size 141 bytes

function UpperCase_DKC_IA32_19_b(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 cmp   dl,$61
 jb    @L1
 cmp   dl,$7a
 jnbe  @L1
 sub   dl,$20
@L1 :
 mov   [edi+eax],dl
 add   eax,1
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

procedure Filler6;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32
//Size 141 bytes

function UpperCase_DKC_IA32_19_c(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 cmp   dl,$61
 jb    @L1
 cmp   dl,$7a
 jnbe  @L1
 sub   dl,$20
@L1 :
 mov   [edi+eax],dl
 add   eax,1
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

procedure Filler7;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32
//Size 141 bytes

function UpperCase_DKC_IA32_19_d(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 xor   ebp,-1         //char2 = char2 xor -1
 and   ebp,80808080h  //char2 = char2 and 80h
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx, ecx       //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 cmp   dl,$61
 jb    @L1
 cmp   dl,$7a
 jnbe  @L1
 sub   dl,$20
@L1 :
 mov   [edi+eax],dl
 add   eax,1
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32
//Size = 132 bytes

function UpperCase_DKC_IA32_21_a(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 not   ebp            //char2 = not char2
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx,ecx        //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 cmp   dl,$61
 jb    @L1
 cmp   dl,$7a
 jnbe  @L1
 sub   dl,$20
@L1 :
 mov   [edi+eax],dl
 inc   eax
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32
//Size = 132 bytes

function UpperCase_DKC_IA32_21_b(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 not   ebp            //char2 = not char2
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx,ecx        //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 cmp   dl,$61
 jb    @L1
 cmp   dl,$7a
 jnbe  @L1
 sub   dl,$20
@L1 :
 mov   [edi+eax],dl
 inc   eax
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32
//Size = 132 bytes

function UpperCase_DKC_IA32_21_c(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 not   ebp            //char2 = not char2
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx,ecx        //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 cmp   dl,$61
 jb    @L1
 cmp   dl,$7a
 jnbe  @L1
 sub   dl,$20
@L1 :
 mov   [edi+eax],dl
 inc   eax
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32
//Size = 132 bytes

function UpperCase_DKC_IA32_21_d(const S: string): string;
asm
 push  ebx
 push  esi
 push  edi
 push  ebp
 mov   edi,edx
 mov   ebx,eax
 //Max := Length(S);
 call  System.@LStrLen
 //SetLength(Result, Max);
 mov   esi,eax
 mov   eax,edi
 mov   edx,esi
 call  System.@LStrSetLength
 //if Max > 0 then
 test  esi,esi
 jbe   @Exit
 //PResult := Pointer(Result);
 mov   edi,[edi]
 //CharNo := 0;
 xor   eax,eax
 cmp   esi,4
 jb    @RepeatSmallBegin
 sub   esi,3
@RepeatBigBegin :
 mov   edx,[ebx+eax]
 mov   ecx,7f7f7f7fh  //char3 = 7F
 and   ecx,edx        //char3 = char3 and char
 add   ecx,05050505h  //char3 = char3 + 05h
 and   ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add   ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov   ebp,edx        //char2 = char
 not   ebp            //char2 = not char2
 and   ecx,ebp        //char3 = char3 and char2
 shr   ecx,2          //char3 = char3 shr 2
 and   ecx,20202020h  //char3 = char3 and 20h
 sub   edx,ecx        //char = char - char3
 mov   [edi+eax],edx
 add   eax,4
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatBigBegin
 add   esi,3
 cmp   esi,eax
 jbe   @Exit
@RepeatSmallBegin :
 movzx edx,[ebx+eax]
 cmp   dl,$61
 jb    @L1
 cmp   dl,$7a
 jnbe  @L1
 sub   dl,$20
@L1 :
 mov   [edi+eax],dl
 inc   eax
 //until(CharNo >= Max);
 cmp   esi,eax
 jnbe  @RepeatSmallBegin
@Exit :
 pop   ebp
 pop   edi
 pop   esi
 pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32, MMX
//Size 306 byte + 136 + 256 = 698 bytes

function UpperCase_DKC_MMX_48_a(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,15
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32, MMX
//Size 306 byte + 136 + 256 = 698 bytes

function UpperCase_DKC_MMX_48_b(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,15
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32, MMX
//Size 306 byte + 136 + 256 = 698 bytes

function UpperCase_DKC_MMX_48_c(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,15
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32, MMX
//Size 306 byte + 136 + 256 = 698 bytes

function UpperCase_DKC_MMX_48_d(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,15
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32, MMX
//Size 310 byte + 136 + 256 = 702 bytes

function UpperCase_DKC_MMX_49_a(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32, MMX
//Size 310 byte + 136 + 256 = 702 bytes

function UpperCase_DKC_MMX_49_b(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

procedure Filler5;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32, MMX
//Size 310 byte + 136 + 256 = 702 bytes

function UpperCase_DKC_MMX_49_c(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              1/8 2006
//Instructionset(s): IA32, MMX
//Size 310 byte + 136 + 256 = 702 bytes

function UpperCase_DKC_MMX_49_d(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jnbe      @ByteLoop
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 282 + 256 + 136 = 674 byte

function UpperCase_DKC_MMX_54_a(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 282 + 256 + 136 = 674 byte

function UpperCase_DKC_MMX_54_b(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 282 + 256 + 136 = 674 byte

function UpperCase_DKC_MMX_54_c(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 282 + 256 + 136 = 674 byte

function UpperCase_DKC_MMX_54_d(const S: string): string;
const
 Const1 : Integer = $05050505;//Datatypes bigger than 4 byte can be misaligned
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movd      mm2,Const1
 punpckldq mm2,mm2
 movd      mm3,Const2
 punpckldq mm3,mm3
 movd      mm4,Const3
 punpckldq mm4,mm4
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 302 + 256 + 136 = 694 byte

function UpperCase_DKC_MMX_56_a(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

procedure Filler8;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 302 + 256 + 136 = 694 byte

function UpperCase_DKC_MMX_56_b(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

procedure Filler9;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 302 + 256 + 136 = 694 byte

function UpperCase_DKC_MMX_56_c(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

procedure Filler10;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 302 + 256 + 136 = 694 byte

function UpperCase_DKC_MMX_56_d(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 297 + 256 + 37 = 590 byte

function UpperCase_DKC_MMX_59_a(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 //and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 lea       ecx, LookUpTable2
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 297 + 256 + 37 = 590 byte

function UpperCase_DKC_MMX_59_b(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 //and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 lea       ecx, LookUpTable2
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 297 + 256 + 37 = 590 byte

function UpperCase_DKC_MMX_59_c(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 //and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 lea       ecx, LookUpTable2
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 297 + 256 + 37 = 590 byte

function UpperCase_DKC_MMX_59_d(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 xor       ebp,-1         //char2 = char2 xor -1
 //and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 lea       ecx, LookUpTable2
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 292 + 256 + 136 = 684 byte

function UpperCase_DKC_MMX_62_a(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,15
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 292 + 256 + 136 = 684 byte

function UpperCase_DKC_MMX_62_b(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,15
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 292 + 256 + 136 = 684 byte

function UpperCase_DKC_MMX_62_c(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,15
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX
//Size = 292 + 256 + 136 = 684 byte

function UpperCase_DKC_MMX_62_d(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,15
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 movq      mm0,[ebx+eax]
 movq      mm1,mm0
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE
//Size = 267 + 256 + 136 = 659 byte

function UpperCase_DKC_SSE_3_a(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 //and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE
//Size = 267 + 256 + 136 = 659 byte

function UpperCase_DKC_SSE_3_b(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 //and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE
//Size = 267 + 256 + 136 = 659 byte

function UpperCase_DKC_SSE_3_c(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 //and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE
//Size = 267 + 256 + 136 = 659 byte

function UpperCase_DKC_SSE_3_d(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 //and       ebp,80808080h  //char2 = char2 and 80h
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE
//Size = 298 + 256 + 136 = 690 byte

function UpperCase_DKC_SSE_4_a(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE
//Size = 298 + 256 + 136 = 690 byte

function UpperCase_DKC_SSE_4_b(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE
//Size = 298 + 256 + 136 = 690 byte

function UpperCase_DKC_SSE_4_c(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE
//Size = 298 + 256 + 136 = 690 byte

function UpperCase_DKC_SSE_4_d(const S: string): string;
const
 Const1 : Int64 = $0505050505050505;
 Const2 : Int64 = $2020202020202020;
 Const3 : Int64 = $6565656565656565;

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,8
 jb        @MediumBegin
//@BigBegin :
 movq      mm2,Const1
 movq      mm3,Const2
 movq      mm4,Const3
@QWordLoop :
 sub       esi,7
@RepeatBigBegin :
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jbe       @RepeatBigEnd
 movq      mm0,[ebx+eax]
 pshufw    mm1,mm0,$E4
 paddb     mm1,mm2        //char3 = char3 + 05h
 pcmpgtb   mm1,mm4
 pand      mm1,mm3        //char3 = char3 and 7Fh
 psubb     mm0,mm1        //char = char - char3
 movq      [edi+eax],mm0
 add       eax,8
 cmp       esi,eax
 jnbe      @RepeatBigBegin
@RepeatBigEnd :
 emms
 add       esi,7
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE2
//Size = 274 + 256 + 136 = 666 byte

function UpperCase_DKC_SSE2_7_a(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movdqu    xmm2,Const1
 movdqu    xmm3,Const2
 movdqu    xmm4,Const3
 sub       esi,15
@DQWordLoop :
 movdqu    xmm0,[ebx+eax]
 movdqa    xmm1,xmm0
 paddb     xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb   xmm1,xmm4
 pand      xmm1,xmm3        //char3 = char3 and 7Fh
 psubb     xmm0,xmm1        //char = char - char3
 movdqu    [edi+eax],xmm0
 add       eax,16
 cmp       esi,eax
 jnbe      @DQWordLoop
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE2
//Size = 274 + 256 + 136 = 666 byte

function UpperCase_DKC_SSE2_7_b(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movdqu    xmm2,Const1
 movdqu    xmm3,Const2
 movdqu    xmm4,Const3
 sub       esi,15
@DQWordLoop :
 movdqu    xmm0,[ebx+eax]
 movdqa    xmm1,xmm0
 paddb     xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb   xmm1,xmm4
 pand      xmm1,xmm3        //char3 = char3 and 7Fh
 psubb     xmm0,xmm1        //char = char - char3
 movdqu    [edi+eax],xmm0
 add       eax,16
 cmp       esi,eax
 jnbe      @DQWordLoop
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE2
//Size = 274 + 256 + 136 = 666 byte

function UpperCase_DKC_SSE2_7_c(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movdqu    xmm2,Const1
 movdqu    xmm3,Const2
 movdqu    xmm4,Const3
 sub       esi,15
@DQWordLoop :
 movdqu    xmm0,[ebx+eax]
 movdqa    xmm1,xmm0
 paddb     xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb   xmm1,xmm4
 pand      xmm1,xmm3        //char3 = char3 and 7Fh
 psubb     xmm0,xmm1        //char = char - char3
 movdqu    [edi+eax],xmm0
 add       eax,16
 cmp       esi,eax
 jnbe      @DQWordLoop
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE2
//Size = 274 + 256 + 136 = 666 byte

function UpperCase_DKC_SSE2_7_d(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movdqu    xmm2,Const1
 movdqu    xmm3,Const2
 movdqu    xmm4,Const3
 sub       esi,15
@DQWordLoop :
 movdqu    xmm0,[ebx+eax]
 movdqa    xmm1,xmm0
 paddb     xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb   xmm1,xmm4
 pand      xmm1,xmm3        //char3 = char3 and 7Fh
 psubb     xmm0,xmm1        //char = char - char3
 movdqu    [edi+eax],xmm0
 add       eax,16
 cmp       esi,eax
 jnbe      @DQWordLoop
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;


//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE2, SSE3
//Size = 274 + 256 + 136 = 666 byte

function UpperCase_DKC_SSE3_5_a(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movdqu    xmm2,Const1
 movdqu    xmm3,Const2
 movdqu    xmm4,Const3
 sub       esi,15
@DQWordLoop :
 //lddqu     xmm0,[ebx+eax]
 db $F2 db $0F db $F0 db $04 db $18
 movdqa    xmm1,xmm0
 paddb     xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb   xmm1,xmm4
 pand      xmm1,xmm3        //char3 = char3 and 7Fh
 psubb     xmm0,xmm1        //char = char - char3
 movdqu    [edi+eax],xmm0
 add       eax,16
 cmp       esi,eax
 jnbe      @DQWordLoop
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;



//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE2, SSE3
//Size = 274 + 256 + 136 = 666 byte

function UpperCase_DKC_SSE3_5_b(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movdqu    xmm2,Const1
 movdqu    xmm3,Const2
 movdqu    xmm4,Const3
 sub       esi,15
@DQWordLoop :
 //lddqu     xmm0,[ebx+eax]
 db $F2 db $0F db $F0 db $04 db $18
 movdqa    xmm1,xmm0
 paddb     xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb   xmm1,xmm4
 pand      xmm1,xmm3        //char3 = char3 and 7Fh
 psubb     xmm0,xmm1        //char = char - char3
 movdqu    [edi+eax],xmm0
 add       eax,16
 cmp       esi,eax
 jnbe      @DQWordLoop
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;



//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE2, SSE3
//Size = 274 + 256 + 136 = 666 byte

function UpperCase_DKC_SSE3_5_c(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movdqu    xmm2,Const1
 movdqu    xmm3,Const2
 movdqu    xmm4,Const3
 sub       esi,15
@DQWordLoop :
 //lddqu     xmm0,[ebx+eax]
 db $F2 db $0F db $F0 db $04 db $18
 movdqa    xmm1,xmm0
 paddb     xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb   xmm1,xmm4
 pand      xmm1,xmm3        //char3 = char3 and 7Fh
 psubb     xmm0,xmm1        //char = char - char3
 movdqu    [edi+eax],xmm0
 add       eax,16
 cmp       esi,eax
 jnbe      @DQWordLoop
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;



//Author:            Dennis Kjaer Christensen
//Date:              3/8 2006
//Instructionset(s): IA32, MMX, SSE2, SSE3
//Size = 274 + 256 + 136 = 666 byte

function UpperCase_DKC_SSE3_5_d(const S: string): string;
const
 Const1 : array[0..1] of Int64 = ($0505050505050505,$0505050505050505);
 Const2 : array[0..1] of Int64 = ($2020202020202020,$2020202020202020);
 Const3 : array[0..1] of Int64 = ($6565656565656565,$6565656565656565);

asm
 push      ebx
 push      esi
 push      edi
 test      eax,eax
 jz        @NilString
 mov       esi,[eax-$04]
 test      esi,esi
 jbe       @NonNilEmptyString
 mov       ebx,eax
 mov       edi,edx
 mov       eax,edx
 mov       edx,esi
 call      System.@LStrSetLength
 mov       edi,[edi]
 xor       eax,eax
 cmp       esi,4
 jb        @SmallBegin
 cmp       esi,16
 jb        @MediumBegin
//@BigBegin :
 movdqu    xmm2,Const1
 movdqu    xmm3,Const2
 movdqu    xmm4,Const3
 sub       esi,15
@DQWordLoop :
 //lddqu     xmm0,[ebx+eax]
 db $F2 db $0F db $F0 db $04 db $18
 movdqa    xmm1,xmm0
 paddb     xmm1,xmm2        //char3 = char3 + 05h
 pcmpgtb   xmm1,xmm4
 pand      xmm1,xmm3        //char3 = char3 and 7Fh
 psubb     xmm0,xmm1        //char = char - char3
 movdqu    [edi+eax],xmm0
 add       eax,16
 cmp       esi,eax
 jnbe      @DQWordLoop
 add       esi,15
 cmp       esi,eax
 jbe       @Exit
 mov       edx,esi
 sub       edx,eax
 cmp       edx,3
 jbe       @SmallBegin
@MediumBegin :
 sub       esi,3
 push      ebp
@DWORDLoop :
 mov       edx,[ebx+eax]
 mov       ecx,7f7f7f7fh  //char3 = 7F
 and       ecx,edx        //char3 = char3 and char
 add       ecx,05050505h  //char3 = char3 + 05h
 and       ecx,7f7f7f7fh  //char3 = char3 and 7Fh
 add       ecx,1a1a1a1ah  //char3 = char3 + 1Ah
 mov       ebp,edx        //char2 = char
 not       ebp            //char2 = char2 xor -1
 and       ecx,ebp        //char3 = char3 and char2
 shr       ecx,2          //char3 = char3 shr 2
 and       ecx,20202020h  //char3 = char3 and 20h
 sub       edx,ecx        //char = char - char3
 mov       [edi+eax],edx
 add       eax,4
 cmp       esi,eax
 jnbe      @DWORDLoop
 pop       ebp
 add       esi,3
 cmp       esi,eax
 jbe       @Exit
@SmallBegin :
 mov       ecx,[LookUpTable]
@ByteLoop :
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
 add       eax,1
 cmp       esi,eax
 jbe       @ByteLoopEnd
 movzx     edx,[ebx+eax]
 movzx     edx,[ecx+edx]
 mov       [edi+eax],dl
@ByteLoopEnd :
@Exit :
 pop       edi
 pop       esi
 pop       ebx
 ret
@NonNilEmptyString :
@NilString :
 //Return empty string
 mov       eax, edx
 xor       edx, edx
 call      System.@LStrSetLength
 pop       edi
 pop       esi
 pop       ebx
end;



initialization

 InitializeLookUpTable;
 InitializeLookUpTable2;
 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;
 Filler7;
 Filler8;
 Filler9;
 Filler10;


end.
