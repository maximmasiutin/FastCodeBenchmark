unit FastcodeCharPosEYDC02;

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
 * Contributor(s): John O'Harrow and Aleksandr Sharahov
 *
 * ***** END LICENSE BLOCK ***** *)

//Version : 0.2
//Only plain function calls supported
//Last update 13/9 2005

//Change log

//24/2 2005: Initial version 0.1 made by Dennis Christensen
//1/10 2005: New Initial version 0.2 made by Dennis Christensen

interface

function CharPosFastcodeP4P(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
function CharPosFastcodeP4N(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
function CharPosFastcodePMD(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
function CharPosFastcodePMB(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
function CharPosFastcodeAMD64(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosFastcodeXP(const SearchCharacter : Char;
                           const SourceString : AnsiString;
                           Occurrence : Integer = 1;
                           StartPos   : Integer = 1): Integer;
function CharPosFastcodeBlended(const SearchCharacter : Char;
                                const SourceString : AnsiString;
                                Occurrence : Integer = 1;
                                StartPos   : Integer = 1): Integer;
function CharPosFastcodeRTL(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
function CharPosFastcodePascal(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos   : Integer = 1): Integer;

implementation

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Intel P4 Prescott
//Instructionset(s): IA32
//Original name:     CharPosEY_Sha_Asm_1

function CharPosFastcodeP4P(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
asm
          //Entry code generated: push ebp; mov ebp, esp;
          test edx, edx
          je @EmptyString

          test ecx, ecx
          jle @WrongOccurrence

          push edi
          mov edi, dword ptr [edx-04] //Length in edi
          mov ebp, dword ptr [ebp+08] //StartPos in ebp
          add edx, edi //Terminator address in edx

          test ebp, ebp
          jle @WrongStartPos

          sub ebp, edi //Negative position in ebp
          jg @WrongStartPos

          cmp al, byte ptr [edx+ebp-01]
          je @Found0

@Continue1:
          cmp al, byte ptr [edx+ebp]
          je @Found1

@Continue2:
          add ebp, 2
          jg @NotFound

          cmp al, byte ptr [edx+ebp-01]
          jne @Continue1

@Found0:
          sub ecx, 1
          jle @Found

          cmp al, byte ptr [edx+ebp]
          jne @Continue2

@Found1:
          sub ecx, 1
          jg @Continue2

          add ebp, 1
          jg @NotFound

@Found:
          mov eax, edi
          pop edi
          add eax, ebp
          pop ebp
          ret 4

@NotFound:
@WrongStartPos:
          pop edi

@WrongOccurrence:
@EmptyString:
          xor eax, eax
          //Exit code generated: pop ebp; ret 4;
  end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel P4 Northwood
//Instructionset(s): IA32
//Original name:     CharPosEY_JOH_IA32_4

{Can Read DWORD containing NULL Charatcer}
function CharPosFastcodeP4N(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
asm
  test   edx, edx
  jz     @@NotFoundExit        {Exit if SourceString = ''}
  cmp    ecx, 1
  jl     @@NotFoundExit        {Exit if Occurence < 1}
  mov    ebp, StartPos         {Safe since EBP automatically saved}
  sub    ebp, 1
  jl     @@NotFoundExit        {Exit if StartPos < 1}
  push   ebx
  add    ebp, edx
  mov    ebx, [edx-4]
  add    ebx, edx
  sub    ebp, ebx
  jge    @@NotFound            {Traps Zero Length Non-Nil String}
@@Loop:
  cmp    al, [ebx+ebp]
  je     @@Check1
@@Next:
  cmp    al, [ebx+ebp+1]
  je     @@Check2
@@Next2:
  cmp    al, [ebx+ebp+2]
  je     @@Check3
@@Next3:
  cmp    al, [ebx+ebp+3]
  je     @@Check4
@@Next4:
  add    ebp, 4
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check4:
  sub    ecx, 1
  jnz    @@Next4
  add    ebp, 3
  jge    @@NotFound
  jmp    @@SetResult
@@Check3:
  sub    ecx, 1
  jnz    @@Next3
  add    ebp, 2
  jge    @@NotFound
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jge    @@NotFound
  jmp    @@SetResult
@@Check1:
  sub    ecx, 1
  jnz    @@Next
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32
//Original name:     CharPosEY_JOH_IA32_4

{Can Read DWORD containing NULL Charatcer}
function CharPosFastcodePMD(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
asm
  test   edx, edx
  jz     @@NotFoundExit        {Exit if SourceString = ''}
  cmp    ecx, 1
  jl     @@NotFoundExit        {Exit if Occurence < 1}
  mov    ebp, StartPos         {Safe since EBP automatically saved}
  sub    ebp, 1
  jl     @@NotFoundExit        {Exit if StartPos < 1}
  push   ebx
  add    ebp, edx
  mov    ebx, [edx-4]
  add    ebx, edx
  sub    ebp, ebx
  jge    @@NotFound            {Traps Zero Length Non-Nil String}
@@Loop:
  cmp    al, [ebx+ebp]
  je     @@Check1
@@Next:
  cmp    al, [ebx+ebp+1]
  je     @@Check2
@@Next2:
  cmp    al, [ebx+ebp+2]
  je     @@Check3
@@Next3:
  cmp    al, [ebx+ebp+3]
  je     @@Check4
@@Next4:
  add    ebp, 4
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check4:
  sub    ecx, 1
  jnz    @@Next4
  add    ebp, 3
  jge    @@NotFound
  jmp    @@SetResult
@@Check3:
  sub    ecx, 1
  jnz    @@Next3
  add    ebp, 2
  jge    @@NotFound
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jge    @@NotFound
  jmp    @@SetResult
@@Check1:
  sub    ecx, 1
  jnz    @@Next
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32
//Original name:     CharPosEY_JOH_IA32_4

{Can Read DWORD containing NULL Charatcer}
function CharPosFastcodePMB(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
asm
  test   edx, edx
  jz     @@NotFoundExit        {Exit if SourceString = ''}
  cmp    ecx, 1
  jl     @@NotFoundExit        {Exit if Occurence < 1}
  mov    ebp, StartPos         {Safe since EBP automatically saved}
  sub    ebp, 1
  jl     @@NotFoundExit        {Exit if StartPos < 1}
  push   ebx
  add    ebp, edx
  mov    ebx, [edx-4]
  add    ebx, edx
  sub    ebp, ebx
  jge    @@NotFound            {Traps Zero Length Non-Nil String}
@@Loop:
  cmp    al, [ebx+ebp]
  je     @@Check1
@@Next:
  cmp    al, [ebx+ebp+1]
  je     @@Check2
@@Next2:
  cmp    al, [ebx+ebp+2]
  je     @@Check3
@@Next3:
  cmp    al, [ebx+ebp+3]
  je     @@Check4
@@Next4:
  add    ebp, 4
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check4:
  sub    ecx, 1
  jnz    @@Next4
  add    ebp, 3
  jge    @@NotFound
  jmp    @@SetResult
@@Check3:
  sub    ecx, 1
  jnz    @@Next3
  add    ebp, 2
  jge    @@NotFound
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jge    @@NotFound
  jmp    @@SetResult
@@Check1:
  sub    ecx, 1
  jnz    @@Next
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): IA32
//Original name:     CharPosEY_JOH_IA32_4

{Can Read DWORD containing NULL Charatcer}
function CharPosFastcodeAMD64(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm
  test   edx, edx
  jz     @@NotFoundExit        {Exit if SourceString = ''}
  cmp    ecx, 1
  jl     @@NotFoundExit        {Exit if Occurence < 1}
  mov    ebp, StartPos         {Safe since EBP automatically saved}
  sub    ebp, 1
  jl     @@NotFoundExit        {Exit if StartPos < 1}
  push   ebx
  add    ebp, edx
  mov    ebx, [edx-4]
  add    ebx, edx
  sub    ebp, ebx
  jge    @@NotFound            {Traps Zero Length Non-Nil String}
@@Loop:
  cmp    al, [ebx+ebp]
  je     @@Check1
@@Next:
  cmp    al, [ebx+ebp+1]
  je     @@Check2
@@Next2:
  cmp    al, [ebx+ebp+2]
  je     @@Check3
@@Next3:
  cmp    al, [ebx+ebp+3]
  je     @@Check4
@@Next4:
  add    ebp, 4
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check4:
  sub    ecx, 1
  jnz    @@Next4
  add    ebp, 3
  jge    @@NotFound
  jmp    @@SetResult
@@Check3:
  sub    ecx, 1
  jnz    @@Next3
  add    ebp, 2
  jge    @@NotFound
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jge    @@NotFound
  jmp    @@SetResult
@@Check1:
  sub    ecx, 1
  jnz    @@Next
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32
//Original name:     CharPosEY_JOH_IA32_4

{Can Read DWORD containing NULL Charatcer}
function CharPosFastcodeXP(const SearchCharacter : Char;
                           const SourceString : AnsiString;
                           Occurrence : Integer = 1;
                           StartPos   : Integer = 1): Integer;
asm
  test   edx, edx
  jz     @@NotFoundExit        {Exit if SourceString = ''}
  cmp    ecx, 1
  jl     @@NotFoundExit        {Exit if Occurence < 1}
  mov    ebp, StartPos         {Safe since EBP automatically saved}
  sub    ebp, 1
  jl     @@NotFoundExit        {Exit if StartPos < 1}
  push   ebx
  add    ebp, edx
  mov    ebx, [edx-4]
  add    ebx, edx
  sub    ebp, ebx
  jge    @@NotFound            {Traps Zero Length Non-Nil String}
@@Loop:
  cmp    al, [ebx+ebp]
  je     @@Check1
@@Next:
  cmp    al, [ebx+ebp+1]
  je     @@Check2
@@Next2:
  cmp    al, [ebx+ebp+2]
  je     @@Check3
@@Next3:
  cmp    al, [ebx+ebp+3]
  je     @@Check4
@@Next4:
  add    ebp, 4
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check4:
  sub    ecx, 1
  jnz    @@Next4
  add    ebp, 3
  jge    @@NotFound
  jmp    @@SetResult
@@Check3:
  sub    ecx, 1
  jnz    @@Next3
  add    ebp, 2
  jge    @@NotFound
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jge    @@NotFound
  jmp    @@SetResult
@@Check1:
  sub    ecx, 1
  jnz    @@Next
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
//Original name:     CharPosEY_JOH_IA32_4

{Can Read DWORD containing NULL Charatcer}
function CharPosFastcodeBlended(const SearchCharacter : Char;
                                const SourceString : AnsiString;
                                Occurrence : Integer = 1;
                                StartPos   : Integer = 1): Integer;
asm
  test   edx, edx
  jz     @@NotFoundExit        {Exit if SourceString = ''}
  cmp    ecx, 1
  jl     @@NotFoundExit        {Exit if Occurence < 1}
  mov    ebp, StartPos         {Safe since EBP automatically saved}
  sub    ebp, 1
  jl     @@NotFoundExit        {Exit if StartPos < 1}
  push   ebx
  add    ebp, edx
  mov    ebx, [edx-4]
  add    ebx, edx
  sub    ebp, ebx
  jge    @@NotFound            {Traps Zero Length Non-Nil String}
@@Loop:
  cmp    al, [ebx+ebp]
  je     @@Check1
@@Next:
  cmp    al, [ebx+ebp+1]
  je     @@Check2
@@Next2:
  cmp    al, [ebx+ebp+2]
  je     @@Check3
@@Next3:
  cmp    al, [ebx+ebp+3]
  je     @@Check4
@@Next4:
  add    ebp, 4
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check4:
  sub    ecx, 1
  jnz    @@Next4
  add    ebp, 3
  jge    @@NotFound
  jmp    @@SetResult
@@Check3:
  sub    ecx, 1
  jnz    @@Next3
  add    ebp, 2
  jge    @@NotFound
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jge    @@NotFound
  jmp    @@SetResult
@@Check1:
  sub    ecx, 1
  jnz    @@Next
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:     CharPosEY_JOH_IA32_4

{Can Read DWORD containing NULL Charatcer}
function CharPosFastcodeRTL(const SearchCharacter : Char;
                            const SourceString : AnsiString;
                            Occurrence : Integer = 1;
                            StartPos   : Integer = 1): Integer;
asm
  test   edx, edx
  jz     @@NotFoundExit        {Exit if SourceString = ''}
  cmp    ecx, 1
  jl     @@NotFoundExit        {Exit if Occurence < 1}
  mov    ebp, StartPos         {Safe since EBP automatically saved}
  sub    ebp, 1
  jl     @@NotFoundExit        {Exit if StartPos < 1}
  push   ebx
  add    ebp, edx
  mov    ebx, [edx-4]
  add    ebx, edx
  sub    ebp, ebx
  jge    @@NotFound            {Traps Zero Length Non-Nil String}
@@Loop:
  cmp    al, [ebx+ebp]
  je     @@Check1
@@Next:
  cmp    al, [ebx+ebp+1]
  je     @@Check2
@@Next2:
  cmp    al, [ebx+ebp+2]
  je     @@Check3
@@Next3:
  cmp    al, [ebx+ebp+3]
  je     @@Check4
@@Next4:
  add    ebp, 4
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check4:
  sub    ecx, 1
  jnz    @@Next4
  add    ebp, 3
  jge    @@NotFound
  jmp    @@SetResult
@@Check3:
  sub    ecx, 1
  jnz    @@Next3
  add    ebp, 2
  jge    @@NotFound
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jge    @@NotFound
  jmp    @@SetResult
@@Check1:
  sub    ecx, 1
  jnz    @@Next
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

//Author:            Aleksandr Sharahov
//Date:
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:     CharPosEY_Sha_Pas_3

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CharPosFastcodePascal(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos   : Integer = 1): Integer;
var
  Len: integer;
label
  Cont1, Cont2, Found0, Found1, NotFound;
begin;
  Len:=Length(SourceString);
  Result:=StartPos;
  if (Occurrence<=0) or (Result<=0) or (Result>Len) then goto NotFound;
  if SourceString[Result]=SearchCharacter then goto Found0;
Cont1:
  if SourceString[Result+1]=SearchCharacter then goto Found1;
Cont2:
  Result:=Result+2;
  if cardinal(Result)>cardinal(Len) then goto NotFound;
  if SourceString[Result]<>SearchCharacter then goto Cont1;
Found0:
  dec(Occurrence);
  if Occurrence<=0 then exit;
  if SourceString[Result+1]<>SearchCharacter then goto Cont2;
Found1:
  dec(Occurrence);
  if Occurrence>0 then goto Cont2;
  if Result>=Len then goto NotFound;
  inc(Result);
  exit;
NotFound:
  Result:=0;
  end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

end.
