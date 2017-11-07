unit FastcodeStrCopyDC02;

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
 * Contributor(s):
 *
 * ***** END LICENSE BLOCK ***** *)

//Version : 0.2
//Only plain function calls supported
//Last update 20/9 2005

//Change log

//20/9 2005: Totally updated version 0.2 made by Dennis Christensen

interface

function StrCopyFastcodeP4P(Dest: PChar; const Source: PChar): PChar;
function StrCopyFastcodeP4N(Dest: PChar; const Source: PChar): PChar;
function StrCopyFastcodePMD(Dest: PChar; const Source: PChar): PChar;
function StrCopyFastcodePMB(Dest: PChar; const Source: PChar): PChar;
function StrCopyFastcodeAMD64(Dest: PChar; const Source: PChar): PChar;
function StrCopyFastcodeXP(Dest: PChar; const Source: PChar): PChar;
function StrCopyFastcodeBlended(Dest: PChar; const Source: PChar): PChar;
function StrCopyFastcodeRTL(Dest: PChar; const Source: PChar): PChar;
function StrCopyFastcodePascal(Dest: PChar; const Source: PChar): PChar;

implementation

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Intel P4 Prescott
//Instructionset(s): IA32
//Original name:     StrCopyShaAsm3

function StrCopyFastcodeP4P(Dest: PChar; const Source: PChar): PChar;
asm
  sub edx,eax;
  test eax, 1;
  push eax;
  jz @loop;
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; mov [eax+00],cl; jz @ret;
  add eax, 1;
@loop:
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; jz @ret00;
  movzx ecx,word ptr[eax+edx+00]; cmp ecx,255; mov [eax+00],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+02]; test cl, cl; jz @ret02;
  movzx ecx,word ptr[eax+edx+02]; cmp ecx,255; mov [eax+02],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+04]; test cl, cl; jz @ret04;
  movzx ecx,word ptr[eax+edx+04]; cmp ecx,255; mov [eax+04],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+06]; test cl, cl; jz @ret06;
  movzx ecx,word ptr[eax+edx+06]; cmp ecx,255; mov [eax+06],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+08]; test cl, cl; jz @ret08;
  movzx ecx,word ptr[eax+edx+08]; cmp ecx,255; mov [eax+08],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+10]; test cl, cl; jz @ret10;
  movzx ecx,word ptr[eax+edx+10]; cmp ecx,255; mov [eax+10],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+12]; test cl, cl; jz @ret12;
  movzx ecx,word ptr[eax+edx+12]; cmp ecx,255; mov [eax+12],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+14]; test cl, cl; jz @ret14;
  movzx ecx,word ptr[eax+edx+14]; mov [eax+14],cx;
  add eax,16;
  cmp ecx,255; ja @loop;
@ret:
  pop eax; ret;
@ret00:
  mov [eax+00],cl; pop eax; ret;
@ret02:
  mov [eax+02],cl; pop eax; ret;
@ret04:
  mov [eax+04],cl; pop eax; ret;
@ret06:
  mov [eax+06],cl; pop eax; ret;
@ret08:
  mov [eax+08],cl; pop eax; ret;
@ret10:
  mov [eax+10],cl; pop eax; ret;
@ret12:
  mov [eax+12],cl; pop eax; ret;
@ret14:
  mov [eax+14],cl; pop eax; //ret;
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Intel P4 Northwood
//Instructionset(s): IA32
//Original name:     StrCopyShaAsm3

function StrCopyFastcodeP4N(Dest: PChar; const Source: PChar): PChar;
asm
  sub edx,eax;
  test eax, 1;
  push eax;
  jz @loop;
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; mov [eax+00],cl; jz @ret;
  add eax, 1;
@loop:
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; jz @ret00;
  movzx ecx,word ptr[eax+edx+00]; cmp ecx,255; mov [eax+00],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+02]; test cl, cl; jz @ret02;
  movzx ecx,word ptr[eax+edx+02]; cmp ecx,255; mov [eax+02],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+04]; test cl, cl; jz @ret04;
  movzx ecx,word ptr[eax+edx+04]; cmp ecx,255; mov [eax+04],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+06]; test cl, cl; jz @ret06;
  movzx ecx,word ptr[eax+edx+06]; cmp ecx,255; mov [eax+06],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+08]; test cl, cl; jz @ret08;
  movzx ecx,word ptr[eax+edx+08]; cmp ecx,255; mov [eax+08],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+10]; test cl, cl; jz @ret10;
  movzx ecx,word ptr[eax+edx+10]; cmp ecx,255; mov [eax+10],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+12]; test cl, cl; jz @ret12;
  movzx ecx,word ptr[eax+edx+12]; cmp ecx,255; mov [eax+12],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+14]; test cl, cl; jz @ret14;
  movzx ecx,word ptr[eax+edx+14]; mov [eax+14],cx;
  add eax,16;
  cmp ecx,255; ja @loop;
@ret:
  pop eax; ret;
@ret00:
  mov [eax+00],cl; pop eax; ret;
@ret02:
  mov [eax+02],cl; pop eax; ret;
@ret04:
  mov [eax+04],cl; pop eax; ret;
@ret06:
  mov [eax+06],cl; pop eax; ret;
@ret08:
  mov [eax+08],cl; pop eax; ret;
@ret10:
  mov [eax+10],cl; pop eax; ret;
@ret12:
  mov [eax+12],cl; pop eax; ret;
@ret14:
  mov [eax+14],cl; pop eax; //ret;
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32
//Original name:     StrCopyJOH_IA32_a

function StrCopyFastcodePMD(Dest: PChar; const Source: PChar): PChar;
asm
  push  eax
  movzx ecx, [edx]
  mov   [eax], cl      {Copy 1st Char}
  test  cl, cl
  jz    @@Exit         {Exit if Null Terminator}
  movzx ecx, [edx+1]
  mov   [eax+1], cl    {Copy 2nd Char}
  test  cl, cl
  jz    @@Exit         {Exit if Null Terminator}
  movzx ecx, [edx+2]
  mov   [eax+2], cl    {Copy 3rd Char}
  test  cl, cl
  jz    @@Exit         {Exit if Null Terminator}
  movzx ecx, [edx+3]
  mov   [eax+3], cl    {Copy 4th Char}
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+4]
  mov   [eax+4], cl    {Copy 5th Char}
  test  cl, cl
  jz    @@Exit         {Exit if Null Terminator}
  movzx ecx, [edx+5]
  mov   [eax+5], cl    {Copy 6th Char}
  test  cl, cl
  jz    @@Exit         {Exit if Null Terminator}
  movzx ecx, [edx+6]
  mov   [eax+6], cl    {Copy 7th Char}
  test  cl, cl
  jz    @@Exit         {Exit if Null Terminator}
  movzx ecx, [edx+7]
  mov   [eax+7], cl    {Copy 8th Char}
  test  cl, cl
  jz    @@Exit         {Exit if Null Terminator}
  mov   ecx, edx       {DWORD Align}
  and   ecx, 3
  sub   edx, ecx
  sub   eax, ecx
@@Loop:
  add   edx, 8
  add   eax, 8
  movzx ecx, [edx]     {Get Next Char}
  test  cl, cl
  je    @@Done1        {Exit if Null Terminator}
  movzx ecx, [edx+1]   {Get Next Char}
  test  cl, cl
  je    @@Done2        {Exit if Null Terminator}
  movzx ecx, [edx+2]   {Get Next Char}
  test  cl, cl
  je    @@Done3        {Exit if Null Terminator}
  mov   ecx, [edx]     {Copy 4 Chars}
  mov   [eax], ecx
  test  ecx, $FF000000 {Check Last Character for Null}
  je    @@Done         {Exit if Null Terminator}
  movzx ecx, [edx+4]   {Get Next Char}
  test  cl, cl
  je    @@Done5        {Exit if Null Terminator}
  movzx ecx, [edx+5]   {Get Next Char}
  test  cl, cl
  je    @@Done6        {Exit if Null Terminator}
  movzx ecx, [edx+6]   {Get Next Char}
  test  cl, cl
  je    @@Done7        {Exit if Null Terminator}
  mov   ecx, [edx+4]   {Copy 4 Chars}
  mov   [eax+4], ecx
  test  ecx, $FF000000 {Check Last Character for Null}
  jne   @@Loop         {Loop if Not Null Terminator}
@@Exit:
  pop   eax
  ret
@@Done7:
  mov   edx, [edx+3]   {Copy Final 4 Chars}
  mov   [eax+3], edx
  jmp   @@Done
@@Done6:
  mov   edx, [edx+2]   {Copy Final 4 Chars}
  mov   [eax+2], edx
  jmp   @@Done
@@Done5:
  mov   [eax+4], cl    {Copy Final Char}
  jmp   @@Done
@@Done3:
  mov   [eax+2], cl    {Copy Final 3 Chars}
@@Done2:
  mov   dx, [edx]      {Copy Final 2 Chars}
  mov   [eax], dx
  jmp   @@Done
@@Done1:
  mov   [eax], cl      {Copy Final Char}
@@Done:
  pop   eax
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32
//Original name:     StrCopyShaAsm3

function StrCopyFastcodePMB(Dest: PChar; const Source: PChar): PChar;
asm
  sub edx,eax;
  test eax, 1;
  push eax;
  jz @loop;
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; mov [eax+00],cl; jz @ret;
  add eax, 1;
@loop:
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; jz @ret00;
  movzx ecx,word ptr[eax+edx+00]; cmp ecx,255; mov [eax+00],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+02]; test cl, cl; jz @ret02;
  movzx ecx,word ptr[eax+edx+02]; cmp ecx,255; mov [eax+02],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+04]; test cl, cl; jz @ret04;
  movzx ecx,word ptr[eax+edx+04]; cmp ecx,255; mov [eax+04],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+06]; test cl, cl; jz @ret06;
  movzx ecx,word ptr[eax+edx+06]; cmp ecx,255; mov [eax+06],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+08]; test cl, cl; jz @ret08;
  movzx ecx,word ptr[eax+edx+08]; cmp ecx,255; mov [eax+08],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+10]; test cl, cl; jz @ret10;
  movzx ecx,word ptr[eax+edx+10]; cmp ecx,255; mov [eax+10],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+12]; test cl, cl; jz @ret12;
  movzx ecx,word ptr[eax+edx+12]; cmp ecx,255; mov [eax+12],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+14]; test cl, cl; jz @ret14;
  movzx ecx,word ptr[eax+edx+14]; mov [eax+14],cx;
  add eax,16;
  cmp ecx,255; ja @loop;
@ret:
  pop eax; ret;
@ret00:
  mov [eax+00],cl; pop eax; ret;
@ret02:
  mov [eax+02],cl; pop eax; ret;
@ret04:
  mov [eax+04],cl; pop eax; ret;
@ret06:
  mov [eax+06],cl; pop eax; ret;
@ret08:
  mov [eax+08],cl; pop eax; ret;
@ret10:
  mov [eax+10],cl; pop eax; ret;
@ret12:
  mov [eax+12],cl; pop eax; ret;
@ret14:
  mov [eax+14],cl; pop eax; //ret;
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): IA32
//Original name:     StrCopyShaAsm2

function StrCopyFastcodeAMD64(Dest: PChar; const Source: PChar): PChar;
asm
  push eax;
  sub edx,eax;
@loop:
  movzx ecx,[eax+edx+00]; test cl,cl; mov [eax+00],cl; jz @ret;
  movzx ecx,[eax+edx+01]; test cl,cl; mov [eax+01],cl; jz @ret;
  movzx ecx,[eax+edx+02]; test cl,cl; mov [eax+02],cl; jz @ret;
  movzx ecx,[eax+edx+03]; test cl,cl; mov [eax+03],cl; jz @ret;
  movzx ecx,[eax+edx+04]; test cl,cl; mov [eax+04],cl; jz @ret;
  movzx ecx,[eax+edx+05]; test cl,cl; mov [eax+05],cl; jz @ret;
  movzx ecx,[eax+edx+06]; test cl,cl; mov [eax+06],cl; jz @ret;
  movzx ecx,[eax+edx+07]; test cl,cl; mov [eax+07],cl; jz @ret;
  movzx ecx,[eax+edx+08]; test cl,cl; mov [eax+08],cl; jz @ret;
  movzx ecx,[eax+edx+09]; test cl,cl; mov [eax+09],cl; jz @ret;
  movzx ecx,[eax+edx+10]; test cl,cl; mov [eax+10],cl; jz @ret;
  movzx ecx,[eax+edx+11]; test cl,cl; mov [eax+11],cl; jz @ret;
  movzx ecx,[eax+edx+12]; test cl,cl; mov [eax+12],cl; jz @ret;
  movzx ecx,[eax+edx+13]; test cl,cl; mov [eax+13],cl; jz @ret;
  movzx ecx,[eax+edx+14]; test cl,cl; mov [eax+14],cl; jz @ret;
  movzx ecx,[eax+edx+15]; test cl,cl; mov [eax+15],cl; jz @ret;
  movzx ecx,[eax+edx+16]; test cl,cl; mov [eax+16],cl; jz @ret;
  movzx ecx,[eax+edx+17]; test cl,cl; mov [eax+17],cl; jz @ret;
  movzx ecx,[eax+edx+18]; test cl,cl; mov [eax+18],cl; jz @ret;
  movzx ecx,[eax+edx+19]; test cl,cl; mov [eax+19],cl; jz @ret;
  movzx ecx,[eax+edx+20]; test cl,cl; mov [eax+20],cl; jz @ret;
  movzx ecx,[eax+edx+21]; test cl,cl; mov [eax+21],cl; jz @ret;
  movzx ecx,[eax+edx+22]; test cl,cl; mov [eax+22],cl; jz @ret;
  movzx ecx,[eax+edx+23]; test cl,cl; mov [eax+23],cl; jz @ret;
  movzx ecx,[eax+edx+24]; test cl,cl; mov [eax+24],cl; jz @ret;
  movzx ecx,[eax+edx+25]; test cl,cl; mov [eax+25],cl; jz @ret;
  movzx ecx,[eax+edx+26]; test cl,cl; mov [eax+26],cl; jz @ret;
  movzx ecx,[eax+edx+27]; test cl,cl; mov [eax+27],cl; jz @ret;
  movzx ecx,[eax+edx+28]; test cl,cl; mov [eax+28],cl; jz @ret;
  movzx ecx,[eax+edx+29]; test cl,cl; mov [eax+29],cl; jz @ret;
  movzx ecx,[eax+edx+30]; test cl,cl; mov [eax+30],cl; jz @ret;
  movzx ecx,[eax+edx+31]; mov [eax+31],cl;
  add eax,32;
  test cl,cl; jnz @loop;
@ret:
  pop eax;
end;

//Author:            Atle Smelver
//Date:
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32
//Original name:     StrCopyAS_IA32_6

function StrCopyFastcodeXP(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  push    ebx
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     bl, [eax+edx+2]
  jz     @Move2

  xor     bh, [eax+edx+3]
  mov     [eax+2], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     bl, [eax+edx+6]
  jz     @Move4

  xor     bh, [eax+edx+7]
  mov     [eax+6], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     bl, [eax+edx+10]
  jz     @Move6

  xor     bh, [eax+edx+11]
  mov     [eax+10], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     bl, [eax+edx+14]
  jz     @Move8

  xor     bh, [eax+edx+15]
  mov     [eax+14], bx
  jnz    @Block2

@Endit1:

  pop     ebx
  pop     eax
  ret

@Move1:

  mov     [eax], cl
  jmp    @Endit1

@Move2:

  mov     [eax+2], bl
  jmp    @Endit1

@Move3:

  mov     [eax+4], cl
  jmp    @Endit1

@Move4:

  mov     [eax+6], bl
  jmp    @Endit1

@Move5:

  mov     [eax+8], cl
  jmp    @Endit1

@Move6:

  mov     [eax+10], bl
  jmp    @Endit1

@Move7:

  mov     [eax+12], cl
  jmp    @Endit1

@Move8:

  mov     [eax+14], bl
  jmp    @Endit1

@block2:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     bl, [eax+edx+18]
  jz      @Move10

  xor     bh, [eax+edx+19]
  mov     [eax+18], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     bl, [eax+edx+22]
  jz       @Move12

  xor     bh, [eax+edx+23]
  mov     [eax+22], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     bl, [eax+edx+26]
  jz      @Move14

  xor     bh, [eax+edx+27]
  mov     [eax+26], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     bl, [eax+edx+30]
  jz      @Move16

  xor     bh, [eax+edx+31]
  mov     [eax+30], bx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Move9:

  mov    [eax+16], cl
  jmp    @Endit2

@Move10:

  mov    [eax+18], bl
  jmp    @Endit2

@Move11:

  mov    [eax+20], cl
  jmp    @Endit2

@Move12:

  mov    [eax+22], bl
  jmp    @Endit2

@Move13:

  mov    [eax+24], cl
  jmp    @Endit2

@Move14:

  mov    [eax+26], bl
  jmp    @Endit2

@Move15:

  mov    [eax+28], cl
  jmp    @Endit2

@Move16:

  mov    [eax+30], bl

@Endit2:
  pop    ebx
  pop    eax

end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
//Original name:     StrCopyShaAsm3

function StrCopyFastcodeBlended(Dest: PChar; const Source: PChar): PChar;
asm
  sub edx,eax;
  test eax, 1;
  push eax;
  jz @loop;
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; mov [eax+00],cl; jz @ret;
  add eax, 1;
@loop:
  movzx ecx,byte ptr[eax+edx+00]; test cl, cl; jz @ret00;
  movzx ecx,word ptr[eax+edx+00]; cmp ecx,255; mov [eax+00],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+02]; test cl, cl; jz @ret02;
  movzx ecx,word ptr[eax+edx+02]; cmp ecx,255; mov [eax+02],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+04]; test cl, cl; jz @ret04;
  movzx ecx,word ptr[eax+edx+04]; cmp ecx,255; mov [eax+04],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+06]; test cl, cl; jz @ret06;
  movzx ecx,word ptr[eax+edx+06]; cmp ecx,255; mov [eax+06],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+08]; test cl, cl; jz @ret08;
  movzx ecx,word ptr[eax+edx+08]; cmp ecx,255; mov [eax+08],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+10]; test cl, cl; jz @ret10;
  movzx ecx,word ptr[eax+edx+10]; cmp ecx,255; mov [eax+10],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+12]; test cl, cl; jz @ret12;
  movzx ecx,word ptr[eax+edx+12]; cmp ecx,255; mov [eax+12],cx; jbe @ret;
  movzx ecx,byte ptr[eax+edx+14]; test cl, cl; jz @ret14;
  movzx ecx,word ptr[eax+edx+14]; mov [eax+14],cx;
  add eax,16;
  cmp ecx,255; ja @loop;
@ret:
  pop eax; ret;
@ret00:
  mov [eax+00],cl; pop eax; ret;
@ret02:
  mov [eax+02],cl; pop eax; ret;
@ret04:
  mov [eax+04],cl; pop eax; ret;
@ret06:
  mov [eax+06],cl; pop eax; ret;
@ret08:
  mov [eax+08],cl; pop eax; ret;
@ret10:
  mov [eax+10],cl; pop eax; ret;
@ret12:
  mov [eax+12],cl; pop eax; ret;
@ret14:
  mov [eax+14],cl; pop eax; //ret;
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:     StrCopyShaAsm4

function StrCopyFastcodeRTL(Dest: PChar; const Source: PChar): PChar;
asm
  sub   edx, eax
  test  eax, 1
  push  eax
  jz    @loop
  movzx ecx, byte ptr[eax+edx]
  mov   [eax], cl
  test  ecx, ecx
  jz    @ret
  inc   eax
@loop:
  movzx ecx, byte ptr[eax+edx]
  test  ecx, ecx
  jz    @move0
  movzx ecx, word ptr[eax+edx]
  mov   [eax], cx
  add   eax, 2
  cmp   ecx, 255
  ja    @loop
@ret:
  pop   eax
  ret
@move0:
  mov   [eax], cl
  pop   eax
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:     StrCopyShaPas1

function StrCopyFastcodePascal(Dest: PChar; const Source: PChar): PChar;
var
  d: integer;
  ch: char;
begin
  d:=integer(Source);
  Result:=Dest;
  dec(d,integer(Dest));
  repeat
    ch:=Dest[d+00]; Dest[00]:=ch; if ch=#0 then break;
    ch:=Dest[d+01]; Dest[01]:=ch; if ch=#0 then break;
    ch:=Dest[d+02]; Dest[02]:=ch; if ch=#0 then break;
    ch:=Dest[d+03]; Dest[03]:=ch; if ch=#0 then break;
    ch:=Dest[d+04]; Dest[04]:=ch; if ch=#0 then break;
    ch:=Dest[d+05]; Dest[05]:=ch; if ch=#0 then break;
    ch:=Dest[d+06]; Dest[06]:=ch; if ch=#0 then break;
    ch:=Dest[d+07]; Dest[07]:=ch; if ch=#0 then break;
    ch:=Dest[d+08]; Dest[08]:=ch; if ch=#0 then break;
    ch:=Dest[d+09]; Dest[09]:=ch; if ch=#0 then break;
    ch:=Dest[d+10]; Dest[10]:=ch; if ch=#0 then break;
    ch:=Dest[d+11]; Dest[11]:=ch; if ch=#0 then break;
    ch:=Dest[d+12]; Dest[12]:=ch; if ch=#0 then break;
    ch:=Dest[d+13]; Dest[13]:=ch; if ch=#0 then break;
    ch:=Dest[d+14]; Dest[14]:=ch; if ch=#0 then break;
    ch:=Dest[d+15]; Dest[15]:=ch; if ch=#0 then break;
    ch:=Dest[d+16]; Dest[16]:=ch; if ch=#0 then break;
    ch:=Dest[d+17]; Dest[17]:=ch; if ch=#0 then break;
    ch:=Dest[d+18]; Dest[18]:=ch; if ch=#0 then break;
    ch:=Dest[d+19]; Dest[19]:=ch; if ch=#0 then break;
    ch:=Dest[d+20]; Dest[20]:=ch; if ch=#0 then break;
    ch:=Dest[d+21]; Dest[21]:=ch; if ch=#0 then break;
    ch:=Dest[d+22]; Dest[22]:=ch; if ch=#0 then break;
    ch:=Dest[d+23]; Dest[23]:=ch; if ch=#0 then break;
    ch:=Dest[d+24]; Dest[24]:=ch; if ch=#0 then break;
    ch:=Dest[d+25]; Dest[25]:=ch; if ch=#0 then break;
    ch:=Dest[d+26]; Dest[26]:=ch; if ch=#0 then break;
    ch:=Dest[d+27]; Dest[27]:=ch; if ch=#0 then break;
    ch:=Dest[d+28]; Dest[28]:=ch; if ch=#0 then break;
    ch:=Dest[d+29]; Dest[29]:=ch; if ch=#0 then break;
    ch:=Dest[d+30]; Dest[30]:=ch; if ch=#0 then break;
    ch:=Dest[d+31]; Dest[31]:=ch;
    inc(Dest,32);
  until ch=#0;
end;

end.
