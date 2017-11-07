unit PosJOHUnit;

interface

{$UNDEF Inline}
{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 18.0}
    {$DEFINE Inline}
  {$IFEND}
{$ENDIF}

function Pos_JOH_PAS_3 (const SubStr : AnsiString; const Str : AnsiString) : Integer;
function Pos_JOH_PAS_4 (const SubStr : AnsiString; const Str : AnsiString) : Integer;
function Pos_JOH_MMX_3 (const SubStr : AnsiString; const Str : AnsiString) : Integer;
function Pos_JOH_SSE_3 (const SubStr : AnsiString; const Str : AnsiString) : Integer;
function Pos_JOH_SSE2_3(const SubStr : AnsiString; const Str : AnsiString) : Integer;
function Pos_JOH_IA32_5(const SubStr : AnsiString; const Str : AnsiString) : Integer;
function Pos_JOH_IA32_6(const SubStr : AnsiString; const Str : AnsiString) : Integer;
function Pos_JOH_IA32_7(const SubStr : AnsiString; const Str : AnsiString) : Integer;

function Pos_JOH_PAS_6(const SubStr : AnsiString; const Str : AnsiString) : Integer;
{$IFDEF Inline} inline; {$ENDIF}


implementation

Uses PosExJOHUnit;

function Pos_JOH_PAS_3(const SubStr : AnsiString; const Str : AnsiString) : Integer;
var
  StrLen, SubLen, Remainder : Integer;
  PStr, PSub, PStart, PMax  : Pchar;
  FirstChar                 : Char;
begin;
  Result := 0;
  if Str    = '' then Exit;
  if SubStr = '' then Exit;
  StrLen := PCardinal(Cardinal(Str   ) - 4)^;
  SubLen := PCardinal(Cardinal(SubStr) - 4)^;
  if (SubLen = 0) then
    Exit;
  if (SubLen > StrLen) then
    Exit;
  PStart    := Pointer(Str);
  PSub      := Pointer(SubStr);
  PStr      := PStart; {Search Start Position}
  PMax      := PStart + StrLen - SubLen; {Maximum Start Position}
  FirstChar := PSub^;
  if SubLen = 1 then
    repeat {Single Character Saarch}
      if PStr^ = FirstChar then
        begin
          Result := PStr + 1 - PStart;
          Exit;
        end;
      if PStr[1] = FirstChar then
        begin
          if PStr < PMax then
            Result := PStr + 2 - PStart;
          Exit;
        end;
      Inc(PStr, 2);
    until PStr > PMax
  else
    begin {Multi-Character Search}
      repeat
        if PStr^ = FirstChar then
          begin
            Remainder := SubLen;
            while True do
              begin
                Dec(Remainder, 2);
                if PSub[Remainder+1] <> PStr[Remainder+1] then
                  Break;
                if PSub[Remainder] <> PStr[Remainder] then
                  Break;
                if Remainder < 2 then
                  begin
                    Result := PStr + 1 - PStart;
                    Exit;
                  end;
              end;
          end;
        if PStr[1] = FirstChar then
          begin
            Remainder := SubLen;
            while True do
              begin
                Dec(Remainder, 2);
                if PSub[Remainder+1] <> PStr[Remainder+2] then
                  Break;
                if PSub[Remainder] <> PStr[Remainder+1] then
                  Break;
                if Remainder < 2 then
                  begin
                    if PStr < PMax then
                      Result := PStr + 2 - PStart;
                    Exit;
                  end;
              end;
          end;
        Inc(PStr, 2);
      until PStr > PMax;
    end;
end;

function Pos_JOH_PAS_4(const SubStr : AnsiString; const Str : AnsiString) : Integer;
var
  StrLen, SubLen, Remainder : Integer;
  PStr, PSub, PStart, PMax  : Pchar;
  FirstChar                 : Char;
begin;
  Result := 0;
  if Str    = '' then Exit;
  if SubStr = '' then Exit;
  StrLen := PCardinal(Cardinal(Str   ) - 4)^;
  SubLen := PCardinal(Cardinal(SubStr) - 4)^;
  if (SubLen = 0) then
    Exit;
  if (SubLen > StrLen) then
    Exit;
  if SubLen = 1 then
    begin
      PStr := Pointer(Str);
      Inc(PStr, StrLen);
      Remainder := -StrLen;
      FirstChar := SubStr[1];
      repeat
        if PStr[Remainder] = FirstChar then
          begin
            Result := StrLen + Remainder + 1;
            Exit;
          end;
        Inc(Remainder);
      until Remainder = 0;
    end
  else
    begin {Multi-Character Search}
      PStart    := Pointer(Str);
      PSub      := Pointer(SubStr);
      PStr      := PStart; {Search Start Position}
      PMax      := PStart + StrLen - SubLen; {Maximum Start Position}
      FirstChar := PSub^;
      repeat
        if PStr^ = FirstChar then
          begin
            Remainder := SubLen;
            while True do
              begin
                Dec(Remainder, 2);
                if PSub[Remainder+1] <> PStr[Remainder+1] then
                  Break;
                if PSub[Remainder] <> PStr[Remainder] then
                  Break;
                if Remainder < 2 then
                  begin
                    Result := PStr + 1 - PStart;
                    Exit;
                  end;
              end;
          end;
        if PStr[1] = FirstChar then
          begin
            Remainder := SubLen;
            while True do
              begin
                Dec(Remainder, 2);
                if PSub[Remainder+1] <> PStr[Remainder+2] then
                  Break;
                if PSub[Remainder] <> PStr[Remainder+1] then
                  Break;
                if Remainder < 2 then
                  begin
                    Result := PStr + 2 - PStart;
                    Exit;
                  end;
              end;
          end;
        Inc(PStr, 2);
      until PStr > PMax;
      Result := 0;
    end;
end;

function Pos_JOH_MMX_3(const SubStr : AnsiString; const Str : AnsiString) : Integer;
asm
  test      eax, eax
  jz        @@NotFoundExit   {Exit if SubStr = ''}
  test      edx, edx
  jz        @@NotFound       {Exit if Str = ''}
  mov       ecx, [edx-4]     {Length(Str)}
  cmp       [eax-4], 1       {Length SubStr = 1?}
  je        @@SingleChar     {Yes - Exit via CharPos}
  jl        @@NotFound       {Exit if Length(SubStr) < 1}
  sub       ecx, [eax-4]     {Subtract Length(SubStr), -ve handled by CharPos}
  push      esi              {Save Registers}
  push      edi
  push      ebx
  push      ebp
  push      edx              {Save Start Address of Str}
  mov       ebx, [eax]       {BL = 1st Char of SubStr}
  mov       esi, eax         {Start Address of SubStr}
  lea       edi, [ecx+1]     {Initial Remainder Count}
@@StrLoop:
  mov       eax, ebx         {AL  = 1st char of SubStr}
  mov       ecx, edi         {Remaining Length}
  mov       ebp, edx         {Save Start Position}
  call      @@CharPos        {Search for 1st Character}
  jz        @@StrExit        {Exit with Zero Result if 1st Char Not Found}
  mov       ecx, [esi-4]     {Length SubStr}
  lea       edx, [ebp+eax]   {Update Start Position}
  sub       ecx, 1           {Remaining Characters to Compare}
  sub       edi, eax         {Update Remaining Length for Next Loop}
@@StrCheck:
  mov       ax, [edx+ecx-2]  {Compare Next 2 Chars of SubStr and Str}
  cmp       ax, [esi+ecx-1]
  jne       @@StrLoop        {Different - Return to First Character Search}
  sub       ecx, 2
  jg        @@StrCheck       {Check each Remaining Character}
  sub       edx, [esp]
  mov       eax, edx
@@StrExit:
  pop       edx              {Restore Registers}
  pop       ebp
  pop       ebx
  pop       edi
  pop       esi
  ret
@@NotFound:
  xor       eax, eax         {Return 0}
@@NotFoundExit:
  ret
@@SingleChar:
  mov       al, [eax]        {Search Character}
{Return Position of Character AL within a String of Length ECX starting}
{at Address EDX.  If Found, Return Index in EAX and Clear Zero Flag,   }
{otherwise Return 0 in EAX and Set Zero Flag.  Changes EAX, ECX and EDX}
@@CharPos:
  cmp       ecx, 8
  jg        @@NotSmall
@@Small:
  push      ecx
  or        ecx, ecx
  jle       @@SmallNotFound      {Exit if Length <= 0}
  cmp       al, [edx]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+1]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+2]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+3]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+4]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+5]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+6]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+7]
  jz        @@Found
@@SmallNotFound:
  pop       ecx
  xor       eax, eax
  ret
@@Found:
  pop       eax
  sub       eax, ecx
  add       eax, 1
  ret

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
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
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

function Pos_JOH_SSE_3(const SubStr : AnsiString; const Str : AnsiString) : Integer;
asm
  test      eax, eax
  jz        @@NotFoundExit   {Exit if SubStr = ''}
  test      edx, edx
  jz        @@NotFound       {Exit if Str = ''}
  mov       ecx, [edx-4]     {Length(Str)}
  cmp       [eax-4], 1       {Length SubStr = 1?}
  je        @@SingleChar     {Yes - Exit via CharPos}
  jl        @@NotFound       {Exit if Length(SubStr) < 1}
  sub       ecx, [eax-4]     {Subtract Length(SubStr), -ve handled by CharPos}
  push      esi              {Save Registers}
  push      edi
  push      ebx
  push      ebp
  push      edx              {Save Start Address of Str}
  mov       ebx, [eax]       {BL = 1st Char of SubStr}
  mov       esi, eax         {Start Address of SubStr}
  lea       edi, [ecx+1]     {Initial Remainder Count}
@@StrLoop:
  mov       eax, ebx         {AL  = 1st char of SubStr}
  mov       ecx, edi         {Remaining Length}
  mov       ebp, edx         {Save Start Position}
  call      @@CharPos        {Search for 1st Character}
  jz        @@StrExit        {Exit with Zero Result if 1st Char Not Found}
  mov       ecx, [esi-4]     {Length SubStr}
  lea       edx, [ebp+eax]   {Update Start Position}
  sub       ecx, 1           {Remaining Characters to Compare}
  sub       edi, eax         {Update Remaining Length for Next Loop}
@@StrCheck:
  mov       ax, [edx+ecx-2]  {Compare Next 2 Chars of SubStr and Str}
  cmp       ax, [esi+ecx-1]
  jne       @@StrLoop        {Different - Return to First Character Search}
  sub       ecx, 2
  jg        @@StrCheck       {Check each Remaining Character}
  sub       edx, [esp]
  mov       eax, edx
@@StrExit:
  pop       edx              {Restore Registers}
  pop       ebp
  pop       ebx
  pop       edi
  pop       esi
  ret
@@NotFound:
  xor       eax, eax         {Return 0}
@@NotFoundExit:
  ret
@@SingleChar:
  mov       al, [eax]        {Search Character}
{Return Position of Character AL within a String of Length ECX starting}
{at Address EDX.  If Found, Return Index in EAX and Clear Zero Flag,   }
{otherwise Return 0 in EAX and Set Zero Flag.  Changes EAX, ECX and EDX}
@@CharPos:
  cmp       ecx, 8
  jg        @@NotSmall
@@Small:
  push      ecx
  or        ecx, ecx
  jle       @@SmallNotFound      {Exit if Length <= 0}
  cmp       al, [edx]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+1]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+2]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+3]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+4]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+5]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+6]
  jz        @@Found
  sub       ecx, 1
  jz        @@SmallNotFound
  cmp       al, [edx+7]
  jz        @@Found
@@SmallNotFound:
  pop       ecx
  xor       eax, eax
  ret
@@Found:
  pop       eax
  sub       eax, ecx
  add       eax, 1
  ret

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
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
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

function Pos_JOH_SSE2_3(const SubStr : AnsiString; const Str : AnsiString) : Integer;
asm
  test      eax, eax
  jz        @NotFoundExit    {Exit if SurStr = ''}
  test      edx, edx
  jz        @NotFound        {Exit if Str = ''}
  mov       ecx, [edx-4]     {Length(Str)}
  cmp       [eax-4], 1       {Length SubStr = 1?}
  je        @SingleChar      {Yes - Exit via CharPos}
  jl        @NotFound        {Exit if Length(SubStr) < 1}
  sub       ecx, [eax-4]     {Subtract Length(SubStr)}
  jl        @NotFound        {Exit if Length(SubStr) > Length(Str)}
  push      esi              {Save Registers}
  push      edi
  push      ebx
  push      ebp
  mov       esi, eax         {Start Address of SubStr}
  lea       edi, [ecx+1]     {Initial Remainder Count}
  mov       eax, [eax]       {AL = 1st Char of SubStr}
  mov       ebp, edx         {Start Address of Str}
  mov       ebx, eax         {Maintain 1st Search Char in BL}
@StrLoop:
  mov       eax, ebx         {AL  = 1st char of SubStr}
  mov       ecx, edi         {Remaining Length}
  push      edx              {Save Start Position}
  call      @CharPos         {Search for 1st Character}
  pop       edx              {Restore Start Position}
  test      eax, eax         {Result = 0?}
  jz        @StrExit         {Exit if 1st Character Not Found}
  mov       ecx, [esi-4]     {Length SubStr}
  add       edx, eax         {Update Start Position for Next Loop}
  sub       edi, eax         {Update Remaining Length for Next Loop}
  sub       ecx, 1           {Remaining Characters to Compare}
@StrCheck:
  mov       ax, [edx+ecx-2]  {Compare Next Char of SubStr and Str}
  cmp       ax, [esi+ecx-1]
  jne       @StrLoop         {Different - Return to First Character Search}
  sub       ecx, 2
  jg        @StrCheck        {Check each Remaining Character}
  mov       eax, edx         {All Characters Matched - Calculate Result}
  sub       eax, ebp
@StrExit:
  pop       ebp              {Restore Registers}
  pop       ebx
  pop       edi
  pop       esi
  ret
@NotFound:
  xor       eax, eax         {Return 0}
@NotFoundExit:
  ret
@SingleChar:
  mov       al, [eax]        {Search Character}
@CharPos:
  PUSH      EBX
  MOV       EBX, EAX
  CMP       ECX, 16
  JL        @@Small
@@NotSmall:
  MOV       AH, AL           {Fill each Byte of XMM1 with AL}
  MOVD      XMM1, EAX
  PSHUFLW   XMM1, XMM1, 0
  PSHUFD    XMM1, XMM1, 0
@@First16:
  MOVUPS    XMM0, [EDX]      {Unaligned}
  PCMPEQB   XMM0, XMM1       {Compare First 16 Characters}
  PMOVMSKB  EAX, XMM0
  TEST      EAX, EAX
  JNZ       @@FoundStart     {Exit on any Match}
  CMP       ECX, 32
  JL        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  SUB       ECX, 16          {Align Block Reads}
  PUSH      ECX
  MOV       EAX, EDX
  NEG       EAX
  AND       EAX, 15
  ADD       EDX, ECX
  NEG       ECX
  ADD       ECX, EAX
@@Loop:
  MOVAPS    XMM0, [EDX+ECX]  {Aligned}
  PCMPEQB   XMM0, XMM1       {Compare Next 16 Characters}
  PMOVMSKB  EAX, XMM0
  TEST      EAX, EAX
  JNZ       @@Found          {Exit on any Match}
  ADD       ECX, 16
  JLE       @@Loop
@Remainder:
  POP       EAX              {Check Remaining Characters}
  ADD       EDX, 16
  ADD       EAX, ECX         {Count from Last Loop End Position}
  JMP       DWORD PTR [@@JumpTable2-ECX*4]

@@NullString:
  XOR       EAX, EAX         {Result = 0}
  RET

@@FoundStart:
  BSF       EAX, EAX         {Get Set Bit}
  POP       EBX
  ADD       EAX, 1           {Set Result}
  RET

@@Found:
  POP       EDX
  BSF       EAX, EAX         {Get Set Bit}
  ADD       EDX, ECX
  POP       EBX
  LEA       EAX, [EAX+EDX+1] {Set Result}
  RET

@@Medium:
  ADD       EDX, ECX         {End of String}
  MOV       EAX, 16          {Count from 16}
  JMP       DWORD PTR [@@JumpTable1-64-ECX*4]

@@Small:
  ADD       EDX, ECX         {End of String}
  XOR       EAX, EAX         {Count from 0}
  JMP       DWORD PTR [@@JumpTable1-ECX*4]

  nop; nop                   {Aligb Jump Tables}

@@JumpTable1:
  DD        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  DD        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16

@@JumpTable2:
  DD        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  DD        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound

@@16:
  ADD       EAX, 1
  CMP       BL, [EDX-16]
  JE        @@Done
@@15:
  ADD       EAX, 1
  CMP       BL, [EDX-15]
  JE        @@Done
@@14:
  ADD       EAX, 1
  CMP       BL, [EDX-14]
  JE        @@Done
@@13:
  ADD       EAX, 1
  CMP       BL, [EDX-13]
  JE        @@Done
@@12:
  ADD       EAX, 1
  CMP       BL, [EDX-12]
  JE        @@Done
@@11:
  ADD       EAX, 1
  CMP       BL, [EDX-11]
  JE        @@Done
@@10:
  ADD       EAX, 1
  CMP       BL, [EDX-10]
  JE        @@Done
@@09:
  ADD       EAX, 1
  CMP       BL, [EDX-9]
  JE        @@Done
@@08:
  ADD       EAX, 1
  CMP       BL, [EDX-8]
  JE        @@Done
@@07:
  ADD       EAX, 1
  CMP       BL, [EDX-7]
  JE        @@Done
@@06:
  ADD       EAX, 1
  CMP       BL, [EDX-6]
  JE        @@Done
@@05:
  ADD       EAX, 1
  CMP       BL, [EDX-5]
  JE        @@Done
@@04:
  ADD       EAX, 1
  CMP       BL, [EDX-4]
  JE        @@Done
@@03:
  ADD       EAX, 1
  CMP       BL, [EDX-3]
  JE        @@Done
@@02:
  ADD       EAX, 1
  CMP       BL, [EDX-2]
  JE        @@Done
@@01:
  ADD       EAX, 1
  CMP       BL, [EDX-1]
  JE        @@Done
@@NotFound:
  XOR       EAX, EAX
@@Done:
  POP       EBX
end;

function Pos_JOH_IA32_5(const SubStr : AnsiString; const Str : AnsiString) : Integer;
asm
  cmp     eax, 1
  sbb     ecx, ecx         {-1 if SubStr = '' else 0}
  cmp     edx, 1
  sbb     ecx, 0           {Negative if Str = '' or SubStr = ''}
  jl      @@InvalidInput
  sub     esp, 20
  mov     [esp], ebx       {Save Registers}
  mov     [esp+4], edi
  mov     [esp+8], esi
  mov     [esp+12], ebp
  mov     [esp+16], edx    {Save Start Position}
  mov     esi, [edx-4]     {Length(Str)}
  mov     edi, [eax-4]     {Length(SubStr)}
  sub     esi, 1           {Length(Str) - 1}
  sbb     ecx, ecx         {Negative if Length(Str) = 0}
  sub     edi, 1           {Length(SubStr) - 1}
  sbb     ecx, 0           {Negative if Length(Str) = 0 or Length(SubStr) = 0}
  jl      @@NotFound       {Exit if Length(Str) = 0 or Length(SubStr) = 0}
  add     esi, edx         {Last Character Position in Str}
  lea     ebx, [eax+edi]   {Last Character Position in SubStr}
  add     edx, edi         {Search Start Position within Str for Last Char}
  not     edi              {- Length(SubStr)}
  movzx   eax, [ebx]       {Last Character of SubStr}
  mov     ah, al
  mov     ecx, eax
  shl     eax, 16
  or      ecx, eax         {All 4 Bytes = Last Character of SubStr}
@@MainLoop:
  lea     eax, [edx+4]
  cmp     eax, esi
  jae     @@Remainder      {1 to 4 Positions Remaining}
  mov     eax, [edx]       {Check Next 4 Bytes of Str}
  add     edx, 4           {Ready for Next Loop}
  xor     eax, ecx         {Zero Byte at each Matching Position}
  lea     ebp, [eax-$01010101]
  not     eax
  and     eax, ebp
  and     eax, $80808080   {Set Byte to $80 at each Matching Position else $00}
  jz      @@MainLoop       {Loop Until any Match on Last Character Found}
  bsf     eax, eax         {Find First Match Bit}
  shr     eax, 3           {Byte Offset of First Match (0..3)}
  lea     edx, [eax+edx-3] {Address of First Match on Last Character + 1}
@@Check:
  cmp     edi, -1
  je      @@SetResult      {Exit on Match if Lenght(SubStr) = 1}
  movzx   eax, word ptr [edi+ebx+1] {Compare First 2 Characters}
  cmp     ax, [edi+edx]
  jne     @@MainLoop       {No Match on First 2 Characters}
  cmp     edi, -4
  jle     @@Long           {Length(SubStr) >= 4}
@@SetResult:               {Full Match om 2 or 3 Character String}
  lea     eax, [edx+edi+1] {Calculate and Return Result}
  sub     eax, [esp+16]    {Subtract Start Position}
  jmp     @@Finished
@@InvalidInput:
  xor     eax, eax
  ret
@@Long:                    {Length(SubStr) >= 4}
  mov     eax, [ebx-3]     {Compare Last 4 Characters of Str and SubStr}
  cmp     eax, [edx-4]
  jne     @@MainLoop       {No Match on Last 4 Characters}
  lea     ebp, [edi+6-3]   {First 2 and Last 4 Characters already Matched}
@@MainCompare:             {Compare Remaining Characters}
  add     ebp, 4           {Compare 4 Characters per Loop}
  jg      @@SetResult      {All Characters Matched}
  mov     eax, [ebp+ebx-4]
  cmp     eax, [ebp+edx-5]
  je      @@MainCompare    {Match on Next 4 Characters}
  jmp     @@MainLoop       {No Match}
@@Remainder:
  add     edx, 1
  cmp     cl, [edx-1]
  je      @@Check          {Match on Last Character - Check Remainder}
  cmp     edx, esi
  jbe     @@Remainder      {More Positions Available}
@@NotFound:
  xor     eax, eax         {No Match Found - Return 0}
@@Finished:
  mov     ebx, [esp]       {Restore Registers}
  mov     edi, [esp+4]
  mov     esi, [esp+8]
  mov     ebp, [esp+12]
  add     esp, 20
end; {Pos}

function Pos_JOH_IA32_6(const SubStr : AnsiString; const Str : AnsiString) : Integer;
asm {Slightly Cut-Down version of PosEx_JOH_6}
  push    ebx
  cmp     eax, 1
  sbb     ebx, ebx         {-1 if SubStr = '' else 0}
  sub     edx, 1           {-1 if S = ''}
  sbb     ebx, 0           {Negative if S = '' or SubStr = '' else 0}
  jl      @@InvalidInput
  push    edi
  push    esi
  push    ebp
  push    edx
  mov     edi, [eax-4]     {Length(SubStr)}
  mov     esi, [edx-3]     {Length(S)}
  cmp     edi, esi
  jg      @@NotFound       {Offset to High for a Match}
  test    edi, edi
  jz      @@NotFound       {Length(SubStr = 0)}
  lea     ebp, [eax+edi]   {Last Character Position in SubStr + 1}
  add     esi, edx         {Last Character Position in S}
  movzx   eax, [ebp-1]     {Last Character of SubStr}
  add     edx, edi         {Search Start Position in S for Last Character}
  mov     ah, al
  neg     edi              {-Length(SubStr)}
  mov     ecx, eax
  shl     eax, 16
  or      ecx, eax         {All 4 Bytes = Last Character of SubStr}
@@MainLoop:
  add     edx, 4
  cmp     edx, esi
  ja      @@Remainder      {1 to 4 Positions Remaining}
  mov     eax, [edx-4]     {Check Next 4 Bytes of S}
  xor     eax, ecx         {Zero Byte at each Matching Position}
  lea     ebx, [eax-$01010101]
  not     eax
  and     eax, ebx
  and     eax, $80808080   {Set Byte to $80 at each Match Position else $00}
  jz      @@MainLoop       {Loop Until any Match on Last Character Found}
  bsf     eax, eax         {Find First Match Bit}
  shr     eax, 3           {Byte Offset of First Match (0..3)}
  lea     edx, [eax+edx-3] {Address of First Match on Last Character + 1}
@@Compare:
  cmp     edi, -4
  jle     @@Large          {Lenght(SubStr) >= 4}
  cmp     edi, -1
  je      @@SetResult      {Exit with Match if Lenght(SubStr) = 1}
  movzx   eax, word ptr [ebp+edi] {Last Char Matches - Compare First 2 Chars}
  cmp     ax, [edx+edi]
  jne     @@MainLoop       {No Match on First 2 Characters}
@@SetResult:               {Full Match}
  lea     eax, [edx+edi]   {Calculate and Return Result}
  pop     edx
  pop     ebp
  pop     esi
  pop     edi
  pop     ebx
  sub     eax, edx         {Subtract Start Position}
  ret
@@NotFound:
  pop     edx              {Dump Start Position}
  pop     ebp
  pop     esi
  pop     edi
@@InvalidInput:
  pop     ebx
  xor     eax, eax         {No Match Found - Return 0}
  ret
@@Remainder:               {Check Last 1 to 4 Characters}
  mov     eax, [esi-3]     {Last 4 Characters of S - May include Length Bytes}
  xor     eax, ecx         {Zero Byte at each Matching Position}
  lea     ebx, [eax-$01010101]
  not     eax
  and     eax, ebx
  and     eax, $80808080   {Set Byte to $80 at each Match Position else $00}
  jz      @@NotFound       {No Match Possible}
  lea     eax, [edx-4]     {Check Valid Match Positions}
  cmp     cl, [eax]
  lea     edx, [eax+1]
  je      @@Compare
  cmp     edx, esi
  ja      @@NotFound
  lea     edx, [eax+2]
  cmp     cl, [eax+1]
  je      @@Compare
  cmp     edx, esi
  ja      @@NotFound
  lea     edx, [eax+3]
  cmp     cl, [eax+2]
  je      @@Compare
  cmp     edx, esi
  ja      @@NotFound
  lea     edx, [eax+4]
  jmp     @@Compare
@@Large:
  mov     eax, [ebp-4]     {Compare Last 4 Characters of S and SubStr}
  cmp     eax, [edx-4]
  jne     @@MainLoop       {No Match on Last 4 Characters}
  mov     ebx, edi
@@CompareLoop:             {Compare Remaining Characters}
  add     ebx, 4           {Compare 4 Characters per Loop}
  jge     @@SetResult      {All Characters Matched}
  mov     eax, [ebp+ebx-4]
  cmp     eax, [edx+ebx-4]
  je      @@CompareLoop    {Match on Next 4 Characters}
  jmp     @@MainLoop       {No Match}
end;

function Pos_JOH_PAS_6(const SubStr : AnsiString; const Str : AnsiString) : Integer;
{$IFDEF Inline} inline; {$ENDIF}
begin
  Result := PosEx(SubStr, Str, 1);
end;

function Pos_JOH_IA32_7(const SubStr : AnsiString; const Str : AnsiString) : Integer;
asm
  mov ecx, 1
  jmp PosEx
end;

end.

