unit FastcodeTrunc32DC01;

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

//12/9 2005: Initial version 0.1 made by Dennis Christensen
//16/9 2005: 0.2 Dothan functions added by Dennis Christensen

interface

//Use RTL Trunc for disabled targets. This is the fastest solution
//function Trunc32FastcodeP4P(const X : Extended) : Integer; overload;
function Trunc32FastcodeP4P(const X : Double) : Integer; overload;
function Trunc32FastcodeP4P(const X : Single) : Integer; overload;

//function Trunc32FastcodeP4N(const X : Extended) : Integer; overload;
function Trunc32FastcodeP4N(const X : Double) : Integer; overload;
function Trunc32FastcodeP4N(const X : Single) : Integer; overload;

//function Trunc32FastcodePMD(const X : Extended) : Integer; overload;
function Trunc32FastcodePMD(const X : Double) : Integer; overload;
function Trunc32FastcodePMD(const X : Single) : Integer; overload;

//function Trunc32FastcodePMB(const X : Extended) : Integer; overload;
function Trunc32FastcodePMB(const X : Double) : Integer; overload;
function Trunc32FastcodePMB(const X : Single) : Integer; overload;

//function Trunc32FastcodeAMD64(const X : Extended) : Integer; overload;
function Trunc32FastcodeAMD64(const X : Double) : Integer; overload;
function Trunc32FastcodeAMD64(const X : Single) : Integer; overload;

//function Trunc32FastcodeXP(const X : Extended) : Integer; overload;
//function Trunc32FastcodeXP(const X : Double) : Integer; overload;
function Trunc32FastcodeXP(const X : Single) : Integer; overload;

//function Trunc32FastcodeBlended(const X : Extended) : Integer; overload;
//function Trunc32FastcodeBlended(const X : Double) : Integer; overload;
//function Trunc32FastcodeBlended(const X : Single) : Integer; overload;

//function Trunc32FastcodeRTL(const X : Extended) : Integer; overload;
//function Trunc32FastcodeRTL(const X : Double) : Integer; overload;
//function Trunc32FastcodeRTL(const X : Single) : Integer; overload;

//function Trunc32FastcodePascal(const X : Extended) : Integer; overload;
//function Trunc32FastcodePascal(const X : Double) : Integer; overload;
//function Trunc32FastcodePascal(const X : Single) : Integer; overload;

implementation

uses
 SysUtils;

//Author:
//Date:
//Optimized for:     Intel P4 Prescott
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeP4P(const X : Extended) : Integer; overload;

//Author:            Dennis Christensen
//Date:
//Optimized for:     Intel P4 Prescott
//Instructionset(s): IA32, SSE2
//Original name:     Trunc32DoubleDKCSSE2

function Trunc32FastcodeP4P(const X : Double) : Integer; overload;
asm
 cvttsd2si eax,X
end;

//Author:            Dennis Christensen
//Date:
//Optimized for:     Intel P4 Prescott
//Instructionset(s): IA32, SSE
//Original name:     Trunc32SingleDKCSSE_2

function Trunc32FastcodeP4P(const X : Single) : Integer; overload;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvttss2si eax,X
  cmp      eax, -2147483648
  jne      @Exit
  mov      ecx,[ExceptionText]
  mov      dl,$01
  mov      eax,[$00407510]
  call     SysUtils.Exception.Create
  call     SysUtils.@RaiseExcept
  mov      eax,ecx
@Exit :
end;

//Author:
//Date:
//Optimized for:     Intel P4 Northwood
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeP4N(const X : Extended) : Integer; overload;

//Author:            Dennis Christensen
//Date:
//Optimized for:     Intel P4 Northwood
//Instructionset(s): IA32, SSE2
//Original name:     Trunc32DoubleDKCSSE2

function Trunc32FastcodeP4N(const X : Double) : Integer; overload;
asm
 cvttsd2si eax,X
end;

//Author:            Dennis Christensen
//Date:
//Optimized for:     Intel P4 Northwood
//Instructionset(s): IA32, SSE
//Original name:     Trunc32SingleDKCSSE_2

function Trunc32FastcodeP4N(const X : Single) : Integer; overload;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvttss2si eax,X
  cmp      eax, -2147483648
  jne      @Exit
  mov      ecx,[ExceptionText]
  mov      dl,$01
  mov      eax,[$00407510]
  call     SysUtils.Exception.Create
  call     SysUtils.@RaiseExcept
  mov      eax,ecx
@Exit :
end;

//Author:
//Date:
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodePMD(const X : Extended) : Integer; overload;

//Author:            Dennis Christensen
//Date:
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32, SSE2
//Original name:     Trunc32DoubleDKCSSE2

function Trunc32FastcodePMD(const X : Double) : Integer; overload;
asm
 cvttsd2si eax,X
end;

//Author:            Dennis Christensen
//Date:
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32, SSE
//Original name:     Trunc32SingleDKCSSE_2

function Trunc32FastcodePMD(const X : Single) : Integer; overload;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvttss2si eax,X
  cmp      eax, -2147483648
  jne      @Exit
  mov      ecx,[ExceptionText]
  mov      dl,$01
  mov      eax,[$00407510]
  call     SysUtils.Exception.Create
  call     SysUtils.@RaiseExcept
  mov      eax,ecx
@Exit :
end;

//Author:
//Date:
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodePMB(const X : Extended) : Integer; overload;

//Author:            Dennis Christensen
//Date:
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32, SSE2
//Original name:     Trunc32DoubleDKCSSE2

function Trunc32FastcodePMB(const X : Double) : Integer; overload;
asm
 cvttsd2si eax,X
end;

//Author:            Dennis Christensen
//Date:
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32, SSE
//Original name:     Trunc32SingleDKCSSE_2

function Trunc32FastcodePMB(const X : Single) : Integer; overload;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvttss2si eax,X
  cmp      eax, -2147483648
  jne      @Exit
  mov      ecx,[ExceptionText]
  mov      dl,$01
  mov      eax,[$00407510]
  call     SysUtils.Exception.Create
  call     SysUtils.@RaiseExcept
  mov      eax,ecx
@Exit :
end;

//Author:
//Date:
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeAMD64(const X : Extended) : Integer; overload;

//Author:            Dennis Christensen
//Date:
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): IA32, SSE2
//Original name:     Trunc32DoubleDKCSSE2

function Trunc32FastcodeAMD64(const X : Double) : Integer; overload;
asm
 cvttsd2si eax,X
end;

//Author:            Dennis Christensen
//Date:
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): IA32, SSE
//Original name:     Trunc32SingleDKCSSE_2

function Trunc32FastcodeAMD64(const X : Single) : Integer; overload;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvttss2si eax,X
  cmp      eax, -2147483648
  jne      @Exit
  mov      ecx,[ExceptionText]
  mov      dl,$01
  mov      eax,[$00407510]
  call     SysUtils.Exception.Create
  call     SysUtils.@RaiseExcept
  mov      eax,ecx
@Exit :
end;

//Author:
//Date:
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeXP(const X : Extended) : Integer; overload;

//Author:
//Date:
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeXP(const X : Double) : Integer; overload;

//Author:            Dennis Christensen
//Date:
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32, SSE
//Original name:     Trunc32SingleDKCSSE_2

function Trunc32FastcodeXP(const X : Single) : Integer; overload;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvttss2si eax,X
  cmp      eax, -2147483648
  jne      @Exit
  mov      ecx,[ExceptionText]
  mov      dl,$01
  mov      eax,[$00407510]
  call     SysUtils.Exception.Create
  call     SysUtils.@RaiseExcept
  mov      eax,ecx
@Exit :
end;

//Author:
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeBlended(const X : Extended) : Integer; overload;

//Author:
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeBlended(const X : Double) : Integer; overload;

//Author:
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeBlended(const X : Single) : Integer; overload;

//Author:
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeRTL(const X : Extended) : Integer; overload;

//Author:
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeRTL(const X : Double) : Integer; overload;

//Author:
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodeRTL(const X : Single) : Integer; overload;

//Author:
//Date:
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodePascal(const X : Extended) : Integer; overload;

//Author:
//Date:
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodePascal(const X : Double) : Integer; overload;

//Author:
//Date:
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:

//function Trunc32FastcodePascal(const X : Single) : Integer; overload;

end.
