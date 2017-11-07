unit StrICompDKCUnit;

interface

function StrIComp_DKC_Pas_6_a(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_Pas_6_b(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_Pas_6_c(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_Pas_6_d(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_10_a(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_10_b(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_10_c(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_10_d(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_15_a(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_15_b(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_15_c(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_15_d(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_16_a(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_16_b(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_16_c(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_16_d(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_17_a(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_17_b(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_17_c(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_17_d(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_18_a(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_18_b(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_18_c(const Str1, Str2: PChar): Integer;
function StrIComp_DKC_IA32_18_d(const Str1, Str2: PChar): Integer;

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
   S2 := UpperCase(S1);
   LookUpTable[I] := S2[1];
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              24/11 2005
//Instructionset(s): IA32

function StrIComp_DKC_Pas_6_a(const Str1, Str2: PChar): Integer;
var
 S1, S2 : PChar;
 C1, C2 : Char;
label
 ExitResult0, ExitResult1, ExitResultMinus1;

begin
 if (Str1 <> nil) and (Str2 <> nil) then
  begin
   S1 := Str1;
   S2 := Str2;
   repeat
    C1 := LookUpTable[Ord(S1^)];
    C2 := LookUpTable[Ord(S2^)];
    if C1 <> C2 then
     begin
      if C1 > C2 then
       goto ExitResult1
      else
       goto ExitResultMinus1;
     end;
    Inc(S1);
    Inc(S2);
   until(C1 = #0) or (C2 = #0);
   if (C1 = #0) and (C2 = #0) then
    goto ExitResult0;
   if (C1 = #0) then
    goto ExitResult1;
   if (C1 = #0) then
    goto ExitResultMinus1;
  end
 else
  begin
   //Result := 0;//For compiler
   if (Str1 = nil) and (Str2 = nil) then
    begin
     Result := 0;
     Exit;
    end;
   if Str1 = nil then
    begin
     Result := -1;
     Exit;
    end;
   if Str2 = nil then
    begin
     Result := 1;
     Exit;
    end;
  end;
 //Exit;
ExitResult0 :
 Result := 0;
 Exit;
ExitResult1 :
 Result := 1;
 Exit;
ExitResultMinus1 :
 Result := -1;
 Exit;
end;

function StrIComp_DKC_Pas_6_b(const Str1, Str2: PChar): Integer;
var
 S1, S2 : PChar;
 C1, C2 : Char;
label
 ExitResult0, ExitResult1, ExitResultMinus1;

begin
 if (Str1 <> nil) and (Str2 <> nil) then
  begin
   S1 := Str1;
   S2 := Str2;
   repeat
    C1 := LookUpTable[Ord(S1^)];
    C2 := LookUpTable[Ord(S2^)];
    if C1 <> C2 then
     begin
      if C1 > C2 then
       goto ExitResult1
      else
       goto ExitResultMinus1;
     end;
    Inc(S1);
    Inc(S2);
   until(C1 = #0) or (C2 = #0);
   if (C1 = #0) and (C2 = #0) then
    goto ExitResult0;
   if (C1 = #0) then
    goto ExitResult1;
   if (C1 = #0) then
    goto ExitResultMinus1;
  end
 else
  begin
   if (Str1 = nil) and (Str2 = nil) then
    begin
     Result := 0;
     Exit;
    end;
   if Str1 = nil then
    begin
     Result := -1;
     Exit;
    end;
   if Str2 = nil then
    begin
     Result := 1;
     Exit;
    end;
  end;
ExitResult0 :
 Result := 0;
 Exit;
ExitResult1 :
 Result := 1;
 Exit;
ExitResultMinus1 :
 Result := -1;
 Exit;
end;

function StrIComp_DKC_Pas_6_c(const Str1, Str2: PChar): Integer;
var
 S1, S2 : PChar;
 C1, C2 : Char;
label
 ExitResult0, ExitResult1, ExitResultMinus1;

begin
 if (Str1 <> nil) and (Str2 <> nil) then
  begin
   S1 := Str1;
   S2 := Str2;
   repeat
    C1 := LookUpTable[Ord(S1^)];
    C2 := LookUpTable[Ord(S2^)];
    if C1 <> C2 then
     begin
      if C1 > C2 then
       goto ExitResult1
      else
       goto ExitResultMinus1;
     end;
    Inc(S1);
    Inc(S2);
   until(C1 = #0) or (C2 = #0);
   if (C1 = #0) and (C2 = #0) then
    goto ExitResult0;
   if (C1 = #0) then
    goto ExitResult1;
   if (C1 = #0) then
    goto ExitResultMinus1;
  end
 else
  begin
   if (Str1 = nil) and (Str2 = nil) then
    begin
     Result := 0;
     Exit;
    end;
   if Str1 = nil then
    begin
     Result := -1;
     Exit;
    end;
   if Str2 = nil then
    begin
     Result := 1;
     Exit;
    end;
  end;
ExitResult0 :
 Result := 0;
 Exit;
ExitResult1 :
 Result := 1;
 Exit;
ExitResultMinus1 :
 Result := -1;
 Exit;
end;

function StrIComp_DKC_Pas_6_d(const Str1, Str2: PChar): Integer;
var
 S1, S2 : PChar;
 C1, C2 : Char;
label
 ExitResult0, ExitResult1, ExitResultMinus1;

begin
 if (Str1 <> nil) and (Str2 <> nil) then
  begin
   S1 := Str1;
   S2 := Str2;
   repeat
    C1 := LookUpTable[Ord(S1^)];
    C2 := LookUpTable[Ord(S2^)];
    if C1 <> C2 then
     begin
      if C1 > C2 then
       goto ExitResult1
      else
       goto ExitResultMinus1;
     end;
    Inc(S1);
    Inc(S2);
   until(C1 = #0) or (C2 = #0);
   if (C1 = #0) and (C2 = #0) then
    goto ExitResult0;
   if (C1 = #0) then
    goto ExitResult1;
   if (C1 = #0) then
    goto ExitResultMinus1;
  end
 else
  begin
   if (Str1 = nil) and (Str2 = nil) then
    begin
     Result := 0;
     Exit;
    end;
   if Str1 = nil then
    begin
     Result := -1;
     Exit;
    end;
   if Str2 = nil then
    begin
     Result := 1;
     Exit;
    end;
  end;
ExitResult0 :
 Result := 0;
 Exit;
ExitResult1 :
 Result := 1;
 Exit;
ExitResultMinus1 :
 Result := -1;
 Exit;
end;

//Author:            Dennis Kjaer Christensen
//Date:              26/11 2005
//Instructionset(s): IA32

function StrIComp_DKC_IA32_10_a(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   //S1 := Str1;
   //S2 := Str2;
   mov   esi,edx
   mov   ebx,[LookUpTable]
 @LoopStart :
   //C1 := LookUpTable[Ord(S1^)];
   movzx ecx,[eax]
   mov   edx,[LookUpTable]
   movzx ecx,[edx+ecx]
   //C2 := LookUpTable[Ord(S2^)];
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   //if C1 <> C2 then
   cmp   dl,cl
   jz    @Continue
   //if C1 > C2 then
   cmp   dl,cl
   jb    @ExitResult1
   jmp   @ExitResultMinus1
   //Inc(S1);
 @Continue :
   inc   eax
   //Inc(S2);
   inc   esi
   //until(C1 = #0) or (C2 = #0);
   test  cl,cl
   jz    @Label1
   test  dl,dl
   jnz   @LoopStart
   //if (C1 = #0) and (C2 = #0) then
 @Label1 :
   test  cl,cl
   jnz   @Label2
   test  dl,dl
   jz    @ExitResult0
   //if (C1 = #0) then
 @Label2 :
   test  cl,cl
   jz    @ExitResult1
   //if (C1 = #0) then
   test  cl,cl
   jz    @ExitResultMinus1
   jmp   @ExitResultMinus1
   //if (Str1 = nil) and (Str2 = nil) then
   //Result := 0;
 @ExitResult0 :
   xor   eax,eax
   pop   esi
   pop   ebx
   ret
   //Result := 1;
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   esi
   pop   ebx
   ret
   //Result := -1;
 @ExitResultMinus1 :
   or    eax,-1
   pop   esi
   pop   ebx
   ret
end;

function StrIComp_DKC_IA32_10_b(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   //S1 := Str1;
   //S2 := Str2;
   mov   esi,edx
   mov   ebx,[LookUpTable]
 @LoopStart :
   //C1 := LookUpTable[Ord(S1^)];
   movzx ecx,[eax]
   mov   edx,[LookUpTable]
   movzx ecx,[edx+ecx]
   //C2 := LookUpTable[Ord(S2^)];
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   //if C1 <> C2 then
   cmp   dl,cl
   jz    @Continue
   //if C1 > C2 then
   cmp   dl,cl
   jb    @ExitResult1
   jmp   @ExitResultMinus1
   //Inc(S1);
 @Continue :
   inc   eax
   //Inc(S2);
   inc   esi
   //until(C1 = #0) or (C2 = #0);
   test  cl,cl
   jz    @Label1
   test  dl,dl
   jnz   @LoopStart
   //if (C1 = #0) and (C2 = #0) then
 @Label1 :
   test  cl,cl
   jnz   @Label2
   test  dl,dl
   jz    @ExitResult0
   //if (C1 = #0) then
 @Label2 :
   test  cl,cl
   jz    @ExitResult1
   //if (C1 = #0) then
   test  cl,cl
   jz    @ExitResultMinus1
   jmp   @ExitResultMinus1
   //if (Str1 = nil) and (Str2 = nil) then
   //Result := 0;
 @ExitResult0 :
   xor   eax,eax
   pop   esi
   pop   ebx
   ret
   //Result := 1;
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   esi
   pop   ebx
   ret
   //Result := -1;
 @ExitResultMinus1 :
   or    eax,-1
   pop   esi
   pop   ebx
   ret
end;

procedure Filler1;
asm
 nop
end;

function StrIComp_DKC_IA32_10_c(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   //S1 := Str1;
   //S2 := Str2;
   mov   esi,edx
   mov   ebx,[LookUpTable]
 @LoopStart :
   //C1 := LookUpTable[Ord(S1^)];
   movzx ecx,[eax]
   mov   edx,[LookUpTable]
   movzx ecx,[edx+ecx]
   //C2 := LookUpTable[Ord(S2^)];
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   //if C1 <> C2 then
   cmp   dl,cl
   jz    @Continue
   //if C1 > C2 then
   cmp   dl,cl
   jb    @ExitResult1
   jmp   @ExitResultMinus1
   //Inc(S1);
 @Continue :
   inc   eax
   //Inc(S2);
   inc   esi
   //until(C1 = #0) or (C2 = #0);
   test  cl,cl
   jz    @Label1
   test  dl,dl
   jnz   @LoopStart
   //if (C1 = #0) and (C2 = #0) then
 @Label1 :
   test  cl,cl
   jnz   @Label2
   test  dl,dl
   jz    @ExitResult0
   //if (C1 = #0) then
 @Label2 :
   test  cl,cl
   jz    @ExitResult1
   //if (C1 = #0) then
   test  cl,cl
   jz    @ExitResultMinus1
   jmp   @ExitResultMinus1
   //if (Str1 = nil) and (Str2 = nil) then
   //Result := 0;
 @ExitResult0 :
   xor   eax,eax
   pop   esi
   pop   ebx
   ret
   //Result := 1;
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   esi
   pop   ebx
   ret
   //Result := -1;
 @ExitResultMinus1 :
   or    eax,-1
   pop   esi
   pop   ebx
   ret
end;

function StrIComp_DKC_IA32_10_d(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   //S1 := Str1;
   //S2 := Str2;
   mov   esi,edx
   mov   ebx,[LookUpTable]
 @LoopStart :
   //C1 := LookUpTable[Ord(S1^)];
   movzx ecx,[eax]
   mov   edx,[LookUpTable]
   movzx ecx,[edx+ecx]
   //C2 := LookUpTable[Ord(S2^)];
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   //if C1 <> C2 then
   cmp   dl,cl
   jz    @Continue
   //if C1 > C2 then
   cmp   dl,cl
   jb    @ExitResult1
   jmp   @ExitResultMinus1
   //Inc(S1);
 @Continue :
   inc   eax
   //Inc(S2);
   inc   esi
   //until(C1 = #0) or (C2 = #0);
   test  cl,cl
   jz    @Label1
   test  dl,dl
   jnz   @LoopStart
   //if (C1 = #0) and (C2 = #0) then
 @Label1 :
   test  cl,cl
   jnz   @Label2
   test  dl,dl
   jz    @ExitResult0
   //if (C1 = #0) then
 @Label2 :
   test  cl,cl
   jz    @ExitResult1
   //if (C1 = #0) then
   test  cl,cl
   jz    @ExitResultMinus1
   jmp   @ExitResultMinus1
   //if (Str1 = nil) and (Str2 = nil) then
   //Result := 0;
 @ExitResult0 :
   xor   eax,eax
   pop   esi
   pop   ebx
   ret
   //Result := 1;
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   esi
   pop   ebx
   ret
   //Result := -1;
 @ExitResultMinus1 :
   or    eax,-1
   pop   esi
   pop   ebx
   ret
end;

//Author:            Dennis Kjaer Christensen
//Date:              26/11 2005
//Instructionset(s): IA32

function StrIComp_DKC_IA32_15_a(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   //S1 := Str1;
   //S2 := Str2;
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   //C1 := LookUpTable[Ord(S1^)];
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   //C2 := LookUpTable[Ord(S2^)];
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   //if C1 <> C2 then
   cmp   dl,cl
   jz    @Continue
   //if C1 > C2 then
   cmp   dl,cl
   jb    @ExitResult1
   jmp   @ExitResultMinus1
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @Continue :
   inc   eax
   inc   esi
   //until(C1 = #0) or (C2 = #0);
   test  cl,cl
   jz    @Label1
   test  dl,dl
   jnz   @LoopStart
   //if (C1 = #0) and (C2 = #0) then
 @Label1 :
   test  cl,cl
   jnz   @Label2
   test  dl,dl
   jz    @ExitResult0
   //if (C1 = #0) then
 @Label2 :
   test  cl,cl
   jz    @ExitResult1
   //if (C1 = #0) then
   test  cl,cl
   jz    @ExitResultMinus1
   jmp   @ExitResultMinus1
   //if (Str1 = nil) and (Str2 = nil) then
   //Result := 0;
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
   //Result := 1;
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
   //Result := -1;
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
end;

function StrIComp_DKC_IA32_15_b(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   //S1 := Str1;
   //S2 := Str2;
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   //C1 := LookUpTable[Ord(S1^)];
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   //C2 := LookUpTable[Ord(S2^)];
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   //if C1 <> C2 then
   cmp   dl,cl
   jz    @Continue
   //if C1 > C2 then
   cmp   dl,cl
   jb    @ExitResult1
   jmp   @ExitResultMinus1
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @Continue :
   inc   eax
   inc   esi
   //until(C1 = #0) or (C2 = #0);
   test  cl,cl
   jz    @Label1
   test  dl,dl
   jnz   @LoopStart
   //if (C1 = #0) and (C2 = #0) then
 @Label1 :
   test  cl,cl
   jnz   @Label2
   test  dl,dl
   jz    @ExitResult0
   //if (C1 = #0) then
 @Label2 :
   test  cl,cl
   jz    @ExitResult1
   //if (C1 = #0) then
   test  cl,cl
   jz    @ExitResultMinus1
   jmp   @ExitResultMinus1
   //if (Str1 = nil) and (Str2 = nil) then
   //Result := 0;
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
   //Result := 1;
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
   //Result := -1;
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
end;

function StrIComp_DKC_IA32_15_c(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   //S1 := Str1;
   //S2 := Str2;
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   //C1 := LookUpTable[Ord(S1^)];
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   //C2 := LookUpTable[Ord(S2^)];
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   //if C1 <> C2 then
   cmp   dl,cl
   jz    @Continue
   //if C1 > C2 then
   cmp   dl,cl
   jb    @ExitResult1
   jmp   @ExitResultMinus1
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @Continue :
   inc   eax
   inc   esi
   //until(C1 = #0) or (C2 = #0);
   test  cl,cl
   jz    @Label1
   test  dl,dl
   jnz   @LoopStart
   //if (C1 = #0) and (C2 = #0) then
 @Label1 :
   test  cl,cl
   jnz   @Label2
   test  dl,dl
   jz    @ExitResult0
   //if (C1 = #0) then
 @Label2 :
   test  cl,cl
   jz    @ExitResult1
   //if (C1 = #0) then
   test  cl,cl
   jz    @ExitResultMinus1
   jmp   @ExitResultMinus1
   //if (Str1 = nil) and (Str2 = nil) then
   //Result := 0;
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
   //Result := 1;
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
   //Result := -1;
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
end;

function StrIComp_DKC_IA32_15_d(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   //S1 := Str1;
   //S2 := Str2;
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   //C1 := LookUpTable[Ord(S1^)];
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   //C2 := LookUpTable[Ord(S2^)];
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   //if C1 <> C2 then
   cmp   dl,cl
   jz    @Continue
   //if C1 > C2 then
   cmp   dl,cl
   jb    @ExitResult1
   jmp   @ExitResultMinus1
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @Continue :
   inc   eax
   inc   esi
   //until(C1 = #0) or (C2 = #0);
   test  cl,cl
   jz    @Label1
   test  dl,dl
   jnz   @LoopStart
   //if (C1 = #0) and (C2 = #0) then
 @Label1 :
   test  cl,cl
   jnz   @Label2
   test  dl,dl
   jz    @ExitResult0
   //if (C1 = #0) then
 @Label2 :
   test  cl,cl
   jz    @ExitResult1
   //if (C1 = #0) then
   test  cl,cl
   jz    @ExitResultMinus1
   jmp   @ExitResultMinus1
   //if (Str1 = nil) and (Str2 = nil) then
   //Result := 0;
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
   //Result := 1;
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
   //Result := -1;
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/12 2005
//Instructionset(s): IA32

function StrIComp_DKC_IA32_16_a(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

function StrIComp_DKC_IA32_16_b(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler2;
asm
 nop
end;

function StrIComp_DKC_IA32_16_c(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

function StrIComp_DKC_IA32_16_d(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/12 2005
//Instructionset(s): IA32

function StrIComp_DKC_IA32_17_a(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
 @LoopEnd :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

function StrIComp_DKC_IA32_17_b(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
 @LoopEnd :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

function StrIComp_DKC_IA32_17_c(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
 @LoopEnd :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

function StrIComp_DKC_IA32_17_d(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
 @LoopEnd :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/12 2005
//Instructionset(s): IA32

function StrIComp_DKC_IA32_18_a(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
 @LoopEnd :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler3;
asm
 nop
end;

function StrIComp_DKC_IA32_18_b(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
 @LoopEnd :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler4;
asm
 nop
end;

function StrIComp_DKC_IA32_18_c(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
 @LoopEnd :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler5;
asm
 nop
end;

function StrIComp_DKC_IA32_18_d(const Str1, Str2: PChar): Integer;
asm
   push  ebx
   push  esi
   push  edi
   mov   esi,edx
   mov   ebx,[LookUpTable]
   mov   edi,[LookUpTable]
 @LoopStart :
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jz    @LoopEnd
   movzx ecx,[eax]
   movzx ecx,[edi+ecx]
   movzx edx,[esi]
   movzx edx,[ebx+edx]
   cmp   dl,cl
   jnz   @BreakNotEqual
   inc   eax
   inc   esi
   test  cl,cl
   jz    @Label3
   test  dl,dl
   jnz   @LoopStart
 @LoopEnd :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Label3 :
   test  dl,dl
   jz    @ExitResult0
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @BreakNotEqual :
   cmp   dl,cl
   jb    @ExitResult1
 @ExitResultMinus1 :
   or    eax,-1
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult0 :
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   ret
 @ExitResult1 :
   xor   eax,eax
   inc   eax
   pop   edi
   pop   esi
   pop   ebx
end;

initialization

  InitializeLookUpTable;
  Filler1;
  Filler2;
  Filler3;
  Filler4;
  Filler5;

end.
