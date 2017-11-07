unit StrCompDKCUnit;

interface

function StrComp_DKC_Pas_7_a(const Str1, Str2: PChar): Integer;
function StrComp_DKC_Pas_7_b(const Str1, Str2: PChar): Integer;
function StrComp_DKC_Pas_7_c(const Str1, Str2: PChar): Integer;
function StrComp_DKC_Pas_7_d(const Str1, Str2: PChar): Integer;
function StrComp_DKC_IA32_11_a(const Str1, Str2: PChar): Integer;
function StrComp_DKC_IA32_11_b(const Str1, Str2: PChar): Integer;
function StrComp_DKC_IA32_11_c(const Str1, Str2: PChar): Integer;
function StrComp_DKC_IA32_11_d(const Str1, Str2: PChar): Integer;
function StrComp_DKC_IA32_24_a(const Str1, Str2: PChar): Integer;
function StrComp_DKC_IA32_24_b(const Str1, Str2: PChar): Integer;
function StrComp_DKC_IA32_24_c(const Str1, Str2: PChar): Integer;
function StrComp_DKC_IA32_24_d(const Str1, Str2: PChar): Integer;

implementation

uses
 SysUtils;

//Author:            Dennis Kjaer Christensen
//Date:              19/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function StrComp_DKC_Pas_7_a(const Str1, Str2: PChar): Integer;
var
 J : Integer;
 C1, C2 : Char;
label
 L1, L2;

begin
 J := -1;
 repeat
  Inc(J);
  C1 := Str1[J];
  C2 := Str2[J];
  if C1 < C2 then
   goto L1;
  if C1 > C2 then
   goto L2;
 until(C1 = #0);
 Result := 0;
 Exit;
 L1 :
  begin
   Result := -1;
   Exit;
  end;
 L2 :
  begin
   Result := 1;
  end
end;

procedure Filler4;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function StrComp_DKC_Pas_7_b(const Str1, Str2: PChar): Integer;
var
 J : Integer;
 C1, C2 : Char;
label
 L1, L2;

begin
 J := -1;
 repeat
  Inc(J);
  C1 := Str1[J];
  C2 := Str2[J];
  if C1 < C2 then
   goto L1;
  if C1 > C2 then
   goto L2;
 until(C1 = #0);
 Result := 0;
 Exit;
 L1 :
  begin
   Result := -1;
   Exit;
  end;
 L2 :
  begin
   Result := 1;
  end
end;

procedure Filler5;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function StrComp_DKC_Pas_7_c(const Str1, Str2: PChar): Integer;
var
 J : Integer;
 C1, C2 : Char;
label
 L1, L2;

begin
 J := -1;
 repeat
  Inc(J);
  C1 := Str1[J];
  C2 := Str2[J];
  if C1 < C2 then
   goto L1;
  if C1 > C2 then
   goto L2;
 until(C1 = #0);
 Result := 0;
 Exit;
 L1 :
  begin
   Result := -1;
   Exit;
  end;
 L2 :
  begin
   Result := 1;
  end
end;

procedure Filler6;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function StrComp_DKC_Pas_7_d(const Str1, Str2: PChar): Integer;
var
 J : Integer;
 C1, C2 : Char;
label
 L1, L2;

begin
 J := -1;
 repeat
  Inc(J);
  C1 := Str1[J];
  C2 := Str2[J];
  if C1 < C2 then
   goto L1;
  if C1 > C2 then
   goto L2;
 until(C1 = #0);
 Result := 0;
 Exit;
 L1 :
  begin
   Result := -1;
   Exit;
  end;
 L2 :
  begin
   Result := 1;
  end
end;

//Author:            Dennis Kjaer Christensen
//Date:              20/2 2004
//Instructionset(s): IA32

function StrComp_DKC_IA32_11_a(const Str1, Str2: PChar): Integer;
asm
   push  ebx
 @LoopStart :
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jnz   @LoopStart
 @LoopEnd :
   xor   eax,eax
   pop   ebx
   ret
 @L3 :
   mov   eax,ecx
   sub   eax,ebx
   pop   ebx
end;

function StrComp_DKC_IA32_11_b(const Str1, Str2: PChar): Integer;
asm
   push  ebx
 @LoopStart :
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jnz   @LoopStart
 @LoopEnd :
   xor   eax,eax
   pop   ebx
   ret
 @L3 :
   mov   eax,ecx
   sub   eax,ebx
   pop   ebx
end;

function StrComp_DKC_IA32_11_c(const Str1, Str2: PChar): Integer;
asm
   push  ebx
 @LoopStart :
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jnz   @LoopStart
 @LoopEnd :
   xor   eax,eax
   pop   ebx
   ret
 @L3 :
   mov   eax,ecx
   sub   eax,ebx
   pop   ebx
end;

function StrComp_DKC_IA32_11_d(const Str1, Str2: PChar): Integer;
asm
   push  ebx
 @LoopStart :
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   movzx ecx, byte ptr [eax]
   movzx ebx, byte ptr [edx]
   add   eax, 1
   add   edx, 1
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jnz   @LoopStart
 @LoopEnd :
   xor   eax,eax
   pop   ebx
   ret
 @L3 :
   mov   eax,ecx
   sub   eax,ebx
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function StrComp_DKC_IA32_24_a(const Str1, Str2: PChar): Integer;
asm
   push  ebx
 @LoopStart :
   movzx ecx, word ptr [eax]
   add   eax, 2
   movzx ebx, word ptr [edx]
   add   edx, 2
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   cmp   bh,ch
   jne   @L3
   test  ch,ch
   jz    @LoopEnd
   test  bh,bh
   jnz   @LoopStart
 @LoopEnd :
   xor   eax,eax
   pop   ebx
   ret
 @L3 :
   mov   eax,ecx
   sub   eax,ebx
   pop   ebx
end;

procedure Filler1;
asm
 nop
end;

function StrComp_DKC_IA32_24_b(const Str1, Str2: PChar): Integer;
asm
   push  ebx
 @LoopStart :
   movzx ecx, word ptr [eax]
   add   eax, 2
   movzx ebx, word ptr [edx]
   add   edx, 2
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   cmp   bh,ch
   jne   @L3
   test  ch,ch
   jz    @LoopEnd
   test  bh,bh
   jnz   @LoopStart
 @LoopEnd :
   xor   eax,eax
   pop   ebx
   ret
 @L3 :
   mov   eax,ecx
   sub   eax,ebx
   pop   ebx
end;

procedure Filler2;
asm
 nop
end;

function StrComp_DKC_IA32_24_c(const Str1, Str2: PChar): Integer;
asm
   push  ebx
 @LoopStart :
   movzx ecx, word ptr [eax]
   add   eax, 2
   movzx ebx, word ptr [edx]
   add   edx, 2
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   cmp   bh,ch
   jne   @L3
   test  ch,ch
   jz    @LoopEnd
   test  bh,bh
   jnz   @LoopStart
 @LoopEnd :
   xor   eax,eax
   pop   ebx
   ret
 @L3 :
   mov   eax,ecx
   sub   eax,ebx
   pop   ebx
end;

procedure Filler3;
asm
 nop
end;

function StrComp_DKC_IA32_24_d(const Str1, Str2: PChar): Integer;
asm
   push  ebx
 @LoopStart :
   movzx ecx, word ptr [eax]
   add   eax, 2
   movzx ebx, word ptr [edx]
   add   edx, 2
   cmp   bl,cl
   jne   @L3
   test  cl,cl
   jz    @LoopEnd
   test  bl,bl
   jz    @LoopEnd
   cmp   bh,ch
   jne   @L3
   test  ch,ch
   jz    @LoopEnd
   test  bh,bh
   jnz   @LoopStart
 @LoopEnd :
   xor   eax,eax
   pop   ebx
   ret
 @L3 :
   mov   eax,ecx
   sub   eax,ebx
   pop   ebx
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;

end.
