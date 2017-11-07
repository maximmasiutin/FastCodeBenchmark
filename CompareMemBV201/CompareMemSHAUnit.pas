unit CompareMemSHAUnit;

interface

function CompareMem_Sha_Pas_4_a(p1, p2: pointer; length: integer): boolean;
function CompareMem_Sha_Pas_4_b(p1, p2: pointer; length: integer): boolean;
function CompareMem_Sha_Pas_4_c(p1, p2: pointer; length: integer): boolean;
function CompareMem_Sha_Pas_4_d(p1, p2: pointer; length: integer): boolean;
function CompareMem_Sha_IA32_4_a(P1, P2: pointer; Length: integer): boolean;
function CompareMem_Sha_IA32_4_b(P1, P2: pointer; Length: integer): boolean;
function CompareMem_Sha_IA32_4_c(P1, P2: pointer; Length: integer): boolean;
function CompareMem_Sha_IA32_4_d(P1, P2: pointer; Length: integer): boolean;
function CompareMem_Sha_IA32_5_a(P1, P2: pointer; Length: integer): boolean;
function CompareMem_Sha_IA32_5_b(P1, P2: pointer; Length: integer): boolean;
function CompareMem_Sha_IA32_5_c(P1, P2: pointer; Length: integer): boolean;
function CompareMem_Sha_IA32_5_d(P1, P2: pointer; Length: integer): boolean;

implementation

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CompareMem_Sha_Pas_4_a(p1, p2: pointer; length: integer): boolean;
var
  q1, q2: pIntegerArray;
  c: cardinal;
label
  Ret0;
begin;
  c:=length;
  c:=c+cardinal(p1)-8;
  q1:=p1;
  q2:=p2;
  if c>=cardinal(q1) then begin;
    if q1[0]<>q2[0] then goto Ret0;
    inc(cardinal(q1),4);
    inc(cardinal(q2),4);
    dec(cardinal(q2),cardinal(q1));
    cardinal(q1):=cardinal(q1) and -4;
    inc(cardinal(q2),cardinal(q1));
    //if c>=cardinal(q1) then repeat;
    //replaced: compiler creates a copy of cardinal(q1) for statement above
    if pchar(c)>=q1 then repeat;
      if q1[0]<>q2[0] then goto Ret0;
      if q1[1]<>q2[1] then goto Ret0;
      inc(cardinal(q1),8);
      inc(cardinal(q2),8);
      if c<cardinal(q1) then break;
      if q1[0]<>q2[0] then goto Ret0;
      if q1[1]<>q2[1] then goto Ret0;
      inc(cardinal(q1),8);
      inc(cardinal(q2),8);
      until c<cardinal(q1);
    end;
  c:=c-cardinal(q1)+8;
  if integer(c)>=4 then begin;
    if q1[0]<>q2[0] then goto Ret0;
    inc(cardinal(q1),4);
    inc(cardinal(q2),4);
    c:=c-4;
    end;
  if integer(c)>=2 then begin;
    if pword(q1)^<>pword(q2)^ then goto Ret0;
    inc(cardinal(q1),2);
    inc(cardinal(q2),2);
    c:=c-2;
    end;
  if integer(c)>=1 then if pchar(q1)^<>pchar(q2)^ then goto Ret0;
  Result:=true;
  exit;
Ret0:
  Result:=false;
  end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CompareMem_Sha_Pas_4_b(p1, p2: pointer; length: integer): boolean;
var
  q1, q2: pIntegerArray;
  c: cardinal;
label
  Ret0;
begin;
  c:=length;
  c:=c+cardinal(p1)-8;
  q1:=p1;
  q2:=p2;
  if c>=cardinal(q1) then begin;
    if q1[0]<>q2[0] then goto Ret0;
    inc(cardinal(q1),4);
    inc(cardinal(q2),4);
    dec(cardinal(q2),cardinal(q1));
    cardinal(q1):=cardinal(q1) and -4;
    inc(cardinal(q2),cardinal(q1));
    //if c>=cardinal(q1) then repeat;
    //replaced: compiler creates a copy of cardinal(q1) for statement above
    if pchar(c)>=q1 then repeat;
      if q1[0]<>q2[0] then goto Ret0;
      if q1[1]<>q2[1] then goto Ret0;
      inc(cardinal(q1),8);
      inc(cardinal(q2),8);
      if c<cardinal(q1) then break;
      if q1[0]<>q2[0] then goto Ret0;
      if q1[1]<>q2[1] then goto Ret0;
      inc(cardinal(q1),8);
      inc(cardinal(q2),8);
      until c<cardinal(q1);
    end;
  c:=c-cardinal(q1)+8;
  if integer(c)>=4 then begin;
    if q1[0]<>q2[0] then goto Ret0;
    inc(cardinal(q1),4);
    inc(cardinal(q2),4);
    c:=c-4;
    end;
  if integer(c)>=2 then begin;
    if pword(q1)^<>pword(q2)^ then goto Ret0;
    inc(cardinal(q1),2);
    inc(cardinal(q2),2);
    c:=c-2;
    end;
  if integer(c)>=1 then if pchar(q1)^<>pchar(q2)^ then goto Ret0;
  Result:=true;
  exit;
Ret0:
  Result:=false;
  end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CompareMem_Sha_Pas_4_c(p1, p2: pointer; length: integer): boolean;
var
  q1, q2: pIntegerArray;
  c: cardinal;
label
  Ret0;
begin;
  c:=length;
  c:=c+cardinal(p1)-8;
  q1:=p1;
  q2:=p2;
  if c>=cardinal(q1) then begin;
    if q1[0]<>q2[0] then goto Ret0;
    inc(cardinal(q1),4);
    inc(cardinal(q2),4);
    dec(cardinal(q2),cardinal(q1));
    cardinal(q1):=cardinal(q1) and -4;
    inc(cardinal(q2),cardinal(q1));
    //if c>=cardinal(q1) then repeat;
    //replaced: compiler creates a copy of cardinal(q1) for statement above
    if pchar(c)>=q1 then repeat;
      if q1[0]<>q2[0] then goto Ret0;
      if q1[1]<>q2[1] then goto Ret0;
      inc(cardinal(q1),8);
      inc(cardinal(q2),8);
      if c<cardinal(q1) then break;
      if q1[0]<>q2[0] then goto Ret0;
      if q1[1]<>q2[1] then goto Ret0;
      inc(cardinal(q1),8);
      inc(cardinal(q2),8);
      until c<cardinal(q1);
    end;
  c:=c-cardinal(q1)+8;
  if integer(c)>=4 then begin;
    if q1[0]<>q2[0] then goto Ret0;
    inc(cardinal(q1),4);
    inc(cardinal(q2),4);
    c:=c-4;
    end;
  if integer(c)>=2 then begin;
    if pword(q1)^<>pword(q2)^ then goto Ret0;
    inc(cardinal(q1),2);
    inc(cardinal(q2),2);
    c:=c-2;
    end;
  if integer(c)>=1 then if pchar(q1)^<>pchar(q2)^ then goto Ret0;
  Result:=true;
  exit;
Ret0:
  Result:=false;
  end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CompareMem_Sha_Pas_4_d(p1, p2: pointer; length: integer): boolean;
var
  q1, q2: pIntegerArray;
  c: cardinal;
label
  Ret0;
begin;
  c:=length;
  c:=c+cardinal(p1)-8;
  q1:=p1;
  q2:=p2;
  if c>=cardinal(q1) then begin;
    if q1[0]<>q2[0] then goto Ret0;
    inc(cardinal(q1),4);
    inc(cardinal(q2),4);
    dec(cardinal(q2),cardinal(q1));
    cardinal(q1):=cardinal(q1) and -4;
    inc(cardinal(q2),cardinal(q1));
    //if c>=cardinal(q1) then repeat;
    //replaced: compiler creates a copy of cardinal(q1) for statement above
    if pchar(c)>=q1 then repeat;
      if q1[0]<>q2[0] then goto Ret0;
      if q1[1]<>q2[1] then goto Ret0;
      inc(cardinal(q1),8);
      inc(cardinal(q2),8);
      if c<cardinal(q1) then break;
      if q1[0]<>q2[0] then goto Ret0;
      if q1[1]<>q2[1] then goto Ret0;
      inc(cardinal(q1),8);
      inc(cardinal(q2),8);
      until c<cardinal(q1);
    end;
  c:=c-cardinal(q1)+8;
  if integer(c)>=4 then begin;
    if q1[0]<>q2[0] then goto Ret0;
    inc(cardinal(q1),4);
    inc(cardinal(q2),4);
    c:=c-4;
    end;
  if integer(c)>=2 then begin;
    if pword(q1)^<>pword(q2)^ then goto Ret0;
    inc(cardinal(q1),2);
    inc(cardinal(q2),2);
    c:=c-2;
    end;
  if integer(c)>=1 then if pchar(q1)^<>pchar(q2)^ then goto Ret0;
  Result:=true;
  exit;
Ret0:
  Result:=false;
  end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

function CompareMem_Sha_IA32_4_a(P1, P2: pointer; Length: integer): boolean;
asm
   add   eax, ecx
   add   edx, ecx
   xor   ecx, -1
   add   eax, -8
   add   edx, -8
   add   ecx, 9
   push  ebx
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   lea   ebx, [eax+ecx]
   add   ecx, 4
   and   ebx, 3
   sub   ecx, ebx
   jg    @Dword
@DwordLoop:
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jle   @DwordLoop
@Dword:
   cmp   ecx, 4
   jg    @Word
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   add   ecx, 4
@Word:
   cmp   ecx, 6
   jg    @Byte
   movzx ebx, word ptr [eax+ecx]
   cmp   bx, [edx+ecx]
   jne   @Ret0
   add   ecx, 2
@Byte:
   cmp   ecx, 7
   jg    @Ret1
   movzx ebx, byte ptr [eax+7]
   cmp   bl, [edx+7]
   jne   @Ret0
@Ret1:
   mov   eax, 1
   pop   ebx
   ret
@Ret0:
   xor   eax, eax
   pop   ebx
   end;

function CompareMem_Sha_IA32_4_b(P1, P2: pointer; Length: integer): boolean;
asm
   add   eax, ecx
   add   edx, ecx
   xor   ecx, -1
   add   eax, -8
   add   edx, -8
   add   ecx, 9
   push  ebx
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   lea   ebx, [eax+ecx]
   add   ecx, 4
   and   ebx, 3
   sub   ecx, ebx
   jg    @Dword
@DwordLoop:
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jle   @DwordLoop
@Dword:
   cmp   ecx, 4
   jg    @Word
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   add   ecx, 4
@Word:
   cmp   ecx, 6
   jg    @Byte
   movzx ebx, word ptr [eax+ecx]
   cmp   bx, [edx+ecx]
   jne   @Ret0
   add   ecx, 2
@Byte:
   cmp   ecx, 7
   jg    @Ret1
   movzx ebx, byte ptr [eax+7]
   cmp   bl, [edx+7]
   jne   @Ret0
@Ret1:
   mov   eax, 1
   pop   ebx
   ret
@Ret0:
   xor   eax, eax
   pop   ebx
   end;

function CompareMem_Sha_IA32_4_c(P1, P2: pointer; Length: integer): boolean;
asm
   add   eax, ecx
   add   edx, ecx
   xor   ecx, -1
   add   eax, -8
   add   edx, -8
   add   ecx, 9
   push  ebx
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   lea   ebx, [eax+ecx]
   add   ecx, 4
   and   ebx, 3
   sub   ecx, ebx
   jg    @Dword
@DwordLoop:
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jle   @DwordLoop
@Dword:
   cmp   ecx, 4
   jg    @Word
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   add   ecx, 4
@Word:
   cmp   ecx, 6
   jg    @Byte
   movzx ebx, word ptr [eax+ecx]
   cmp   bx, [edx+ecx]
   jne   @Ret0
   add   ecx, 2
@Byte:
   cmp   ecx, 7
   jg    @Ret1
   movzx ebx, byte ptr [eax+7]
   cmp   bl, [edx+7]
   jne   @Ret0
@Ret1:
   mov   eax, 1
   pop   ebx
   ret
@Ret0:
   xor   eax, eax
   pop   ebx
   end;

function CompareMem_Sha_IA32_4_d(P1, P2: pointer; Length: integer): boolean;
asm
   add   eax, ecx
   add   edx, ecx
   xor   ecx, -1
   add   eax, -8
   add   edx, -8
   add   ecx, 9
   push  ebx
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   lea   ebx, [eax+ecx]
   add   ecx, 4
   and   ebx, 3
   sub   ecx, ebx
   jg    @Dword
@DwordLoop:
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jg    @Dword
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   mov   ebx, [eax+ecx+4]
   cmp   ebx, [edx+ecx+4]
   jne   @Ret0
   add   ecx, 8
   jle   @DwordLoop
@Dword:
   cmp   ecx, 4
   jg    @Word
   mov   ebx, [eax+ecx]
   cmp   ebx, [edx+ecx]
   jne   @Ret0
   add   ecx, 4
@Word:
   cmp   ecx, 6
   jg    @Byte
   movzx ebx, word ptr [eax+ecx]
   cmp   bx, [edx+ecx]
   jne   @Ret0
   add   ecx, 2
@Byte:
   cmp   ecx, 7
   jg    @Ret1
   movzx ebx, byte ptr [eax+7]
   cmp   bl, [edx+7]
   jne   @Ret0
@Ret1:
   mov   eax, 1
   pop   ebx
   ret
@Ret0:
   xor   eax, eax
   pop   ebx
   end;

function CompareMem_Sha_IA32_5_a(P1, P2: pointer; Length: integer): boolean;
asm
   sub   edx, eax
   add   ecx, -8
   push  ebx
   jl    @Dword
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   add   ecx, eax
   add   eax, 4
   and   eax, -4
   sub   ecx, eax
   jl    @Dword
@DwordLoop:
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   mov   ebx, [eax+edx+4]
   cmp   ebx, [eax+4]
   jne   @Ret0
   add   eax, 8
   add   ecx, -8
   jl    @Dword
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   mov   ebx, [eax+edx+4]
   cmp   ebx, [eax+4]
   jne   @Ret0
   add   eax, 8
   add   ecx, -8
   jge   @DwordLoop
@Dword:
   add   ecx, 4
   jl    @Word
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   add   eax, 4
   add   ecx, -4
@Word:
   add   ecx, 2
   jl    @Byte
   movzx ebx, word ptr [eax+edx]
   cmp   bx, [eax]
   jne   @Ret0
   add   eax, 2
   add   ecx, -2
@Byte:
   add   ecx, 1
   jl    @Ret1
   movzx ebx, byte ptr [eax+edx]
   cmp   bl, [eax]
   jne   @Ret0
@Ret1:
   mov   eax, 1
   pop   ebx
   ret
@Ret0:
   xor   eax, eax
   pop   ebx
   end;

function CompareMem_Sha_IA32_5_b(P1, P2: pointer; Length: integer): boolean;
asm
   sub   edx, eax
   add   ecx, -8
   push  ebx
   jl    @Dword
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   add   ecx, eax
   add   eax, 4
   and   eax, -4
   sub   ecx, eax
   jl    @Dword
@DwordLoop:
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   mov   ebx, [eax+edx+4]
   cmp   ebx, [eax+4]
   jne   @Ret0
   add   eax, 8
   add   ecx, -8
   jl    @Dword
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   mov   ebx, [eax+edx+4]
   cmp   ebx, [eax+4]
   jne   @Ret0
   add   eax, 8
   add   ecx, -8
   jge   @DwordLoop
@Dword:
   add   ecx, 4
   jl    @Word
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   add   eax, 4
   add   ecx, -4
@Word:
   add   ecx, 2
   jl    @Byte
   movzx ebx, word ptr [eax+edx]
   cmp   bx, [eax]
   jne   @Ret0
   add   eax, 2
   add   ecx, -2
@Byte:
   add   ecx, 1
   jl    @Ret1
   movzx ebx, byte ptr [eax+edx]
   cmp   bl, [eax]
   jne   @Ret0
@Ret1:
   mov   eax, 1
   pop   ebx
   ret
@Ret0:
   xor   eax, eax
   pop   ebx
   end;

function CompareMem_Sha_IA32_5_c(P1, P2: pointer; Length: integer): boolean;
asm
   sub   edx, eax
   add   ecx, -8
   push  ebx
   jl    @Dword
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   add   ecx, eax
   add   eax, 4
   and   eax, -4
   sub   ecx, eax
   jl    @Dword
@DwordLoop:
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   mov   ebx, [eax+edx+4]
   cmp   ebx, [eax+4]
   jne   @Ret0
   add   eax, 8
   add   ecx, -8
   jl    @Dword
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   mov   ebx, [eax+edx+4]
   cmp   ebx, [eax+4]
   jne   @Ret0
   add   eax, 8
   add   ecx, -8
   jge   @DwordLoop
@Dword:
   add   ecx, 4
   jl    @Word
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   add   eax, 4
   add   ecx, -4
@Word:
   add   ecx, 2
   jl    @Byte
   movzx ebx, word ptr [eax+edx]
   cmp   bx, [eax]
   jne   @Ret0
   add   eax, 2
   add   ecx, -2
@Byte:
   add   ecx, 1
   jl    @Ret1
   movzx ebx, byte ptr [eax+edx]
   cmp   bl, [eax]
   jne   @Ret0
@Ret1:
   mov   eax, 1
   pop   ebx
   ret
@Ret0:
   xor   eax, eax
   pop   ebx
   end;

function CompareMem_Sha_IA32_5_d(P1, P2: pointer; Length: integer): boolean;
asm
   sub   edx, eax
   add   ecx, -8
   push  ebx
   jl    @Dword
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   add   ecx, eax
   add   eax, 4
   and   eax, -4
   sub   ecx, eax
   jl    @Dword
@DwordLoop:
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   mov   ebx, [eax+edx+4]
   cmp   ebx, [eax+4]
   jne   @Ret0
   add   eax, 8
   add   ecx, -8
   jl    @Dword
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   mov   ebx, [eax+edx+4]
   cmp   ebx, [eax+4]
   jne   @Ret0
   add   eax, 8
   add   ecx, -8
   jge   @DwordLoop
@Dword:
   add   ecx, 4
   jl    @Word
   mov   ebx, [eax+edx]
   cmp   ebx, [eax]
   jne   @Ret0
   add   eax, 4
   add   ecx, -4
@Word:
   add   ecx, 2
   jl    @Byte
   movzx ebx, word ptr [eax+edx]
   cmp   bx, [eax]
   jne   @Ret0
   add   eax, 2
   add   ecx, -2
@Byte:
   add   ecx, 1
   jl    @Ret1
   movzx ebx, byte ptr [eax+edx]
   cmp   bl, [eax]
   jne   @Ret0
@Ret1:
   mov   eax, 1
   pop   ebx
   ret
@Ret0:
   xor   eax, eax
   pop   ebx
   end;

end.
