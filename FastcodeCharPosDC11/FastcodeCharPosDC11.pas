unit FastcodeCharPosDC11;

(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Fastcode
 *
 * The Initial Developer of the Original Code is Fastcode
 *
 * Portions created by the Initial Developer are Copyright (C) 2002-2004
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow, Aleksandr Sharahov
 *
 * ***** END LICENSE BLOCK ***** *)

//Version : 1.1
//Only plain function calls supported
//Last update 12/9 2005

//Change log

//12/9 - 2005 Version 1.1 Dennis Christensen. Removed P3 target, New file name, Added Dothan winner

interface

function CharPosFastcodeP4P(Ch : Char; const Str : AnsiString) : Integer;
function CharPosFastcodeP4N(Ch : Char; const Str : AnsiString) : Integer;
function CharPosFastcodePMD(Ch : Char; const Str : AnsiString) : Integer;
function CharPosFastcodePMB(Ch : Char; const Str : AnsiString) : Integer;
function CharPosFastcodeAMD64(Ch: Char; const Str: AnsiString): Integer;
function CharPosFastcodeXP(Ch : Char; const Str : AnsiString) : Integer;
function CharPosFastcodeBlended(Ch : Char; const Str : AnsiString) : Integer;
function CharPosFastcodeRTL(Ch : Char; const Str : AnsiString) : Integer;
function CharPosFastcodePascal(Ch : Char; const Str : AnsiString) : Integer;

implementation

//Author:            John O'Harrow
//Optimized for:     Intel Pentium 4 Prescott
//Instructionset(s): IA32, SSE, SSE2
//Original Name:     CharPosJOH_SSE2

function CharPosFastcodeP4P(Ch : Char; const Str : AnsiString) : Integer;
asm
  test      edx, edx
  jz        @@NullString
  mov       ecx, [edx-4]
  push      ebx
  mov       ebx, eax
  cmp       ecx, 16
  jl        @@Small
@@NotSmall:
  mov       ah, al           {Fill each Byte of XMM1 with AL}
  movd      xmm1, eax
  pshuflw   xmm1, xmm1, 0
  pshufd    xmm1, xmm1, 0
@@First16:
  movups    xmm0, [edx]      {Unaligned}
  pcmpeqb   xmm0, xmm1       {Compare First 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@FoundStart     {Exit on any Match}
  cmp       ecx, 32
  jl        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  sub       ecx, 16          {Align Block Reads}
  push      ecx
  mov       eax, edx
  neg       eax
  and       eax, 15
  add       edx, ecx
  neg       ecx
  add       ecx, eax
@@Loop:
  movaps    xmm0, [edx+ecx]  {Aligned}
  pcmpeqb   xmm0, xmm1       {Compare Next 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@Found          {Exit on any Match}
  add       ecx, 16
  jle       @@Loop
  pop       eax              {Check Remaining Characters}
  add       edx, 16
  add       eax, ecx         {Count from Last Loop End Position}
  jmp       dword ptr [@@JumpTable2-ecx*4]
  nop
  nop
@@NullString:
  xor       eax, eax         {Result = 0}
  ret
  nop
@@FoundStart:
  bsf       eax, eax         {Get Set Bit}
  pop       ebx
  inc       eax              {Set Result}
  ret
  nop
  nop
@@Found:
  pop       edx
  bsf       eax, eax         {Get Set Bit}
  add       edx, ecx
  pop       ebx
  lea       eax, [eax+edx+1] {Set Result}
  ret
@@Medium:
  add       edx, ecx         {End of String}
  mov       eax, 16          {Count from 16}
  jmp       dword ptr [@@JumpTable1-64-ecx*4]
  nop
  nop
@@Small:
  add       edx, ecx         {End of String}
  xor       eax, eax         {Count from 0}
  jmp       dword ptr [@@JumpTable1-ecx*4]
  nop
@@JumpTable1:
  dd        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  dd        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16
@@JumpTable2:
  dd        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  dd        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound
@@16:
  add       eax, 1
  cmp       bl, [edx-16]
  je        @@Done
@@15:
  add       eax, 1
  cmp       bl, [edx-15]
  je        @@Done
@@14:
  add       eax, 1
  cmp       bl, [edx-14]
  je        @@Done
@@13:
  add       eax, 1
  cmp       bl, [edx-13]
  je        @@Done
@@12:
  add       eax, 1
  cmp       bl, [edx-12]
  je        @@Done
@@11:
  add       eax, 1
  cmp       bl, [edx-11]
  je        @@Done
@@10:
  add       eax, 1
  cmp       bl, [edx-10]
  je        @@Done
@@09:
  add       eax, 1
  cmp       bl, [edx-9]
  je        @@Done
@@08:
  add       eax, 1
  cmp       bl, [edx-8]
  je        @@Done
@@07:
  add       eax, 1
  cmp       bl, [edx-7]
  je        @@Done
@@06:
  add       eax, 1
  cmp       bl, [edx-6]
  je        @@Done
@@05:
  add       eax, 1
  cmp       bl, [edx-5]
  je        @@Done
@@04:
  add       eax, 1
  cmp       bl, [edx-4]
  je        @@Done
@@03:
  add       eax, 1
  cmp       bl, [edx-3]
  je        @@Done
@@02:
  add       eax, 1
  cmp       bl, [edx-2]
  je        @@Done
@@01:
  add       eax, 1
  cmp       bl, [edx-1]
  je        @@Done
@@NotFound:
  xor       eax, eax
  pop       ebx
  ret
@@Done:
  pop       ebx
end;

//Author:            John O'Harrow
//Optimized for:     Intel Pentium 4 Northwood
//Instructionset(s): IA32, SSE, SSE2
//Original Name:     CharPosJOH_SSE2

function CharPosFastcodeP4N(Ch : Char; const Str : AnsiString) : Integer;
asm
  test      edx, edx
  jz        @@NullString
  mov       ecx, [edx-4]
  push      ebx
  mov       ebx, eax
  cmp       ecx, 16
  jl        @@Small
@@NotSmall:
  mov       ah, al           {Fill each Byte of XMM1 with AL}
  movd      xmm1, eax
  pshuflw   xmm1, xmm1, 0
  pshufd    xmm1, xmm1, 0
@@First16:
  movups    xmm0, [edx]      {Unaligned}
  pcmpeqb   xmm0, xmm1       {Compare First 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@FoundStart     {Exit on any Match}
  cmp       ecx, 32
  jl        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  sub       ecx, 16          {Align Block Reads}
  push      ecx
  mov       eax, edx
  neg       eax
  and       eax, 15
  add       edx, ecx
  neg       ecx
  add       ecx, eax
@@Loop:
  movaps    xmm0, [edx+ecx]  {Aligned}
  pcmpeqb   xmm0, xmm1       {Compare Next 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@Found          {Exit on any Match}
  add       ecx, 16
  jle       @@Loop
  pop       eax              {Check Remaining Characters}
  add       edx, 16
  add       eax, ecx         {Count from Last Loop End Position}
  jmp       dword ptr [@@JumpTable2-ecx*4]
  nop
  nop
@@NullString:
  xor       eax, eax         {Result = 0}
  ret
  nop
@@FoundStart:
  bsf       eax, eax         {Get Set Bit}
  pop       ebx
  inc       eax              {Set Result}
  ret
  nop
  nop
@@Found:
  pop       edx
  bsf       eax, eax         {Get Set Bit}
  add       edx, ecx
  pop       ebx
  lea       eax, [eax+edx+1] {Set Result}
  ret
@@Medium:
  add       edx, ecx         {End of String}
  mov       eax, 16          {Count from 16}
  jmp       dword ptr [@@JumpTable1-64-ecx*4]
  nop
  nop
@@Small:
  add       edx, ecx         {End of String}
  xor       eax, eax         {Count from 0}
  jmp       dword ptr [@@JumpTable1-ecx*4]
  nop
@@JumpTable1:
  dd        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  dd        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16
@@JumpTable2:
  dd        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  dd        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound
@@16:
  add       eax, 1
  cmp       bl, [edx-16]
  je        @@Done
@@15:
  add       eax, 1
  cmp       bl, [edx-15]
  je        @@Done
@@14:
  add       eax, 1
  cmp       bl, [edx-14]
  je        @@Done
@@13:
  add       eax, 1
  cmp       bl, [edx-13]
  je        @@Done
@@12:
  add       eax, 1
  cmp       bl, [edx-12]
  je        @@Done
@@11:
  add       eax, 1
  cmp       bl, [edx-11]
  je        @@Done
@@10:
  add       eax, 1
  cmp       bl, [edx-10]
  je        @@Done
@@09:
  add       eax, 1
  cmp       bl, [edx-9]
  je        @@Done
@@08:
  add       eax, 1
  cmp       bl, [edx-8]
  je        @@Done
@@07:
  add       eax, 1
  cmp       bl, [edx-7]
  je        @@Done
@@06:
  add       eax, 1
  cmp       bl, [edx-6]
  je        @@Done
@@05:
  add       eax, 1
  cmp       bl, [edx-5]
  je        @@Done
@@04:
  add       eax, 1
  cmp       bl, [edx-4]
  je        @@Done
@@03:
  add       eax, 1
  cmp       bl, [edx-3]
  je        @@Done
@@02:
  add       eax, 1
  cmp       bl, [edx-2]
  je        @@Done
@@01:
  add       eax, 1
  cmp       bl, [edx-1]
  je        @@Done
@@NotFound:
  xor       eax, eax
  pop       ebx
  ret
@@Done:
  pop       ebx
end;

//Author:            John O'Harrow
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32, SSE, SSE2
//Original Name:     CharPosJOH_SSE2

function CharPosFastcodePMD(Ch : Char; const Str : AnsiString) : Integer;
asm
  test      edx, edx
  jz        @@NullString
  mov       ecx, [edx-4]
  push      ebx
  mov       ebx, eax
  cmp       ecx, 16
  jl        @@Small
@@NotSmall:
  mov       ah, al           {Fill each Byte of XMM1 with AL}
  movd      xmm1, eax
  pshuflw   xmm1, xmm1, 0
  pshufd    xmm1, xmm1, 0
@@First16:
  movups    xmm0, [edx]      {Unaligned}
  pcmpeqb   xmm0, xmm1       {Compare First 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@FoundStart     {Exit on any Match}
  cmp       ecx, 32
  jl        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  sub       ecx, 16          {Align Block Reads}
  push      ecx
  mov       eax, edx
  neg       eax
  and       eax, 15
  add       edx, ecx
  neg       ecx
  add       ecx, eax
@@Loop:
  movaps    xmm0, [edx+ecx]  {Aligned}
  pcmpeqb   xmm0, xmm1       {Compare Next 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@Found          {Exit on any Match}
  add       ecx, 16
  jle       @@Loop
  pop       eax              {Check Remaining Characters}
  add       edx, 16
  add       eax, ecx         {Count from Last Loop End Position}
  jmp       dword ptr [@@JumpTable2-ecx*4]
  nop
  nop
@@NullString:
  xor       eax, eax         {Result = 0}
  ret
  nop
@@FoundStart:
  bsf       eax, eax         {Get Set Bit}
  pop       ebx
  inc       eax              {Set Result}
  ret
  nop
  nop
@@Found:
  pop       edx
  bsf       eax, eax         {Get Set Bit}
  add       edx, ecx
  pop       ebx
  lea       eax, [eax+edx+1] {Set Result}
  ret
@@Medium:
  add       edx, ecx         {End of String}
  mov       eax, 16          {Count from 16}
  jmp       dword ptr [@@JumpTable1-64-ecx*4]
  nop
  nop
@@Small:
  add       edx, ecx         {End of String}
  xor       eax, eax         {Count from 0}
  jmp       dword ptr [@@JumpTable1-ecx*4]
  nop
@@JumpTable1:
  dd        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  dd        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16
@@JumpTable2:
  dd        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  dd        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound
@@16:
  add       eax, 1
  cmp       bl, [edx-16]
  je        @@Done
@@15:
  add       eax, 1
  cmp       bl, [edx-15]
  je        @@Done
@@14:
  add       eax, 1
  cmp       bl, [edx-14]
  je        @@Done
@@13:
  add       eax, 1
  cmp       bl, [edx-13]
  je        @@Done
@@12:
  add       eax, 1
  cmp       bl, [edx-12]
  je        @@Done
@@11:
  add       eax, 1
  cmp       bl, [edx-11]
  je        @@Done
@@10:
  add       eax, 1
  cmp       bl, [edx-10]
  je        @@Done
@@09:
  add       eax, 1
  cmp       bl, [edx-9]
  je        @@Done
@@08:
  add       eax, 1
  cmp       bl, [edx-8]
  je        @@Done
@@07:
  add       eax, 1
  cmp       bl, [edx-7]
  je        @@Done
@@06:
  add       eax, 1
  cmp       bl, [edx-6]
  je        @@Done
@@05:
  add       eax, 1
  cmp       bl, [edx-5]
  je        @@Done
@@04:
  add       eax, 1
  cmp       bl, [edx-4]
  je        @@Done
@@03:
  add       eax, 1
  cmp       bl, [edx-3]
  je        @@Done
@@02:
  add       eax, 1
  cmp       bl, [edx-2]
  je        @@Done
@@01:
  add       eax, 1
  cmp       bl, [edx-1]
  je        @@Done
@@NotFound:
  xor       eax, eax
  pop       ebx
  ret
@@Done:
  pop       ebx
end;

//Author:            John O'Harrow
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32, SSE
//Original Name:     CharPosJOH_SSE

function CharPosFastcodePMB(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET
@@NotSmall:
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PSHUFW    MM0, MM0, 0
  PUSH      ECX
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7
  SUB       ECX, EAX
@@Loop:                      {Loop Unrolled 2X}
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JL        @@loop
@@Last8:
  PCMPEQB   MM0, [EDX-8]
  POP       ECX              {Original Length}
  PMOVMSKB  EAX, MM0
  TEST      EAX, EAX
  JNZ       @@Matched2
  EMMS
  RET                        {Finished}
@@Matched:                   {Set Result from 1st Match in EcX}
  POP       EDX              {Original Length}
  ADD       ECX, EDX
@@Matched2:
  EMMS
  BSF       EDX, EAX
  LEA       EAX, [EDX+ECX-7]
end;

//Author:            John O'Harrow
//Optimized for:     AMD 64 Opteron, FX, XP
//Instructionset(s): IA32, SSE, SSE2
//Original Name:     CharPosJOH_SSE2

function CharPosFastcodeAMD64(Ch : Char; const Str : AnsiString) : Integer;
asm
  test      edx, edx
  jz        @@NullString
  mov       ecx, [edx-4]
  push      ebx
  mov       ebx, eax
  cmp       ecx, 16
  jl        @@Small
@@NotSmall:
  mov       ah, al           {Fill each Byte of XMM1 with AL}
  movd      xmm1, eax
  pshuflw   xmm1, xmm1, 0
  pshufd    xmm1, xmm1, 0
@@First16:
  movups    xmm0, [edx]      {Unaligned}
  pcmpeqb   xmm0, xmm1       {Compare First 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@FoundStart     {Exit on any Match}
  cmp       ecx, 32
  jl        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  sub       ecx, 16          {Align Block Reads}
  push      ecx
  mov       eax, edx
  neg       eax
  and       eax, 15
  add       edx, ecx
  neg       ecx
  add       ecx, eax
@@Loop:
  movaps    xmm0, [edx+ecx]  {Aligned}
  pcmpeqb   xmm0, xmm1       {Compare Next 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@Found          {Exit on any Match}
  add       ecx, 16
  jle       @@Loop
  pop       eax              {Check Remaining Characters}
  add       edx, 16
  add       eax, ecx         {Count from Last Loop End Position}
  jmp       dword ptr [@@JumpTable2-ecx*4]
  nop
  nop
@@NullString:
  xor       eax, eax         {Result = 0}
  ret
  nop
@@FoundStart:
  bsf       eax, eax         {Get Set Bit}
  pop       ebx
  inc       eax              {Set Result}
  ret
  nop
  nop
@@Found:
  pop       edx
  bsf       eax, eax         {Get Set Bit}
  add       edx, ecx
  pop       ebx
  lea       eax, [eax+edx+1] {Set Result}
  ret
@@Medium:
  add       edx, ecx         {End of String}
  mov       eax, 16          {Count from 16}
  jmp       dword ptr [@@JumpTable1-64-ecx*4]
  nop
  nop
@@Small:
  add       edx, ecx         {End of String}
  xor       eax, eax         {Count from 0}
  jmp       dword ptr [@@JumpTable1-ecx*4]
  nop
@@JumpTable1:
  dd        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  dd        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16
@@JumpTable2:
  dd        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  dd        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound
@@16:
  add       eax, 1
  cmp       bl, [edx-16]
  je        @@Done
@@15:
  add       eax, 1
  cmp       bl, [edx-15]
  je        @@Done
@@14:
  add       eax, 1
  cmp       bl, [edx-14]
  je        @@Done
@@13:
  add       eax, 1
  cmp       bl, [edx-13]
  je        @@Done
@@12:
  add       eax, 1
  cmp       bl, [edx-12]
  je        @@Done
@@11:
  add       eax, 1
  cmp       bl, [edx-11]
  je        @@Done
@@10:
  add       eax, 1
  cmp       bl, [edx-10]
  je        @@Done
@@09:
  add       eax, 1
  cmp       bl, [edx-9]
  je        @@Done
@@08:
  add       eax, 1
  cmp       bl, [edx-8]
  je        @@Done
@@07:
  add       eax, 1
  cmp       bl, [edx-7]
  je        @@Done
@@06:
  add       eax, 1
  cmp       bl, [edx-6]
  je        @@Done
@@05:
  add       eax, 1
  cmp       bl, [edx-5]
  je        @@Done
@@04:
  add       eax, 1
  cmp       bl, [edx-4]
  je        @@Done
@@03:
  add       eax, 1
  cmp       bl, [edx-3]
  je        @@Done
@@02:
  add       eax, 1
  cmp       bl, [edx-2]
  je        @@Done
@@01:
  add       eax, 1
  cmp       bl, [edx-1]
  je        @@Done
@@NotFound:
  xor       eax, eax
  pop       ebx
  ret
@@Done:
  pop       ebx
end;

//Author:            John O'Harrow
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32, SSE
//Original Name:     CharPosJOH_SSE

function CharPosFastcodeXP(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET
@@NotSmall:
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PSHUFW    MM0, MM0, 0
  PUSH      ECX
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7
  SUB       ECX, EAX
@@Loop:                      {Loop Unrolled 2X}
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JL        @@loop
@@Last8:
  PCMPEQB   MM0, [EDX-8]
  POP       ECX              {Original Length}
  PMOVMSKB  EAX, MM0
  TEST      EAX, EAX
  JNZ       @@Matched2
  EMMS
  RET                        {Finished}
@@Matched:                   {Set Result from 1st Match in EcX}
  POP       EDX              {Original Length}
  ADD       ECX, EDX
@@Matched2:
  EMMS
  BSF       EDX, EAX
  LEA       EAX, [EDX+ECX-7]
end;

//Author:            John O'Harrow
//Optimized for:     Blended
//Instructionset(s): IA32, MMX
//Original Name:     CharPosJOH_MMX

function CharPosFastcodeBlended(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET

@@NotSmall:                  {Length(Str) > 8}
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PUNPCKLWD MM0, MM0
  PUNPCKLDQ MM0, MM0
  PUSH      ECX              {Save Length}
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:                     {Align to Previous 8 Byte Boundary}
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7           {EAX -> 0 or 4}
  SUB       ECX, EAX
@@Loop:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JL        @@Loop
@@Last8:
  MOVQ      MM1, [EDX-8]     {Position for Last 8 Used Characters}
  POP       EDX              {Original Length}
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched2       {Exit on Match at any Position}
  EMMS
  RET                        {Finished - Not Found}
@@Matched:                   {Set Result from 1st Match in EDX}
  POP       EDX              {Original Length}
  ADD       EDX, ECX
@@Matched2:
  EMMS
  SUB       EDX, 8           {Adjust for Extra ADD ECX,8 in Loop}
  TEST      AL, AL
  JNZ       @@MatchDone      {Match at Position 1 or 2}
  TEST      AH, AH
  JNZ       @@Match1         {Match at Position 3 or 4}
  SHR       EAX, 16
  TEST      AL, AL
  JNZ       @@Match2         {Match at Position 5 or 6}
  SHR       EAX, 8
  ADD       EDX, 6
  JMP       @@MatchDone
@@Match2:
  ADD       EDX, 4
  JMP       @@MatchDone
@@Match1:
  SHR       EAX, 8           {AL <- AH}
  ADD       EDX, 2
@@MatchDone:
  XOR       EAX, 2
  AND       EAX, 3           {EAX <- 1 or 2}
  ADD       EAX, EDX
end;

//Author:            Aleksandr Sharahov
//Instructionset(s): IA32
//Original Name:     CharPosShaPas2

function CharPosFastcodeRTL(Ch : Char; const Str : AnsiString) : Integer;
const
  cMinusOnes = -$01010101;
  cSignums   =  $80808080;
var
  Ndx, Len, c, d, Mask, Sign, Save, SaveEnd: integer;
label
  Small, Middle, Large,
  Found0, Found1, Found2, Found3, NotFound,
  Matched, MatchedPlus1, MatchedMinus1, NotMatched,
  Return;
begin
  c:=integer(@pchar(integer(Str))[-4]);
  if c=-4 then goto NotFound;
  Len:=pinteger(c)^;
  if Len>24 then goto Large;
  Ndx:=4;
  if Ndx>Len then goto Small;

Middle:
  if pchar(c)[Ndx+0]=ch then goto Found0;
  if pchar(c)[Ndx+1]=ch then goto Found1;
  if pchar(c)[Ndx+2]=ch then goto Found2;
  if pchar(c)[Ndx+3]=ch then goto Found3;
  inc(Ndx,4);
  if Ndx<=Len then goto Middle;

  Ndx:=Len+1;
  if pchar(c)[Len+1]=ch then goto Found0;
  if pchar(c)[Len+2]=ch then goto Found1;
  if pchar(c)[Len+3]<>ch then goto NotFound;
  Result:=integer(@pchar(Ndx)[-1]); exit;
  goto Return; //drop Ndx

Small:
  if Len=0 then goto NotFound; if pchar(c)[Ndx+0]=ch then goto Found0;
  if Len=1 then goto NotFound; if pchar(c)[Ndx+1]=ch then goto Found1;
  if Len=2 then goto NotFound; if pchar(c)[Ndx+2]<>ch then goto NotFound;

Found2: Result:=integer(@pchar(Ndx)[-1]); exit;
Found1: Result:=integer(@pchar(Ndx)[-2]); exit;
Found0: Result:=integer(@pchar(Ndx)[-3]); exit;
NotFound: Result:=0; exit;
  goto NotFound; //kill warning 'Ndx might not have been initialized'
Found3: Result:=integer(@pchar(Ndx)[0]); exit;
  goto Return; //drop Ndx

Large:
  Save:=c;
    Mask:=ord(ch);
  Ndx:=integer(@pchar(c)[+4]);

    d:=Mask;
  inc(Len,c);
  SaveEnd:=Len;
    Mask:=(Mask shl 8);
  inc(Len,+4-16+3);

    Mask:=Mask or d;
  Len:=Len and (-4);
    d:=Mask;
  cardinal(Sign):=cSignums;

    Mask:=Mask shl 16;
  c:=pintegerArray(Ndx)[0];
    Mask:=Mask or d;
  inc(Ndx,4);

    c:=c xor Mask;
    d:=integer(@pchar(c)[cMinusOnes]);
    c:=c xor (-1);
    c:=c and d;
    d:=Mask;

    if c and Sign<>0 then goto MatchedMinus1;
    Ndx:=Ndx and (-4);
    d:=d xor pintegerArray(Ndx)[0];

    if cardinal(Ndx)<cardinal(Len) then repeat;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=Mask;

      d:=d xor pintegerArray(Ndx)[1];
      if c and Sign<>0 then goto Matched;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=pintegerArray(Ndx)[2];
      if c and Sign<>0 then goto MatchedPlus1;
      d:=d xor Mask;

      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      inc(Ndx,12);
      c:=c and d;

      //if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if c and Sign<>0 then goto MatchedMinus1;
      d:=d xor pintegerArray(Ndx)[0];
      until cardinal(Ndx)>=cardinal(Len);

    Len:=SaveEnd;
    while true do begin;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      inc(Ndx,4);
      if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if cardinal(Ndx)<=cardinal(Len)
      then d:=d xor pintegerArray(Ndx)[0]
      else begin;
        if Len=0 then goto NotMatched;
        d:=d xor pintegerArray(Len)[0];
        Ndx:=Len;
        Len:=0;
        end
      end;

NotMatched:
  Result:=0; exit;

MatchedPlus1:   inc(Ndx,8);
MatchedMinus1:  dec(Ndx,4);
Matched:
    c:=c and Sign;
    dec(Ndx,integer(Save)+2);
    if word(c)=0 then begin;
      c:=c shr 16; inc(Ndx,2);
      end;
    if byte(c)<>0 then dec(Ndx);
    Result:=Ndx;
Return:
  end;

//Author:            Aleksandr Sharahov
//Instructionset(s): IA32
//Original Name:     CharPosShaPas2

function CharPosFastcodePascal(Ch : Char; const Str : AnsiString) : Integer;
const
  cMinusOnes = -$01010101;
  cSignums   =  $80808080;
var
  Ndx, Len, c, d, Mask, Sign, Save, SaveEnd: integer;
label
  Small, Middle, Large,
  Found0, Found1, Found2, Found3, NotFound,
  Matched, MatchedPlus1, MatchedMinus1, NotMatched,
  Return;
begin
  c:=integer(@pchar(integer(Str))[-4]);
  if c=-4 then goto NotFound;
  Len:=pinteger(c)^;
  if Len>24 then goto Large;
  Ndx:=4;
  if Ndx>Len then goto Small;

Middle:
  if pchar(c)[Ndx+0]=ch then goto Found0;
  if pchar(c)[Ndx+1]=ch then goto Found1;
  if pchar(c)[Ndx+2]=ch then goto Found2;
  if pchar(c)[Ndx+3]=ch then goto Found3;
  inc(Ndx,4);
  if Ndx<=Len then goto Middle;

  Ndx:=Len+1;
  if pchar(c)[Len+1]=ch then goto Found0;
  if pchar(c)[Len+2]=ch then goto Found1;
  if pchar(c)[Len+3]<>ch then goto NotFound;
  Result:=integer(@pchar(Ndx)[-1]); exit;
  goto Return; //drop Ndx

Small:
  if Len=0 then goto NotFound; if pchar(c)[Ndx+0]=ch then goto Found0;
  if Len=1 then goto NotFound; if pchar(c)[Ndx+1]=ch then goto Found1;
  if Len=2 then goto NotFound; if pchar(c)[Ndx+2]<>ch then goto NotFound;

Found2: Result:=integer(@pchar(Ndx)[-1]); exit;
Found1: Result:=integer(@pchar(Ndx)[-2]); exit;
Found0: Result:=integer(@pchar(Ndx)[-3]); exit;
NotFound: Result:=0; exit;
  goto NotFound; //kill warning 'Ndx might not have been initialized'
Found3: Result:=integer(@pchar(Ndx)[0]); exit;
  goto Return; //drop Ndx

Large:
  Save:=c;
    Mask:=ord(ch);
  Ndx:=integer(@pchar(c)[+4]);

    d:=Mask;
  inc(Len,c);
  SaveEnd:=Len;
    Mask:=(Mask shl 8);
  inc(Len,+4-16+3);

    Mask:=Mask or d;
  Len:=Len and (-4);
    d:=Mask;
  cardinal(Sign):=cSignums;

    Mask:=Mask shl 16;
  c:=pintegerArray(Ndx)[0];
    Mask:=Mask or d;
  inc(Ndx,4);

    c:=c xor Mask;
    d:=integer(@pchar(c)[cMinusOnes]);
    c:=c xor (-1);
    c:=c and d;
    d:=Mask;

    if c and Sign<>0 then goto MatchedMinus1;
    Ndx:=Ndx and (-4);
    d:=d xor pintegerArray(Ndx)[0];

    if cardinal(Ndx)<cardinal(Len) then repeat;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=Mask;

      d:=d xor pintegerArray(Ndx)[1];
      if c and Sign<>0 then goto Matched;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      d:=pintegerArray(Ndx)[2];
      if c and Sign<>0 then goto MatchedPlus1;
      d:=d xor Mask;

      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      inc(Ndx,12);
      c:=c and d;

      //if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if c and Sign<>0 then goto MatchedMinus1;
      d:=d xor pintegerArray(Ndx)[0];
      until cardinal(Ndx)>=cardinal(Len);

    Len:=SaveEnd;
    while true do begin;
      c:=integer(@pchar(d)[cMinusOnes]);
      d:=d xor (-1);
      c:=c and d;
      inc(Ndx,4);
      if c and Sign<>0 then goto MatchedMinus1;
      d:=Mask;
      if cardinal(Ndx)<=cardinal(Len)
      then d:=d xor pintegerArray(Ndx)[0]
      else begin;
        if Len=0 then goto NotMatched;
        d:=d xor pintegerArray(Len)[0];
        Ndx:=Len;
        Len:=0;
        end
      end;

NotMatched:
  Result:=0; exit;

MatchedPlus1:   inc(Ndx,8);
MatchedMinus1:  dec(Ndx,4);
Matched:
    c:=c and Sign;
    dec(Ndx,integer(Save)+2);
    if word(c)=0 then begin;
      c:=c shr 16; inc(Ndx,2);
      end;
    if byte(c)<>0 then dec(Ndx);
    Result:=Ndx;
Return:
  end;

end.
