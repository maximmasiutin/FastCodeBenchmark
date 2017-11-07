unit PosShaUnit2;

interface

function Pos_Sha_Pas_1(const SubStr: AnsiString; const Str: AnsiString): Integer;
function Pos_Sha_Pas_2(const SubStr: AnsiString; const Str: AnsiString): Integer;
function Pos_Sha_Pas_3(const SubStr: AnsiString; const Str: AnsiString): Integer;
function Pos_Sha_IA32_3(const SubStr: AnsiString; const Str: AnsiString): Integer;
function Pos_Sha_IA32_4(const SubStr: AnsiString; const Str: AnsiString): Integer;
function Pos_Sha_IA32_5(const SubStr: AnsiString; const Str: AnsiString): Integer;

implementation

function Pos_Sha_Pas_1(const SubStr: AnsiString; const Str: AnsiString): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pEnd: pchar;
label
  Ret, Ret0, Ret1, Next0, Next1;
begin;
  p:=pointer(Str);
  pSub:=pointer(SubStr);

  //if need pure Pascal uncomment this paragraph
  //and comment out the next 3 paragraphs
{
  len:=length(Str);
  lenSub:=length(SubStr);
  pEnd:=p+len;
  pStart:=p;
  pEnd:=pEnd-lenSub;
  if (len<=0) or (lenSub<=0) or (p>pEnd) then begin;
    Result:=0;
    exit;
    end;
}

  if (p=nil) or (pSub=nil) then begin;
    Result:=0;
    exit;
    end;

  len:=pinteger(p-4)^;
  lenSub:=pinteger(pSub-4)^;
  if (len<lenSub) or (lenSub<=0) then begin;
    Result:=0;
    exit;
    end;

  pEnd:=p+len;
  pStart:=p;
  pEnd:=pEnd-lenSub;

  ch:=pSub[0];

  if lenSub=1 then begin;
    repeat;
      if ch=p[0] then goto Ret0;
      if ch=p[1] then goto Ret1;
      p:=p+2;
      until p>pEnd;
    Result:=0;
    exit;
    end;

  repeat;
    if ch=p[0] then begin;
      len:=lensub;
      repeat;
        if psub[len-1]<>p[len-1] then goto Next0;
        if psub[len-2]<>p[len-2] then goto Next0;
        len:=len-2;
        until len<2;
      goto Ret0;
Next0:end;

    if ch=p[1] then begin;
      len:=lensub;
      repeat;
        if psub[len-1]<>p[len] then goto Next1;
        if psub[len-2]<>p[len-1] then goto Next1;
        len:=len-2;
        until len<2;
      goto Ret1;
Next1:end;

    p:=p+2;
    until p>pEnd;
  Result:=0;
  exit;

Ret1:
  inc(pEnd);
  p:=p+2;
  if p<=pEnd then goto Ret;
  Result:=0;
  exit;
Ret0:
  inc(p);
Ret:
  Result:=p-pStart;
  end;

function Pos_Sha_Pas_2(const SubStr: AnsiString; const Str: AnsiString): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Ret, Ret0, Ret1, Next0, Next1;
begin;
  p:=pointer(Str);
  pSub:=pointer(SubStr);

  if (p=nil) or (pSub=nil) then begin;
    Result:=0;
    exit;
    end;

  len:=pinteger(p-4)^;
  lenSub:=pinteger(pSub-4)^;
  if (len<lenSub) or (lenSub<=0) then begin;
    Result:=0;
    exit;
    end;

  lenSub:=lenSub-1;
  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;

  ch:=pSub[0];

  if lenSub=0 then begin;
    repeat;
      if ch=p[0] then goto Ret0;
      if ch=p[1] then goto Ret1;
      p:=p+2;
      until p>=pStop;
    Result:=0;
    exit;
    end;

  lenSub:=-lenSub;
  repeat;
    if ch=p[0] then begin;
      len:=lenSub;
      repeat;
        if psub[len]<>p[len] then goto Next0;
        if psub[len+1]<>p[len+1] then goto Next0;
        len:=len+2;
        until len>=0;
      goto Ret0;
Next0:end;

    if ch=p[1] then begin;
      len:=lenSub;
      repeat;
        if psub[len]<>p[len+1] then goto Next1;
        if psub[len+1]<>p[len+2] then goto Next1;
        len:=len+2;
        until len>=0;
      goto Ret1;
Next1:end;

    p:=p+2;
    until p>=pStop;
  Result:=0;
  exit;

Ret1:
  p:=p+2;
  if p<=pStop then goto Ret;
  Result:=0;
  exit;
Ret0:
  inc(p);
Ret:
  Result:=p-pStart;
  end;

function Pos_Sha_Pas_3(const SubStr: AnsiString; const Str: AnsiString): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Ret, Ret0, Ret1, Next0, Next1;
begin;
  p:=pointer(Str);
  pSub:=pointer(SubStr);

  if (p=nil) or (pSub=nil) then begin;
    Result:=0;
    exit;
    end;

  len:=pinteger(p-4)^;
  lenSub:=pinteger(pSub-4)^;
  if (len<lenSub) or (lenSub<=0) then begin;
    Result:=0;
    exit;
    end;

  lenSub:=lenSub-1;
  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;

  ch:=pSub[0];

  if lenSub=0 then begin;
    repeat;
      if ch=p[0] then goto Ret0;
      if ch=p[1] then goto Ret1;
      p:=p+2;
      until p>=pStop;
    Result:=0;
    exit;
    end;

  lenSub:=-lenSub;
  repeat;
    if ch=p[0] then begin;
      len:=lenSub;
      repeat;
        if pword(psub+len)^<>pword(p+len)^ then goto Next0;
        len:=len+2;
        until len>=0;
      goto Ret0;
Next0:end;

    if ch=p[1] then begin;
      len:=lenSub;
      repeat;
        if pword(@psub[len])^<>pword(@p[len+1])^ then goto Next1;
        len:=len+2;
        until len>=0;
      goto Ret1;
Next1:end;

    p:=p+2;
    until p>=pStop;
  Result:=0;
  exit;

Ret1:
  p:=p+2;
  if p<=pStop then goto Ret;
  Result:=0;
  exit;
Ret0:
  inc(p);
Ret:
  Result:=p-pStart;
  end;

function Pos_Sha_IA32_3(const SubStr: AnsiString; const Str: AnsiString): Integer;
asm
       push  ebx
       push  esi
       add   esp, -16
       test  edx, edx
       jz    @NotFound
       test  eax, eax
       jz    @NotFound
       mov   ebx, [eax-4]
       mov   esi, [edx-4]
       cmp   esi, ebx
       jl    @NotFound
       test  ebx, ebx
       jle   @NotFound
       dec   ebx
       add   esi, edx
       add   edx, ebx
       mov   [esp+8], esi
       add   eax, ebx
       mov   [esp+4], edx
       neg   ebx
       movzx ecx, byte ptr [eax]
       mov   [esp], ebx
       jnz   @FindString

@FindChar:
       cmp   cl, [edx]
       jz    @Matched0
       cmp   cl, [edx+1]
       jz    @Matched1
       add   edx, 2
       cmp   edx, [esp+8]
       jb    @FindChar
@NotFound:
       xor   eax, eax
       jmp   @Exit

@FindString:
       sub   esi, 2
       mov   [esp+12], esi
@FindString2:
       cmp   cl, [edx]
       jz    @Test0
@NotMatched0:
       cmp   cl, [edx+1]
       jz    @Test1
@NotMatched1:
       add   edx, 2
       cmp   edx, [esp+12]
       jb    @FindString4
       cmp   edx, [esp+8]
       jb    @FindString2
       xor   eax, eax
       jmp   @Exit

@FindString4:
       cmp   cl, [edx]
       jz    @Test0
       cmp   cl, [edx+1]
       jz    @Test1
       cmp   cl, [edx+2]
       jz    @Test2
       cmp   cl, [edx+3]
       jz    @Test3
       add   edx, 4
       cmp   edx, [esp+12]
       jb    @FindString4
       cmp   edx, [esp+8]
       jb    @FindString2
       xor   eax, eax
       jmp   @Exit

@Test3:
       add   edx,2
@Test1:
       mov   esi, [esp]
@Loop1:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @NotMatched1
       add   esi, 2
       jl    @Loop1
@Matched1:
       add   edx, 2
       cmp   edx, [esp+8]
       jbe   @RetCode
       xor   eax, eax
       jmp   @Exit

@Test2:
       add   edx,2
@Test0:
       mov   esi, [esp]
@Loop0:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx]
       jnz   @NotMatched0
       add   esi, 2
       jl    @Loop0
@Matched0:
       inc   edx
@RetCode:
       mov   eax, edx
       sub   eax, [esp+4]
@Exit:
       add   esp, 16
       pop   esi
       pop   ebx
       end;

function Pos_Sha_IA32_4(const SubStr: AnsiString; const Str: AnsiString): Integer;
asm
       push  ebx
       push  esi
       add   esp, -16
       test  eax, eax
       jz    @NotFound
       test  edx, edx
       jz    @NotFound
       mov   ebx, [eax-4]
       mov   esi, [edx-4]
       cmp   esi, ebx
       jl    @NotFound
       test  ebx, ebx
       jle   @NotFound
       dec   ebx
       add   esi, edx
       add   edx, ebx
       mov   [esp+8], esi
       add   eax, ebx
       mov   [esp+4], edx
       neg   ebx
       movzx ecx, byte ptr [eax]
       mov   [esp], ebx
       jnz   @FindString

       sub   esi, 2
       mov   [esp+12], esi

@FindChar2:
       cmp   cl, [edx]
       jz    @Matched0
       cmp   cl, [edx+1]
       jz    @Matched1
       add   edx, 2
       cmp   edx, [esp+12]
       jb    @FindChar4
       cmp   edx, [esp+8]
       jb    @FindChar2
@NotFound:
       xor   eax, eax
       jmp   @Exit
@FindChar4:
       cmp   cl, [edx]
       jz    @Matched0
       cmp   cl, [edx+1]
       jz    @Matched1
       cmp   cl, [edx+2]
       jz    @Matched2
       cmp   cl, [edx+3]
       jz    @Matched3
       add   edx, 4
       cmp   edx, [esp+12]
       jb    @FindChar4
       cmp   edx, [esp+8]
       jb    @FindChar2
       xor   eax, eax
       jmp   @Exit

@FindString:
       sub   esi, 2
       mov   [esp+12], esi
@FindString2:
       cmp   cl, [edx]
       jz    @Test0
@NotMatched0:
       cmp   cl, [edx+1]
       jz    @Test1
@NotMatched1:
       add   edx, 2
       cmp   edx, [esp+12]
       jb    @FindString4
       cmp   edx, [esp+8]
       jb    @FindString2
       xor   eax, eax
       jmp   @Exit

@FindString4:
       cmp   cl, [edx]
       jz    @Test0
       cmp   cl, [edx+1]
       jz    @Test1
       cmp   cl, [edx+2]
       jz    @Test2
       cmp   cl, [edx+3]
       jz    @Test3
       add   edx, 4
       cmp   edx, [esp+12]
       jb    @FindString4
       cmp   edx, [esp+8]
       jb    @FindString2
       xor   eax, eax
       jmp   @Exit

@Test3:
       add   edx,2
@Test1:
       mov   esi, [esp]
@Loop1:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @NotMatched1
       add   esi, 2
       jl    @Loop1
@Matched1:
       add   edx, 2
       xor   eax, eax
       cmp   edx, [esp+8]
       ja    @Exit1
@RetCode1:
       mov   eax, edx
       sub   eax, [esp+4]
@Exit1:
       add   esp, 16
       pop   esi
       pop   ebx
       ret
@Matched3:
       add   edx, 4
       xor   eax, eax
       cmp   edx, [esp+8]
       jbe   @RetCode1
       jmp   @Exit1

@Matched2:
       add   edx, 3
       jmp   @RetCode0
@Test2:
       add   edx,2
@Test0:
       mov   esi, [esp]
@Loop0:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx]
       jnz   @NotMatched0
       add   esi, 2
       jl    @Loop0
@Matched0:
       inc   edx
@RetCode0:
       mov   eax, edx
       sub   eax, [esp+4]
@Exit:
       add   esp, 16
       pop   esi
       pop   ebx
       end;

function Pos_Sha_IA32_5(const SubStr: AnsiString; const Str: AnsiString): Integer;
asm
       push  ebx
       push  esi
       add   esp, -16
       test  edx, edx
       jz    @NotFound
       test  eax, eax
       jz    @NotFound
       mov   esi, [edx-4] //Length(Str)
       mov   ebx, [eax-4] //Length(Substr)
       cmp   esi, ebx
       jl    @NotFound
       test  ebx, ebx
       jle   @NotFound
       dec   ebx
       add   esi, edx
       add   edx, ebx
       mov   [esp+8], esi
       add   eax, ebx
       mov   [esp+4], edx
       neg   ebx
       movzx ecx, byte ptr [eax]
       mov   [esp], ebx
       jnz   @FindString

       sub   esi, 2
       mov   [esp+12], esi

@FindChar2:
       cmp   cl, [edx]
       jz    @Matched0ch
       cmp   cl, [edx+1]
       jz    @Matched1ch
       add   edx, 2
       cmp   edx, [esp+12]
       jb    @FindChar4
       cmp   edx, [esp+8]
       jb    @FindChar2
@NotFound:
       xor   eax, eax
       jmp   @Exit0ch

@FindChar4:
       cmp   cl, [edx]
       jz    @Matched0ch
       cmp   cl, [edx+1]
       jz    @Matched1ch
       cmp   cl, [edx+2]
       jz    @Matched2ch
       cmp   cl, [edx+3]
       jz    @Matched3ch
       add   edx, 4
       cmp   edx, [esp+12]
       jb    @FindChar4
       cmp   edx, [esp+8]
       jb    @FindChar2
       xor   eax, eax
       jmp   @Exit0ch

@Matched2ch:
       add   edx, 2
@Matched0ch:
       inc   edx
       mov   eax, edx
       sub   eax, [esp+4]
@Exit0ch:
       add   esp, 16
       pop   esi
       pop   ebx
       ret

@Matched3ch:
       add   edx, 2
@Matched1ch:
       add   edx, 2
       xor   eax, eax
       cmp   edx, [esp+8]
       ja    @Exit1ch
       mov   eax, edx
       sub   eax, [esp+4]
@Exit1ch:
       add   esp, 16
       pop   esi
       pop   ebx
       ret

@FindString4:
       cmp   cl, [edx]
       jz    @Test0
       cmp   cl, [edx+1]
       jz    @Test1
       cmp   cl, [edx+2]
       jz    @Test2
       cmp   cl, [edx+3]
       jz    @Test3
       add   edx, 4
       cmp   edx, [esp+12]
       jb    @FindString4
       cmp   edx, [esp+8]
       jb    @FindString2
       xor   eax, eax
       jmp   @Exit1

@FindString:
       sub   esi, 2
       mov   [esp+12], esi
@FindString2:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @Test1
@AfterTest1:
       add   edx, 2
       cmp   edx, [esp+12]
       jb    @FindString4
       cmp   edx, [esp+8]
       jb    @FindString2
       xor   eax, eax
       jmp   @Exit1

@Test3:
       add   edx, 2
@Test1:
       mov   esi, [esp]
@Loop1:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTest1
       add   esi, 2
       jl    @Loop1
       add   edx, 2
       xor   eax, eax
       cmp   edx, [esp+8]
       ja    @Exit1
@RetCode1:
       mov   eax, edx
       sub   eax, [esp+4]
@Exit1:
       add   esp, 16
       pop   esi
       pop   ebx
       ret

@Test2:
       add   edx,2
@Test0:
       mov   esi, [esp]
@Loop0:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx]
       jnz   @AfterTest0
       add   esi, 2
       jl    @Loop0
       inc   edx
@RetCode0:
       mov   eax, edx
       sub   eax, [esp+4]
       add   esp, 16
       pop   esi
       pop   ebx
       end;

function PosExShaAsm5_a(const SubStr, Str: AnsiString; Offset: integer): Integer;
asm //Faster than PosEx & integer Offset
       test  ecx, ecx
       push  ebx
       push  esi
       jle   @BadOffset
       dec   ecx
@OffsetOk:
       add   esp, -16
       test  edx, edx
       jz    @NotFound
       test  eax, eax
       jz    @NotFound
       mov   esi, [edx-4] //Length(Str)
       mov   ebx, [eax-4] //Length(Substr)
       sub   esi, ecx
       add   edx, ecx
       cmp   esi, ebx
       jl    @NotFound
       test  ebx, ebx
       jle   @NotFound
       dec   ebx
       add   esi, edx
       add   edx, ebx
       mov   [esp+8], esi
       add   eax, ebx
       mov   [esp+4], edx
       neg   ebx
       movzx ecx, byte ptr [eax]
       mov   [esp], ebx
       jnz   @FindString

       sub   esi, 2
       mov   [esp+12], esi

@FindChar2:
       cmp   cl, [edx]
       jz    @Matched0ch
       cmp   cl, [edx+1]
       jz    @Matched1ch
       add   edx, 2
       cmp   edx, [esp+12]
       jb    @FindChar4
       cmp   edx, [esp+8]
       jb    @FindChar2
@NotFound:
       xor   eax, eax
       jmp   @Exit0ch

@BadOffset:
       xor   ecx, ecx
       jmp   @OffsetOk

@FindChar4:
       cmp   cl, [edx]
       jz    @Matched0ch
       cmp   cl, [edx+1]
       jz    @Matched1ch
       cmp   cl, [edx+2]
       jz    @Matched2ch
       cmp   cl, [edx+3]
       jz    @Matched3ch
       add   edx, 4
       cmp   edx, [esp+12]
       jb    @FindChar4
       cmp   edx, [esp+8]
       jb    @FindChar2
       xor   eax, eax
       jmp   @Exit0ch

@Matched2ch:
       add   edx, 2
@Matched0ch:
       inc   edx
       mov   eax, edx
       sub   eax, [esp+4]
@Exit0ch:
       add   esp, 16
       pop   esi
       pop   ebx
       ret

@Matched3ch:
       add   edx, 2
@Matched1ch:
       add   edx, 2
       xor   eax, eax
       cmp   edx, [esp+8]
       ja    @Exit1ch
       mov   eax, edx
       sub   eax, [esp+4]
@Exit1ch:
       add   esp, 16
       pop   esi
       pop   ebx
       ret

@FindString4:
       cmp   cl, [edx]
       jz    @Test0
       cmp   cl, [edx+1]
       jz    @Test1
       cmp   cl, [edx+2]
       jz    @Test2
       cmp   cl, [edx+3]
       jz    @Test3
       add   edx, 4
       cmp   edx, [esp+12]
       jb    @FindString4
       cmp   edx, [esp+8]
       jb    @FindString2
       xor   eax, eax
       jmp   @Exit1

@FindString:
       sub   esi, 2
       mov   [esp+12], esi
@FindString2:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @Test1
@AfterTest1:
       add   edx, 2
       cmp   edx, [esp+12]
       jb    @FindString4
       cmp   edx, [esp+8]
       jb    @FindString2
       xor   eax, eax
       jmp   @Exit1

@Test3:
       add   edx, 2
@Test1:
       mov   esi, [esp]
@Loop1:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTest1
       add   esi, 2
       jl    @Loop1
       add   edx, 2
       xor   eax, eax
       cmp   edx, [esp+8]
       ja    @Exit1
@RetCode1:
       mov   eax, edx
       sub   eax, [esp+4]
@Exit1:
       add   esp, 16
       pop   esi
       pop   ebx
       ret

@Test2:
       add   edx,2
@Test0:
       mov   esi, [esp]
@Loop0:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx]
       jnz   @AfterTest0
       add   esi, 2
       jl    @Loop0
       inc   edx
@RetCode0:
       mov   eax, edx
       sub   eax, [esp+4]
       add   esp, 16
       pop   esi
       pop   ebx
       end;

end.

