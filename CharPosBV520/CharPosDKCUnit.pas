unit CharPosDKCUnit;

interface

function CharPos_DKC_Pas_1_a(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_Pas_1_b(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_Pas_1_c(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_Pas_1_d(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_MMX_1_a(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_MMX_1_b(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_MMX_1_c(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_MMX_1_d(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_SSE_1_a(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_SSE_1_b(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_SSE_1_c(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DKC_SSE_1_d(Chr : Char; const Str : AnsiString) : Integer;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              8/10 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX

function CharPos_DKC_MMX_1_a(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_MMX_1_b(Chr : Char; const Str : AnsiString) : Integer;
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

procedure Filler1;
asm
 nop
end;

function CharPos_DKC_MMX_1_c(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_MMX_1_d(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_SSE_1_a(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_SSE_1_b(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_SSE_1_c(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_SSE_1_d(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_Pas_1_a(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_Pas_1_b(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_Pas_1_c(Chr : Char; const Str : AnsiString) : Integer;
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

function CharPos_DKC_Pas_1_d(Chr : Char; const Str : AnsiString) : Integer;
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

initialization

 Filler1;

end.
