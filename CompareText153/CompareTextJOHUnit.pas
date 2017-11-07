unit CompareTextJOHUnit;

interface

function CompareText_JOH_PAS_1_a (const S1, S2: string): Integer;
function CompareText_JOH_PAS_1_b (const S1, S2: string): Integer;
function CompareText_JOH_PAS_1_c (const S1, S2: string): Integer;
function CompareText_JOH_PAS_1_d (const S1, S2: string): Integer;

function CompareText_JOH_IA32_5_a(const S1, S2: string): Integer;
function CompareText_JOH_IA32_5_b(const S1, S2: string): Integer;
function CompareText_JOH_IA32_5_c(const S1, S2: string): Integer;
function CompareText_JOH_IA32_5_d(const S1, S2: string): Integer;

function CompareText_JOH_IA32_6_a(const S1, S2: string): Integer;
function CompareText_JOH_IA32_6_b(const S1, S2: string): Integer;
function CompareText_JOH_IA32_6_c(const S1, S2: string): Integer;
function CompareText_JOH_IA32_6_d(const S1, S2: string): Integer;

implementation

function CompareText_JOH_PAS_1_a(const S1, S2: string): Integer;
var
  Len1, Len2, CheckLen, CheckPos, Char1, Char2 : Integer;
begin
  Len1 := Length(S1);
  Len2 := Length(S2);
  if (Len1 = 0) then
    if (Len2 = 0) then
      Result := 0
    else
      Result := -1
  else
    if (Len2 = 0) then
      Result := +1
    else
      begin
        if Len1 > Len2 then
          begin
            if Len2 = 0 then
              begin
                Result := +1; Exit;
              end;
            CheckLen := Len2
          end
        else
          begin
            if Len1 = 0 then
              begin
                if Len2 = 0 then
                  Result := 0
                else
                  Result := -1;
                Exit;
              end;
            CheckLen := Len1;
          end;
        CheckPos := 1;
        repeat
          if (S1[CheckPos] <> S2[CheckPos]) then
            begin
              Char1 := Ord(S1[CheckPos]);
              Char2 := Ord(S2[CheckPos]);
              if (Char1 >= Ord('a')) and (Char1 <= Ord('z')) then
                begin
                  Dec(Char1, $20); {Convert to Uppercase}
                  if Char1 > Char2 then
                    begin {If Uppercase(Char1) > Char2 then S1 > S2}
                      Result := 1; Exit;
                    end
                end;
              if (Char2 >= Ord('a')) and (Char2 <= Ord('z')) then
                Dec(Char2, $20); {Convert to Uppercase}
              if Char1 <> Char2 then
                begin
                  Result := Char1 - Char2; Exit;
                end;
            end;
          Inc(CheckPos);
        until CheckPos > CheckLen;
        Result := Len1 - Len2;
      end;
end;

procedure Filler1;
asm
 nop
end;

function CompareText_JOH_PAS_1_b(const S1, S2: string): Integer;
var
  Len1, Len2, CheckLen, CheckPos, Char1, Char2 : Integer;
begin
  Len1 := Length(S1);
  Len2 := Length(S2);
  if (Len1 = 0) then
    if (Len2 = 0) then
      Result := 0
    else
      Result := -1
  else
    if (Len2 = 0) then
      Result := +1
    else
      begin
        if Len1 > Len2 then
          begin
            if Len2 = 0 then
              begin
                Result := +1; Exit;
              end;
            CheckLen := Len2
          end
        else
          begin
            if Len1 = 0 then
              begin
                if Len2 = 0 then
                  Result := 0
                else
                  Result := -1;
                Exit;
              end;
            CheckLen := Len1;
          end;
        CheckPos := 1;
        repeat
          if (S1[CheckPos] <> S2[CheckPos]) then
            begin
              Char1 := Ord(S1[CheckPos]);
              Char2 := Ord(S2[CheckPos]);
              if (Char1 >= Ord('a')) and (Char1 <= Ord('z')) then
                begin
                  Dec(Char1, $20); {Convert to Uppercase}
                  if Char1 > Char2 then
                    begin {If Uppercase(Char1) > Char2 then S1 > S2}
                      Result := 1; Exit;
                    end
                end;
              if (Char2 >= Ord('a')) and (Char2 <= Ord('z')) then
                Dec(Char2, $20); {Convert to Uppercase}
              if Char1 <> Char2 then
                begin
                  Result := Char1 - Char2; Exit;
                end;
            end;
          Inc(CheckPos);
        until CheckPos > CheckLen;
        Result := Len1 - Len2;
      end;
end;

procedure Filler2;
asm
 nop
 nop
 nop
 nop
 nop
end;

function CompareText_JOH_PAS_1_c(const S1, S2: string): Integer;
var
  Len1, Len2, CheckLen, CheckPos, Char1, Char2 : Integer;
begin
  Len1 := Length(S1);
  Len2 := Length(S2);
  if (Len1 = 0) then
    if (Len2 = 0) then
      Result := 0
    else
      Result := -1
  else
    if (Len2 = 0) then
      Result := +1
    else
      begin
        if Len1 > Len2 then
          begin
            if Len2 = 0 then
              begin
                Result := +1; Exit;
              end;
            CheckLen := Len2
          end
        else
          begin
            if Len1 = 0 then
              begin
                if Len2 = 0 then
                  Result := 0
                else
                  Result := -1;
                Exit;
              end;
            CheckLen := Len1;
          end;
        CheckPos := 1;
        repeat
          if (S1[CheckPos] <> S2[CheckPos]) then
            begin
              Char1 := Ord(S1[CheckPos]);
              Char2 := Ord(S2[CheckPos]);
              if (Char1 >= Ord('a')) and (Char1 <= Ord('z')) then
                begin
                  Dec(Char1, $20); {Convert to Uppercase}
                  if Char1 > Char2 then
                    begin {If Uppercase(Char1) > Char2 then S1 > S2}
                      Result := 1; Exit;
                    end
                end;
              if (Char2 >= Ord('a')) and (Char2 <= Ord('z')) then
                Dec(Char2, $20); {Convert to Uppercase}
              if Char1 <> Char2 then
                begin
                  Result := Char1 - Char2; Exit;
                end;
            end;
          Inc(CheckPos);
        until CheckPos > CheckLen;
        Result := Len1 - Len2;
      end;
end;

procedure Filler3;
asm
 nop
end;

function CompareText_JOH_PAS_1_d(const S1, S2: string): Integer;
var
  Len1, Len2, CheckLen, CheckPos, Char1, Char2 : Integer;
begin
  Len1 := Length(S1);
  Len2 := Length(S2);
  if (Len1 = 0) then
    if (Len2 = 0) then
      Result := 0
    else
      Result := -1
  else
    if (Len2 = 0) then
      Result := +1
    else
      begin
        if Len1 > Len2 then
          begin
            if Len2 = 0 then
              begin
                Result := +1; Exit;
              end;
            CheckLen := Len2
          end
        else
          begin
            if Len1 = 0 then
              begin
                if Len2 = 0 then
                  Result := 0
                else
                  Result := -1;
                Exit;
              end;
            CheckLen := Len1;
          end;
        CheckPos := 1;
        repeat
          if (S1[CheckPos] <> S2[CheckPos]) then
            begin
              Char1 := Ord(S1[CheckPos]);
              Char2 := Ord(S2[CheckPos]);
              if (Char1 >= Ord('a')) and (Char1 <= Ord('z')) then
                begin
                  Dec(Char1, $20); {Convert to Uppercase}
                  if Char1 > Char2 then
                    begin {If Uppercase(Char1) > Char2 then S1 > S2}
                      Result := 1; Exit;
                    end
                end;
              if (Char2 >= Ord('a')) and (Char2 <= Ord('z')) then
                Dec(Char2, $20); {Convert to Uppercase}
              if Char1 <> Char2 then
                begin
                  Result := Char1 - Char2; Exit;
                end;
            end;
          Inc(CheckPos);
        until CheckPos > CheckLen;
        Result := Len1 - Len2;
      end;
end;

function CompareText_JOH_IA32_5_a(const S1, S2: string): Integer;
asm
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx
  jnz     @@Compare
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@Compare          {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@@Same:
  xor     eax, eax
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@Compare:
  push    ebx
  push    ebp
  push    edi
  push    esi
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ebp, ebp
  and     ebp, ebx
  add     ebp, [edx-4]       {Compare Length = Min(Length(S1),Length(S2))}
  add     eax, ebp           {End of S1}
  add     edx, ebp           {End of S2}
  neg     ebp                {Negate Compare Length}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ebp]
  mov     ecx, [edx+ebp]
  cmp     ebx, ecx
  je      @@Next
  mov     esi, ebx           {Convert 4 Chars in EBX into Uppercase}
  or      ebx, $80808080
  mov     edi, ebx
  sub     ebx, $7B7B7B7B
  xor     edi, esi
  or      ebx, $80808080
  sub     ebx, $66666666
  and     ebx, edi
  shr     ebx, 2
  xor     ebx, esi
  mov     esi, ecx           {Convert 4 Chars in ECX into Uppercase}
  or      ecx, $80808080
  mov     edi, ecx
  sub     ecx, $7B7B7B7B
  xor     edi, esi
  or      ecx, $80808080
  sub     ecx, $66666666
  and     ecx, edi
  shr     ecx, 2
  xor     ecx, esi
  cmp     ebx, ecx
  jne     @@CheckDiff
@@Next:
  add     ebp, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  pop     eax                {Default Result}
@@DiffLoop:
  cmp     cl, bl
  jne     @@SetResult
  add     ebp, 1
  jz      @@Done             {Difference after Compare Length}
  shr     ecx, 8
  shr     ebx, 8
  jmp     @@DiffLoop
@@SetResult:
  movzx   eax, bl            {Set Result from Character Difference}
  and     ecx, $ff
  sub     eax, ecx
@@Done:
  pop     esi
  pop     edi
  pop     ebp
  pop     ebx
end;

function CompareText_JOH_IA32_5_b(const S1, S2: string): Integer;
asm
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx
  jnz     @@Compare
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@Compare          {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@@Same:
  xor     eax, eax
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@Compare:
  push    ebx
  push    ebp
  push    edi
  push    esi
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ebp, ebp
  and     ebp, ebx
  add     ebp, [edx-4]       {Compare Length = Min(Length(S1),Length(S2))}
  add     eax, ebp           {End of S1}
  add     edx, ebp           {End of S2}
  neg     ebp                {Negate Compare Length}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ebp]
  mov     ecx, [edx+ebp]
  cmp     ebx, ecx
  je      @@Next
  mov     esi, ebx           {Convert 4 Chars in EBX into Uppercase}
  or      ebx, $80808080
  mov     edi, ebx
  sub     ebx, $7B7B7B7B
  xor     edi, esi
  or      ebx, $80808080
  sub     ebx, $66666666
  and     ebx, edi
  shr     ebx, 2
  xor     ebx, esi
  mov     esi, ecx           {Convert 4 Chars in ECX into Uppercase}
  or      ecx, $80808080
  mov     edi, ecx
  sub     ecx, $7B7B7B7B
  xor     edi, esi
  or      ecx, $80808080
  sub     ecx, $66666666
  and     ecx, edi
  shr     ecx, 2
  xor     ecx, esi
  cmp     ebx, ecx
  jne     @@CheckDiff
@@Next:
  add     ebp, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  pop     eax                {Default Result}
@@DiffLoop:
  cmp     cl, bl
  jne     @@SetResult
  add     ebp, 1
  jz      @@Done             {Difference after Compare Length}
  shr     ecx, 8
  shr     ebx, 8
  jmp     @@DiffLoop
@@SetResult:
  movzx   eax, bl            {Set Result from Character Difference}
  and     ecx, $ff
  sub     eax, ecx
@@Done:
  pop     esi
  pop     edi
  pop     ebp
  pop     ebx
end;

procedure Filler4;
asm
 nop
end;

function CompareText_JOH_IA32_5_c(const S1, S2: string): Integer;
asm
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx
  jnz     @@Compare
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@Compare          {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@@Same:
  xor     eax, eax
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@Compare:
  push    ebx
  push    ebp
  push    edi
  push    esi
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ebp, ebp
  and     ebp, ebx
  add     ebp, [edx-4]       {Compare Length = Min(Length(S1),Length(S2))}
  add     eax, ebp           {End of S1}
  add     edx, ebp           {End of S2}
  neg     ebp                {Negate Compare Length}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ebp]
  mov     ecx, [edx+ebp]
  cmp     ebx, ecx
  je      @@Next
  mov     esi, ebx           {Convert 4 Chars in EBX into Uppercase}
  or      ebx, $80808080
  mov     edi, ebx
  sub     ebx, $7B7B7B7B
  xor     edi, esi
  or      ebx, $80808080
  sub     ebx, $66666666
  and     ebx, edi
  shr     ebx, 2
  xor     ebx, esi
  mov     esi, ecx           {Convert 4 Chars in ECX into Uppercase}
  or      ecx, $80808080
  mov     edi, ecx
  sub     ecx, $7B7B7B7B
  xor     edi, esi
  or      ecx, $80808080
  sub     ecx, $66666666
  and     ecx, edi
  shr     ecx, 2
  xor     ecx, esi
  cmp     ebx, ecx
  jne     @@CheckDiff
@@Next:
  add     ebp, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  pop     eax                {Default Result}
@@DiffLoop:
  cmp     cl, bl
  jne     @@SetResult
  add     ebp, 1
  jz      @@Done             {Difference after Compare Length}
  shr     ecx, 8
  shr     ebx, 8
  jmp     @@DiffLoop
@@SetResult:
  movzx   eax, bl            {Set Result from Character Difference}
  and     ecx, $ff
  sub     eax, ecx
@@Done:
  pop     esi
  pop     edi
  pop     ebp
  pop     ebx
end;

function CompareText_JOH_IA32_5_d(const S1, S2: string): Integer;
asm
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx
  jnz     @@Compare
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@Compare          {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@@Same:
  xor     eax, eax
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@Compare:
  push    ebx
  push    ebp
  push    edi
  push    esi
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ebp, ebp
  and     ebp, ebx
  add     ebp, [edx-4]       {Compare Length = Min(Length(S1),Length(S2))}
  add     eax, ebp           {End of S1}
  add     edx, ebp           {End of S2}
  neg     ebp                {Negate Compare Length}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ebp]
  mov     ecx, [edx+ebp]
  cmp     ebx, ecx
  je      @@Next
  mov     esi, ebx           {Convert 4 Chars in EBX into Uppercase}
  or      ebx, $80808080
  mov     edi, ebx
  sub     ebx, $7B7B7B7B
  xor     edi, esi
  or      ebx, $80808080
  sub     ebx, $66666666
  and     ebx, edi
  shr     ebx, 2
  xor     ebx, esi
  mov     esi, ecx           {Convert 4 Chars in ECX into Uppercase}
  or      ecx, $80808080
  mov     edi, ecx
  sub     ecx, $7B7B7B7B
  xor     edi, esi
  or      ecx, $80808080
  sub     ecx, $66666666
  and     ecx, edi
  shr     ecx, 2
  xor     ecx, esi
  cmp     ebx, ecx
  jne     @@CheckDiff
@@Next:
  add     ebp, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  pop     eax                {Default Result}
@@DiffLoop:
  cmp     cl, bl
  jne     @@SetResult
  add     ebp, 1
  jz      @@Done             {Difference after Compare Length}
  shr     ecx, 8
  shr     ebx, 8
  jmp     @@DiffLoop
@@SetResult:
  movzx   eax, bl            {Set Result from Character Difference}
  and     ecx, $ff
  sub     eax, ecx
@@Done:
  pop     esi
  pop     edi
  pop     ebp
  pop     ebx
end;

function CompareText_JOH_IA32_6_a(const S1, S2: string): Integer;
asm
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx        
  jnz     @@Compare
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@Compare          {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@@Same:
  xor     eax, eax
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@Compare:
  push    ebx
  push    ebp
  push    edi
  push    esi
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ebp, ebp
  and     ebp, ebx
  sub     ebp, [eax-4]       {-Min(Length(S1),Length(S2))}
  sub     eax, ebp           {End of S1}
  sub     edx, ebp           {End of S2}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ebp]
  mov     ecx, [edx+ebp]
  cmp     ebx, ecx
  je      @@Next
  mov     esi, ebx           {Convert 4 Chars in EBX into Uppercase}
  or      ebx, $80808080
  mov     edi, ebx
  sub     ebx, $7B7B7B7B
  xor     edi, esi
  or      ebx, $80808080
  sub     ebx, $66666666
  and     ebx, edi
  shr     ebx, 2
  xor     ebx, esi
  mov     esi, ecx           {Convert 4 Chars in ECX into Uppercase}
  or      ecx, $80808080
  mov     edi, ecx
  sub     ecx, $7B7B7B7B
  xor     edi, esi
  or      ecx, $80808080
  sub     ecx, $66666666
  and     ecx, edi
  shr     ecx, 2
  xor     ecx, esi
  cmp     ebx, ecx
  jne     @@CheckDiff
@@Next:
  add     ebp, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  pop     eax                {Default Result}
@@DiffLoop:
  cmp     bl, cl
  jne     @@SetResult
  add     ebp, 1
  jz      @@Done             {Difference after Compare Length}
  shr     ecx, 8
  shr     ebx, 8
  jmp     @@DiffLoop
@@SetResult:
  movzx   eax, bl            {Set Result from Character Difference}
  and     ecx, $ff
  sub     eax, ecx
@@Done:
  pop     esi
  pop     edi
  pop     ebp
  pop     ebx
end;

function CompareText_JOH_IA32_6_b(const S1, S2: string): Integer;
asm
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx        
  jnz     @@Compare
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@Compare          {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@@Same:
  xor     eax, eax
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@Compare:
  push    ebx
  push    ebp
  push    edi
  push    esi
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ebp, ebp
  and     ebp, ebx
  sub     ebp, [eax-4]       {-Min(Length(S1),Length(S2))}
  sub     eax, ebp           {End of S1}
  sub     edx, ebp           {End of S2}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ebp]
  mov     ecx, [edx+ebp]
  cmp     ebx, ecx
  je      @@Next
  mov     esi, ebx           {Convert 4 Chars in EBX into Uppercase}
  or      ebx, $80808080
  mov     edi, ebx
  sub     ebx, $7B7B7B7B
  xor     edi, esi
  or      ebx, $80808080
  sub     ebx, $66666666
  and     ebx, edi
  shr     ebx, 2
  xor     ebx, esi
  mov     esi, ecx           {Convert 4 Chars in ECX into Uppercase}
  or      ecx, $80808080
  mov     edi, ecx
  sub     ecx, $7B7B7B7B
  xor     edi, esi
  or      ecx, $80808080
  sub     ecx, $66666666
  and     ecx, edi
  shr     ecx, 2
  xor     ecx, esi
  cmp     ebx, ecx
  jne     @@CheckDiff
@@Next:
  add     ebp, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  pop     eax                {Default Result}
@@DiffLoop:
  cmp     bl, cl
  jne     @@SetResult
  add     ebp, 1
  jz      @@Done             {Difference after Compare Length}
  shr     ecx, 8
  shr     ebx, 8
  jmp     @@DiffLoop
@@SetResult:
  movzx   eax, bl            {Set Result from Character Difference}
  and     ecx, $ff
  sub     eax, ecx
@@Done:
  pop     esi
  pop     edi
  pop     ebp
  pop     ebx
end;

function CompareText_JOH_IA32_6_c(const S1, S2: string): Integer;
asm
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx        
  jnz     @@Compare
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@Compare          {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@@Same:
  xor     eax, eax
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@Compare:
  push    ebx
  push    ebp
  push    edi
  push    esi
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ebp, ebp
  and     ebp, ebx
  sub     ebp, [eax-4]       {-Min(Length(S1),Length(S2))}
  sub     eax, ebp           {End of S1}
  sub     edx, ebp           {End of S2}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ebp]
  mov     ecx, [edx+ebp]
  cmp     ebx, ecx
  je      @@Next
  mov     esi, ebx           {Convert 4 Chars in EBX into Uppercase}
  or      ebx, $80808080
  mov     edi, ebx
  sub     ebx, $7B7B7B7B
  xor     edi, esi
  or      ebx, $80808080
  sub     ebx, $66666666
  and     ebx, edi
  shr     ebx, 2
  xor     ebx, esi
  mov     esi, ecx           {Convert 4 Chars in ECX into Uppercase}
  or      ecx, $80808080
  mov     edi, ecx
  sub     ecx, $7B7B7B7B
  xor     edi, esi
  or      ecx, $80808080
  sub     ecx, $66666666
  and     ecx, edi
  shr     ecx, 2
  xor     ecx, esi
  cmp     ebx, ecx
  jne     @@CheckDiff
@@Next:
  add     ebp, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  pop     eax                {Default Result}
@@DiffLoop:
  cmp     bl, cl
  jne     @@SetResult
  add     ebp, 1
  jz      @@Done             {Difference after Compare Length}
  shr     ecx, 8
  shr     ebx, 8
  jmp     @@DiffLoop
@@SetResult:
  movzx   eax, bl            {Set Result from Character Difference}
  and     ecx, $ff
  sub     eax, ecx
@@Done:
  pop     esi
  pop     edi
  pop     ebp
  pop     ebx
end;

function CompareText_JOH_IA32_6_d(const S1, S2: string): Integer;
asm
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx        
  jnz     @@Compare
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@Compare          {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@@Same:
  xor     eax, eax
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@Compare:
  push    ebx
  push    ebp
  push    edi
  push    esi
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ebp, ebp
  and     ebp, ebx
  sub     ebp, [eax-4]       {-Min(Length(S1),Length(S2))}
  sub     eax, ebp           {End of S1}
  sub     edx, ebp           {End of S2}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ebp]
  mov     ecx, [edx+ebp]
  cmp     ebx, ecx
  je      @@Next
  mov     esi, ebx           {Convert 4 Chars in EBX into Uppercase}
  or      ebx, $80808080
  mov     edi, ebx
  sub     ebx, $7B7B7B7B
  xor     edi, esi
  or      ebx, $80808080
  sub     ebx, $66666666
  and     ebx, edi
  shr     ebx, 2
  xor     ebx, esi
  mov     esi, ecx           {Convert 4 Chars in ECX into Uppercase}
  or      ecx, $80808080
  mov     edi, ecx
  sub     ecx, $7B7B7B7B
  xor     edi, esi
  or      ecx, $80808080
  sub     ecx, $66666666
  and     ecx, edi
  shr     ecx, 2
  xor     ecx, esi
  cmp     ebx, ecx
  jne     @@CheckDiff
@@Next:
  add     ebp, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  pop     eax                {Default Result}
@@DiffLoop:
  cmp     bl, cl
  jne     @@SetResult
  add     ebp, 1
  jz      @@Done             {Difference after Compare Length}
  shr     ecx, 8
  shr     ebx, 8
  jmp     @@DiffLoop
@@SetResult:
  movzx   eax, bl            {Set Result from Character Difference}
  and     ecx, $ff
  sub     eax, ecx
@@Done:
  pop     esi
  pop     edi
  pop     ebp
  pop     ebx
end;

initialization
 Filler1;
 Filler2;
 Filler3;
 Filler4;

end.
