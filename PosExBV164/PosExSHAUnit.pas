unit PosExSHAUnit;

interface

//function PosEx_Sha_Pas_1_a(const SubStr, S: string; Offset: Integer = 1): Integer;
//function PosEx_Sha_Pas_1_b(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_Sha_Pas_2_a(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_Sha_Pas_2_b(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_Sha_Pas_2_c(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_Sha_Pas_2_d(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_Sha_IA32_2_a(const SubStr, Str: string; Offset:integer=1): integer;
function PosEx_Sha_IA32_2_b(const SubStr, Str: string; Offset: integer=1): integer;
function PosEx_Sha_IA32_3_a(const SubStr, Str: string; Offset: integer=1): integer;
function PosEx_Sha_IA32_3_b(const SubStr, Str: string; Offset: integer=1): integer;
function PosEx_Sha_IA32_3_c(const SubStr, Str: string; Offset: integer=1): integer;
function PosEx_Sha_IA32_3_d(const SubStr, Str: string; Offset: integer=1): integer;
function PosEx_Sha_IA32_4_a(const SubStr, Str: string; Offset: integer=1): integer;
function PosEx_Sha_IA32_4_b(const SubStr, Str: string; Offset: integer=1): integer;
function PosEx_Sha_IA32_4_c(const SubStr, Str: string; Offset: integer=1): integer;
function PosEx_Sha_IA32_4_d(const SubStr, Str: string; Offset: integer=1): integer;

implementation

function PosEx_Sha_Pas_1_a(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Ret, Ret0, Ret1, Next0, Next1;
begin;
  p:=pointer(S);
  pSub:=pointer(SubStr);

  if (p=nil) or (pSub=nil) or (Offset<1) then begin;
    Result:=0;
    exit;
    end;

  lenSub:=pinteger(pSub-4)^;
  len:=pinteger(p-4)^;
  lenSub:=lenSub-1;
  if (len<lenSub+Offset) or (lenSub<0) then begin;
    Result:=0;
    exit;
    end;

  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;
  p:=p+Offset-1;

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

function PosEx_Sha_Pas_1_b(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Ret, Ret0, Ret1, Next0, Next1;
begin;
  p:=pointer(S);
  pSub:=pointer(SubStr);

  if (p=nil) or (pSub=nil) or (Offset<1) then begin;
    Result:=0;
    exit;
    end;

  lenSub:=pinteger(pSub-4)^;
  len:=pinteger(p-4)^;
  lenSub:=lenSub-1;
  if (len<lenSub+Offset) or (lenSub<0) then begin;
    Result:=0;
    exit;
    end;

  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;
  p:=p+Offset-1;

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

function PosEx_Sha_Pas_2_a(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Loop0, Loop4,
  TestT, Test0, Test1, Test2, Test3, Test4,
  AfterTestT, AfterTest0,
  Ret, Exit;
begin;
  pSub:=pointer(SubStr);
  p:=pointer(S);

  if (p=nil) or (pSub=nil) or (Offset<1) then begin;
    Result:=0;
    goto Exit;
    end;

  lenSub:=pinteger(pSub-4)^-1;
  len:=pinteger(p-4)^;
  if (len<lenSub+Offset) or (lenSub<0) then begin;
    Result:=0;
    goto Exit;
    end;

  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;
  p:=p+Offset+3;

  ch:=pSub[0];
  lenSub:=-lenSub;
  if p<pStop then goto Loop4;
  p:=p-4;
  goto Loop0;

Loop4:
  if ch=p[-4] then goto Test4;
  if ch=p[-3] then goto Test3;
  if ch=p[-2] then goto Test2;
  if ch=p[-1] then goto Test1;
Loop0:
  if ch=p[0] then goto Test0;
AfterTest0:
  if ch=p[1] then goto TestT;
AfterTestT:
  p:=p+6;
  if p<pStop then goto Loop4;
  p:=p-4;
  if p<pStop then goto Loop0;
  Result:=0;
  goto Exit;

Test3: p:=p-2;
Test1: p:=p-2;
TestT: len:=lenSub;
  if lenSub<>0 then repeat;
    if (psub[len]<>p[len+1])
    or (psub[len+1]<>p[len+2]) then goto AfterTestT;
    len:=len+2;
    until len>=0;
  p:=p+2;
  if p<=pStop then goto Ret;
  Result:=0;
  goto Exit;

Test4: p:=p-2;
Test2: p:=p-2;
Test0: len:=lenSub;
  if lenSub<>0 then repeat;
    if (psub[len]<>p[len])
    or (psub[len+1]<>p[len+1]) then goto AfterTest0;
    len:=len+2;
    until len>=0;
  inc(p);
Ret:
  Result:=p-pStart;
Exit:
  end;

procedure Filler1;
asm
 nop
end;

function PosEx_Sha_Pas_2_b(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Loop0, Loop4,
  TestT, Test0, Test1, Test2, Test3, Test4,
  AfterTestT, AfterTest0,
  Ret, Exit;
begin;
  pSub:=pointer(SubStr);
  p:=pointer(S);

  if (p=nil) or (pSub=nil) or (Offset<1) then begin;
    Result:=0;
    goto Exit;
    end;

  lenSub:=pinteger(pSub-4)^-1;
  len:=pinteger(p-4)^;
  if (len<lenSub+Offset) or (lenSub<0) then begin;
    Result:=0;
    goto Exit;
    end;

  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;
  p:=p+Offset+3;

  ch:=pSub[0];
  lenSub:=-lenSub;
  if p<pStop then goto Loop4;
  p:=p-4;
  goto Loop0;

Loop4:
  if ch=p[-4] then goto Test4;
  if ch=p[-3] then goto Test3;
  if ch=p[-2] then goto Test2;
  if ch=p[-1] then goto Test1;
Loop0:
  if ch=p[0] then goto Test0;
AfterTest0:
  if ch=p[1] then goto TestT;
AfterTestT:
  p:=p+6;
  if p<pStop then goto Loop4;
  p:=p-4;
  if p<pStop then goto Loop0;
  Result:=0;
  goto Exit;

Test3: p:=p-2;
Test1: p:=p-2;
TestT: len:=lenSub;
  if lenSub<>0 then repeat;
    if (psub[len]<>p[len+1])
    or (psub[len+1]<>p[len+2]) then goto AfterTestT;
    len:=len+2;
    until len>=0;
  p:=p+2;
  if p<=pStop then goto Ret;
  Result:=0;
  goto Exit;

Test4: p:=p-2;
Test2: p:=p-2;
Test0: len:=lenSub;
  if lenSub<>0 then repeat;
    if (psub[len]<>p[len])
    or (psub[len+1]<>p[len+1]) then goto AfterTest0;
    len:=len+2;
    until len>=0;
  inc(p);
Ret:
  Result:=p-pStart;
Exit:
  end;

procedure Filler2;
asm
 nop
end;

function PosEx_Sha_Pas_2_c(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Loop0, Loop4,
  TestT, Test0, Test1, Test2, Test3, Test4,
  AfterTestT, AfterTest0,
  Ret, Exit;
begin;
  pSub:=pointer(SubStr);
  p:=pointer(S);

  if (p=nil) or (pSub=nil) or (Offset<1) then begin;
    Result:=0;
    goto Exit;
    end;

  lenSub:=pinteger(pSub-4)^-1;
  len:=pinteger(p-4)^;
  if (len<lenSub+Offset) or (lenSub<0) then begin;
    Result:=0;
    goto Exit;
    end;

  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;
  p:=p+Offset+3;

  ch:=pSub[0];
  lenSub:=-lenSub;
  if p<pStop then goto Loop4;
  p:=p-4;
  goto Loop0;

Loop4:
  if ch=p[-4] then goto Test4;
  if ch=p[-3] then goto Test3;
  if ch=p[-2] then goto Test2;
  if ch=p[-1] then goto Test1;
Loop0:
  if ch=p[0] then goto Test0;
AfterTest0:
  if ch=p[1] then goto TestT;
AfterTestT:
  p:=p+6;
  if p<pStop then goto Loop4;
  p:=p-4;
  if p<pStop then goto Loop0;
  Result:=0;
  goto Exit;

Test3: p:=p-2;
Test1: p:=p-2;
TestT: len:=lenSub;
  if lenSub<>0 then repeat;
    if (psub[len]<>p[len+1])
    or (psub[len+1]<>p[len+2]) then goto AfterTestT;
    len:=len+2;
    until len>=0;
  p:=p+2;
  if p<=pStop then goto Ret;
  Result:=0;
  goto Exit;

Test4: p:=p-2;
Test2: p:=p-2;
Test0: len:=lenSub;
  if lenSub<>0 then repeat;
    if (psub[len]<>p[len])
    or (psub[len+1]<>p[len+1]) then goto AfterTest0;
    len:=len+2;
    until len>=0;
  inc(p);
Ret:
  Result:=p-pStart;
Exit:
  end;

procedure Filler3;
asm
 nop
end;

function PosEx_Sha_Pas_2_d(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  len, lenSub: integer;
  ch: char;
  p, pSub, pStart, pStop: pchar;
label
  Loop0, Loop4,
  TestT, Test0, Test1, Test2, Test3, Test4,
  AfterTestT, AfterTest0,
  Ret, Exit;
begin;
  pSub:=pointer(SubStr);
  p:=pointer(S);

  if (p=nil) or (pSub=nil) or (Offset<1) then begin;
    Result:=0;
    goto Exit;
    end;

  lenSub:=pinteger(pSub-4)^-1;
  len:=pinteger(p-4)^;
  if (len<lenSub+Offset) or (lenSub<0) then begin;
    Result:=0;
    goto Exit;
    end;

  pStop:=p+len;
  p:=p+lenSub;
  pSub:=pSub+lenSub;
  pStart:=p;
  p:=p+Offset+3;

  ch:=pSub[0];
  lenSub:=-lenSub;
  if p<pStop then goto Loop4;
  p:=p-4;
  goto Loop0;

Loop4:
  if ch=p[-4] then goto Test4;
  if ch=p[-3] then goto Test3;
  if ch=p[-2] then goto Test2;
  if ch=p[-1] then goto Test1;
Loop0:
  if ch=p[0] then goto Test0;
AfterTest0:
  if ch=p[1] then goto TestT;
AfterTestT:
  p:=p+6;
  if p<pStop then goto Loop4;
  p:=p-4;
  if p<pStop then goto Loop0;
  Result:=0;
  goto Exit;

Test3: p:=p-2;
Test1: p:=p-2;
TestT: len:=lenSub;
  if lenSub<>0 then repeat;
    if (psub[len]<>p[len+1])
    or (psub[len+1]<>p[len+2]) then goto AfterTestT;
    len:=len+2;
    until len>=0;
  p:=p+2;
  if p<=pStop then goto Ret;
  Result:=0;
  goto Exit;

Test4: p:=p-2;
Test2: p:=p-2;
Test0: len:=lenSub;
  if lenSub<>0 then repeat;
    if (psub[len]<>p[len])
    or (psub[len+1]<>p[len+1]) then goto AfterTest0;
    len:=len+2;
    until len>=0;
  inc(p);
Ret:
  Result:=p-pStart;
Exit:
  end;

function PosEx_Sha_IA32_2_a(const SubStr, Str: string; Offset:integer=1): integer;
asm
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
       sub   ecx, edx
       add   eax, ebx
       mov   [esp+4], ecx
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
       add   esp, 16
@BadOffset:  //comment out this label to continue as Offset = 1
       xor   eax, eax
       pop   esi
       pop   ebx
       ret

//@BadOffset: //uncomment this block to continue as Offset = 1
//       xor   ecx, ecx
//       jmp   @OffsetOk

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
       add   eax, [esp+4]
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
       add   eax, [esp+4]
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
       add   eax, [esp+4]
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
       add   eax, [esp+4]
       add   esp, 16
       pop   esi
       pop   ebx
       end;

function PosEx_Sha_IA32_2_b(const SubStr, Str: string; Offset: integer=1): integer;
asm
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
       sub   ecx, edx
       add   eax, ebx
       mov   [esp+4], ecx
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
       add   esp, 16
@BadOffset:  //comment out this label to continue as Offset = 1
       xor   eax, eax
       pop   esi
       pop   ebx
       ret

//@BadOffset: //uncomment this block to continue as Offset = 1
//       xor   ecx, ecx
//       jmp   @OffsetOk

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
       add   eax, [esp+4]
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
       add   eax, [esp+4]
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
       add   eax, [esp+4]
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
       add   eax, [esp+4]
       add   esp, 16
       pop   esi
       pop   ebx
       end;

function PosEx_Sha_IA32_3_a(const SubStr, Str: string; Offset: integer=1): integer;
asm
       test  eax, eax
       jz    @Nil
       test  edx, edx
       jz    @Nil
       dec   ecx
       jl    @Nil

       push  esi
       push  ebx

       mov   esi, [edx-4]  //Length(Str)
       mov   ebx, [eax-4]  //Length(Substr)
       sub   esi, ecx      //effective length of Str
       add   edx, ecx      //addr of the first char at starting position
       cmp   esi, ebx
       jl    @Past         //jump if EffectiveLength(Str)<Length(Substr)
       test  ebx, ebx
       jle   @Past         //jump if Length(Substr)<=0

       add   esp, -12
       add   ebx, -1       //Length(Substr)-1
       add   esi, edx      //addr of the terminator
       add   edx, ebx      //addr of the last char at starting position
       mov   [esp+8], esi  //save addr of the terminator
       add   eax, ebx      //addr of the last char of Substr
       sub   ecx, edx      //-@Str[Length(Substr)]
       neg   ebx           //-(Length(Substr)-1)
       mov   [esp+4], ecx  //save -@Str[Length(Substr)]
       mov   [esp], ebx    //save -(Length(Substr)-1)
       movzx ecx, byte ptr [eax] //the last char of Substr

@SmallLoop:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @TestT
@AfterTest1:
       add   edx, 8
       cmp   edx, [esp+8]
       jae   @EndSmall
@MainLoop:
       cmp   cl, [edx-6]
       jz    @Test6
       cmp   cl, [edx-5]
       jz    @Test5
       cmp   cl, [edx-4]
       jz    @Test4
       cmp   cl, [edx-3]
       jz    @Test3
       cmp   cl, [edx-2]
       jz    @Test2
       cmp   cl, [edx-1]
       jz    @Test1
       cmp   cl, [edx]
       jz    @Test0
       cmp   cl, [edx+1]
       jz    @TestT
       add   edx, 8
       cmp   edx, [esp+8]
       jb    @MainLoop
@EndSmall:
       add   edx, -6
       cmp   edx, [esp+8]
       jb    @SmallLoop
@Exit:
       add   esp, 12
@Past:
       pop   ebx
       pop   esi
@Nil:
       xor   eax, eax
       ret

@Test6:
       add   edx, -2
@Test4:
       add   edx, -2
@Test2:
       add   edx, -2
@Test0:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found0
@Loop0:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx]
       jnz   @AfterTest0
       cmp   esi, -2
       jge   @Found0
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+2]
       jnz   @AfterTest0
       add   esi, 4
       jl    @Loop0
@Found0:
       mov   eax, [esp+4]
       add   edx, 1
       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       ret

@Test5:
       add   edx, -2
@Test3:
       add   edx, -2
@Test1:
       add   edx, -2
@TestT:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found1
@Loop1:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTest1
       cmp   esi, -2
       jge   @Found1
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+3]
       jnz   @AfterTest1
       add   esi, 4
       jl    @Loop1
@Found1:
       mov   eax, [esp+4]
       add   edx, 2

       cmp   edx, [esp+8]
       ja    @Exit

       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       end;

function PosEx_Sha_IA32_3_b(const SubStr, Str: string; Offset: integer=1): integer;
asm
       test  eax, eax
       jz    @Nil
       test  edx, edx
       jz    @Nil
       dec   ecx
       jl    @Nil

       push  esi
       push  ebx

       mov   esi, [edx-4]  //Length(Str)
       mov   ebx, [eax-4]  //Length(Substr)
       sub   esi, ecx      //effective length of Str
       add   edx, ecx      //addr of the first char at starting position
       cmp   esi, ebx
       jl    @Past         //jump if EffectiveLength(Str)<Length(Substr)
       test  ebx, ebx
       jle   @Past         //jump if Length(Substr)<=0

       add   esp, -12
       add   ebx, -1       //Length(Substr)-1
       add   esi, edx      //addr of the terminator
       add   edx, ebx      //addr of the last char at starting position
       mov   [esp+8], esi  //save addr of the terminator
       add   eax, ebx      //addr of the last char of Substr
       sub   ecx, edx      //-@Str[Length(Substr)]
       neg   ebx           //-(Length(Substr)-1)
       mov   [esp+4], ecx  //save -@Str[Length(Substr)]
       mov   [esp], ebx    //save -(Length(Substr)-1)
       movzx ecx, byte ptr [eax] //the last char of Substr

@SmallLoop:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @TestT
@AfterTest1:
       add   edx, 8
       cmp   edx, [esp+8]
       jae   @EndSmall
@MainLoop:
       cmp   cl, [edx-6]
       jz    @Test6
       cmp   cl, [edx-5]
       jz    @Test5
       cmp   cl, [edx-4]
       jz    @Test4
       cmp   cl, [edx-3]
       jz    @Test3
       cmp   cl, [edx-2]
       jz    @Test2
       cmp   cl, [edx-1]
       jz    @Test1
       cmp   cl, [edx]
       jz    @Test0
       cmp   cl, [edx+1]
       jz    @TestT
       add   edx, 8
       cmp   edx, [esp+8]
       jb    @MainLoop
@EndSmall:
       add   edx, -6
       cmp   edx, [esp+8]
       jb    @SmallLoop
@Exit:
       add   esp, 12
@Past:
       pop   ebx
       pop   esi
@Nil:
       xor   eax, eax
       ret

@Test6:
       add   edx, -2
@Test4:
       add   edx, -2
@Test2:
       add   edx, -2
@Test0:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found0
@Loop0:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx]
       jnz   @AfterTest0
       cmp   esi, -2
       jge   @Found0
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+2]
       jnz   @AfterTest0
       add   esi, 4
       jl    @Loop0
@Found0:
       mov   eax, [esp+4]
       add   edx, 1
       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       ret

@Test5:
       add   edx, -2
@Test3:
       add   edx, -2
@Test1:
       add   edx, -2
@TestT:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found1
@Loop1:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTest1
       cmp   esi, -2
       jge   @Found1
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+3]
       jnz   @AfterTest1
       add   esi, 4
       jl    @Loop1
@Found1:
       mov   eax, [esp+4]
       add   edx, 2

       cmp   edx, [esp+8]
       ja    @Exit

       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       end;

function PosEx_Sha_IA32_3_c(const SubStr, Str: string; Offset: integer=1): integer;
asm
       test  eax, eax
       jz    @Nil
       test  edx, edx
       jz    @Nil
       dec   ecx
       jl    @Nil

       push  esi
       push  ebx

       mov   esi, [edx-4]  //Length(Str)
       mov   ebx, [eax-4]  //Length(Substr)
       sub   esi, ecx      //effective length of Str
       add   edx, ecx      //addr of the first char at starting position
       cmp   esi, ebx
       jl    @Past         //jump if EffectiveLength(Str)<Length(Substr)
       test  ebx, ebx
       jle   @Past         //jump if Length(Substr)<=0

       add   esp, -12
       add   ebx, -1       //Length(Substr)-1
       add   esi, edx      //addr of the terminator
       add   edx, ebx      //addr of the last char at starting position
       mov   [esp+8], esi  //save addr of the terminator
       add   eax, ebx      //addr of the last char of Substr
       sub   ecx, edx      //-@Str[Length(Substr)]
       neg   ebx           //-(Length(Substr)-1)
       mov   [esp+4], ecx  //save -@Str[Length(Substr)]
       mov   [esp], ebx    //save -(Length(Substr)-1)
       movzx ecx, byte ptr [eax] //the last char of Substr

@SmallLoop:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @TestT
@AfterTest1:
       add   edx, 8
       cmp   edx, [esp+8]
       jae   @EndSmall
@MainLoop:
       cmp   cl, [edx-6]
       jz    @Test6
       cmp   cl, [edx-5]
       jz    @Test5
       cmp   cl, [edx-4]
       jz    @Test4
       cmp   cl, [edx-3]
       jz    @Test3
       cmp   cl, [edx-2]
       jz    @Test2
       cmp   cl, [edx-1]
       jz    @Test1
       cmp   cl, [edx]
       jz    @Test0
       cmp   cl, [edx+1]
       jz    @TestT
       add   edx, 8
       cmp   edx, [esp+8]
       jb    @MainLoop
@EndSmall:
       add   edx, -6
       cmp   edx, [esp+8]
       jb    @SmallLoop
@Exit:
       add   esp, 12
@Past:
       pop   ebx
       pop   esi
@Nil:
       xor   eax, eax
       ret

@Test6:
       add   edx, -2
@Test4:
       add   edx, -2
@Test2:
       add   edx, -2
@Test0:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found0
@Loop0:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx]
       jnz   @AfterTest0
       cmp   esi, -2
       jge   @Found0
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+2]
       jnz   @AfterTest0
       add   esi, 4
       jl    @Loop0
@Found0:
       mov   eax, [esp+4]
       add   edx, 1
       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       ret

@Test5:
       add   edx, -2
@Test3:
       add   edx, -2
@Test1:
       add   edx, -2
@TestT:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found1
@Loop1:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTest1
       cmp   esi, -2
       jge   @Found1
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+3]
       jnz   @AfterTest1
       add   esi, 4
       jl    @Loop1
@Found1:
       mov   eax, [esp+4]
       add   edx, 2

       cmp   edx, [esp+8]
       ja    @Exit

       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       end;

function PosEx_Sha_IA32_3_d(const SubStr, Str: string; Offset: integer=1): integer;
asm
       test  eax, eax
       jz    @Nil
       test  edx, edx
       jz    @Nil
       dec   ecx
       jl    @Nil

       push  esi
       push  ebx

       mov   esi, [edx-4]  //Length(Str)
       mov   ebx, [eax-4]  //Length(Substr)
       sub   esi, ecx      //effective length of Str
       add   edx, ecx      //addr of the first char at starting position
       cmp   esi, ebx
       jl    @Past         //jump if EffectiveLength(Str)<Length(Substr)
       test  ebx, ebx
       jle   @Past         //jump if Length(Substr)<=0

       add   esp, -12
       add   ebx, -1       //Length(Substr)-1
       add   esi, edx      //addr of the terminator
       add   edx, ebx      //addr of the last char at starting position
       mov   [esp+8], esi  //save addr of the terminator
       add   eax, ebx      //addr of the last char of Substr
       sub   ecx, edx      //-@Str[Length(Substr)]
       neg   ebx           //-(Length(Substr)-1)
       mov   [esp+4], ecx  //save -@Str[Length(Substr)]
       mov   [esp], ebx    //save -(Length(Substr)-1)
       movzx ecx, byte ptr [eax] //the last char of Substr

@SmallLoop:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @TestT
@AfterTest1:
       add   edx, 8
       cmp   edx, [esp+8]
       jae   @EndSmall
@MainLoop:
       cmp   cl, [edx-6]
       jz    @Test6
       cmp   cl, [edx-5]
       jz    @Test5
       cmp   cl, [edx-4]
       jz    @Test4
       cmp   cl, [edx-3]
       jz    @Test3
       cmp   cl, [edx-2]
       jz    @Test2
       cmp   cl, [edx-1]
       jz    @Test1
       cmp   cl, [edx]
       jz    @Test0
       cmp   cl, [edx+1]
       jz    @TestT
       add   edx, 8
       cmp   edx, [esp+8]
       jb    @MainLoop
@EndSmall:
       add   edx, -6
       cmp   edx, [esp+8]
       jb    @SmallLoop
@Exit:
       add   esp, 12
@Past:
       pop   ebx
       pop   esi
@Nil:
       xor   eax, eax
       ret

@Test6:
       add   edx, -2
@Test4:
       add   edx, -2
@Test2:
       add   edx, -2
@Test0:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found0
@Loop0:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx]
       jnz   @AfterTest0
       cmp   esi, -2
       jge   @Found0
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+2]
       jnz   @AfterTest0
       add   esi, 4
       jl    @Loop0
@Found0:
       mov   eax, [esp+4]
       add   edx, 1
       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       ret

@Test5:
       add   edx, -2
@Test3:
       add   edx, -2
@Test1:
       add   edx, -2
@TestT:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found1
@Loop1:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTest1
       cmp   esi, -2
       jge   @Found1
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+3]
       jnz   @AfterTest1
       add   esi, 4
       jl    @Loop1
@Found1:
       mov   eax, [esp+4]
       add   edx, 2

       cmp   edx, [esp+8]
       ja    @Exit

       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       end;

function PosEx_Sha_IA32_4_a(const SubStr, Str: string; Offset: integer=1): integer;
asm
       test  eax, eax
       jz    @Nil
       test  edx, edx
       jz    @Nil
       dec   ecx
       jl    @Nil

       push  esi
       push  ebx

       mov   esi, [edx-4]  //Length(Str)
       mov   ebx, [eax-4]  //Length(Substr)
       sub   esi, ecx      //effective length of Str
       add   edx, ecx      //addr of the first char at starting position
       cmp   esi, ebx
       jl    @Past         //jump if EffectiveLength(Str)<Length(Substr)
       test  ebx, ebx
       jle   @Past         //jump if Length(Substr)<=0

       add   esp, -12
       add   ebx, -1       //Length(Substr)-1
       add   esi, edx      //addr of the terminator
       add   edx, ebx      //addr of the last char at starting position
       mov   [esp+8], esi  //save addr of the terminator
       add   eax, ebx      //addr of the last char of Substr
       sub   ecx, edx      //-@Str[Length(Substr)]
       neg   ebx           //-(Length(Substr)-1)
       mov   [esp+4], ecx  //save -@Str[Length(Substr)]
       mov   [esp], ebx    //save -(Length(Substr)-1)
       movzx ecx, byte ptr [eax] //the last char of Substr

@Loop:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @TestT
@AfterTestT:
       add   edx, 4
       cmp   edx, [esp+8]
       jb   @Continue
@EndLoop:
       add   edx, -2
       cmp   edx, [esp+8]
       jb    @Loop
@Exit:
       add   esp, 12
@Past:
       pop   ebx
       pop   esi
@Nil:
       xor   eax, eax
       ret
@Continue:
       cmp   cl, [edx-2]
       jz    @Test2
       cmp   cl, [edx-1]
       jnz   @Loop
@Test1:
       add   edx,  1
@Test2:
       add   edx, -2
@Test0:
       add   edx, -1
@TestT:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found
@String:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTestT
       cmp   esi, -2
       jge   @Found
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+3]
       jnz   @AfterTestT
       add   esi, 4
       jl    @String
@Found:
       mov   eax, [esp+4]
       add   edx, 2

       cmp   edx, [esp+8]
       ja    @Exit

       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       end;

procedure Filler4;
asm
 nop
end;

function PosEx_Sha_IA32_4_b(const SubStr, Str: string; Offset: integer=1): integer;
asm
       test  eax, eax
       jz    @Nil
       test  edx, edx
       jz    @Nil
       dec   ecx
       jl    @Nil

       push  esi
       push  ebx

       mov   esi, [edx-4]  //Length(Str)
       mov   ebx, [eax-4]  //Length(Substr)
       sub   esi, ecx      //effective length of Str
       add   edx, ecx      //addr of the first char at starting position
       cmp   esi, ebx
       jl    @Past         //jump if EffectiveLength(Str)<Length(Substr)
       test  ebx, ebx
       jle   @Past         //jump if Length(Substr)<=0

       add   esp, -12
       add   ebx, -1       //Length(Substr)-1
       add   esi, edx      //addr of the terminator
       add   edx, ebx      //addr of the last char at starting position
       mov   [esp+8], esi  //save addr of the terminator
       add   eax, ebx      //addr of the last char of Substr
       sub   ecx, edx      //-@Str[Length(Substr)]
       neg   ebx           //-(Length(Substr)-1)
       mov   [esp+4], ecx  //save -@Str[Length(Substr)]
       mov   [esp], ebx    //save -(Length(Substr)-1)
       movzx ecx, byte ptr [eax] //the last char of Substr

@Loop:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @TestT
@AfterTestT:
       add   edx, 4
       cmp   edx, [esp+8]
       jb   @Continue
@EndLoop:
       add   edx, -2
       cmp   edx, [esp+8]
       jb    @Loop
@Exit:
       add   esp, 12
@Past:
       pop   ebx
       pop   esi
@Nil:
       xor   eax, eax
       ret
@Continue:
       cmp   cl, [edx-2]
       jz    @Test2
       cmp   cl, [edx-1]
       jnz   @Loop
@Test1:
       add   edx,  1
@Test2:
       add   edx, -2
@Test0:
       add   edx, -1
@TestT:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found
@String:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTestT
       cmp   esi, -2
       jge   @Found
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+3]
       jnz   @AfterTestT
       add   esi, 4
       jl    @String
@Found:
       mov   eax, [esp+4]
       add   edx, 2

       cmp   edx, [esp+8]
       ja    @Exit

       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       end;

procedure Filler5;
asm
 nop
end;

function PosEx_Sha_IA32_4_c(const SubStr, Str: string; Offset: integer=1): integer;
asm
       test  eax, eax
       jz    @Nil
       test  edx, edx
       jz    @Nil
       dec   ecx
       jl    @Nil

       push  esi
       push  ebx

       mov   esi, [edx-4]  //Length(Str)
       mov   ebx, [eax-4]  //Length(Substr)
       sub   esi, ecx      //effective length of Str
       add   edx, ecx      //addr of the first char at starting position
       cmp   esi, ebx
       jl    @Past         //jump if EffectiveLength(Str)<Length(Substr)
       test  ebx, ebx
       jle   @Past         //jump if Length(Substr)<=0

       add   esp, -12
       add   ebx, -1       //Length(Substr)-1
       add   esi, edx      //addr of the terminator
       add   edx, ebx      //addr of the last char at starting position
       mov   [esp+8], esi  //save addr of the terminator
       add   eax, ebx      //addr of the last char of Substr
       sub   ecx, edx      //-@Str[Length(Substr)]
       neg   ebx           //-(Length(Substr)-1)
       mov   [esp+4], ecx  //save -@Str[Length(Substr)]
       mov   [esp], ebx    //save -(Length(Substr)-1)
       movzx ecx, byte ptr [eax] //the last char of Substr

@Loop:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @TestT
@AfterTestT:
       add   edx, 4
       cmp   edx, [esp+8]
       jb   @Continue
@EndLoop:
       add   edx, -2
       cmp   edx, [esp+8]
       jb    @Loop
@Exit:
       add   esp, 12
@Past:
       pop   ebx
       pop   esi
@Nil:
       xor   eax, eax
       ret
@Continue:
       cmp   cl, [edx-2]
       jz    @Test2
       cmp   cl, [edx-1]
       jnz   @Loop
@Test1:
       add   edx,  1
@Test2:
       add   edx, -2
@Test0:
       add   edx, -1
@TestT:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found
@String:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTestT
       cmp   esi, -2
       jge   @Found
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+3]
       jnz   @AfterTestT
       add   esi, 4
       jl    @String
@Found:
       mov   eax, [esp+4]
       add   edx, 2

       cmp   edx, [esp+8]
       ja    @Exit

       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       end;

procedure Filler6;
asm
 nop
end;

function PosEx_Sha_IA32_4_d(const SubStr, Str: string; Offset: integer=1): integer;
asm
       test  eax, eax
       jz    @Nil
       test  edx, edx
       jz    @Nil
       dec   ecx
       jl    @Nil

       push  esi
       push  ebx

       mov   esi, [edx-4]  //Length(Str)
       mov   ebx, [eax-4]  //Length(Substr)
       sub   esi, ecx      //effective length of Str
       add   edx, ecx      //addr of the first char at starting position
       cmp   esi, ebx
       jl    @Past         //jump if EffectiveLength(Str)<Length(Substr)
       test  ebx, ebx
       jle   @Past         //jump if Length(Substr)<=0

       add   esp, -12
       add   ebx, -1       //Length(Substr)-1
       add   esi, edx      //addr of the terminator
       add   edx, ebx      //addr of the last char at starting position
       mov   [esp+8], esi  //save addr of the terminator
       add   eax, ebx      //addr of the last char of Substr
       sub   ecx, edx      //-@Str[Length(Substr)]
       neg   ebx           //-(Length(Substr)-1)
       mov   [esp+4], ecx  //save -@Str[Length(Substr)]
       mov   [esp], ebx    //save -(Length(Substr)-1)
       movzx ecx, byte ptr [eax] //the last char of Substr

@Loop:
       cmp   cl, [edx]
       jz    @Test0
@AfterTest0:
       cmp   cl, [edx+1]
       jz    @TestT
@AfterTestT:
       add   edx, 4
       cmp   edx, [esp+8]
       jb   @Continue
@EndLoop:
       add   edx, -2
       cmp   edx, [esp+8]
       jb    @Loop
@Exit:
       add   esp, 12
@Past:
       pop   ebx
       pop   esi
@Nil:
       xor   eax, eax
       ret
@Continue:
       cmp   cl, [edx-2]
       jz    @Test2
       cmp   cl, [edx-1]
       jnz   @Loop
@Test1:
       add   edx,  1
@Test2:
       add   edx, -2
@Test0:
       add   edx, -1
@TestT:
       mov   esi, [esp]
       test  esi, esi
       jz    @Found
@String:
       movzx ebx, word ptr [esi+eax]
       cmp   bx, word ptr [esi+edx+1]
       jnz   @AfterTestT
       cmp   esi, -2
       jge   @Found
       movzx ebx, word ptr [esi+eax+2]
       cmp   bx, word ptr [esi+edx+3]
       jnz   @AfterTestT
       add   esi, 4
       jl    @String
@Found:
       mov   eax, [esp+4]
       add   edx, 2

       cmp   edx, [esp+8]
       ja    @Exit

       add   esp, 12
       add   eax, edx
       pop   ebx
       pop   esi
       end;


initialization
 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;

end.
