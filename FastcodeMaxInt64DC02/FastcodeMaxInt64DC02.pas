unit FastcodeMaxInt64DC01;

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

function MaxFastcodeP4P(const A, B: Int64): Int64;
function MaxFastcodeP4N(const A, B: Int64): Int64;
function MaxFastcodePMD(const A, B: Int64): Int64;
function MaxFastcodePMB(const A, B: Int64): Int64;
function MaxFastcodeAMD64(const A, B: Int64): Int64;
function MaxFastcodeXP(const A, B: Int64): Int64;
function MaxFastcodeBlended(const A, B: Int64): Int64;
function MaxFastcodeRTL(const A, B: Int64): Int64;

//Use RTL Max
//function MaxFastcodePascal(const A, B: Int64): Int64;

implementation

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Intel P4 Prescott
//Instructionset(s): IA32
//Original name:     MaxShaInt64_2

function MaxFastcodeP4P(const A, B: Int64): Int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setl cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Intel P4 Northwood
//Instructionset(s): IA32
//Original name:     MaxShaInt64_2

function MaxFastcodeP4N(const A, B: Int64): Int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setl cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32
//Original name:     MaxShaInt64_2

function MaxFastcodePMD(const A, B: Int64): Int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setl cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32
//Original name:     MaxShaInt64_2

function MaxFastcodePMB(const A, B: Int64): Int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setl cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): IA32
//Original name:     MaxShaInt64

function MaxFastcodeAMD64(const A, B: Int64): Int64;
asm
  xor ecx,ecx
  mov eax,[ebp+$10]
  mov edx,[ebp+$14]
  sub eax,[ebp+$08]
  sbb edx,[ebp+$0C]
  setl cl
  sub ecx,1
  and eax,ecx
  and edx,ecx
  add eax,[ebp+$08]
  adc edx,[ebp+$0C]
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32
//Original name:     MaxShaInt64

function MaxFastcodeXP(const A, B: Int64): Int64;
asm
  xor ecx,ecx
  mov eax,[ebp+$10]
  mov edx,[ebp+$14]
  sub eax,[ebp+$08]
  sbb edx,[ebp+$0C]
  setl cl
  sub ecx,1
  and eax,ecx
  and edx,ecx
  add eax,[ebp+$08]
  adc edx,[ebp+$0C]
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
//Original name:     MaxShaInt64_2

function MaxFastcodeBlended(const A, B: Int64): Int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setl cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:     MaxShaInt64_2

function MaxFastcodeRTL(const A, B: Int64): Int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setl cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

//Author:
//Date:
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:

//function MaxFastcodePascal(const A, B: Int64): Int64;

end.
