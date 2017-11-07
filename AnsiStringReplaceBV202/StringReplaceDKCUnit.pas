unit StringReplaceDKCUnit;

interface

uses
 SysUtils;

function StringReplace_DKC_Pas_6(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_IA32_17(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_IA32_19(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_IA32_20(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_MMX_12(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_MMX_13(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_MMX_14(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_SSE_11(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_SSE_12(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_SSE2_21(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function StringReplace_DKC_SSE2_22(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;

implementation

uses
 Windows, StrUtils;

var
 UpperCaseLookUpTable : array of Char;
 LowerCaseLookUpTable : array of Char;

procedure InitializeUpperCaseLookUpTable;
var
 I : Byte;
 S1, S2 : AnsiString;

begin
 SetLength(UpperCaseLookUpTable, 256);
 for I := 0 to 255 do
  begin
   S1 := Char(I);
   S2 := AnsiUpperCase(S1);
   UpperCaseLookUpTable[I] := S2[1];
  end;
end;

procedure InitializeLowerCaseLookUpTable;
var
 I : Byte;
 S1, S2 : AnsiString;

begin
 SetLength(LowerCaseLookUpTable, 256);
 for I := 0 to 255 do
  begin
   S1 := Char(I);
   S2 := AnsiLowerCase(S1);
   LowerCaseLookUpTable[I] := S2[1];
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/10 2004
//Instructionset(s): IA32

procedure MoveForward_DKC_IA32_2( const Source; var Dest; count : Integer );
asm
 push ebx
 push edi
 xor  edi,edi
 cmp  ecx,8
 jb   @ForLoop3Begin
 sub  ecx,7
@ForLoop2Begin :
 mov  ebx,[eax+edi]
 mov  [edx+edi],ebx
 mov  ebx,[eax+edi+4]
 mov  [edx+edi+4],ebx
 add  edi,8
 cmp  edi,ecx
 jb   @ForLoop2Begin
 add  ecx,7
 cmp  edi,ecx
 jae  @ByteMoveEnd1
@ForLoop3Begin :
 mov  bl,[eax+edi]
 mov  [edx+edi],bl
 add  edi,1
 cmp  edi,ecx
 jnz  @ForLoop3Begin
@ByteMoveEnd1 :
 pop  edi
 pop  ebx
@Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/11 2004
//Instructionset(s): IA32

procedure MoveForward_DKC_MMX_1( const Source; var Dest; count : Integer );
asm
 push ebx
 push edi
 xor  edi,edi
 cmp  ecx,8
 jb   @ForLoop3Begin
 sub  ecx,7
@ForLoop2Begin :
 movq mm0,[eax+edi]
 movq [edx+edi],mm0
 add  edi,8
 cmp  edi,ecx
 jb   @ForLoop2Begin
 emms
 add  ecx,7
 cmp  edi,ecx
 jae  @ByteMoveEnd1
@ForLoop3Begin :
 mov  bl,[eax+edi]
 mov  [edx+edi],bl
 add  edi,1
 cmp  edi,ecx
 jnz  @ForLoop3Begin
@ByteMoveEnd1 :
 pop  edi
 pop  ebx
@Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              9/1 2004
//Optimized for:     P4
//Instructionset(s): IA32

function LowerCaseDKC_IA32_1(const S: string): string;
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
 mov   ecx,[LowerCaseLookUpTable]
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
//Date:              8/10 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX

function CharPosDKCMMX1(Chr : Char; const Str : AnsiString) : Integer;
asm
 push      ebx
 push      edi
 //if StrLenght > 0 then
 test      edx, edx
 jz        @Else1Begin
 //StrLenght := Length(Str);
 mov       edi, [edx-$04]
 test      edi, edi
 jz        @Else1Begin
 cmp       edi, 8
 jae       @BigStr
 //SmallStr :
 //I := 0;
 xor       ecx, ecx
 sub       edx,1
 @RepeatBegin :
 //Inc(I);
 add       ecx,1
 //until((Str[I] = Chr) or (I > StrLenght));
 movzx     ebx, byte ptr [edx+ecx]
 cmp       al, bl
 jz        @Exit
 cmp       edi,ecx
 ja        @RepeatBegin
 //Result := 0;
 xor       eax,eax
 pop       edi
 pop       ebx
 ret
@Exit :
 mov       eax, ecx
 pop       edi
 pop       ebx
 ret
@BigStr :
 push      esi
 mov       ah, al
 shl       eax, 8
 mov       al, ah
 shl       eax, 8
 mov       al, ah
 movd      mm0, eax
 movq      mm1, mm0
 psllq     mm1, 32
 por       mm0, mm1
 xor       esi, esi
 //StrLenght := Length(Str);
 shr       edi, 3
 add       edi, edi
 add       edi, edi
 add       edi, edi
@LoopStart :
 movq      mm1, [edx + esi]
 pcmpeqb   mm1, mm0
 packsswb  mm1, mm1
 movd      ebx, mm1
 add       esi, 8
 test      ebx, ebx
 jnz       @Found
 cmp       esi, edi
 jb        @LoopStart
 emms
 jmp       @BigNotFound
@Found :
 //There is a match, but where? Find the leftmost match.
 test      bl, bl
 jnz       @Char1or2Match
 test      bh, bh
 jnz       @Char3or4Match
 shr       ebx, 16
 test      bl, bl
 jnz       @Char5or6Match
 test      bh, bh
 jnz       @Char7or8Match
@Char1or2Match :
 cmp       bl, 255
 je        @Char1Match
 cmp       bl, 127
 jbe       @Char1Match
 jmp       @Char2Match
@Char3or4Match :
 cmp       bl, 255
 je        @Char3Match
 cmp       bh, 255
 je        @Char3Match
 cmp       bh, 127
 jbe       @Char3Match
 jmp       @Char4Match
@Char5or6Match :
 cmp       bl, 255
 je        @Char5Match
 cmp       bl, 127
 jbe       @Char5Match
 jmp       @Char6Match
@Char7or8Match :
 cmp       bl, 255
 je        @Char7Match
 cmp       bh, 255
 je        @Char7Match
 cmp       bh, 127
 jbe       @Char7Match
 jmp       @Char8Match
@Char1Match :
 sub       esi, 8
 mov       eax, esi
 add       eax, 1
 emms
 pop       esi
 pop       edi
 pop       ebx
 ret
@Char2Match :
 sub       esi, 8
 mov       eax, esi
 add       eax, 2
 emms
 pop       esi
 pop       edi
 pop       ebx
 ret
@Char3Match :
 sub       esi, 8
 mov       eax, esi
 add       eax, 3
 emms
 pop       esi
 pop       edi
 pop       ebx
 ret
@Char4Match :
 sub       esi, 8
 mov       eax, esi
 add       eax, 4
 emms
 pop       esi
 pop       edi
 pop       ebx
 ret
@Char5Match :
 sub       esi, 8
 mov       eax, esi
 add       eax, 5
 emms
 pop       esi
 pop       edi
 pop       ebx
 ret
@Char6Match :
 sub       esi, 8
 mov       eax, esi
 add       eax, 6
 emms
 pop       esi
 pop       edi
 pop       ebx
 ret
@Char7Match :
 sub       esi, 8
 mov       eax, esi
 add       eax, 7
 emms
 pop       esi
 pop       edi
 pop       ebx
 ret
@Char8Match :
 sub       esi, 8
 mov       eax, esi
 add       eax, 8
 emms
 pop       esi
 pop       edi
 pop       ebx
 ret
@BigNotFound :
 //Search the rest - if any
 mov       edi, [edx-$04]
 cmp       esi, edi
 je        @Else3Begin//No rest
 sub       edx, 1
@BigRepeatBegin :
 //Inc(I);
 add       esi,1
 //until((Str[I] = Chr) or (I > StrLenght));
 movzx     ebx, byte ptr [edx+esi]
 cmp       al, bl
 jz        @FoundSmallAfterBig
 cmp       edi, esi
 ja        @BigRepeatBegin
 pop       esi
@Else1Begin :
 //Result := 0;
 xor       eax, eax
 pop       edi
 pop       ebx
 ret
@Else3Begin :
 //Result := 0;
 xor       eax, eax
 pop       esi
 pop       edi
 pop       ebx
 ret
@FoundSmallAfterBig :
 mov       eax, esi
 pop       esi
 pop       edi
 pop       ebx
 ret
end;

//Author:            Dennis Kjaer Christensen
//Date:              8/10 2003
//Optimized for:     P3
//Instructionset(s): IA32, MMX, SSE

function CharPosDKCSSE_1(Chr : Char; const Str : AnsiString) : Integer;
asm
 //if StrLenght > 0 then
 test      edx, edx
 jz        @Else3Begin
 push      ebx
 push      edi
 //StrLenght := Length(Str);
 mov       edi, [edx-$04]
 test      edi,edi
 jz        @Else1Begin
 cmp       edi, 8
 jae       @BigStr
 //SmallStr :
 //I := 0;
 xor       ecx, ecx
 dec       edx
 @RepeatBegin :
 //Inc(I);
 inc       ecx
 //until((Str[I] = Chr) or (I > StrLenght));
 movzx     ebx, byte ptr [edx+ecx]
 cmp       al, bl
 jz        @FoundSmall
 cmp       edi,ecx
 ja        @RepeatBegin
 //Result := 0;
 xor       eax,eax
 pop       edi
 pop       ebx
 ret
@FoundSmall :
 mov       eax, ecx
 pop       edi
 pop       ebx
 ret
 nop
@BigStr :
 mov       ah, al
 movd      mm0, eax
 pshufw    mm0, mm0, 0
 mov       ecx, eax
 xor       eax, eax
 //StrLenght := Length(Str);
 shr       edi, 3
 shl       edi, 3
@LoopStart :
 movq      mm1, [edx + eax]
 pcmpeqb   mm1, mm0
 packsswb  mm1, mm1
 movd      ebx, mm1
 add       eax, 8
 test      ebx, ebx
 jnz       @Found
 cmp       eax, edi
 jb        @LoopStart
 emms
 jmp       @BigNotFound
@Found :
 //There is a match, but where?
 test      bl, bl
 jnz       @Char1or2Match
 test      bh, bh
 jnz       @Char3or4Match
 shr       ebx, 16
 test      bl, bl
 jnz       @Char5or6Match
 test      bh, bh
 jnz       @Char7or8Match
@Char1or2Match :
 cmp       bl, 255
 je        @Char1Match
 cmp       bl, 127
 jbe       @Char1Match
 jmp       @Char2Match
@Char3or4Match :
 cmp       bh, 255
 je        @Char3Match
 cmp       bh, 255
 je        @Char4Match
 cmp       bh, 127
 jbe       @Char3Match
 jmp       @Char4Match
@Char5or6Match :
 cmp       bl, 255
 je        @Char5Match
 cmp       bl, 127
 jbe       @Char5Match
 jmp       @Char6Match
@Char7or8Match :
 cmp       bl, 255
 je        @Char7Match
 cmp       bh, 255
 je        @Char7Match
 cmp       bh, 127
 jbe       @Char7Match
 jmp       @Char8Match
@Char1Match :
 sub       eax, 7
 emms
 pop       edi
 pop       ebx
 ret
@Char2Match :
 sub       eax, 6
 emms
 pop       edi
 pop       ebx
 ret
@Char3Match :
 sub       eax, 5
 emms
 pop       edi
 pop       ebx
 ret
@Char4Match :
 sub       eax, 4
 emms
 pop       edi
 pop       ebx
 ret
@Char5Match :
 sub       eax, 3
 emms
 pop       edi
 pop       ebx
 ret
@Char6Match :
 sub       eax, 2
 emms
 pop       edi
 pop       ebx
 ret
@Char7Match :
 sub       eax, 1
 emms
 pop       edi
 pop       ebx
 ret
@Char8Match :
 emms
 pop       edi
 pop       ebx
 ret
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
@BigNotFound :
 //Search the rest - if any
 mov       edi, [edx-$04]
 cmp       eax, edi
 je        @Else1Begin//No rest
 sub       edx, 1
@BigRepeatBegin :
 //Inc(I);
 inc       eax
 //until((Str[I] = Chr) or (I > StrLenght));
 movzx     ebx, byte ptr [edx+eax]
 cmp       cl, bl
 jz        @FoundSmallAfterBig
 cmp       edi, eax
 ja        @BigRepeatBegin
@Else1Begin :
 //Result := 0;
 xor       eax, eax
 pop       edi
 pop       ebx
 ret
@FoundSmallAfterBig :
 pop       edi
 pop       ebx
 ret
@Else3Begin :
 //Result := 0;
 xor       eax, eax
 ret
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/11 2005
//Optimized for:     P3
//Instructionset(s): IA32, MMX, SSE

function CharPosDKCSSE_2(Chr : Char; const Str : AnsiString) : Integer;
asm
 push      ebx
 push      edi
 //StrLenght := Length(Str);
 mov       edi, [edx-$04]
 test      edi,edi
 jz        @Else1Begin
 cmp       edi, 8
 jae       @BigStr
 //SmallStr :
 //I := 0;
 xor       ecx, ecx
 dec       edx
 @RepeatBegin :
 //Inc(I);
 inc       ecx
 //until((Str[I] = Chr) or (I > StrLenght));
 movzx     ebx, byte ptr [edx+ecx]
 cmp       al, bl
 jz        @FoundSmall
 cmp       edi,ecx
 ja        @RepeatBegin
 //Result := 0;
 xor       eax,eax
 pop       edi
 pop       ebx
 ret
@FoundSmall :
 mov       eax, ecx
 pop       edi
 pop       ebx
 ret
 nop
@BigStr :
 mov       ah, al
 movd      mm0, eax
 pshufw    mm0, mm0, 0
 mov       ecx, eax
 xor       eax, eax
 //StrLenght := Length(Str);
 shr       edi, 3
 shl       edi, 3
@LoopStart :
 movq      mm1, [edx + eax]
 pcmpeqb   mm1, mm0
 packsswb  mm1, mm1
 movd      ebx, mm1
 add       eax, 8
 test      ebx, ebx
 jnz       @Found
 cmp       eax, edi
 jb        @LoopStart
 emms
 jmp       @BigNotFound
@Found :
 //There is a match, but where?
 test      bl, bl
 jnz       @Char1or2Match
 test      bh, bh
 jnz       @Char3or4Match
 shr       ebx, 16
 test      bl, bl
 jnz       @Char5or6Match
 test      bh, bh
 jnz       @Char7or8Match
@Char1or2Match :
 cmp       bl, 255
 je        @Char1Match
 cmp       bl, 127
 jbe       @Char1Match
 jmp       @Char2Match
@Char3or4Match :
 cmp       bh, 255
 je        @Char3Match
 cmp       bh, 255
 je        @Char4Match
 cmp       bh, 127
 jbe       @Char3Match
 jmp       @Char4Match
@Char5or6Match :
 cmp       bl, 255
 je        @Char5Match
 cmp       bl, 127
 jbe       @Char5Match
 jmp       @Char6Match
@Char7or8Match :
 cmp       bl, 255
 je        @Char7Match
 cmp       bh, 255
 je        @Char7Match
 cmp       bh, 127
 jbe       @Char7Match
 jmp       @Char8Match
@Char1Match :
 sub       eax, 7
 emms
 pop       edi
 pop       ebx
 ret
@Char2Match :
 sub       eax, 6
 emms
 pop       edi
 pop       ebx
 ret
@Char3Match :
 sub       eax, 5
 emms
 pop       edi
 pop       ebx
 ret
@Char4Match :
 sub       eax, 4
 emms
 pop       edi
 pop       ebx
 ret
@Char5Match :
 sub       eax, 3
 emms
 pop       edi
 pop       ebx
 ret
@Char6Match :
 sub       eax, 2
 emms
 pop       edi
 pop       ebx
 ret
@Char7Match :
 sub       eax, 1
 emms
 pop       edi
 pop       ebx
 ret
@Char8Match :
 emms
 pop       edi
 pop       ebx
 ret
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
 nop
@BigNotFound :
 //Search the rest - if any
 mov       edi, [edx-$04]
 cmp       eax, edi
 je        @Else1Begin//No rest
 sub       edx, 1
@BigRepeatBegin :
 //Inc(I);
 inc       eax
 //until((Str[I] = Chr) or (I > StrLenght));
 movzx     ebx, byte ptr [edx+eax]
 cmp       cl, bl
 jz        @FoundSmallAfterBig
 cmp       edi, eax
 ja        @BigRepeatBegin
@Else1Begin :
 //Result := 0;
 xor       eax, eax
 pop       edi
 pop       ebx
 ret
@FoundSmallAfterBig :
 pop       edi
 pop       ebx
 ret
//@Else3Begin :
 //Result := 0;
 xor       eax, eax
 ret
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/10 2004
//Optimized for:     Opteron
//Instructionset(s): IA32, MMX, SSE

procedure MoveForward_DKC_SSE_1(const Source; var Dest; Count : Integer);
asm
     cmp     ecx, 55
     jnbe    @ForwardCaseElse
     jmp     dword ptr [ecx*4+@Case1JmpTable]
@ForwardCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
@ForwardCaseCount0:
     ret
@ForwardCaseCount2:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     ret
@ForwardCaseCount3:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax+2]
     mov     [edx+2], cl
     ret
@ForwardCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@ForwardCaseCount5:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     ret
@ForwardCaseCount6:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     ret
@ForwardCaseCount7:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+6]
     mov     [edx+6], cl
     ret
@ForwardCaseCount8:
     movq    mm0, [eax]
     movq    [edx], mm0
     emms
     ret
@ForwardCaseCount9:
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     emms
     ret
@ForwardCaseCount10 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     emms
     ret
@ForwardCaseCount11 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+10]
     mov     [edx+10], cl
     emms
     ret
@ForwardCaseCount12:
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     emms
     ret
@ForwardCaseCount13 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     emms
     ret
@ForwardCaseCount14 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     emms
     ret
@ForwardCaseCount15 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+14]
     mov     [edx+14], cl
     emms
     ret
@ForwardCaseCount16 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     emms
     ret
@ForwardCaseCount17 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     emms
     ret
@ForwardCaseCount18 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     emms
     ret
@ForwardCaseCount19 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+18]
     mov     [edx+18], cl
     emms
     ret
@ForwardCaseCount20 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     emms
     ret
@ForwardCaseCount21 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     emms
     ret
@ForwardCaseCount22 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     emms
     ret
@ForwardCaseCount23 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+22]
     mov     [edx+22], cl
     emms
     ret
@ForwardCaseCount24 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     emms
     ret
@ForwardCaseCount25 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     emms
     ret
@ForwardCaseCount26 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     emms
     ret
@ForwardCaseCount27 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+26]
     mov     [edx+26], cl
     emms
     ret
@ForwardCaseCount28 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     emms
     ret
@ForwardCaseCount29 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     emms
     ret
@ForwardCaseCount30 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     emms
     ret
@ForwardCaseCount31 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+30]
     mov     [edx+30], cl
     emms
     ret
@ForwardCaseCount32 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     emms
     ret
@ForwardCaseCount33 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     emms
     ret
@ForwardCaseCount34 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     emms
     ret
@ForwardCaseCount35 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+34]
     mov     [edx+34], cl
     emms
     ret
@ForwardCaseCount36 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     emms
     ret
@ForwardCaseCount37 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     emms
     ret
@ForwardCaseCount38 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     emms
     ret
@ForwardCaseCount39 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+38]
     mov     [edx+38], cl
     emms
     ret
@ForwardCaseCount40 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     emms
     ret
@ForwardCaseCount41 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     emms
     ret
@ForwardCaseCount42 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     emms
     ret
@ForwardCaseCount43 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+42]
     mov     [edx+42], cl
     emms
     ret
@ForwardCaseCount44 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     emms
     ret
@ForwardCaseCount45 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     emms
     ret
@ForwardCaseCount46 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     emms
     ret
@ForwardCaseCount47 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+46]
     mov     [edx+46], cl
     emms
     ret
@ForwardCaseCount48 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     emms
     ret
@ForwardCaseCount49 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     emms
     ret
@ForwardCaseCount50 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     emms
     ret
@ForwardCaseCount51 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     emms
     ret
@ForwardCaseCount52 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     emms
     ret
@ForwardCaseCount53 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     emms
     ret
@ForwardCaseCount54 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     emms
     ret
@ForwardCaseCount55 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl,[eax+54]
     mov     [edx+54],cl
     emms
     ret
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @ForwardCaseElse:
     cmp     ecx, 800
     jnle    @Else9
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     mov     edi, ecx
     shr     edi, 5
     shl     edi, 5
     xor     ebx, ebx
 @L11:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    mm2, [eax+ebx+16]
     movq    mm3, [eax+ebx+24]
     movq    [edx+ebx], mm0
     movq    [edx+ebx+8], mm1
     movq    [edx+ebx+16], mm2
     movq    [edx+ebx+24], mm3
     add     ebx, 32
     cmp     ebx, edi
     jb      @L11
     emms
     add     eax, edi
     add     edx, edi
     sub     ecx, edi  //Remaining moves
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
     nop
     nop
     nop
     nop
     nop
 @Else9:
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     //Align destination
     xor     edi, edi                // ByteNo1 := 0;
 @L111:
     mov     bl, [eax+edi]           // DstB[ByteNo1] := SrcB[ByteNo1];
     mov     [edx+edi], bl
     add     edi, 1                  // Inc(ByteNo1);
     mov     ebx, edx                // edx is destination pointer
     add     ebx, edi
     and     ebx, $0f
     test    ebx, ebx
     jnz     @L111                   // until((SrcAddress2 mod 16) = 0);
     add     eax, edi                // SrcB is aligned now - "SrcI := SrcI + ByteNo1;" Not valid Pascal
     add     edx, edi                // DstB is aligned now - "DstI := DstI + ByteNo1;" Not valid Pascal
     sub     ecx, edi                // Count := Count - ByteNo1;
     mov     esi, ecx
 @L222:
     //SourceAddress2 := Cardinal(@SrcB[0]);
     //if (SourceAddress2 mod 16 = 0) then
     mov     ebx, eax
     and     ebx, $0f
     jnz     @ElseIf1
     //Both source and destination are 16 byte aligned
     cmp     ecx, 240000            // if Count < 1M then
     jnl     @Else2
     shr     ecx,4
     shl     ecx,4
     xor     ebx, ebx
 @L1111:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L1111
     jmp     @Fedtmule
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @Else2:
     shr     ecx, 7                  // NoOfIntLoops  := Count div 16;    16, 32, 48, 64, 80, 96, 112, 128
     shl     ecx, 7                  // NoOfIntMoves := NoOfIntLoops * 4;  4,  8, 12, 16, 20, 24,  28,  32
     xor     ebx, ebx
 @L10:
     movaps  xmm0, [eax+ebx]
     movaps  xmm1, [eax+ebx+16]
     movaps  xmm2, [eax+ebx+32]
     movaps  xmm3, [eax+ebx+48]
     movaps  xmm4, [eax+ebx+64]
     movaps  xmm5, [eax+ebx+80]
     movaps  xmm6, [eax+ebx+96]
     movaps  xmm7, [eax+ebx+112]
     movntps [edx+ebx],     xmm0
     movntps [edx+ebx+16],  xmm1
     movntps [edx+ebx+32],  xmm2
     movntps [edx+ebx+48],  xmm3
     movntps [edx+ebx+64],  xmm4
     movntps [edx+ebx+80],  xmm5
     movntps [edx+ebx+96],  xmm6
     movntps [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @L10
 @L20:
     jmp     @Fedtmule
     nop
     nop
     nop
     nop
     nop
     //else if (SourceAddress2 mod 8 = 0) then
 @ElseIf1:
     //Source is at least 8 byte aligned and destination is at least 16 byte aligned
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @Else1
     //Destination 16 byte aligned, Source unaligned
     shr     ecx, 4               // NoOfIntLoops  := Count div 16;
     shl     ecx, 4               // NoOfIntMoves := NoOfIntLoops * 4;
     xor     ebx, ebx
 @L100:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L100
 @L200:
     jmp     @Fedtmule
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @Else1:
     //Destination 16 byte aligned. Source unaligned
     shr     ecx, 4
     shl     ecx, 4
     xor     ebx, ebx
 @L1000:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L1000
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @Fedtmule:
     // Small moves after big 16 byte destination aligned moves
     add     eax, ecx
     add     edx, ecx
     sub     esi, ecx  //Remaining moves
     mov     ecx, esi
     cmp     ecx, 55
     ja      @L1239
     pop     esi
     pop     edi
     pop     ebx
     emms
     jmp     dword ptr [ecx*4+@Case1JmpTable]
     nop
     nop
     nop
     nop
     nop
 @L1239:
     add     ecx, eax
 @L123:
     mov     bl, [eax]          // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx], bl
     inc     eax
     inc     edx
     cmp     eax, ecx
     jb      @L123                  // until(ByteNo >= EndOfByteMoves);
     pop     esi
     pop     edi
     pop     ebx
     emms
     ret
 @Exit:
     ret
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop

@Case1JmpTable:
 dd @ForwardCaseCount0
 dd @ForwardCaseCount1
 dd @ForwardCaseCount2
 dd @ForwardCaseCount3
 dd @ForwardCaseCount4
 dd @ForwardCaseCount5
 dd @ForwardCaseCount6
 dd @ForwardCaseCount7
 dd @ForwardCaseCount8
 dd @ForwardCaseCount9
 dd @ForwardCaseCount10
 dd @ForwardCaseCount11
 dd @ForwardCaseCount12
 dd @ForwardCaseCount13
 dd @ForwardCaseCount14
 dd @ForwardCaseCount15
 dd @ForwardCaseCount16
 dd @ForwardCaseCount17
 dd @ForwardCaseCount18
 dd @ForwardCaseCount19
 dd @ForwardCaseCount20
 dd @ForwardCaseCount21
 dd @ForwardCaseCount22
 dd @ForwardCaseCount23
 dd @ForwardCaseCount24
 dd @ForwardCaseCount25
 dd @ForwardCaseCount26
 dd @ForwardCaseCount27
 dd @ForwardCaseCount28
 dd @ForwardCaseCount29
 dd @ForwardCaseCount30
 dd @ForwardCaseCount31
 dd @ForwardCaseCount32
 dd @ForwardCaseCount33
 dd @ForwardCaseCount34
 dd @ForwardCaseCount35
 dd @ForwardCaseCount36
 dd @ForwardCaseCount37
 dd @ForwardCaseCount38
 dd @ForwardCaseCount39
 dd @ForwardCaseCount40
 dd @ForwardCaseCount41
 dd @ForwardCaseCount42
 dd @ForwardCaseCount43
 dd @ForwardCaseCount44
 dd @ForwardCaseCount45
 dd @ForwardCaseCount46
 dd @ForwardCaseCount47
 dd @ForwardCaseCount48
 dd @ForwardCaseCount49
 dd @ForwardCaseCount50
 dd @ForwardCaseCount51
 dd @ForwardCaseCount52
 dd @ForwardCaseCount53
 dd @ForwardCaseCount54
 dd @ForwardCaseCount55

end;

//Author:            Dennis Kjaer Christensen
//Date:              31/10 2004
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure MoveForward_DKC_SSE2_3(const Source; var Dest; Count : Integer);
const
 L2CACHESIZE : Cardinal = 475000;
 SPLIT1 : Cardinal = 150;

asm
     cmp     ecx, 55
     jnbe    @ForwardCaseElse
     jmp     dword ptr [ecx*4+@Case1JmpTable]
@ForwardCaseCount0:
     jmp     @Exit
@ForwardCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
     jmp     @Exit
@ForwardCaseCount2:
     mov     cx, [eax]
     mov     [edx], cx
     jmp     @Exit
@ForwardCaseCount3:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax+2]
     mov     [edx+2], cl
     jmp     @Exit
@ForwardCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     jmp     @Exit
@ForwardCaseCount5:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     jmp     @Exit
@ForwardCaseCount6:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     jmp     @Exit
@ForwardCaseCount7:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+6]
     mov     [edx+6], cl
     jmp     @Exit
@ForwardCaseCount8:
     movq    xmm0, [eax]
     movq    [edx], xmm0
     jmp     @Exit
@ForwardCaseCount9:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     cl, [eax+8]
     mov     [edx+8], cl
     jmp     @Exit
@ForwardCaseCount10 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     jmp     @Exit
@ForwardCaseCount11 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+10]
     mov     [edx+10], cl
     jmp     @Exit
@ForwardCaseCount12:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     jmp     @Exit
@ForwardCaseCount13 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     jmp     @Exit
@ForwardCaseCount14 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     jmp     @Exit
@ForwardCaseCount15 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+14]
     mov     [edx+14], cl
     jmp     @Exit
@ForwardCaseCount16 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     jmp     @Exit
@ForwardCaseCount17 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     cl, [eax+16]
     mov     [edx+16], cl
     jmp     @Exit
@ForwardCaseCount18 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     jmp     @Exit
@ForwardCaseCount19 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+18]
     mov     [edx+18], cl
     jmp     @Exit
@ForwardCaseCount20 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     jmp     @Exit
@ForwardCaseCount21 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+12]
     mov     [edx+12], ecx
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     jmp     @Exit
@ForwardCaseCount22 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     jmp     @Exit
@ForwardCaseCount23 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+22]
     mov     [edx+22], cl
     jmp     @Exit
@ForwardCaseCount24 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     jmp     @Exit
@ForwardCaseCount25 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     jmp     @Exit
@ForwardCaseCount26 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     jmp     @Exit
@ForwardCaseCount27 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+26]
     mov     [edx+26], cl
     jmp     @Exit
@ForwardCaseCount28 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     jmp     @Exit
@ForwardCaseCount29 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     jmp     @Exit
@ForwardCaseCount30 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     jmp     @Exit
@ForwardCaseCount31 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+30]
     mov     [edx+30], cl
     jmp     @Exit
@ForwardCaseCount32 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     jmp     @Exit
@ForwardCaseCount33 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     jmp     @Exit
@ForwardCaseCount34 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     jmp     @Exit
@ForwardCaseCount35 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+34]
     mov     [edx+34], cl
     jmp     @Exit
@ForwardCaseCount36 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     jmp     @Exit
@ForwardCaseCount37 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     jmp     @Exit
@ForwardCaseCount38 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     jmp     @Exit
@ForwardCaseCount39 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+38]
     mov     [edx+38], cl
     jmp     @Exit
@ForwardCaseCount40 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     jmp     @Exit
@ForwardCaseCount41 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     jmp     @Exit
@ForwardCaseCount42 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     jmp     @Exit
@ForwardCaseCount43 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+42]
     mov     [edx+42], cl
     jmp     @Exit
@ForwardCaseCount44 :
     movdqu  xmm0, [eax]
     movdqu  [edx], xmm0
     movdqu  xmm2, [eax+16]
     movdqu  [edx+16], xmm2
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     jmp     @Exit
@ForwardCaseCount45 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     jmp     @Exit
@ForwardCaseCount46 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     jmp     @Exit
@ForwardCaseCount47 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+46]
     mov     [edx+46], cl
     jmp     @Exit
@ForwardCaseCount48 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     jmp     @Exit
@ForwardCaseCount49 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     jmp     @Exit
@ForwardCaseCount50 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     jmp     @Exit
@ForwardCaseCount51 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     jmp     @Exit
@ForwardCaseCount52 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     mov     cl, [eax+51]
     mov     [edx+51], cl
     jmp     @Exit
@ForwardCaseCount53 :
     movq    xmm0, [eax]
     movq    [edx], xmm0
     movq    xmm1, [eax+8]
     movq    [edx+8], xmm1
     movq    xmm2, [eax+16]
     movq    [edx+16], xmm2
     movq    xmm3, [eax+24]
     movq    [edx+24], xmm3
     movq    xmm4, [eax+32]
     movq    [edx+32], xmm4
     movq    xmm5, [eax+40]
     movq    [edx+40], xmm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     jmp     @Exit
@ForwardCaseCount54 :
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     ecx, [eax+$04]
     mov     [edx+$04], ecx
     mov     ecx, [eax+$08]
     mov     [edx+$08], ecx
     mov     ecx, [eax+$0c]
     mov     [edx+$0c], ecx
     mov     ecx, [eax+$10]
     mov     [edx+$10], ecx
     mov     ecx, [eax+$14]
     mov     [edx+$14], ecx
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     ecx, [eax+28]
     mov     [edx+28], ecx
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     ecx, [eax+36]
     mov     [edx+36], ecx
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     ecx, [eax+44]
     mov     [edx+44], ecx
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     jmp     @Exit
@ForwardCaseCount55 :
     movdqu  xmm0, [eax]
     movdqu  [edx], xmm0
     movdqu  xmm1, [eax+16]
     movdqu  [edx+16], xmm1
     movdqu  xmm3, [eax+32]
     movdqu  [edx+32], xmm3
     mov     ecx,[eax+48]
     mov     [edx+48],ecx
     mov     cl,[eax+52]
     mov     [edx+52],cl
     mov     cl,[eax+53]
     mov     [edx+53],cl
     mov     cl,[eax+54]
     mov     [edx+54],cl
     jmp     @Exit
 @ForwardCaseElse:
     cmp     ecx, SPLIT1
     ja      @Else9
     push    ebx                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     sub     ecx, 7
     xor     esi,esi
 @L11:
     mov     ebx, [eax+esi]
     mov     [edx+esi], ebx
     mov     ebx, [eax+esi+4]
     mov     [edx+esi+4], ebx
     add     esi, 8
     cmp     esi, ecx
     jb      @L11
     add     ecx, 7
     sub     esi, 1
 @L3:
     mov     bl, [eax+esi]
     mov     [edx+esi], bl
     add     esi, 1
     cmp     esi, ecx
     jb      @L3
     pop     esi
     pop     ebx
     jmp     @Exit1
 @Else9:
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     //Align destination
     mov     ebx, edx
     and     ebx, $0f
     mov     esi, 16
     sub     esi, ebx
     test    esi, esi
     jz      @L222
     xor     edi, edi
 @L111:
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jae     @ByteMoveExit
     mov     bl, [eax+edi]
     mov     [edx+edi], bl
     add     edi, 1
     cmp     edi, esi
     jb      @L111
 @ByteMoveExit :
     add     eax, edi                // SrcB is aligned now - "SrcI := SrcI + ByteNo1;" Not valid Pascal
     add     edx, edi                // DstB is aligned now - "DstI := DstI + ByteNo1;" Not valid Pascal
     sub     ecx, edi                // Count := Count - ByteNo1;
 @L222:
     //SourceAddress2 := Cardinal(@SrcB[0]);
     //if (SourceAddress2 mod 16 = 0) then //Both source and destination are 16 byte aligned
     mov     ebx, eax
     and     ebx, $0f
     jnz     @ElseIf1
     cmp     ecx, L2CACHESIZE
     jnl     @Else2
     sub     ecx, 47
     xor     ebx, ebx
 @L1111:
     movaps  xmm0, [eax+ebx]
     movaps  [edx+ebx], xmm0
     movaps  xmm1, [eax+ebx+16]
     movaps  [edx+ebx+16], xmm1
     movaps  xmm2, [eax+ebx+32]
     movaps  [edx+ebx+32], xmm2
     add     ebx, 48
     cmp     ebx, ecx
     jb      @L1111
     add     ecx, 47
     // Small moves after big 16 byte aligned moves
     sub     ebx,1
     mov     edi, ecx
@L123:
     mov     cl, [eax+ebx]           // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @L123                   // until(ByteNo >= EndOfByteMoves);
 @L234:
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit1
 @Else2:
     sub     ecx,127
     xor     ebx, ebx
 @L10:
     movdqa  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqa  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqa  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqa  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqa  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqa  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqa  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqa  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128                 //  4, 8, 12, 16, 20, 24, 28, 32
     cmp     ebx, ecx
     jb      @L10
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @ByteMove1:
     mov     cl, [eax+ebx]           // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove1                   // until(ByteNo >= EndOfByteMoves);
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit1
     //else if (SourceAddress2 mod 8 = 0) then //Both source and destination are at least 8 byte aligned
 @ElseIf1:
     cmp     ecx, L2CACHESIZE
     ja      @ElseDennis
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @Else1
     xor     ebx, ebx
     sub     ecx, 31
 @L100:
     movq    xmm0, [eax+ebx]
     movq    [edx+ebx], xmm0
     movq    xmm1, [eax+ebx+8]
     movq    [edx+ebx+8], xmm1
     movq    xmm2, [eax+ebx+16]
     movq    [edx+ebx+16], xmm2
     movq    xmm3, [eax+ebx+24]
     movq    [edx+ebx+24], xmm3
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L100
     add     ecx, 31
 @L200:
     add     eax, ebx
     add     edx, ebx
     sub     ecx, ebx
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
 @Else1:
     sub     ecx, 31
     xor     ebx, ebx
 @L1000:
     movdqu  xmm0, [eax+ebx]
     movdqa  [edx+ebx], xmm0
     movdqu  xmm1, [eax+ebx+16]
     movdqa  [edx+ebx+16], xmm1
     add     ebx, 32
     cmp     ebx, ecx
     jb      @L1000
     add     ecx, 31
     sub     ebx, 1
     mov     edi, ecx
 @ByteMove2:
     mov     cl, [eax+ebx]
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove2
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit1
 @ElseDennis:
     sub     ecx,127
     xor     ebx, ebx
 @Yps3:
     movdqu  xmm0, [eax+ebx]
     movntdq [edx+ebx], xmm0
     movdqu  xmm1, [eax+ebx+16]
     movntdq [edx+ebx+16], xmm1
     movdqu  xmm2, [eax+ebx+32]
     movntdq [edx+ebx+32], xmm2
     movdqu  xmm3, [eax+ebx+48]
     movntdq [edx+ebx+48], xmm3
     movdqu  xmm4, [eax+ebx+64]
     movntdq [edx+ebx+64], xmm4
     movdqu  xmm5, [eax+ebx+80]
     movntdq [edx+ebx+80], xmm5
     movdqu  xmm6, [eax+ebx+96]
     movntdq [edx+ebx+96], xmm6
     movdqu  xmm7, [eax+ebx+112]
     movntdq [edx+ebx+112], xmm7
     add     ebx, 128                 //  4, 8, 12, 16, 20, 24, 28, 32
     cmp     ebx, ecx
     jb      @Yps3
     add     ecx, 127
     sfence
     mov     edi, ecx
     sub     ebx, 1
 @ByteMove7:
     mov     cl, [eax+ebx]           // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx+ebx], cl
     add     ebx, 1
     cmp     ebx, edi
     jb      @ByteMove7                   // until(ByteNo >= EndOfByteMoves);
     pop     esi
     pop     edi
     pop     ebx
     jmp     @Exit1
 @ForwardCaseEnd:
 @Exit1:
 @Exit:
     ret

@Case1JmpTable:
 dd @ForwardCaseCount0
 dd @ForwardCaseCount1
 dd @ForwardCaseCount2
 dd @ForwardCaseCount3
 dd @ForwardCaseCount4
 dd @ForwardCaseCount5
 dd @ForwardCaseCount6
 dd @ForwardCaseCount7
 dd @ForwardCaseCount8
 dd @ForwardCaseCount9
 dd @ForwardCaseCount10
 dd @ForwardCaseCount11
 dd @ForwardCaseCount12
 dd @ForwardCaseCount13
 dd @ForwardCaseCount14
 dd @ForwardCaseCount15
 dd @ForwardCaseCount16
 dd @ForwardCaseCount17
 dd @ForwardCaseCount18
 dd @ForwardCaseCount19
 dd @ForwardCaseCount20
 dd @ForwardCaseCount21
 dd @ForwardCaseCount22
 dd @ForwardCaseCount23
 dd @ForwardCaseCount24
 dd @ForwardCaseCount25
 dd @ForwardCaseCount26
 dd @ForwardCaseCount27
 dd @ForwardCaseCount28
 dd @ForwardCaseCount29
 dd @ForwardCaseCount30
 dd @ForwardCaseCount31
 dd @ForwardCaseCount32
 dd @ForwardCaseCount33
 dd @ForwardCaseCount34
 dd @ForwardCaseCount35
 dd @ForwardCaseCount36
 dd @ForwardCaseCount37
 dd @ForwardCaseCount38
 dd @ForwardCaseCount39
 dd @ForwardCaseCount40
 dd @ForwardCaseCount41
 dd @ForwardCaseCount42
 dd @ForwardCaseCount43
 dd @ForwardCaseCount44
 dd @ForwardCaseCount45
 dd @ForwardCaseCount46
 dd @ForwardCaseCount47
 dd @ForwardCaseCount48
 dd @ForwardCaseCount49
 dd @ForwardCaseCount50
 dd @ForwardCaseCount51
 dd @ForwardCaseCount52
 dd @ForwardCaseCount53
 dd @ForwardCaseCount54
 dd @ForwardCaseCount55

end;

//Author:            Dennis Kjaer Christensen
//Date:              1/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function UpperCaseDKCPas32(const S: string): string;
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
    pResult[CharNo] := UpperCaseLookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := UpperCaseLookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := UpperCaseLookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := UpperCaseLookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
   until(CharNo >= Max);
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              7/10 2003
//Instructionset(s): IA32

function UpperCaseDKC_IA32_18(const S: string): string;
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
 mov   ecx,[UpperCaseLookUpTable]
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
//Date:              5/11 2004
//Instructionset(s): IA32

function Pos_DKC_Pas_1(const SubString : AnsiString; const Str : AnsiString ) : Integer;
var
 SubStrLength, StrLength, StringIndex, SubStringIndex, SkipValue, NewStrIndex,
 Skip, StopSearch, I1, I, I2, I3 : Integer;
 SkipValues : array[0..255] of Integer;
 LastChar : Char;
 Match : Boolean;
label
 OuterLoop, InnerLoop;

begin
 StrLength := PCardinal(Cardinal(Str)-4)^;
 SubStrLength := PCardinal(Cardinal(SubString)-4)^;
 if (SubStrLength > StrLength) then
  begin
   Result := 0;
   Exit;
  end;
 if SubStrLength = 1 then
  begin
   I2 := 0;
   repeat
    Inc(I2);
    if Str[I2] = SubString[1] then
     begin
      Result := I2;
      Exit;
     end;
   until(I2 = StrLength);
   Result := 0;
   Exit;
  end;
 if StrLength < 250 then
  begin
   I2 := 0;
   StopSearch := StrLength-SubStrLength+1;
   repeat
    Inc(I2);
    if Str[I2] = SubString[1] then
     begin
      goto InnerLoop;
     end;
    OuterLoop:
   until(I2 = StopSearch);
   Result := 0;
   Exit;
   InnerLoop:
   I3 := 1;
   repeat
    Inc(I3);
    if Str[I2+I3-1] <> SubString[I3] then
     begin
      goto OuterLoop;
     end;
   until(I3 = SubStrLength);
   Result := I2;
   Exit
  end;
 I1 := 0;
 repeat
  SkipValues[I1]   := SubStrLength;
  SkipValues[I1+1] := SubStrLength;
  SkipValues[I1+2] := SubStrLength;
  SkipValues[I1+3] := SubStrLength;
  SkipValues[I1+4] := SubStrLength;
  SkipValues[I1+5] := SubStrLength;
  SkipValues[I1+6] := SubStrLength;
  SkipValues[I1+7] := SubStrLength;
  Inc(I1,8);
 until(I1 >= 255);
 Skip := SubStrLength - 1;
 for I := 1 to SubStrLength-1 do
  begin
   SkipValues[Integer(SubString[I])] := Skip;
   Dec(Skip);
  end;
 LastChar := SubString[SubStrLength];
 StringIndex := SubStrLength;
 while StringIndex <= StrLength do
  begin
   if LastChar <> Str[StringIndex] then
    begin
     SkipValue := SkipValues[Integer(Str[StringIndex])];
     Inc(StringIndex, SkipValue);
    end
   else
    begin
     Match := True;
     Result := StringIndex;
     for SubStringIndex := SubStrLength-1 downto 1 do
      begin
       Dec(Result);
       if SubString[SubStringIndex] <> Str[Result] then
        begin
         NewStrIndex := Result + SkipValues[Cardinal(Str[Result])];
         SkipValue := SkipValues[Integer(Str[StringIndex])];
         Inc(StringIndex, SkipValue);
         if StringIndex < NewStrIndex then
          StringIndex := NewStrIndex;
         Match := False;
         Break;
        end;
      end;
     if Match then
      Exit;
    end;
  end;
 Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/10 2004
//Instructionset(s): IA32, MMX, SSE

function Pos_DKC_SSE_5(const SubString : AnsiString; const Str : AnsiString ) : Integer;
var
 SubStrLength, StrLength, StringIndex, SubStringIndex, SkipValue, NewStrIndex,
 Skip, StopSearch, I1, I, I2, I3 : Integer;
 SkipValues : array[0..255] of Integer;
 LastChar : Char;
 Match : Boolean;
label
 OuterLoop, InnerLoop;

begin
 StrLength := PCardinal(Cardinal(Str)-4)^;
 SubStrLength := PCardinal(Cardinal(SubString)-4)^;
 if (SubStrLength > StrLength) then
  begin
   Result := 0;
   Exit;
  end;
 if SubStrLength = 1 then
  begin
   Result := CharPosDKCSSE_1(SubString[1], Str);
   Exit;
  end;
 if (StrLength < 250) or (SubStrLength < 3) then
  begin
   I2 := 0;
   StopSearch := StrLength-SubStrLength+1;
   repeat
    Inc(I2);
    if Str[I2] = SubString[1] then
     begin
      goto InnerLoop;
     end;
    OuterLoop:
   until(I2 = StopSearch);
   Result := 0;
   Exit;
   InnerLoop:
   I3 := 1;
   repeat
    Inc(I3);
    if Str[I2+I3-1] <> SubString[I3] then
     begin
      goto OuterLoop;
     end;
   until(I3 = SubStrLength);
   Result := I2;
   Exit
  end;
 I1 := 0;
 repeat
  SkipValues[I1]   := SubStrLength;
  SkipValues[I1+1] := SubStrLength;
  SkipValues[I1+2] := SubStrLength;
  SkipValues[I1+3] := SubStrLength;
  SkipValues[I1+4] := SubStrLength;
  SkipValues[I1+5] := SubStrLength;
  SkipValues[I1+6] := SubStrLength;
  SkipValues[I1+7] := SubStrLength;
  Inc(I1,8);
 until(I1 >= 255);
 Skip := SubStrLength - 1;
 for I := 1 to SubStrLength-1 do
  begin
   SkipValues[Integer(SubString[I])] := Skip;
   Dec(Skip);
  end;
 LastChar := SubString[SubStrLength];
 StringIndex := SubStrLength;
 while StringIndex <= StrLength do
  begin
   if LastChar <> Str[StringIndex] then
    begin
     SkipValue := SkipValues[Integer(Str[StringIndex])];
     Inc(StringIndex, SkipValue);
    end
   else
    begin
     Match := True;
     Result := StringIndex;
     for SubStringIndex := SubStrLength-1 downto 1 do
      begin
       Dec(Result);
       if SubString[SubStringIndex] <> Str[Result] then
        begin
         NewStrIndex := Result + SkipValues[Cardinal(Str[Result])];
         SkipValue := SkipValues[Integer(Str[StringIndex])];
         Inc(StringIndex, SkipValue);
         if StringIndex < NewStrIndex then
          StringIndex := NewStrIndex;
         Match := False;
         Break;
        end;
      end;
     if Match then
      Exit;
    end;
  end;
 Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/11 2004
//Instructionset(s): IA32, MMX, SSE

function Pos_DKC_SSE_6(const SubString : AnsiString; const Str : AnsiString ) : Integer;
var
 SubStrLength, StrLength, StringIndex, SubStringIndex, SkipValue, NewStrIndex,
 Skip, StopSearch, I1, I, I2, I3 : Integer;
 SkipValues : array[0..255] of Integer;
 LastChar : Char;
 Match : Boolean;
label
 OuterLoop, InnerLoop;

begin
 StrLength := PCardinal(Cardinal(Str)-4)^;
 SubStrLength := PCardinal(Cardinal(SubString)-4)^;
 if (SubStrLength > StrLength) then
  begin
   Result := 0;
   Exit;
  end;
 if SubStrLength = 1 then
  begin
   Result := CharPosDKCSSE_1(SubString[1], Str);
   Exit;
  end;
 if (StrLength < 250) or (SubStrLength < 3) then
  begin
   I2 := 0;
   StopSearch := StrLength-SubStrLength+1;
   repeat
    Inc(I2);
    if Str[I2] = SubString[1] then
     begin
      goto InnerLoop;
     end;
    OuterLoop:
   until(I2 = StopSearch);
   Result := 0;
   Exit;
   InnerLoop:
   I3 := 1;
   repeat
    Inc(I3);
    if Str[I2+I3-1] <> SubString[I3] then
     begin
      goto OuterLoop;
     end;
   until(I3 = SubStrLength);
   Result := I2;
   Exit
  end;
 I1 := 0;
 repeat
  SkipValues[I1]   := SubStrLength;
  SkipValues[I1+1] := SubStrLength;
  SkipValues[I1+2] := SubStrLength;
  SkipValues[I1+3] := SubStrLength;
  SkipValues[I1+4] := SubStrLength;
  SkipValues[I1+5] := SubStrLength;
  SkipValues[I1+6] := SubStrLength;
  SkipValues[I1+7] := SubStrLength;
  Inc(I1,8);
 until(I1 >= 255);
 Skip := SubStrLength - 1;
 for I := 1 to SubStrLength-1 do
  begin
   SkipValues[Integer(SubString[I])] := Skip;
   Dec(Skip);
  end;
 LastChar := SubString[SubStrLength];
 StringIndex := SubStrLength;
 while StringIndex <= StrLength do
  begin
   if LastChar <> Str[StringIndex] then
    begin
     SkipValue := SkipValues[Integer(Str[StringIndex])];
     Inc(StringIndex, SkipValue);
    end
   else
    begin
     Match := True;
     Result := StringIndex;
     for SubStringIndex := SubStrLength-1 downto 1 do
      begin
       Dec(Result);
       if SubString[SubStringIndex] <> Str[Result] then
        begin
         NewStrIndex := Result + SkipValues[Cardinal(Str[Result])];
         SkipValue := SkipValues[Integer(Str[StringIndex])];
         Inc(StringIndex, SkipValue);
         if StringIndex < NewStrIndex then
          StringIndex := NewStrIndex;
         Match := False;
         Break;
        end;
      end;
     if Match then
      Exit;
    end;
  end;
 Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/11 2004
//Instructionset(s): IA32, MMX, SSE

function Pos_DKC_SSE_7(const SubString : AnsiString; const Str : AnsiString ) : Integer;
var
 SubStrLength, StrLength, StringIndex, SubStringIndex, SkipValue, NewStrIndex,
 Skip, StopSearch, I1, I, I2, I3 : Integer;
 SkipValues : array[0..255] of Integer;
 LastChar : Char;
 Match : Boolean;
label
 OuterLoop, InnerLoop;

begin
 StrLength := PCardinal(Cardinal(Str)-4)^;
 SubStrLength := PCardinal(Cardinal(SubString)-4)^;
 if (SubStrLength > StrLength) then
  begin
   Result := 0;
   Exit;
  end;
 if SubStrLength = 1 then
  begin
   Result := CharPosDKCSSE_2(SubString[1], Str);
   Exit;
  end;
 if (StrLength < 250) or (SubStrLength < 3) then
  begin
   I2 := 0;
   StopSearch := StrLength-SubStrLength+1;
   repeat
    Inc(I2);
    if Str[I2] = SubString[1] then
     begin
      goto InnerLoop;
     end;
    OuterLoop:
   until(I2 = StopSearch);
   Result := 0;
   Exit;
   InnerLoop:
   I3 := 1;
   repeat
    Inc(I3);
    if Str[I2+I3-1] <> SubString[I3] then
     begin
      goto OuterLoop;
     end;
   until(I3 = SubStrLength);
   Result := I2;
   Exit
  end;
 I1 := 0;
 repeat
  SkipValues[I1]   := SubStrLength;
  SkipValues[I1+1] := SubStrLength;
  SkipValues[I1+2] := SubStrLength;
  SkipValues[I1+3] := SubStrLength;
  SkipValues[I1+4] := SubStrLength;
  SkipValues[I1+5] := SubStrLength;
  SkipValues[I1+6] := SubStrLength;
  SkipValues[I1+7] := SubStrLength;
  Inc(I1,8);
 until(I1 >= 255);
 Skip := SubStrLength - 1;
 for I := 1 to SubStrLength-1 do
  begin
   SkipValues[Integer(SubString[I])] := Skip;
   Dec(Skip);
  end;
 LastChar := SubString[SubStrLength];
 StringIndex := SubStrLength;
 while StringIndex <= StrLength do
  begin
   if LastChar <> Str[StringIndex] then
    begin
     SkipValue := SkipValues[Integer(Str[StringIndex])];
     Inc(StringIndex, SkipValue);
    end
   else
    begin
     Match := True;
     Result := StringIndex;
     for SubStringIndex := SubStrLength-1 downto 1 do
      begin
       Dec(Result);
       if SubString[SubStringIndex] <> Str[Result] then
        begin
         NewStrIndex := Result + SkipValues[Cardinal(Str[Result])];
         SkipValue := SkipValues[Integer(Str[StringIndex])];
         Inc(StringIndex, SkipValue);
         if StringIndex < NewStrIndex then
          StringIndex := NewStrIndex;
         Match := False;
         Break;
        end;
      end;
     if Match then
      Exit;
    end;
  end;
 Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/10 2004
//Instructionset(s): IA32, MMX

function Pos_DKC_MMX_1(const SubString : AnsiString; const Str : AnsiString ) : Integer;
var
 SubStrLength, StrLength, StringIndex, SubStringIndex, SkipValue, NewStrIndex,
 Skip, StopSearch, I1, I, I2, I3 : Integer;
 SkipValues : array[0..255] of Integer;
 LastChar : Char;
 Match : Boolean;
label
 OuterLoop, InnerLoop;

begin
 StrLength := Length(Str);
 SubStrLength := Length(SubString);
 if ((SubStrLength = 0) or (StrLength = 0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (SubStrLength > StrLength) then
  begin
   Result := 0;
   Exit;
  end;
 if SubStrLength = 1 then
  begin
   Result := CharPosDKCMMX1(SubString[1], Str);
   Exit;
  end;
 if StrLength < 250 then
  begin
   I2 := 0;
   StopSearch := StrLength-SubStrLength+1;
   repeat
    Inc(I2);
    if Str[I2] = SubString[1] then
     begin
      goto InnerLoop;
     end;
    OuterLoop:
   until(I2 = StopSearch);
   Result := 0;
   Exit;
   InnerLoop:
   I3 := 1;
   repeat
    Inc(I3);
    if Str[I2+I3-1] <> SubString[I3] then
     begin
      goto OuterLoop;
     end;
   until(I3 = SubStrLength);
   Result := I2;
   Exit
  end;
 I1 := 0;
 repeat
  SkipValues[I1]   := SubStrLength;
  SkipValues[I1+1] := SubStrLength;
  SkipValues[I1+2] := SubStrLength;
  SkipValues[I1+3] := SubStrLength;
  SkipValues[I1+4] := SubStrLength;
  SkipValues[I1+5] := SubStrLength;
  SkipValues[I1+6] := SubStrLength;
  SkipValues[I1+7] := SubStrLength;
  Inc(I1,8);
 until(I1 >= 255);
 Skip := SubStrLength - 1;
 for I := 1 to SubStrLength-1 do
  begin
   SkipValues[Integer(SubString[I])] := Skip;
   Dec(Skip);
  end;
 LastChar := SubString[SubStrLength];
 StringIndex := SubStrLength;
 while StringIndex <= StrLength do
  begin
   SkipValue := SkipValues[Integer(Str[StringIndex])];
   if LastChar <> Str[StringIndex] then
    begin
     Inc(StringIndex, SkipValue);
    end
   else
    begin
     Match := True;
     Result := StringIndex;
     for SubStringIndex := SubStrLength-1 downto 1 do
      begin
       Dec(Result);
       if SubString[SubStringIndex] <> Str[Result] then
        begin
         NewStrIndex := Result + SkipValues[Cardinal(Str[Result])];
         Inc(StringIndex, SkipValue);
         if StringIndex < NewStrIndex then
          StringIndex := NewStrIndex;
         Match := False;
         Break;
        end;
      end;
     if Match then
      Exit;
    end;
  end;
 Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/11 2004
//Instructionset(s): IA32, MMX

function Pos_DKC_MMX_2(const SubString : AnsiString; const Str : AnsiString ) : Integer;
var
 SubStrLength, StrLength, StringIndex, SubStringIndex, SkipValue, NewStrIndex,
 Skip, StopSearch, I1, I, I2, I3 : Integer;
 SkipValues : array[0..255] of Integer;
 LastChar : Char;
 Match : Boolean;
label
 OuterLoop, InnerLoop;

begin
 StrLength := PCardinal(Cardinal(Str)-4)^;
 SubStrLength := PCardinal(Cardinal(SubString)-4)^;
 if (SubStrLength > StrLength) then
  begin
   Result := 0;
   Exit;
  end;
 if SubStrLength = 1 then
  begin
   Result := CharPosDKCMMX1(SubString[1], Str);
   Exit;
  end;
 if (StrLength < 250) or (SubStrLength < 2) then
  begin
   I2 := 0;
   StopSearch := StrLength-SubStrLength+1;
   repeat
    Inc(I2);
    if Str[I2] = SubString[1] then
     begin
      goto InnerLoop;
     end;
    OuterLoop:
   until(I2 = StopSearch);
   Result := 0;
   Exit;
   InnerLoop:
   I3 := 1;
   repeat
    Inc(I3);
    if Str[I2+I3-1] <> SubString[I3] then
     begin
      goto OuterLoop;
     end;
   until(I3 = SubStrLength);
   Result := I2;
   Exit
  end;
 I1 := 0;
 repeat
  SkipValues[I1]   := SubStrLength;
  SkipValues[I1+1] := SubStrLength;
  SkipValues[I1+2] := SubStrLength;
  SkipValues[I1+3] := SubStrLength;
  SkipValues[I1+4] := SubStrLength;
  SkipValues[I1+5] := SubStrLength;
  SkipValues[I1+6] := SubStrLength;
  SkipValues[I1+7] := SubStrLength;
  Inc(I1,8);
 until(I1 >= 255);
 Skip := SubStrLength - 1;
 for I := 1 to SubStrLength-1 do
  begin
   SkipValues[Integer(SubString[I])] := Skip;
   Dec(Skip);
  end;
 LastChar := SubString[SubStrLength];
 StringIndex := SubStrLength;
 while StringIndex <= StrLength do
  begin
   if LastChar <> Str[StringIndex] then
    begin
     SkipValue := SkipValues[Integer(Str[StringIndex])];
     Inc(StringIndex, SkipValue);
    end
   else
    begin
     Match := True;
     Result := StringIndex;
     for SubStringIndex := SubStrLength-1 downto 1 do
      begin
       Dec(Result);
       if SubString[SubStringIndex] <> Str[Result] then
        begin
         NewStrIndex := Result + SkipValues[Cardinal(Str[Result])];
         SkipValue := SkipValues[Integer(Str[StringIndex])];
         Inc(StringIndex, SkipValue);
         if StringIndex < NewStrIndex then
          StringIndex := NewStrIndex;
         Match := False;
         Break;
        end;
      end;
     if Match then
      Exit;
    end;
  end;
 Result := 0;
end;

type
 TPosEZResults = array of Integer;

//Author:            Dennis Kjaer Christensen
//Date:              1/11 2004
//Instructionset(s): IA32

function PosEZ_DKC_Pas_9(const SubString : AnsiString; const Str : AnsiString) : TPosEZResults;
var
 C, LastChar : Char;
 SubStrLength, StrLength, StringIndex, SubStringIndex, SkipValue, NewStrIndex,
 Skip, StopSearch, I1, I, I3, NoOfMatches, ResultLength : Integer;
 SkipValues : array[0..255] of Integer;
 Match : Boolean;
 MatchPos : Integer;
label
 OuterLoop, InnerLoop, ContinueSearch;
const
 RESULTGROWSTEPSIZE : Integer = 10;

begin
 StrLength := PCardinal(Cardinal(Str)-4)^;
 SubStrLength := PCardinal(Cardinal(SubString)-4)^;
 NoOfMatches := 0;
 ResultLength := 0;
 if SubStrLength = 1 then
  begin
   MatchPos := 0;
   repeat
    Inc(MatchPos);
    if Str[MatchPos] = SubString[1] then
     begin
      Inc(NoOfMatches);
      MatchPos := MatchPos;
      if ResultLength < NoOfMatches then
       begin
        ResultLength := ResultLength + RESULTGROWSTEPSIZE;
        SetLength(Result, ResultLength);
       end;
      Result[NoOfMatches-1] := MatchPos;
     end;
   until(MatchPos = StrLength);
   //Sqeeze Result to correct size
   SetLength(Result, NoOfMatches);
   Exit;
  end;
 if (StrLength < 250) or (SubStrLength < 3) then
  begin
   MatchPos := 0;
   {
   xor ebx,ebx
   }
   StopSearch := StrLength-SubStrLength+1;
   {
   mov eax,[esp+$0c]
   sub eax,esi
   inc eax
   mov [esp+$14],eax
   }
   repeat
    {
   @LoopStart :
    }
    Inc(MatchPos);
    {
    inc ebx
    }
    if Str[MatchPos] = SubString[1] then
    {
    mov al,[edi+ebx-$01]
    mov edx,[esp]
    cmp al,[edx]
    }
     begin
      goto InnerLoop;
      {
      jz +$27
      }
     end;
    OuterLoop:
   until(MatchPos >= StopSearch);
   {
   cmp ebx,[esp+$14]
   jl @LoopStart
   }
   SetLength(Result, NoOfMatches);
   Exit;
   InnerLoop:
   I3 := 1;
   repeat
    Inc(I3);
    if Str[MatchPos+I3-1] <> SubString[I3] then
     begin
      goto OuterLoop;
     end;
   until(I3 = SubStrLength);
   Inc(NoOfMatches);
   if ResultLength < NoOfMatches then
    begin
     ResultLength := ResultLength + RESULTGROWSTEPSIZE;
     SetLength(Result, ResultLength);
    end;
   Result[NoOfMatches-1] := MatchPos;
   MatchPos := MatchPos + I3 - 1;
   goto OuterLoop;
  end;
 I1 := 0;
 repeat
  SkipValues[I1]   := SubStrLength;
  SkipValues[I1+1] := SubStrLength;
  SkipValues[I1+2] := SubStrLength;
  SkipValues[I1+3] := SubStrLength;
  SkipValues[I1+4] := SubStrLength;
  SkipValues[I1+5] := SubStrLength;
  SkipValues[I1+6] := SubStrLength;
  SkipValues[I1+7] := SubStrLength;
  Inc(I1,8);
 until(I1 >= 255);
 Skip := SubStrLength - 1;
 for I := 1 to SubStrLength-1 do
  begin
   SkipValues[Integer(SubString[I])] := Skip;
   Dec(Skip);
  end;
 LastChar := SubString[SubStrLength];
 StringIndex := SubStrLength;
 while StringIndex <= StrLength do
  begin
   C := Str[StringIndex];
   if C <> LastChar then
    begin
     Inc(StringIndex, SkipValues[Ord(C)]);
    end
   else
    begin
     Match := True;
     MatchPos := StringIndex;
    ContinueSearch :
     for SubStringIndex := SubStrLength-1 downto 1 do
      begin
       Dec(MatchPos);
       if SubString[SubStringIndex] <> Str[MatchPos] then
        begin
         NewStrIndex := MatchPos + SkipValues[Cardinal(Str[MatchPos])];
         SkipValue := SkipValues[Integer(Str[StringIndex])];
         Inc(StringIndex, SkipValue);
         if StringIndex < NewStrIndex then
          StringIndex := NewStrIndex;
         Match := False;
         Break;
        end;
      end;
     if Match then
      begin
       Inc(NoOfMatches);
       if ResultLength < NoOfMatches then
        begin
         ResultLength := ResultLength + RESULTGROWSTEPSIZE;
         SetLength(Result, ResultLength);
        end;
       Result[NoOfMatches-1] := MatchPos;
       //Continue searching after this match
       MatchPos := MatchPos + SubStrLength + 1; //Compensate for Dec(MatchPos);
       if MatchPos < StrLength - SubStrLength then
        goto ContinueSearch
       else
        begin
         SetLength(Result, NoOfMatches);
         Exit;
        end;
      end;
    end;
  end;
 SetLength(Result, NoOfMatches);
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/9 2006
//Instructionset(s): IA32

function PosEZ_DKC_Pas_10(const SubString : AnsiString; const Str : AnsiString) : TPosEZResults;
var
 C, LastChar : Char;
 SubStrLength, StrLength, StringIndex, SubStringIndex, SkipValue,
NewStrIndex,
 Skip, StopSearch, I1, I, I3, NoOfMatches, ResultLength : Integer;
 SkipValues : array[0..255] of Integer;
 Match : Boolean;
 MatchPos : Integer;
label
 OuterLoop, InnerLoop, ContinueSearch;
const
 RESULTGROWSTEPSIZE : Integer = 10;

begin
 StrLength := PCardinal(Cardinal(Str)-4)^;
 SubStrLength := PCardinal(Cardinal(SubString)-4)^;
 NoOfMatches := 0;
 ResultLength := 0;
 if SubStrLength = 1 then
  begin
   MatchPos := 0;
   repeat
    Inc(MatchPos);
    if Str[MatchPos] = SubString[1] then
     begin
      Inc(NoOfMatches);
      MatchPos := MatchPos;
      if ResultLength < NoOfMatches then
       begin
        ResultLength := ResultLength + RESULTGROWSTEPSIZE;
        SetLength(Result, ResultLength);
       end;
      Result[NoOfMatches-1] := MatchPos;
     end;
   until(MatchPos = StrLength);
   //Sqeeze Result to correct size
   SetLength(Result, NoOfMatches);
   Exit;
  end;
 if (StrLength < 250) or (SubStrLength < 3) then
  begin
   MatchPos := 0;
   StopSearch := StrLength-SubStrLength+1;
   repeat
    Inc(MatchPos);
    if Str[MatchPos] = SubString[1] then
     begin
      goto InnerLoop;
     end;
    OuterLoop:
   until(MatchPos >= StopSearch);
   SetLength(Result, NoOfMatches);
   Exit;
   InnerLoop:
   I3 := 1;
   repeat
    Inc(I3);
    if Str[MatchPos+I3-1] <> SubString[I3] then
     begin
      goto OuterLoop;
     end;
   until(I3 = SubStrLength);
   Inc(NoOfMatches);
   if ResultLength < NoOfMatches then
    begin
     ResultLength := ResultLength + RESULTGROWSTEPSIZE;
     SetLength(Result, ResultLength);
    end;
   Result[NoOfMatches-1] := MatchPos;
   MatchPos := MatchPos + I3 - 1;
   goto OuterLoop;
  end;
 I1 := 0;
 repeat
  SkipValues[I1]   := SubStrLength;
  SkipValues[I1+1] := SubStrLength;
  SkipValues[I1+2] := SubStrLength;
  SkipValues[I1+3] := SubStrLength;
  SkipValues[I1+4] := SubStrLength;
  SkipValues[I1+5] := SubStrLength;
  SkipValues[I1+6] := SubStrLength;
  SkipValues[I1+7] := SubStrLength;
  Inc(I1,8);
 until(I1 >= 255);
 Skip := SubStrLength - 1;
 for I := 1 to SubStrLength-1 do
  begin
   SkipValues[Integer(SubString[I])] := Skip;
   Dec(Skip);
  end;
 LastChar := SubString[SubStrLength];
 StringIndex := SubStrLength;
 while StringIndex <= StrLength do
  begin
   C := Str[StringIndex];
   if C <> LastChar then
    begin
     Inc(StringIndex, SkipValues[Ord(C)]);
    end
   else
    begin
     Match := True;
     MatchPos := StringIndex;
    ContinueSearch :
     for SubStringIndex := SubStrLength-1 downto 1 do
      begin
       Dec(MatchPos);
       if SubString[SubStringIndex] <> Str[MatchPos] then
        begin
         NewStrIndex := MatchPos + SkipValues[Cardinal(Str[MatchPos])];
         SkipValue := SkipValues[Integer(Str[StringIndex])];
         Inc(StringIndex, SkipValue);
         if StringIndex < NewStrIndex then
          StringIndex := NewStrIndex;
         Match := False;
         Break;
        end;
      end;
     if Match then
      begin
       Inc(NoOfMatches);
       if ResultLength < NoOfMatches then
        begin
         ResultLength := ResultLength + RESULTGROWSTEPSIZE;
         SetLength(Result, ResultLength);
        end;
       Result[NoOfMatches-1] := MatchPos;
       //Continue searching after this match
       MatchPos := MatchPos + SubStrLength + 1; //Compensate for Dec(MatchPos);
       if MatchPos < StrLength - SubStrLength then
        goto ContinueSearch
       else
        begin
         SetLength(Result, NoOfMatches);
         Exit;
        end;
      end;
    end;
  end;
 SetLength(Result, NoOfMatches);
end;

//Author:            Dennis Kjaer Christensen
//Date:              16/11 2006
//Instructionset(s): IA32

function PosEZ_DKC_Pas_11(const SubString : AnsiString; const Str : AnsiString) : TPosEZResults;
var
 NoOfMatches, Offset, MatchPos, ResultSize : Integer;
const
 RESULTGROWSTEPSIZE : Integer = 10;

begin
 ResultSize := RESULTGROWSTEPSIZE;
 SetLength(Result, ResultSize);
 NoOfMatches := 0;
 Offset := 1;
 repeat
  MatchPos := PosEx(SubString, Str, Offset);
  if MatchPos = 0 then
   Break;
  Inc(NoOFMatches);
  Offset := MatchPos+Length(SubString);
  if NoOfMatches > ResultSize then
   begin
    Inc(ResultSize, RESULTGROWSTEPSIZE);
    SetLength(Result, ResultSize);
   end;
  Result[NoOfMatches-1] := MatchPos;
 until(False);
 SetLength(Result, NoOfMatches);
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/9 2006
//Instructionset(s): IA32

function StringReplace_DKC_Pas_6(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, PatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1,
Count2, Count3 : Integer;
 PosEZResults : TPosEZResults;

begin
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  begin
   Result := ''; //Bogus warning [Pascal Warning] StringReplaceDKCUnit.pas(6803): W1035 Return value of function 'StringReplace_DKC_Pas_6' might be undefined
   Exit;
  end;
 if SLength = 0 then
  begin
   Result := '';
   Exit;
  end;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := UpperCaseDKCPas32(S);
   Pattern := UpperCaseDKCPas32(OldPattern);
   Result := '';
   PatternLength := Length(Pattern);
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_10(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := Length(NewPattern);
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         ResultPos := 1;
         //Insert text before first match
         if PosEZResults[0]-1 > 0 then
          begin
           Count1 := PosEZResults[0]-1;
           Move(S[1], Result[ResultPos], Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           if NewPatternLength > 0 then //Do not Move if not Count > 0
            begin
             Count2 := NewPatternLength;
             Move(NewPattern[1], Result[ResultPos], NewPatternLength);
             Inc(ResultPos, Count2);
            end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           if PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength) > 0 then //Do not Move if not Count > 0
            begin
             Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
             Move(S[PosEZResults[I]+OldPatternLength], Result[ResultPos], Count3);
             Inc(ResultPos, Count3);
            end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+PatternLength;
         //Insert text from last match to end of source
         if SLength-EndOfLastPattern+1 > 0 then //Do not Move if not Count > 0
          Move(S[EndOfLastPattern], Result[ResultLength - (SLength-EndOfLastPattern)], SLength-EndOfLastPattern+1);
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := Length(NewPattern);
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Length(Result) <> ResultLength then
        raise Exception.Create('');
       if Offset-1 > 0 then
        Move(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        Move(NewPattern[1], Result[Offset], NewPatternLength);
       if SLength-Offset-OldPatternLength+1 > 0 then
        Move(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], SLength-Offset-OldPatternLength+1);
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   PatternLength := Length(OldPattern);
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_10(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := Length(NewPattern);
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         ResultPos := 1;
         //Insert text before first match
         if PosEZResults[0]-1 > 0 then
          begin
           Count1 := PosEZResults[0]-1;
           Move(S[1], Result[ResultPos], Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           if NewPatternLength > 0 then //Do not Move if not Count > 0
            begin
             Count2 := NewPatternLength;
             Move(NewPattern[1], Result[ResultPos], NewPatternLength);
             Inc(ResultPos, Count2);
            end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           if PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength) > 0 then //Do not Move if not Count > 0
            begin
             Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
             Move(S[PosEZResults[I]+OldPatternLength], Result[ResultPos], Count3);
             Inc(ResultPos, Count3);
            end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+PatternLength;
         //Insert text from last match to end of source
         if SLength-EndOfLastPattern+1 > 0 then //Do not Move if not Count > 0
          Move(S[EndOfLastPattern], Result[ResultLength - (SLength-EndOfLastPattern)], SLength-EndOfLastPattern+1);
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := Length(NewPattern);
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Length(Result) <> ResultLength then
        raise Exception.Create('');
       if Offset-1 > 0 then
        Move(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        Move(NewPattern[1], Result[Offset], NewPatternLength);
       if SLength-Offset-OldPatternLength+1 > 0 then
        Move(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], SLength-Offset-OldPatternLength+1);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/10 2006
//Instructionset(s): IA32

function StringReplace_DKC_IA32_17(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  begin
   Result := ''; //Bogus warning [Pascal Warning] StringReplaceDKCUnit.pas(4979): W1035 Return value of function 'StringReplace_DKC_IA32_17' might be undefined
   Exit;
  end;
 if SLength = 0 then
  begin
   Result := '';
   Exit;
  end;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := LowerCaseDKC_IA32_1(S);
   Pattern := LowerCaseDKC_IA32_1(OldPattern);
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := Length(NewPattern);
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_IA32_2(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_IA32_2(NewPattern[1], pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_IA32_2(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1] + OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           MoveForward_DKC_IA32_2(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       SetLength(Result, SLength);
       MoveForward_DKC_IA32_2(S[1], Result[1], SLength);
      end;
    end
   else
    begin
     Offset := Pos_DKC_Pas_1(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := Length(NewPattern);
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_IA32_2(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_IA32_2(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_IA32_2(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       SetLength(Result, SLength);
       MoveForward_DKC_IA32_2(S[1], Result[1], SLength);
      end;
    end;
  end
 else
  begin
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_IA32_2(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_IA32_2(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_IA32_2(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           pZ := pS;
           Inc(pZ, EndOfLastPattern-1);
           MoveForward_DKC_IA32_2(pZ^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       SetLength(Result, SLength);
       MoveForward_DKC_IA32_2(S[1], Result[1], SLength);
      end;
    end
   else
    begin
     Offset := Pos_DKC_Pas_1(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength = 0 then
        Exit;
       pResult := @Result[1];
       pS := @S[1];
       if Offset-1 > 0 then
        MoveForward_DKC_IA32_2(pS^, pResult^, Offset-1);
       Inc(pResult, Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_IA32_2(NewPattern[1], pResult^, NewPatternLength);
       Inc(pResult, NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       Inc(pS, Offset+OldPatternLength-1);
       if Count5 > 0 then
        MoveForward_DKC_IA32_2(pS^, pResult^, Count5);
      end
     else
      begin
       SetLength(Result, SLength);
       MoveForward_DKC_IA32_2(S[1], Result[1], SLength);
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              16/11 2006
//Instructionset(s): IA32

function StringReplace_DKC_IA32_19(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  begin
   Result := '';
   Exit;
  end;
 if SLength = 0 then
  begin
   Result := '';
   Exit;
  end;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := UpperCaseDKC_IA32_18(S);
   Pattern := UpperCaseDKC_IA32_18(OldPattern);
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_10(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           Move(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              Move(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              Move(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           Move(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength <> 0 then
        pResult := @Result[1]
       else
        Exit;
       pS := @S[1];
       if Offset-1 > 0 then
        begin
         Move(pS^, pResult^, Offset-1);
        end;
       if NewPatternLength > 0 then
        begin
         pX := pResult;
         Inc(pX, Offset-1);
         Move(NewPattern[1], pX^, NewPatternLength);
        end;
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        begin
         pX := pResult;
         Inc(pX, Offset+NewPatternLength-1);
         pY := pS;
         Inc(pY, Offset+OldPatternLength-1);
         Move(pY^, pX^, Count5);
        end;
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_10(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           Move(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              Move(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              Move(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           Inc(pS, EndOfLastPattern-1);
           Move(pS^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        Move(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        Move(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        Move(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              16/11 2006
//Instructionset(s): IA32

function StringReplace_DKC_IA32_20(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  begin
   Result := '';
   Exit;
  end;
 if SLength = 0 then
  begin
   Result := '';
   Exit;
  end;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := UpperCaseDKC_IA32_18(S);
   Pattern := UpperCaseDKC_IA32_18(OldPattern);
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_11(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           Move(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              Move(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              Move(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           Move(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength <> 0 then
        pResult := @Result[1]
       else
        Exit;
       pS := @S[1];
       if Offset-1 > 0 then
        begin
         Move(pS^, pResult^, Offset-1);
        end;
       if NewPatternLength > 0 then
        begin
         pX := pResult;
         Inc(pX, Offset-1);
         Move(NewPattern[1], pX^, NewPatternLength);
        end;
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        begin
         pX := pResult;
         Inc(pX, Offset+NewPatternLength-1);
         pY := pS;
         Inc(pY, Offset+OldPatternLength-1);
         Move(pY^, pX^, Count5);
        end;
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_11(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           Move(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              Move(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              Move(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           Inc(pS, EndOfLastPattern-1);
           Move(pS^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        Move(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        Move(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        Move(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/10 2006
//Instructionset(s): IA32, MMX

function StringReplace_DKC_MMX_12(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, PatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  begin
   Result := ''; //Bogus warning [Pascal Warning] StringReplaceDKCUnit.pas(4639): W1035 Return value of function 'StringReplace_DKC_MMX_12' might be undefined
   Exit;
  end;
 if SLength = 0 then
  begin
   Result := '';
   Exit;
  end;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := LowerCaseDKC_IA32_1(S);
   Pattern := LowerCaseDKC_IA32_1(OldPattern);
   PatternLength := 0;
   if Pattern <> '' then
    PatternLength := PCardinal(Cardinal(Pattern)-4)^;
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_IA32_2(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_IA32_2(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_IA32_2(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+PatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           MoveForward_DKC_IA32_2(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_MMX_1(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_IA32_2(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_IA32_2(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_IA32_2(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_IA32_2(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_IA32_2(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_IA32_2(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           pZ := pS;
           Inc(pZ, EndOfLastPattern-1);
           MoveForward_DKC_IA32_2(pZ^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_MMX_1(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_IA32_2(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_IA32_2(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_IA32_2(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/10 2006
//Instructionset(s): IA32, MMX

function StringReplace_DKC_MMX_13(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, PatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  begin
   Result := ''; //Bogus warning [Pascal Warning] StringReplaceDKCUnit.pas(5481): W1035 Return value of function 'StringReplace_DKC_MMX_13' might be undefined
   Exit;
  end;
 if SLength = 0 then
  begin
   Result := '';
   Exit;
  end;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := LowerCaseDKC_IA32_1(S);
   Pattern := LowerCaseDKC_IA32_1(OldPattern);
   PatternLength := 0;
   if Pattern <> '' then
    PatternLength := PCardinal(Cardinal(Pattern)-4)^;
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_IA32_2(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_IA32_2(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_IA32_2(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+PatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           MoveForward_DKC_IA32_2(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_MMX_2(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_IA32_2(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_IA32_2(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_IA32_2(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_IA32_2(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_IA32_2(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_IA32_2(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           pZ := pS;
           Inc(pZ, EndOfLastPattern-1);
           MoveForward_DKC_IA32_2(pZ^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_MMX_2(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_IA32_2(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_IA32_2(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_IA32_2(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/10 2006
//Instructionset(s): IA32, MMX

function StringReplace_DKC_MMX_14(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, PatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  begin
   Result := ''; // Bogus warning [Pascal Warning] StringReplaceDKCUnit.pas(5731): W1035 Return value of function 'StringReplace_DKC_MMX_14' might be undefined
   Exit;
  end;
 if SLength = 0 then
  begin
   Result := '';
   Exit;
  end;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := LowerCaseDKC_IA32_1(S);
   Pattern := LowerCaseDKC_IA32_1(OldPattern);
   PatternLength := 0;
   if Pattern <> '' then
    PatternLength := PCardinal(Cardinal(Pattern)-4)^;
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_MMX_1(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_MMX_1(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_MMX_1(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+PatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           MoveForward_DKC_MMX_1(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_MMX_2(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_MMX_1(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_MMX_1(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_MMX_1(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_MMX_1(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_MMX_1(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_MMX_1(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           pZ := pS;
           Inc(pZ, EndOfLastPattern-1);
           MoveForward_DKC_MMX_1(pZ^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_MMX_2(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_MMX_1(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_MMX_1(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_MMX_1(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/10 2006
//Instructionset(s): IA32, MMX, SSE

function StringReplace_DKC_SSE_11(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, PatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 Result := '';  //Bogus warning [Pascal Warning] StringReplaceDKCUnit.pas(4141): W1035 Return value of function 'StringReplace_DKC_SSE_11' might be undefined
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  Exit;
 if SLength = 0 then
  Exit;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := UpperCaseDKC_IA32_18(S);
   Pattern := UpperCaseDKC_IA32_18(OldPattern);
   PatternLength := 0;
   if Pattern <> '' then
    PatternLength := PCardinal(Cardinal(Pattern)-4)^;
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_SSE_1(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_SSE_1(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_SSE_1(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+PatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           MoveForward_DKC_SSE_1(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_SSE_5(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_SSE_1(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_SSE_1(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_SSE_1(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   PatternLength := OldPatternLength;
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_SSE_1(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_SSE_1(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_SSE_1(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+PatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           pZ := pS;
           Inc(pZ, EndOfLastPattern-1);
           MoveForward_DKC_SSE_1(pZ^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_SSE_5(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_SSE_1(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_SSE_1(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_SSE_1(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/10 2006
//Instructionset(s): IA32, MMX, SSE

function StringReplace_DKC_SSE_12(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, PatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 Result := '';
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  Exit;
 if SLength = 0 then
  Exit;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := UpperCaseDKC_IA32_18(S);
   Pattern := UpperCaseDKC_IA32_18(OldPattern);
   PatternLength := 0;
   if Pattern <> '' then
    PatternLength := PCardinal(Cardinal(Pattern)-4)^;
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_SSE_1(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_SSE_1(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_SSE_1(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+PatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           MoveForward_DKC_SSE_1(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_SSE_6(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_SSE_1(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_SSE_1(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_SSE_1(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   PatternLength := OldPatternLength;
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_SSE_1(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_SSE_1(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_SSE_1(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+PatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           pZ := pS;
           Inc(pZ, EndOfLastPattern-1);
           MoveForward_DKC_SSE_1(pZ^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_SSE_6(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_SSE_1(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_SSE_1(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_SSE_1(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/10 2006
//Instructionset(s): IA32, MMX, SSE, SSE2

function StringReplace_DKC_SSE2_21(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  begin
   Result := '';
   Exit;
  end;
 if SLength = 0 then
  begin
   Result := '';
   Exit;
  end;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := UpperCaseDKC_IA32_18(S);
   Pattern := UpperCaseDKC_IA32_18(OldPattern);
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_SSE2_3(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_SSE2_3(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_SSE2_3(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           MoveForward_DKC_SSE2_3(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_SSE_6(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength <> 0 then
        pResult := @Result[1]
       else
        Exit;
       pS := @S[1];
       if Offset-1 > 0 then
        begin
         MoveForward_DKC_SSE2_3(pS^, pResult^, Offset-1);
        end;
       if NewPatternLength > 0 then
        begin
         pX := pResult;
         Inc(pX, Offset-1);
         MoveForward_DKC_SSE2_3(NewPattern[1], pX^, NewPatternLength);
        end;
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        begin
         pX := pResult;
         Inc(pX, Offset+NewPatternLength-1);
         pY := pS;
         Inc(pY, Offset+OldPatternLength-1);
         MoveForward_DKC_SSE2_3(pY^, pX^, Count5);
        end;
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_SSE2_3(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_SSE2_3(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_SSE2_3(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           Inc(pS, EndOfLastPattern-1);
           MoveForward_DKC_SSE2_3(pS^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_SSE_6(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_SSE2_3(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_SSE2_3(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_SSE2_3(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/10 2006
//Instructionset(s): IA32, MMX, SSE, SSE2

function StringReplace_DKC_SSE2_22(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern : AnsiString;
 Offset, OldPatternLength, SLength, NoOfMatches, I,
 EndOfLastPattern, ResultLength, NewPatternLength, ResultPos, Count1, Count2,
 Count3, Count4, Count5 : Integer;
 PosEZResults : TPosEZResults;
 pResult, pS, pX, pY, pZ : PChar;

begin
 if S <> '' then
  SLength := PCardinal(Cardinal(S)-4)^
 else
  begin
   Result := '';
   Exit;
  end;
 if SLength = 0 then
  begin
   Result := '';
   Exit;
  end;
 if OldPattern <> '' then
  OldPatternLength := PCardinal(Cardinal(OldPattern)-4)^
 else
  begin
   Result := S;
   Exit;
  end;
 if OldPatternLength = 0 then
  begin
   Result := S;
   Exit;
  end;
 if (OldPatternLength > SLength) then
  begin
   Result := S;
   Exit;
  end;
 if rfIgnoreCase in Flags then
  begin
   SearchStr := UpperCaseDKC_IA32_18(S);
   Pattern := UpperCaseDKC_IA32_18(OldPattern);
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(Pattern, SearchStr);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_SSE2_3(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_SSE2_3(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_SSE2_3(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           MoveForward_DKC_SSE2_3(S[EndOfLastPattern], pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_SSE_7(Pattern, SearchStr);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength <> 0 then
        pResult := @Result[1]
       else
        Exit;
       pS := @S[1];
       if Offset-1 > 0 then
        begin
         MoveForward_DKC_SSE2_3(pS^, pResult^, Offset-1);
        end;
       if NewPatternLength > 0 then
        begin
         pX := pResult;
         Inc(pX, Offset-1);
         MoveForward_DKC_SSE2_3(NewPattern[1], pX^, NewPatternLength);
        end;
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        begin
         pX := pResult;
         Inc(pX, Offset+NewPatternLength-1);
         pY := pS;
         Inc(pY, Offset+OldPatternLength-1);
         MoveForward_DKC_SSE2_3(pY^, pX^, Count5);
        end;
      end
     else
      begin
       Result := S;
      end;
    end;
  end
 else
  begin
   if (rfReplaceAll in Flags) then
    begin
     PosEZResults := PosEZ_DKC_Pas_9(OldPattern, S);
     NoOfMatches := Length(PosEZResults);
     if NoOfMatches <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       if NewPatternLength > 0 then
        pZ := @NewPattern[1]
       else
        pZ := nil;
       ResultLength := SLength + NoOfMatches * (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if ResultLength > 0 then
        begin
         pResult := @Result[1];
         pS := @S[1];
         ResultPos := 1;
         //Insert text before first match
         Count1 := PosEZResults[0]-1;
         if Count1 > 0 then
          begin
           pX := pResult;
           Inc(pX, ResultPos-1);
           MoveForward_DKC_SSE2_3(pS^, pX^, Count1);
           Inc(ResultPos, Count1);
          end;
         I := 0;
         repeat
          //Insert newpattern
          if I <= NoOfMatches-1 then
           begin
            if NewPatternLength > 0 then //Do not Move if not Count > 0
             begin
              Count2 := NewPatternLength;
              pX := pResult;
              Inc(pX, ResultPos-1);
              MoveForward_DKC_SSE2_3(pZ^, pX^, NewPatternLength);
              Inc(ResultPos, Count2);
             end;
           end;
          //Insert text from end of newpattern to start of next match
          if I < NoOfMatches-1 then //but only if there is a next match
           begin
            Count3 := PosEZResults[I+1] - (PosEZResults[I]+OldPatternLength);
            if Count3 > 0 then //Do not Move if not Count > 0
             begin
              pX := pResult;
              Inc(pX, ResultPos-1);
              pY := pS;
              Inc(pY, PosEZResults[I]+OldPatternLength-1);
              MoveForward_DKC_SSE2_3(pY^, pX^, Count3);
              Inc(ResultPos, Count3);
             end;
           end;
          Inc(I);
         until(I >= NoOfMatches);
         EndOfLastPattern := PosEZResults[NoOfMatches-1]+OldPatternLength;
         //Insert text from last match to end of source
         Count4 := SLength-EndOfLastPattern+1;
         if Count4 > 0 then //Do not Move if not Count > 0
          begin
           pX := pResult;
           Inc(pX, ResultLength - (SLength-EndOfLastPattern)-1);
           Inc(pS, EndOfLastPattern-1);
           MoveForward_DKC_SSE2_3(pS^, pX^, Count4);
          end;
        end;
      end
     else
      begin
       Result := S;
      end;
    end
   else
    begin
     Offset := Pos_DKC_SSE_7(OldPattern, S);
     if Offset <> 0 then
      begin
       NewPatternLength := 0;
       if NewPattern <> '' then
        NewPatternLength := PCardinal(Cardinal(NewPattern)-4)^;
       ResultLength := SLength + (NewPatternLength - OldPatternLength);
       SetLength(Result, ResultLength);
       if Offset-1 > 0 then
        MoveForward_DKC_SSE2_3(S[1], Result[1], Offset-1);
       if NewPatternLength > 0 then
        MoveForward_DKC_SSE2_3(NewPattern[1], Result[Offset], NewPatternLength);
       Count5 := SLength-Offset-OldPatternLength+1;
       if Count5 > 0 then
        MoveForward_DKC_SSE2_3(S[Offset+OldPatternLength], Result[Offset+NewPatternLength], Count5);
      end
     else
      begin
       Result := S;
      end;
    end;
  end;
end;

initialization

 InitializeUpperCaseLookUpTable;
 InitializeLowerCaseLookUpTable;

end.
