unit StrICompDFL;

interface

function StrIComp_DFL_Pas_1_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_2_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_3_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_4_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_5_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_6_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_7_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_8_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_9_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_10_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_10_b(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_10_c(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_10_d(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_11_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_12_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_13_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_14_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_IA32_15_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_16_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_17_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_18_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_19_a(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_19_b(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_19_c(const Str1, Str2: PChar): Integer;
function StrIComp_DFL_Pas_19_d(const Str1, Str2: PChar): Integer;//+

implementation

uses
 SysUtils, Math;

var
 LookUpTable : array of Char;

function StrIComp_DFL_Pas_1_a(const Str1, Str2: PChar): Integer;//+
var
 StrLen1, StrLen2 : Integer;
 AnsiStr1, AnsiStr2 : Ansistring;

begin
 StrLen1 := Length(Str1);
 StrLen2 := Length(Str2);
 if (StrLen1 = 0) and (StrLen2 = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (StrLen1 = 0) then
  begin
   Result := -1;
   Exit;
  end;
 if (StrLen2 = 0) then
  begin
   Result := 1;
   Exit;
  end;
 SetLength(AnsiStr1,StrLen1);
 SetLength(AnsiStr2,StrLen2);
 Move(Str1^,AnsiStr1[1],StrLen1);
 Move(Str2^,AnsiStr2[1],StrLen2);
 AnsiStr1 := UpperCase(AnsiStr1);
 AnsiStr2 := UpperCase(AnsiStr2);
 if AnsiStr1 > AnsiStr2 then
  Result := 1
 else if AnsiStr1 < AnsiStr2 then
  Result := -1
 else
  Result := 0;
end;

function StrIComp_DFL_Pas_2_a(const Str1, Str2: PChar): Integer;//+
var
 StrLen1, StrLen2 : Integer;
 AnsiStr1, AnsiStr2 : Ansistring;

begin
 StrLen1 := StrLen(Str1);
 StrLen2 := StrLen(Str2);
 if (StrLen1 = 0) and (StrLen2 = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (StrLen1 = 0) then
  begin
   Result := -1;
   Exit;
  end;
 if (StrLen2 = 0) then
  begin
   Result := 1;
   Exit;
  end;
 SetLength(AnsiStr1,StrLen1);
 SetLength(AnsiStr2,StrLen2);
 Move(Str1^,AnsiStr1[1],StrLen1);
 Move(Str2^,AnsiStr2[1],StrLen2);
 AnsiStr1 := UpperCase(AnsiStr1);
 AnsiStr2 := UpperCase(AnsiStr2);
 if AnsiStr1 > AnsiStr2 then
  Result := 1
 else if AnsiStr1 < AnsiStr2 then
  Result := -1
 else
  Result := 0;
end;

function StrLen_JOH_IA32_7_a(const Str: PChar): Cardinal;
asm
  cmp   byte ptr [eax], 0
  je    @@0
  cmp   byte ptr [eax+1], 0
  je    @@1
  cmp   byte ptr [eax+2], 0
  je    @@2
  cmp   byte ptr [eax+3], 0
  je    @@3
  push  eax
  and   eax, -4              {DWORD Align Reads}
@@Loop:
  add   eax, 4
  mov   edx, [eax]           {4 Chars per Loop}
  lea   ecx, [edx-$01010101]
  not   edx
  and   edx, ecx
  and   edx, $80808080       {Set Byte to $80 at each #0 Position}
  jz    @@Loop               {Loop until any #0 Found}
@@SetResult:
  pop   ecx
  bsf   edx, edx             {Find First #0 Position}
  shr   edx, 3               {Byte Offset of First #0}
  add   eax, edx             {Address of First #0}
  sub   eax, ecx
  ret
@@0:
  xor   eax, eax
  ret
@@1:
  mov   eax, 1
  ret
@@2:
  mov   eax, 2
  ret
@@3:
  mov   eax, 3
end;

function StrIComp_DFL_Pas_3_a(const Str1, Str2: PChar): Integer;//+
var
 StrLen1, StrLen2 : Integer;
 AnsiStr1, AnsiStr2 : Ansistring;

begin
 StrLen1 := StrLen_JOH_IA32_7_a(Str1);
 StrLen2 := StrLen_JOH_IA32_7_a(Str2);
 if (StrLen1 = 0) and (StrLen2 = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (StrLen1 = 0) then
  begin
   Result := -1;
   Exit;
  end;
 if (StrLen2 = 0) then
  begin
   Result := 1;
   Exit;
  end;
 SetLength(AnsiStr1,StrLen1);
 SetLength(AnsiStr2,StrLen2);
 Move(Str1^,AnsiStr1[1],StrLen1);
 Move(Str2^,AnsiStr2[1],StrLen2);
 AnsiStr1 := UpperCase(AnsiStr1);
 AnsiStr2 := UpperCase(AnsiStr2);
 if AnsiStr1 > AnsiStr2 then
  Result := 1
 else if AnsiStr1 < AnsiStr2 then
  Result := -1
 else
  Result := 0;
end;

procedure MoveJOH_RTL_1(const Source; var Dest; Count : Integer);
asm  {Small (253 Byte) RTL Replacement Candidate}
  cmp     eax, edx
  je      @@Exit {Source = Dest}
  cmp     ecx, 32
  ja      @@LargeMove {Count > 32 or Count < 0}
  sub     ecx, 8
  jg      @@SmallMove
@@TinyMove: {0..8 Byte Move}
  jmp     dword ptr [@@JumpTable+32+ecx*4]
@@SmallMove: {9..32 Byte Move}
  fild    qword ptr [eax+ecx] {Load Last 8}
  fild    qword ptr [eax] {Load First 8}
  cmp     ecx, 8
  jle     @@Small16
  fild    qword ptr [eax+8] {Load Second 8}
  cmp     ecx, 16
  jle     @@Small24
  fild    qword ptr [eax+16] {Load Third 8}
  fistp   qword ptr [edx+16] {Save Third 8}
@@Small24:
  fistp   qword ptr [edx+8] {Save Second 8}
@@Small16:
  fistp   qword ptr [edx] {Save First 8}
  fistp   qword ptr [edx+ecx] {Save Last 8}
@@Exit:
  ret
  nop {4-Byte Align JumpTable}
  nop
@@JumpTable: {4-Byte Aligned}
  dd      @@Exit, @@M01, @@M02, @@M03, @@M04, @@M05, @@M06, @@M07, @@M08
@@LargeForwardMove: {4-Byte Aligned}
  push    edx
  fild    qword ptr [eax] {First 8}
  lea     eax, [eax+ecx-8]
  lea     ecx, [ecx+edx-8]
  fild    qword ptr [eax] {Last 8}
  push    ecx
  neg     ecx
  and     edx, -8 {8-Byte Align Writes}
  lea     ecx, [ecx+edx+8]
  pop     edx
@FwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  add     ecx, 8
  jl      @FwdLoop
  fistp   qword ptr [edx] {Last 8}
  pop     edx
  fistp   qword ptr [edx] {First 8}
  ret
@@LargeMove:
  jng     @@LargeDone {Count < 0}
  cmp     eax, edx
  ja      @@LargeForwardMove
  sub     edx, ecx
  cmp     eax, edx
  lea     edx, [edx+ecx]
  jna     @@LargeForwardMove
  sub     ecx, 8 {Backward Move}
  push    ecx
  fild    qword ptr [eax+ecx] {Last 8}
  fild    qword ptr [eax] {First 8}
  add     ecx, edx
  and     ecx, -8 {8-Byte Align Writes}
  sub     ecx, edx
@BwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  sub     ecx, 8
  jg      @BwdLoop
  pop     ecx
  fistp   qword ptr [edx] {First 8}
  fistp   qword ptr [edx+ecx] {Last 8}
@@LargeDone:
  ret
@@M01:
  movzx   ecx, [eax]
  mov     [edx], cl
  ret
@@M02:
  movzx   ecx, word ptr [eax]
  mov     [edx], cx
  ret
@@M03:
  mov     cx, [eax]
  mov     al, [eax+2]
  mov     [edx], cx
  mov     [edx+2], al
  ret
@@M04:
  mov     ecx, [eax]
  mov     [edx], ecx
  ret
@@M05:
  mov     ecx, [eax]
  mov     al, [eax+4]
  mov     [edx], ecx
  mov     [edx+4], al
  ret
@@M06:
  mov     ecx, [eax]
  mov     ax, [eax+4]
  mov     [edx], ecx
  mov     [edx+4], ax
  ret
@@M07:
  mov     ecx, [eax]
  mov     eax, [eax+3]
  mov     [edx], ecx
  mov     [edx+3], eax
  ret
@@M08:
  fild    qword ptr [eax]
  fistp   qword ptr [edx]
end; {MoveJOH_IA32}

function StrIComp_DFL_Pas_4_a(const Str1, Str2: PChar): Integer;//+
var
 StrLen1, StrLen2 : Integer;
 AnsiStr1, AnsiStr2 : Ansistring;

begin
 StrLen1 := StrLen_JOH_IA32_7_a(Str1);
 StrLen2 := StrLen_JOH_IA32_7_a(Str2);
 if (StrLen1 = 0) and (StrLen2 = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (StrLen1 = 0) then
  begin
   Result := -1;
   Exit;
  end;
 if (StrLen2 = 0) then
  begin
   Result := 1;
   Exit;
  end;
 SetLength(AnsiStr1,StrLen1);
 SetLength(AnsiStr2,StrLen2);
 MoveJOH_RTL_1(Str1^,AnsiStr1[1],StrLen1);
 MoveJOH_RTL_1(Str2^,AnsiStr2[1],StrLen2);
 AnsiStr1 := UpperCase(AnsiStr1);
 AnsiStr2 := UpperCase(AnsiStr2);
 if AnsiStr1 > AnsiStr2 then
  Result := 1
 else if AnsiStr1 < AnsiStr2 then
  Result := -1
 else
  Result := 0;
end;

function UpperCaseShaAsm6_a(const s: string): string;
asm
       push  ebx
       push  esi
       push  edi
       mov   esi, eax          // s
       mov   eax, edx
       test  esi, esi
       jz    @Nil
       mov   edx, [esi-4]      // Length(s)
       mov   edi, eax          // @Result
       test  edx, edx
       jle   @Nil
       mov   ecx, [eax]
       mov   ebx, edx
       test  ecx, ecx
       jz    @Realloc          // Jump if Result not allocated
       test  edx, 3
       jnz   @Length3
       xor   edx, [ecx-4]
       cmp   edx, 3
       jbe   @TestRef
       jmp   @Realloc
@Length3:
       or    edx, 2
       xor   edx, [ecx-4]
       cmp   edx, 1
       ja    @Realloc
@TestRef:
       cmp   [ecx-8], 1
       je    @LengthOK         // Jump if Result RefCt=1
@Realloc:
       mov   edx, ebx
       or    edx, 3
       call  System.@LStrSetLength
@LengthOK:
       mov   edi, [edi]        // Result
       mov   [edi-4], ebx      // Correct Result length
       mov   byte ptr [ebx+edi], 0
       add   ebx, -1
       and   ebx, -4
       mov   eax, [ebx+esi]

@Loop: mov   ecx, eax
       or    eax, $80808080    // $E1..$FA
       mov   edx, eax
       sub   eax, $7B7B7B7B    // $66..$7F
       xor   edx, ecx          // $80
       or    eax, $80808080    // $E6..$FF
       sub   eax, $66666666    // $80..$99
       and   eax, edx          // $80
       shr   eax, 2            // $20
       xor   eax, ecx          // Upper
       mov   [ebx+edi], eax
       mov   eax, [ebx+esi-4]
       sub   ebx, 4
       jge   @Loop

       pop   edi
       pop   esi
       pop   ebx
       ret

@Nil:  pop   edi
       pop   esi
       pop   ebx
       jmp    System.@LStrClr   // Result:=''
       end;

function StrIComp_DFL_Pas_5_a(const Str1, Str2: PChar): Integer;//+
var
 StrLen1, StrLen2 : Integer;
 AnsiStr1, AnsiStr2 : Ansistring;

begin
 StrLen1 := StrLen_JOH_IA32_7_a(Str1);
 StrLen2 := StrLen_JOH_IA32_7_a(Str2);
 if (StrLen1 = 0) and (StrLen2 = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (StrLen1 = 0) then
  begin
   Result := -1;
   Exit;
  end;
 if (StrLen2 = 0) then
  begin
   Result := 1;
   Exit;
  end;
 SetLength(AnsiStr1,StrLen1);
 SetLength(AnsiStr2,StrLen2);
 MoveJOH_RTL_1(Str1^,AnsiStr1[1],StrLen1);
 MoveJOH_RTL_1(Str2^,AnsiStr2[1],StrLen2);
 AnsiStr1 := UpperCaseShaAsm6_a(AnsiStr1);
 AnsiStr2 := UpperCaseShaAsm6_a(AnsiStr2);
 if AnsiStr1 > AnsiStr2 then
  Result := 1
 else if AnsiStr1 < AnsiStr2 then
  Result := -1
 else
  Result := 0;
end;

function StrIComp_DFL_Pas_6_a(const Str1, Str2: PChar): Integer;//+
var
 StrLen1, StrLen2 : Integer;
 AnsiStr1, AnsiStr2, SubAnsiStr1, SubAnsiStr2 : Ansistring;
 i, MinLen : Cardinal;

begin
 StrLen1 := StrLen_JOH_IA32_7_a(Str1);
 StrLen2 := StrLen_JOH_IA32_7_a(Str2);
 if (StrLen1 = 0) and (StrLen2 = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (StrLen1 = 0) then
  begin
   Result := -1;
   Exit;
  end;
 if (StrLen2 = 0) then
  begin
   Result := 1;
   Exit;
  end;
 SetLength(AnsiStr1,StrLen1);
 SetLength(AnsiStr2,StrLen2);
 MoveJOH_RTL_1(Str1^,AnsiStr1[1],StrLen1);
 MoveJOH_RTL_1(Str2^,AnsiStr2[1],StrLen2);
 MinLen := Min(StrLen1,StrLen2);

 for i := 1 to MinLen do
 begin
  SubAnsiStr1 := AnsiStr1[i];
  SubAnsiStr2 := AnsiStr2[i];
  SubAnsiStr1 := UpperCaseShaAsm6_a(SubAnsiStr1);
  SubAnsiStr2 := UpperCaseShaAsm6_a(SubAnsiStr2);
  if SubAnsiStr1 > SubAnsiStr2 then
   begin
    Result := 1;
    Exit;
   end
  else if SubAnsiStr1 < SubAnsiStr2 then
   begin
    Result := -1;
    Exit;
   end;
  end;
 if StrLen1 > StrLen2 then
  Result := 1
 else if StrLen1 < StrLen2 then
  Result := -1
 else
  Result := 0;
end;

function UpperChar_DFL(Str: Char): Char;
var
 AsciiNum : Cardinal;

begin
 AsciiNum := Ord(Str);
 if (97 <= AsciiNum) and (AsciiNum <= 122) then
  Result := Chr(AsciiNum - 32)
 else
  Result := Str;
end;

function StrIComp_DFL_Pas_7_a(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 i : Cardinal;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 i := 0;
 Result := 0;
 repeat
  SubStr1 := Str1[i];
  SubStr2 := Str2[i];

  if (SubStr1 = #0) and (SubStr2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (SubStr1 <> #0) and (SubStr2 = #0) then
   begin
    Result := 1;
    Break;
   end;

  SubStr1 := UpperChar_DFL(SubStr1);
  SubStr2 := UpperChar_DFL(SubStr2);

  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Break;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(i);
 until ((SubStr1 = #0) and (SubStr2 = #0));
end;

function UpperChar_DFL_2(Str: Char): Char; // inline;
var
 AsciiNum : Cardinal;

begin
 AsciiNum := Ord(Str);
 if (97 <= AsciiNum) and (AsciiNum <= 122) then
  Result := Chr(AsciiNum - 32)
 else
  Result := Str;
end;

function StrIComp_DFL_Pas_8_a(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 i : Cardinal;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 i := 0;
 Result := 0;
 repeat
  SubStr1 := Str1[i];
  SubStr2 := Str2[i];

  if (SubStr1 = #0) and (SubStr2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (SubStr1 <> #0) and (SubStr2 = #0) then
   begin
    Result := 1;
    Break;
   end;

  SubStr1 := UpperChar_DFL_2(SubStr1);
  SubStr2 := UpperChar_DFL_2(SubStr2);

  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Break;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(i);
 until ((SubStr1 = #0) and (SubStr2 = #0));
end;

function StrIComp_DFL_Pas_9_a(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 i, AsciiNum : Cardinal;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 i := 0;
 Result := 0;
 repeat
  SubStr1 := Str1[i];
  SubStr2 := Str2[i];

  if (SubStr1 = #0) and (SubStr2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (SubStr1 <> #0) and (SubStr2 = #0) then
   begin
    Result := 1;
    Break;
   end;

//  SubStr1 := UpperChar_DFL_2(SubStr1);
 AsciiNum := Ord(SubStr1);
 if (97 <= AsciiNum) and (AsciiNum <= 122) then
  SubStr1 := Chr(AsciiNum - 32)
 else
  SubStr1 := SubStr1;
//  SubStr2 := UpperChar_DFL_2(SubStr2);
 AsciiNum := Ord(SubStr2);
 if (97 <= AsciiNum) and (AsciiNum <= 122) then
  SubStr2 := Chr(AsciiNum - 32)
 else
  SubStr2 := SubStr2;

  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Break;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(i);
 until ((SubStr1 = #0) and (SubStr2 = #0));
end;

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

function StrIComp_DFL_Pas_10_a(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 i : Cardinal;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 i := 0;
 Result := 0;
 repeat
  SubStr1 := Str1[i];
  SubStr2 := Str2[i];

  if (SubStr1 = #0) and (SubStr2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (SubStr1 <> #0) and (SubStr2 = #0) then
   begin
    Result := 1;
    Break;
   end;

//  SubStr1 := UpperChar_DFL_2(SubStr1);
  SubStr1 := LookUpTable[Ord(SubStr1)];
//  SubStr2 := UpperChar_DFL_2(SubStr2);
  SubStr2 := LookUpTable[Ord(SubStr2)];

  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Break;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(i);
 until ((SubStr1 = #0) and (SubStr2 = #0));
end;

function StrIComp_DFL_Pas_10_b(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 i : Cardinal;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 i := 0;
 Result := 0;
 repeat
  SubStr1 := Str1[i];
  SubStr2 := Str2[i];

  if (SubStr1 = #0) and (SubStr2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (SubStr1 <> #0) and (SubStr2 = #0) then
   begin
    Result := 1;
    Break;
   end;

//  SubStr1 := UpperChar_DFL_2(SubStr1);
  SubStr1 := LookUpTable[Ord(SubStr1)];
//  SubStr2 := UpperChar_DFL_2(SubStr2);
  SubStr2 := LookUpTable[Ord(SubStr2)];

  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Break;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(i);
 until ((SubStr1 = #0) and (SubStr2 = #0));
end;

function StrIComp_DFL_Pas_10_c(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 i : Cardinal;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 i := 0;
 Result := 0;
 repeat
  SubStr1 := Str1[i];
  SubStr2 := Str2[i];

  if (SubStr1 = #0) and (SubStr2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (SubStr1 <> #0) and (SubStr2 = #0) then
   begin
    Result := 1;
    Break;
   end;

//  SubStr1 := UpperChar_DFL_2(SubStr1);
  SubStr1 := LookUpTable[Ord(SubStr1)];
//  SubStr2 := UpperChar_DFL_2(SubStr2);
  SubStr2 := LookUpTable[Ord(SubStr2)];

  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Break;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(i);
 until ((SubStr1 = #0) and (SubStr2 = #0));
end;

function StrIComp_DFL_Pas_10_d(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 i : Cardinal;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 i := 0;
 Result := 0;
 repeat
  SubStr1 := Str1[i];
  SubStr2 := Str2[i];

  if (SubStr1 = #0) and (SubStr2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (SubStr1 <> #0) and (SubStr2 = #0) then
   begin
    Result := 1;
    Break;
   end;

//  SubStr1 := UpperChar_DFL_2(SubStr1);
  SubStr1 := LookUpTable[Ord(SubStr1)];
//  SubStr2 := UpperChar_DFL_2(SubStr2);
  SubStr2 := LookUpTable[Ord(SubStr2)];

  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Break;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(i);
 until ((SubStr1 = #0) and (SubStr2 = #0));
end;

function StrIComp_DFL_Pas_11_a(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 PStr1, PStr2 : PChar;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 PStr1 := Str1;
 PStr2 := Str2;
 Result := 0;
 repeat
  SubStr1 := PStr1^;
  SubStr2 := PStr2^;

  if (SubStr1 = #0) and (SubStr2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (SubStr1 <> #0) and (SubStr2 = #0) then
   begin
    Result := 1;
    Break;
   end;

//  SubStr1 := UpperChar_DFL_2(SubStr1);
  SubStr1 := LookUpTable[Ord(SubStr1)];
//  SubStr2 := UpperChar_DFL_2(SubStr2);
  SubStr2 := LookUpTable[Ord(SubStr2)];

  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Break;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(PStr1);
  Inc(PStr2);
 until ((SubStr1 = #0) and (SubStr2 = #0));
end;

function StrIComp_DFL_Pas_12_a(const Str1, Str2: PChar): Integer;//+
var
 PStr1, PStr2 : PChar;
 C1, C2 : Char;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 PStr1 := Str1;
 PStr2 := Str2;
 C1 := PStr1^;
 C2 := PStr2^;
 Result := 0;
 repeat
  if (C1 = #0) and (C2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (C1 <> #0) and (C2 = #0) then
   begin
    Result := 1;
    Break;
   end;

//  SubStr1 := UpperChar_DFL_2(SubStr1);
  C1 := LookUpTable[Ord(PStr1^)];
//  SubStr2 := UpperChar_DFL_2(SubStr2);
  C2 := LookUpTable[Ord(PStr2^)];

  if C1 > C2 then
   begin
    Result := 1;
    Break;
   end
  else if C1 < C2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(PStr1);
  Inc(PStr2);

  if (C1 = #0) and (C2 = #0) then
   Exit
  else
   begin
    C1 := PStr1^;
    C2 := PStr2^;
    if (C1 = #0) and (C2 <> #0) then
     begin
      Result := -1;
      Break;
     end
    else if (C1 <> #0) and (C2 = #0) then
     begin
      Result := 1;
      Break;
     end;

//  SubStr1 := UpperChar_DFL_2(SubStr1);
  C1 := LookUpTable[Ord(PStr1^)];
//  SubStr2 := UpperChar_DFL_2(SubStr2);
  C2 := LookUpTable[Ord(PStr2^)];

  if C1 > C2 then
   begin
    Result := 1;
    Break;
   end
  else if C1 < C2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(PStr1);
  Inc(PStr2);
   end;
 until ((C1 = #0) and (C2 = #0));
end;

function UpperChar_DFL_3(ch1: Char): Char; //inline;
var
 ch2, ch3 : Char;

begin
      ch2:=ch1;
      byte(ch1):=byte(ch1) or $80; // $E1..$FA
      ch3:=ch1;
      byte(ch1):=byte(ch1) - $7B;           // $66..$7F
      byte(ch1):=byte(ch1) or $80; // $E6..$FF
      byte(ch3):=byte(ch3) xor byte(ch2);               // $80
      byte(ch1):=byte(ch1) - $66;           // $80..$99
      byte(ch3):=byte(ch3) and byte(ch1);               // $80
      byte(ch3):=byte(ch3) shr 2;                 // $20
      byte(ch3) := byte(ch3) xor byte(ch2);               // Upper
      Result := ch3;
end;

function StrIComp_DFL_Pas_13_a(const Str1, Str2: PChar): Integer;//+
var
 PStr1, PStr2 : PChar;
 C1, C2 : Char;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 PStr1 := Str1;
 PStr2 := Str2;
 C1 := PStr1^;
 C2 := PStr2^;
 Result := 0;
 repeat
  if (C1 = #0) and (C2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (C1 <> #0) and (C2 = #0) then
   begin
    Result := 1;
    Break;
   end;

  C1 := UpperChar_DFL_3(PStr1^);
  C2 := UpperChar_DFL_3(PStr2^);

  if C1 > C2 then
   begin
    Result := 1;
    Break;
   end
  else if C1 < C2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(PStr1);
  Inc(PStr2);

  if (C1 = #0) and (C2 = #0) then
   Exit
  else
   begin
    C1 := PStr1^;
    C2 := PStr2^;
    if (C1 = #0) and (C2 <> #0) then
     begin
      Result := -1;
      Break;
     end
    else if (C1 <> #0) and (C2 = #0) then
     begin
      Result := 1;
      Break;
     end;

  C1 := UpperChar_DFL_3(PStr1^);
  C2 := UpperChar_DFL_3(PStr2^);

    if C1 > C2 then
     begin
      Result := 1;
      Break;
     end
    else if C1 < C2 then
     begin
      Result := -1;
      Break;
     end;
    Inc(PStr1);
    Inc(PStr2);
   end;
 until ((C1 = #0) and (C2 = #0));
end;

function StrIComp_DFL_Pas_14_a(const Str1, Str2: PChar): Integer;//+
var
 PStr1, PStr2 : PChar;
 C1, C2 : Char;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 PStr1 := Str1;
 PStr2 := Str2;
 C1 := PStr1^;
 C2 := PStr2^;
 Result := 0;
 repeat

  if (C1 = #0) and (C2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (C1 <> #0) and (C2 = #0) then
   begin
    Result := 1;
    Break;
   end;

  C1 := UpperChar_DFL_3(PStr1^);
  C2 := UpperChar_DFL_3(PStr2^);

  if C1 > C2 then
   begin
    Result := 1;
    Break;
   end
  else if C1 < C2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(PStr1);
  Inc(PStr2);
 until ((C1 = #0) and (C2 = #0));
end;

function UpperChar_DFL_4(ch1: Char): Char;
asm
 push ebx
 mov cl, 7fh
 mov dl, 7fh
 and cl, al
 mov bl, al
 not bl
 add cl, 05h
 and cl, dl
 add cl, 1ah
 and cl, bl
 shr cl, 2
 and cl, 20h
 sub al, cl
 pop ebx
end;

function StrIComp_DFL_IA32_15_a(const Str1, Str2: PChar): Integer;//+
var
 PStr1, PStr2 : PChar;
 C1, C2 : Char;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 PStr1 := Str1;
 PStr2 := Str2;
 C1 := PStr1^;
 C2 := PStr2^;
 Result := 0;
 repeat

  if (C1 = #0) and (C2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (C1 <> #0) and (C2 = #0) then
   begin
    Result := 1;
    Break;
   end;

  C1 := UpperChar_DFL_4(PStr1^);
  C2 := UpperChar_DFL_4(PStr2^);

  if C1 > C2 then
   begin
    Result := 1;
    Break;
   end
  else if C1 < C2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(PStr1);
  Inc(PStr2);
 until ((C1 = #0) and (C1 = #0));
end;

function UpperChar_DFL_5(Ch: Char): Char;
var
 al, cl, dl, bl : Byte;

begin
 al := byte(Ch);
// push ebx
// mov cl, 7fh
 cl := $7f;
// mov dl, 7fh
 dl := $7f;
// and cl, al
 cl := cl and al;
// mov bl, al
 bl := al;
// not bl
 bl := not bl;
// add cl, 05h
 cl := cl + $05;
// and cl, dl
 cl := cl and dl;
// add cl, 1ah
 cl := cl + $1a;
// and cl, bl
 cl := cl and bl;
// shr cl, 2
 cl := cl shr 2;
// and cl, 20h
 cl := cl and $20;
// sub al, cl
 al := al - cl;
// pop ebx
 Result := char(al);
end;

function StrIComp_DFL_Pas_16_a(const Str1, Str2: PChar): Integer;//+
var
 PStr1, PStr2 : PChar;
 C1, C2 : Char;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 PStr1 := Str1;
 PStr2 := Str2;
 C1 := PStr1^;
 C2 := PStr2^;
 Result := 0;
 repeat

  if (C1 = #0) and (C2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (C1 <> #0) and (C2 = #0) then
   begin
    Result := 1;
    Break;
   end;
  C1 := UpperChar_DFL_5(PStr1^);
  C2 := UpperChar_DFL_5(PStr2^);

  if C1 > C2 then
   begin
    Result := 1;
    Break;
   end
  else if C1 < C2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(PStr1);
  Inc(PStr2);
 until ((C1 = #0) and (C2 = #0));
end;

function UpperChar_DFL_6(Ch: Char): Char; //inline;
var
 al, cl, dl, bl : Byte;

begin
 al := byte(Ch);
// push ebx
// mov cl, 7fh
 cl := $7f;
// mov dl, 7fh
 dl := $7f;
// and cl, al
 cl := cl and al;
// mov bl, al
 bl := al;
// not bl
 bl := not bl;
// add cl, 05h
 cl := cl + $05;
// and cl, dl
 cl := cl and dl;
// add cl, 1ah
 cl := cl + $1a;
// and cl, bl
 cl := cl and bl;
// shr cl, 2
 cl := cl shr 2;
// and cl, 20h
 cl := cl and $20;
// sub al, cl
 al := al - cl;
// pop ebx
 Result := char(al);
end;

function StrIComp_DFL_Pas_17_a(const Str1, Str2: PChar): Integer;//+
var
 PStr1, PStr2 : PChar;
 C1, C2 : Char;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 PStr1 := Str1;
 PStr2 := Str2;
 C1 := PStr1^;
 C2 := PStr2^;
 Result := 0;
 repeat
  if (C1 = #0) and (C2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (C1 <> #0) and (C2 = #0) then
   begin
    Result := 1;
    Break;
   end;
  C1 := UpperChar_DFL_6(PStr1^);
  C2 := UpperChar_DFL_6(PStr2^);

  if C1 > C2 then
   begin
    Result := 1;
    Break;
   end
  else if C1 < C2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(PStr1);
  Inc(PStr2);
 until ((C1 = #0) and (C2 = #0));
end;

function StrIComp_DFL_Pas_18_a(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 PStr1, PStr2 : PChar;

begin
 if ((Str1[0] = #0) and (Str2[0] = #0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (Str1[0] = #0) then
  begin
   Result := -1;
   Exit;
  end;
 if (Str2[0] = #0) then
  begin
   Result := 1;
   Exit;
  end;

 PStr1 := Str1;
 PStr2 := Str2;
 Result := 0;
 repeat
  SubStr1 := PStr1^;
  SubStr2 := PStr2^;

  if (SubStr1 = #0) and (SubStr2 <> #0) then
   begin
    Result := -1;
    Break;
   end
  else if (SubStr1 <> #0) and (SubStr2 = #0) then
   begin
    Result := 1;
    Break;
   end;

  SubStr1 := LookUpTable[Ord(SubStr1)];
  SubStr2 := LookUpTable[Ord(SubStr2)];

  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Break;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Break;
   end;
  Inc(PStr1);
  Inc(PStr2);
  if (SubStr1 = #0) and (SubStr2 = #0) then
   Exit
  else
  begin
   SubStr1 := PStr1^;
   SubStr2 := PStr2^;

   if (SubStr1 = #0) and (SubStr2 <> #0) then
    begin
     Result := -1;
     Break;
    end
   else if (SubStr1 <> #0) and (SubStr2 = #0) then
    begin
     Result := 1;
     Break;
    end;

   SubStr1 := LookUpTable[Ord(SubStr1)];
   SubStr2 := LookUpTable[Ord(SubStr2)];

   if SubStr1 > SubStr2 then
    begin
     Result := 1;
     Break;
    end
   else if SubStr1 < SubStr2 then
    begin
     Result := -1;
     Break;
    end;
   Inc(PStr1);
   Inc(PStr2);
  end;
 until ((SubStr1 = #0) and (SubStr2 = #0));
end;

function StrIComp_DFL_Pas_19_a(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 PStr1, PStr2 : PChar;

begin
 PStr1 := Str1;
 PStr2 := Str2;
 repeat
  SubStr1 := PStr1^;
  SubStr2 := PStr2^;
  SubStr1 := LookUpTable[Ord(SubStr1)];
  SubStr2 := LookUpTable[Ord(SubStr2)];
  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Exit;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Exit;
   end;
  Inc(PStr1);
  Inc(PStr2);
 until ((SubStr1 = #0) and (SubStr2 = #0));
 Result := 0;
end;

function StrIComp_DFL_Pas_19_b(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 PStr1, PStr2 : PChar;

begin
 PStr1 := Str1;
 PStr2 := Str2;
 repeat
  SubStr1 := PStr1^;
  SubStr2 := PStr2^;
  SubStr1 := LookUpTable[Ord(SubStr1)];
  SubStr2 := LookUpTable[Ord(SubStr2)];
  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Exit;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Exit;
   end;
  Inc(PStr1);
  Inc(PStr2);
 until ((SubStr1 = #0) and (SubStr2 = #0));
 Result := 0;
end;

procedure Filler1;
asm
 nop
end;

function StrIComp_DFL_Pas_19_c(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 PStr1, PStr2 : PChar;

begin
 PStr1 := Str1;
 PStr2 := Str2;
 repeat
  SubStr1 := PStr1^;
  SubStr2 := PStr2^;
  SubStr1 := LookUpTable[Ord(SubStr1)];
  SubStr2 := LookUpTable[Ord(SubStr2)];
  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Exit;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Exit;
   end;
  Inc(PStr1);
  Inc(PStr2);
 until ((SubStr1 = #0) and (SubStr2 = #0));
 Result := 0;
end;

function StrIComp_DFL_Pas_19_d(const Str1, Str2: PChar): Integer;//+
var
 SubStr1, SubStr2 : Char;
 PStr1, PStr2 : PChar;

begin
 PStr1 := Str1;
 PStr2 := Str2;
 repeat
  SubStr1 := PStr1^;
  SubStr2 := PStr2^;
  SubStr1 := LookUpTable[Ord(SubStr1)];
  SubStr2 := LookUpTable[Ord(SubStr2)];
  if SubStr1 > SubStr2 then
   begin
    Result := 1;
    Exit;
   end
  else if SubStr1 < SubStr2 then
   begin
    Result := -1;
    Exit;
   end;
  Inc(PStr1);
  Inc(PStr2);
 until ((SubStr1 = #0) and (SubStr2 = #0));
 Result := 0;
end;

initialization

  InitializeLookUpTable;
  Filler1;

end.
