unit FastcodeMinInt64DC01;

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
//Last update 16/9 2005

//Change log

//13/9 2005: Initial version 0.1 made by Dennis Christensen
//16/9 2005: 0.2 Dothan function added by Dennis Christensen

interface

function MinInt64FastcodeP4P(const A, B : Int64) : Int64;
function MinInt64FastcodeP4N(const A, B : Int64) : Int64;
function MinInt64FastcodePMD(const A, B : Int64) : Int64;
function MinInt64FastcodePMB(const A, B : Int64) : Int64;
function MinInt64FastcodeAMD64(const A, B : Int64) : Int64;
function MinInt64FastcodeXP(const A, B : Int64) : Int64;
function MinInt64FastcodeBlended(const A, B : Int64) : Int64;
function MinInt64FastcodeRTL(const A, B : Int64) : Int64;
function MinInt64FastcodePascal(const A, B : Int64) : Int64;

implementation

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel P4 Prescott
//Instructionset(s): IA32
//Original name:     MinInt64JOH2

function MinInt64FastcodeP4P(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel P4 Northwood
//Instructionset(s): IA32
//Original name:     MinInt64JOH2

function MinInt64FastcodeP4N(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32
//Original name:     MinInt64JOH2

function MinInt64FastcodePMD(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32
//Original name:     MinInt64JOH2

function MinInt64FastcodePMB(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2003
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): IA32
//Original name:     MinDKCAsmIA32_4

function MinInt64FastcodeAMD64(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2003
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32
//Original name:     MinDKCAsmIA32_4

function MinInt64FastcodeXP(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
//Original name:     MinInt64JOH2

function MinInt64FastcodeBlended(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:     MinInt64JOH2_a

function MinInt64FastcodeRTL(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2003
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:     MinDKCPas

function MinInt64FastcodePascal(const A, B : Int64) : Int64;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

end.
