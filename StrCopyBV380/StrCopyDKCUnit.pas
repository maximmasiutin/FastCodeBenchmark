unit StrCopyDKCUnit;

interface

function StrCopy_DKC_Pas_13_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_Pas_13_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_1_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_1_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_1_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_1_d(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_2_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_2_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_2_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_2_d(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_3_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_3_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_3_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_3_d(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_4_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_4_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_4_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_4_d(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_5_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_5_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_5_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_DKC_IA32_5_d(Dest: PChar; const Source: PChar): PChar;

implementation

uses
 SysUtils;

//Author:            Dennis Kjaer Christensen
//Date:              15/8 2003
//Optimized for:
//Instructionset(s): IA32

function StrCopyDKCPas1_a(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := 0;
 repeat
  Dest[I] := Source[I];
  Inc(I);
 until(Source[I-1] = #0);
 Result := Dest;
end;

function StrCopyDKCPas1_b(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := 0;
 repeat
  Dest[I] := Source[I];
  Inc(I);
 until(Source[I-1] = #0);
 Result := Dest;
end;

function StrCopyDKCPas1_c(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := 0;
 repeat
  Dest[I] := Source[I];
  Inc(I);
 until(Source[I-1] = #0);
 Result := Dest;
end;

function StrCopyDKCPas1_d(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := 0;
 repeat
  Dest[I] := Source[I];
  Inc(I);
 until(Source[I-1] = #0);
 Result := Dest;
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/9 2003
//Optimized for:
//Instructionset(s): IA32

function StrCopyDKCPas4(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := 0;
 repeat
  Dest[I] := Source[I];
  Inc(I);
  if (Source[I-1] = #0) then
   Break;
  Dest[I] := Source[I];
  Inc(I);
 until(Source[I-1] = #0);
 Result := Dest;
end;

function StrCopy_DKC_Pas_13_a(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

function StrCopy_DKC_Pas_13_b(Dest: PChar; const Source: PChar): PChar;
var
 I : Integer;

begin
 I := -1;
 repeat
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
  Inc(I);
  Dest[I] := Source[I];
  if Dest[I] = #0 then
   Break;
 until(Source[I] = #0);
 Result := Dest;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/8 2003
//Instructionset(s): IA32

function StrCopy_DKC_IA32_1_a(Dest: PChar; const Source: PChar): PChar;
asm
       push eax
 @@1:  mov  cl,[edx]
       add  edx,1
       mov  [eax],cl
       add  eax,1
       test cl, cl
       jnz  @@1
       pop  eax
end;

function StrCopy_DKC_IA32_1_b(Dest: PChar; const Source: PChar): PChar;
asm
       push eax
 @@1:  mov  cl,[edx]
       add  edx,1
       mov  [eax],cl
       add  eax,1
       test cl, cl
       jnz  @@1
       pop  eax
end;

function StrCopy_DKC_IA32_1_c(Dest: PChar; const Source: PChar): PChar;
asm
       push eax
 @@1:  mov  cl,[edx]
       add  edx,1
       mov  [eax],cl
       add  eax,1
       test cl, cl
       jnz  @@1
       pop  eax
end;

function StrCopy_DKC_IA32_1_d(Dest: PChar; const Source: PChar): PChar;
asm
       push eax
 @@1:  mov  cl,[edx]
       add  edx,1
       mov  [eax],cl
       add  eax,1
       test cl, cl
       jnz  @@1
       pop  eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/5 2004
//Instructionset(s): IA32

function StrCopy_DKC_IA32_2_a(Dest: PChar; const Source: PChar): PChar;
asm
     push  eax
 @1: movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jz    @Exit
     movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jnz   @1
 @Exit :
     pop   eax
end;

function StrCopy_DKC_IA32_2_b(Dest: PChar; const Source: PChar): PChar;
asm
     push  eax
 @1: movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jz    @Exit
     movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jnz   @1
 @Exit :
     pop   eax
end;

function StrCopy_DKC_IA32_2_c(Dest: PChar; const Source: PChar): PChar;
asm
     push  eax
 @1: movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jz    @Exit
     movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jnz   @1
 @Exit :
     pop   eax
end;

function StrCopy_DKC_IA32_2_d(Dest: PChar; const Source: PChar): PChar;
asm
     push  eax
 @1: movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jz    @Exit
     movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jnz   @1
 @Exit :
     pop   eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/5 2004
//Instructionset(s): IA32

function StrCopy_DKC_IA32_3_a(Dest: PChar; const Source: PChar): PChar;
asm
      push  eax
 @@1: movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @@Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jnz   @@1
 @@Exit :
      pop   eax
end;

function StrCopy_DKC_IA32_3_b(Dest: PChar; const Source: PChar): PChar;
asm
      push  eax
 @@1: movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @@Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jnz   @@1
 @@Exit :
      pop   eax
end;

function StrCopy_DKC_IA32_3_c(Dest: PChar; const Source: PChar): PChar;
asm
      push  eax
 @@1: movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @@Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jnz   @@1
 @@Exit :
      pop   eax
end;

function StrCopy_DKC_IA32_3_d(Dest: PChar; const Source: PChar): PChar;
asm
      push  eax
 @@1: movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @@Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jnz   @@1
 @@Exit :
      pop   eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              22/6 2004
//Instructionset(s): IA32

function StrCopy_DKC_IA32_4_a(Dest: PChar; const Source: PChar): PChar;
asm
      push  eax
  @1: movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jnz   @1
 @Exit :
      pop   eax
end;

procedure Filler1;
asm
 nop
end;

function StrCopy_DKC_IA32_4_b(Dest: PChar; const Source: PChar): PChar;
asm
      push  eax
  @1: movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jnz   @1
 @Exit :
      pop   eax
end;

procedure Filler2;
asm
 nop
end;

function StrCopy_DKC_IA32_4_c(Dest: PChar; const Source: PChar): PChar;
asm
      push  eax
  @1: movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jnz   @1
 @Exit :
      pop   eax
end;

procedure Filler3;
asm
 nop
end;

function StrCopy_DKC_IA32_4_d(Dest: PChar; const Source: PChar): PChar;
asm
      push  eax
  @1: movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jz    @Exit
      movzx ecx, [edx]
      add   edx,1
      mov   [eax],cl
      add   eax,1
      test  cl, cl
      jnz   @1
 @Exit :
      pop   eax
end;

function StrCopy_DKC_IA32_5_a(Dest: PChar; const Source: PChar): PChar;
asm
     push  eax
     nop
     nop
     nop
 @1: movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jz    @Exit
     movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jnz   @1
     nop
     nop
 @Exit :
     pop   eax
end;

function StrCopy_DKC_IA32_5_b(Dest: PChar; const Source: PChar): PChar;
asm
     push  eax
     nop
     nop
     nop
 @1: movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jz    @Exit
     movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jnz   @1
     nop
     nop
 @Exit :
     pop   eax
end;

procedure Filler4;
asm
 nop
end;

function StrCopy_DKC_IA32_5_c(Dest: PChar; const Source: PChar): PChar;
asm
     push  eax
     nop
     nop
     nop
 @1: movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jz    @Exit
     movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jnz   @1
     nop
     nop
 @Exit :
     pop   eax
end;

function StrCopy_DKC_IA32_5_d(Dest: PChar; const Source: PChar): PChar;
asm
     push  eax
     nop
     nop
     nop
 @1: movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jz    @Exit
     movzx ecx, [edx]
     add   edx,1
     mov   [eax],cl
     add   eax,1
     test  cl, cl
     jnz   @1
     nop
     nop
 @Exit :
     pop   eax
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;

end.
