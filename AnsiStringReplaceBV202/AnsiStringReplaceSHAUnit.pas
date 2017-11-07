unit AnsiStringReplaceSHAUnit;

interface

uses
 SysUtils;

function StringReplace_SHA_IA32_1(const S, OldPattern, NewPattern: AnsiString;
  Flags: TReplaceFlags): AnsiString;

implementation

var
  AnsiUpperCaseTable: array[0..255] of char;

procedure InitAnsiUpperCaseTable;
var
  s: string;
  i: integer;
begin;
  SetLength(s,255);
  for i:=1 to 255 do pchar(pointer(s))[i-1]:=chr(i);

  s:=AnsiUpperCase(s);
  for i:=1 to 255 do AnsiUpperCaseTable[i]:=pchar(pointer(s))[i-1];

  AnsiUpperCaseTable[0]:=#0;
  end;

//Based on PosShaAsm5 by Sha
function ShaPosEx(const SubStr, Str: string; Offset: integer): integer;
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

//Based on PosShaAsm5 by Sha
function ShaPosExSpec(const SubStr, Str: string; Offset: integer): integer;
asm //Substr must be AnsiUpperCased
       test  ecx, ecx
       push  ebx
       push  esi
       push  edi
       lea   edi, AnsiUpperCaseTable
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
       //cmp   cl, [edx]
       movzx ebx, [edx]
       cmp   cl, [edi+ebx]
       jz    @Matched0ch
       //cmp   cl, [edx+1]
       movzx ebx, [edx+1];
       cmp   cl, [edi+ebx]
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
       //cmp   cl, [edx]
       movzx ebx, [edx]
       cmp   cl, [edi+ebx]
       jz    @Matched0ch
       //cmp   cl, [edx+1]
       movzx ebx, [edx+1]
       cmp   cl, [edi+ebx]
       jz    @Matched1ch
       //cmp   cl, [edx+2]
       movzx ebx, [edx+2]
       cmp   cl, [edi+ebx]
       jz    @Matched2ch
       //cmp   cl, [edx+3]
       movzx ebx, [edx+3]
       cmp   cl, [edi+ebx]
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
       pop   edi
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
       pop   edi
       pop   esi
       pop   ebx
       ret

@Test2:
       add   edx,2
@Test0:
       mov   esi, [esp]
@Loop0:
       //movzx ebx, word ptr [esi+eax]
       //cmp   bx, word ptr [esi+edx]
       movzx ebx, [esi+edx]
       mov   ch, [esi+eax]
       cmp   ch, [edi+ebx]
       jnz   @AfterTest0
       movzx ebx, [esi+edx+1]
       mov   ch, [esi+eax+1]
       cmp   ch, [edi+ebx]
       jnz   @AfterTest0
       add   esi, 2
       jl    @Loop0
       inc   edx
@RetCode0:
       mov   eax, edx
       add   eax, [esp+4]
       add   esp, 16
       pop   edi
       pop   esi
       pop   ebx
       ret

@FindString4:
       //cmp   cl, [edx]
       movzx ebx, [edx]
       cmp   cl, [edi+ebx]
       jz    @Test0
       //cmp   cl, [edx+1]
       movzx ebx, [edx+1]
       cmp   cl, [edi+ebx]
       jz    @Test1
       //cmp   cl, [edx+2]
       movzx ebx, [edx+2]
       cmp   cl, [edi+ebx]
       jz    @Test2
       //cmp   cl, [edx+3]
       movzx ebx, [edx+3]
       cmp   cl, [edi+ebx]
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
       //cmp   cl, [edx]
       movzx ebx, [edx]
       cmp   cl, [edi+ebx]
       jz    @Test0
@AfterTest0:
       //cmp   cl, [edx+1]
       movzx ebx, [edx+1]
       cmp   cl, [edi+ebx]
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
       //movzx ebx, word ptr [esi+eax]
       //cmp   bx, word ptr [esi+edx+1]
       movzx ebx, [esi+edx+1]
       mov   ch, [esi+eax]
       cmp   ch, [edi+ebx]
       jnz   @AfterTest1
       movzx ebx, [esi+edx+2]
       mov   ch, [esi+eax+1]
       cmp   ch, [edi+ebx]
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
       pop   edi
       pop   esi
       pop   ebx
       end;

//Based on System.Move by Borland
procedure ShaMoveSpec(const Source; var Dest; count: integer);
asm
       push  esi
       push  edi

       mov   esi, eax
       mov   eax, ecx
       sar   ecx, 2
       mov   edi, edx

       rep   movsd

       and   eax, 3
       mov   ecx, eax

       rep   movsb

       pop   edi
       pop   esi
       end;

//Based on Q_ReplaceStr from QStrings library by Andrew N. Driazgov
function ShaReplace(const s, OldPattern, NewPattern: AnsiString;
  Flags: TReplaceFlags): string;
var
  p, ps: pchar;
  lenOld, lenNew, cnt, i, j: integer;
begin;
  lenOld:=Length(OldPattern);
  cnt:=0;
  i:=1;
  repeat;
    i:=ShaPosEx(OldPattern, s, i);
    if i=0 then break;
    inc(i, lenOld);
    inc(cnt);
    asm push i end;
    until not (rfReplaceAll in Flags);

  j:=Length(s);
  if cnt=0
  then if j=0
       then Result:=''
       else Result:=s
  else begin;
    lenNew:=Length(NewPattern);
    i:=j+(lenNew-lenOld)*cnt;
    if i=0
    then Result:=''
    else begin;
      SetString(Result, nil, i);
      p:=pointer(Result);
      ps:=pointer(s);
      inc(p, i);
      dec(ps);
      j:=j+1;
      repeat;
        dec(cnt);
        asm pop i end;
        j:=j-i;
        dec(p, j);
        ShaMoveSpec(ps[i], p^, j);
        dec(p, lenNew);
        ShaMoveSpec(pointer(NewPattern)^, p^, lenNew);
        j:=i-lenOld;
        until cnt=0;
      dec(j);
      if j>0 then ShaMoveSpec(pointer(s)^, pointer(Result)^, j);
      end;
    end;
  end;

//Based on Q_ReplaceStr from QStrings library by Andrew N. Driazgov
function ShaReplaceSpec(const s, OldPattern, NewPattern: AnsiString;
  Flags: TReplaceFlags): string;
var
  p, ps: pchar;
  lenOld, lenNew, cnt, i, j: integer;
begin;
  lenOld:=Length(OldPattern);
  cnt:=0;
  i:=1;
  repeat;
    i:=ShaPosExSpec(OldPattern, s, i);
    if i=0 then break;
    inc(i, lenOld);
    inc(cnt);
    asm push i end;
    until not (rfReplaceAll in Flags);

  j:=Length(s);
  if cnt=0
  then if j=0
       then Result:=''
       else Result:=s
  else begin;
    lenNew:=Length(NewPattern);
    i:=j+(lenNew-lenOld)*cnt;
    if i=0
    then Result:=''
    else begin;
      SetString(Result, nil, i);
      p:=pointer(Result);
      ps:=pointer(s);
      inc(p, i);
      dec(ps);
      j:=j+1;
      repeat;
        dec(cnt);
        asm pop i end;
        j:=j-i;
        dec(p, j);
        ShaMoveSpec(ps[i], p^, j);
        dec(p, lenNew);
        ShaMoveSpec(pointer(NewPattern)^, p^, lenNew);
        j:=i-lenOld;
        until cnt=0;
      dec(j);
      if j>0 then ShaMoveSpec(pointer(s)^, pointer(Result)^, j);
      end;
    end;
  end;

function StringReplace_SHA_IA32_1(const S, OldPattern, NewPattern: AnsiString;
  Flags: TReplaceFlags): AnsiString;
begin;
  if rfIgnoreCase in Flags
  then Result:=ShaReplaceSpec(s, AnsiUpperCase(OldPattern), NewPattern, Flags)
  else Result:=ShaReplace(s, OldPattern, NewPattern, Flags);
  end;

initialization
  InitAnsiUpperCaseTable;
end.

