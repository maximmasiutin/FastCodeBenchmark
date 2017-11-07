unit StrLenJOHUnit;

interface

function StrLen_JOH_PAS_1_a(const Str: PChar): Cardinal;
function StrLen_JOH_PAS_1_b(const Str: PChar): Cardinal;
function StrLen_JOH_PAS_1_c(const Str: PChar): Cardinal;
function StrLen_JOH_PAS_1_d(const Str: PChar): Cardinal;
function StrLen_JOH_PAS_3_a(const Str: PChar): Cardinal;
function StrLen_JOH_PAS_3_b(const Str: PChar): Cardinal;
function StrLen_JOH_PAS_3_c(const Str: PChar): Cardinal;
function StrLen_JOH_PAS_3_d(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_1_a(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_1_b(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_1_c(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_1_d(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_2_a(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_2_b(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_2_c(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_2_d(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_7_a(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_7_b(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_7_c(const Str: PChar): Cardinal;
function StrLen_JOH_IA32_7_d(const Str: PChar): Cardinal;
function StrLen_JOH_SSE2_1_a(const Str: PChar): Cardinal;
function StrLen_JOH_SSE2_1_b(const Str: PChar): Cardinal;
function StrLen_JOH_SSE2_1_c(const Str: PChar): Cardinal;
function StrLen_JOH_SSE2_1_d(const Str: PChar): Cardinal;
function StrLen_JOH_SSE2_2_a(const Str: PChar): Cardinal;
function StrLen_JOH_SSE2_2_b(const Str: PChar): Cardinal;
function StrLen_JOH_SSE2_2_c(const Str: PChar): Cardinal;
function StrLen_JOH_SSE2_2_d(const Str: PChar): Cardinal;

implementation

{$R-,Q-}

function StrLen_JOH_PAS_1_a(const Str: PChar): Cardinal;
var
  P : PChar;
begin
  P := Str;
  while P^ <> #0 do
    Inc(P);
  Result := P - Str;
end;

procedure Filler1;
asm
 nop
end;

function StrLen_JOH_PAS_1_b(const Str: PChar): Cardinal;
var
  P : PChar;
begin
  P := Str;
  while P^ <> #0 do
    Inc(P);
  Result := P - Str;
end;

procedure Filler2;
asm
 nop
end;

function StrLen_JOH_PAS_1_c(const Str: PChar): Cardinal;
var
  P : PChar;
begin
  P := Str;
  while P^ <> #0 do
    Inc(P);
  Result := P - Str;
end;

procedure Filler3;
asm
 nop
end;

function StrLen_JOH_PAS_1_d(const Str: PChar): Cardinal;
var
  P : PChar;
begin
  P := Str;
  while P^ <> #0 do
    Inc(P);
  Result := P - Str;
end;

function StrLen_JOH_PAS_3_a(const Str: PChar): Cardinal;
var
  P, PStr: PChar;
  I, J: Integer;
begin
  if Str^ = #0 then
    begin
      Result := 0; Exit;
    end;
  if Str[1] = #0 then
    begin
      Result := 1; Exit;
    end;
  if Str[2] = #0 then
    begin
      Result := 2; Exit;
    end;
  if Str[3] = #0 then
    begin
      Result := 3; Exit;
    end;
 P := Pointer(Str);
 PStr := P;
 P := Pointer(Integer(P) and -4);
 repeat
   Inc(P, 4);
   I := PInteger(P)^;
   J := I - $01010101;
   I := not(I);
   I := I and J;
 until (I and $80808080) <> 0;
 Result := P - PStr;
 if I and $80 = 0 then
   if I and $8000 <> 0 then
     Inc(Result)
   else
     if I and $800000 <> 0 then
       Inc(Result, 2)
     else
       Inc(Result, 3)
end;

function StrLen_JOH_PAS_3_b(const Str: PChar): Cardinal;
var
  P, PStr: PChar;
  I, J: Integer;
begin
  if Str^ = #0 then
    begin
      Result := 0; Exit;
    end;
  if Str[1] = #0 then
    begin
      Result := 1; Exit;
    end;
  if Str[2] = #0 then
    begin
      Result := 2; Exit;
    end;
  if Str[3] = #0 then
    begin
      Result := 3; Exit;
    end;
 P := Pointer(Str);
 PStr := P;
 P := Pointer(Integer(P) and -4);
 repeat
   Inc(P, 4);
   I := PInteger(P)^;
   J := I - $01010101;
   I := not(I);
   I := I and J;
 until (I and $80808080) <> 0;
 Result := P - PStr;
 if I and $80 = 0 then
   if I and $8000 <> 0 then
     Inc(Result)
   else
     if I and $800000 <> 0 then
       Inc(Result, 2)
     else
       Inc(Result, 3)
end;

function StrLen_JOH_PAS_3_c(const Str: PChar): Cardinal;
var
  P, PStr: PChar;
  I, J: Integer;
begin
  if Str^ = #0 then
    begin
      Result := 0; Exit;
    end;
  if Str[1] = #0 then
    begin
      Result := 1; Exit;
    end;
  if Str[2] = #0 then
    begin
      Result := 2; Exit;
    end;
  if Str[3] = #0 then
    begin
      Result := 3; Exit;
    end;
 P := Pointer(Str);
 PStr := P;
 P := Pointer(Integer(P) and -4);
 repeat
   Inc(P, 4);
   I := PInteger(P)^;
   J := I - $01010101;
   I := not(I);
   I := I and J;
 until (I and $80808080) <> 0;
 Result := P - PStr;
 if I and $80 = 0 then
   if I and $8000 <> 0 then
     Inc(Result)
   else
     if I and $800000 <> 0 then
       Inc(Result, 2)
     else
       Inc(Result, 3)
end;

function StrLen_JOH_PAS_3_d(const Str: PChar): Cardinal;
var
  P, PStr: PChar;
  I, J: Integer;
begin
  if Str^ = #0 then
    begin
      Result := 0; Exit;
    end;
  if Str[1] = #0 then
    begin
      Result := 1; Exit;
    end;
  if Str[2] = #0 then
    begin
      Result := 2; Exit;
    end;
  if Str[3] = #0 then
    begin
      Result := 3; Exit;
    end;
 P := Pointer(Str);
 PStr := P;
 P := Pointer(Integer(P) and -4);
 repeat
   Inc(P, 4);
   I := PInteger(P)^;
   J := I - $01010101;
   I := not(I);
   I := I and J;
 until (I and $80808080) <> 0;
 Result := P - PStr;
 if I and $80 = 0 then
   if I and $8000 <> 0 then
     Inc(Result)
   else
     if I and $800000 <> 0 then
       Inc(Result, 2)
     else
       Inc(Result, 3)
end;

function StrLen_JOH_IA32_1_a(const Str: PChar): Cardinal;
asm
  lea   edx, [eax+1]
@@Loop:
  movzx ecx, [eax]
  add   eax, 1
  test  cl, cl
  jnz   @@Loop
  sub   eax, edx
end;

procedure Filler4;
asm
 nop
end;

function StrLen_JOH_IA32_1_b(const Str: PChar): Cardinal;
asm
  lea   edx, [eax+1]
@@Loop:
  movzx ecx, [eax]
  add   eax, 1
  test  cl, cl
  jnz   @@Loop
  sub   eax, edx
end;

procedure Filler5;
asm
 nop
end;

function StrLen_JOH_IA32_1_c(const Str: PChar): Cardinal;
asm
  lea   edx, [eax+1]
@@Loop:
  movzx ecx, [eax]
  add   eax, 1
  test  cl, cl
  jnz   @@Loop
  sub   eax, edx
end;

procedure Filler6;
asm
 nop
end;

function StrLen_JOH_IA32_1_d(const Str: PChar): Cardinal;
asm
  lea   edx, [eax+1]
@@Loop:
  movzx ecx, [eax]
  add   eax, 1
  test  cl, cl
  jnz   @@Loop
  sub   eax, edx
end;

function StrLen_JOH_IA32_2_a(const Str: PChar): Cardinal;
asm
  mov   edx, eax
  xor   ecx, ecx
@@Loop:
  cmp   cl, [eax]
  je    @@0
  cmp   cl, [eax+1]
  je    @@1
  cmp   cl, [eax+2]
  je    @@2
  cmp   cl, [eax+3]
  je    @@3
  cmp   cl, [eax+4]
  je    @@4
  cmp   cl, [eax+5]
  je    @@5
  cmp   cl, [eax+6]
  je    @@6
  cmp   cl, [eax+7]
  je    @@7
  add   eax, 8
  jmp   @@Loop
@@7:
  add   eax, 1
@@6:
  add   eax, 1
@@5:
  add   eax, 1
@@4:
  add   eax, 1
@@3:
  add   eax, 1
@@2:
  add   eax, 1
@@1:
  add   eax, 1
@@0:
  sub   eax, edx
end;

function StrLen_JOH_IA32_2_b(const Str: PChar): Cardinal;
asm
  mov   edx, eax
  xor   ecx, ecx
@@Loop:
  cmp   cl, [eax]
  je    @@0
  cmp   cl, [eax+1]
  je    @@1
  cmp   cl, [eax+2]
  je    @@2
  cmp   cl, [eax+3]
  je    @@3
  cmp   cl, [eax+4]
  je    @@4
  cmp   cl, [eax+5]
  je    @@5
  cmp   cl, [eax+6]
  je    @@6
  cmp   cl, [eax+7]
  je    @@7
  add   eax, 8
  jmp   @@Loop
@@7:
  add   eax, 1
@@6:
  add   eax, 1
@@5:
  add   eax, 1
@@4:
  add   eax, 1
@@3:
  add   eax, 1
@@2:
  add   eax, 1
@@1:
  add   eax, 1
@@0:
  sub   eax, edx
end;

procedure Filler7;
asm
 nop
end;

function StrLen_JOH_IA32_2_c(const Str: PChar): Cardinal;
asm
  mov   edx, eax
  xor   ecx, ecx
@@Loop:
  cmp   cl, [eax]
  je    @@0
  cmp   cl, [eax+1]
  je    @@1
  cmp   cl, [eax+2]
  je    @@2
  cmp   cl, [eax+3]
  je    @@3
  cmp   cl, [eax+4]
  je    @@4
  cmp   cl, [eax+5]
  je    @@5
  cmp   cl, [eax+6]
  je    @@6
  cmp   cl, [eax+7]
  je    @@7
  add   eax, 8
  jmp   @@Loop
@@7:
  add   eax, 1
@@6:
  add   eax, 1
@@5:
  add   eax, 1
@@4:
  add   eax, 1
@@3:
  add   eax, 1
@@2:
  add   eax, 1
@@1:
  add   eax, 1
@@0:
  sub   eax, edx
end;

function StrLen_JOH_IA32_2_d(const Str: PChar): Cardinal;
asm
  mov   edx, eax
  xor   ecx, ecx
@@Loop:
  cmp   cl, [eax]
  je    @@0
  cmp   cl, [eax+1]
  je    @@1
  cmp   cl, [eax+2]
  je    @@2
  cmp   cl, [eax+3]
  je    @@3
  cmp   cl, [eax+4]
  je    @@4
  cmp   cl, [eax+5]
  je    @@5
  cmp   cl, [eax+6]
  je    @@6
  cmp   cl, [eax+7]
  je    @@7
  add   eax, 8
  jmp   @@Loop
@@7:
  add   eax, 1
@@6:
  add   eax, 1
@@5:
  add   eax, 1
@@4:
  add   eax, 1
@@3:
  add   eax, 1
@@2:
  add   eax, 1
@@1:
  add   eax, 1
@@0:
  sub   eax, edx
end;

function StrLen_JOH_IA32_7_a(const Str: PChar): Cardinal;
asm
  cmp   byte ptr [eax], 0
  je    @@0
  cmp   byte ptr [eax+1], 0
  je    @@1
  cmp   byte ptr [eax+2], 0
  je    @@2
  cmp   byte ptr [eax+3], 0
  je    @@3
  push  eax
  and   eax, -4              {DWORD Align Reads}
@@Loop:
  add   eax, 4
  mov   edx, [eax]           {4 Chars per Loop}
  lea   ecx, [edx-$01010101]
  not   edx
  and   edx, ecx
  and   edx, $80808080       {Set Byte to $80 at each #0 Position}
  jz    @@Loop               {Loop until any #0 Found}
@@SetResult:
  pop   ecx
  bsf   edx, edx             {Find First #0 Position}
  shr   edx, 3               {Byte Offset of First #0}
  add   eax, edx             {Address of First #0}
  sub   eax, ecx
  ret
@@0:
  xor   eax, eax
  ret
@@1:
  mov   eax, 1
  ret
@@2:
  mov   eax, 2
  ret
@@3:
  mov   eax, 3
end;

function StrLen_JOH_IA32_7_b(const Str: PChar): Cardinal;
asm
  cmp   byte ptr [eax], 0
  je    @@0
  cmp   byte ptr [eax+1], 0
  je    @@1
  cmp   byte ptr [eax+2], 0
  je    @@2
  cmp   byte ptr [eax+3], 0
  je    @@3
  push  eax
  and   eax, -4              {DWORD Align Reads}
@@Loop:
  add   eax, 4
  mov   edx, [eax]           {4 Chars per Loop}
  lea   ecx, [edx-$01010101]
  not   edx
  and   edx, ecx
  and   edx, $80808080       {Set Byte to $80 at each #0 Position}
  jz    @@Loop               {Loop until any #0 Found}
@@SetResult:
  pop   ecx
  bsf   edx, edx             {Find First #0 Position}
  shr   edx, 3               {Byte Offset of First #0}
  add   eax, edx             {Address of First #0}
  sub   eax, ecx
  ret
@@0:
  xor   eax, eax
  ret
@@1:
  mov   eax, 1
  ret
@@2:
  mov   eax, 2
  ret
@@3:
  mov   eax, 3
end;

function StrLen_JOH_IA32_7_c(const Str: PChar): Cardinal;
asm
  cmp   byte ptr [eax], 0
  je    @@0
  cmp   byte ptr [eax+1], 0
  je    @@1
  cmp   byte ptr [eax+2], 0
  je    @@2
  cmp   byte ptr [eax+3], 0
  je    @@3
  push  eax
  and   eax, -4              {DWORD Align Reads}
@@Loop:
  add   eax, 4
  mov   edx, [eax]           {4 Chars per Loop}
  lea   ecx, [edx-$01010101]
  not   edx
  and   edx, ecx
  and   edx, $80808080       {Set Byte to $80 at each #0 Position}
  jz    @@Loop               {Loop until any #0 Found}
@@SetResult:
  pop   ecx
  bsf   edx, edx             {Find First #0 Position}
  shr   edx, 3               {Byte Offset of First #0}
  add   eax, edx             {Address of First #0}
  sub   eax, ecx
  ret
@@0:
  xor   eax, eax
  ret
@@1:
  mov   eax, 1
  ret
@@2:
  mov   eax, 2
  ret
@@3:
  mov   eax, 3
end;

function StrLen_JOH_IA32_7_d(const Str: PChar): Cardinal;
asm
  cmp   byte ptr [eax], 0
  je    @@0
  cmp   byte ptr [eax+1], 0
  je    @@1
  cmp   byte ptr [eax+2], 0
  je    @@2
  cmp   byte ptr [eax+3], 0
  je    @@3
  push  eax
  and   eax, -4              {DWORD Align Reads}
@@Loop:
  add   eax, 4
  mov   edx, [eax]           {4 Chars per Loop}
  lea   ecx, [edx-$01010101]
  not   edx
  and   edx, ecx
  and   edx, $80808080       {Set Byte to $80 at each #0 Position}
  jz    @@Loop               {Loop until any #0 Found}
@@SetResult:
  pop   ecx
  bsf   edx, edx             {Find First #0 Position}
  shr   edx, 3               {Byte Offset of First #0}
  add   eax, edx             {Address of First #0}
  sub   eax, ecx
  ret
@@0:
  xor   eax, eax
  ret
@@1:
  mov   eax, 1
  ret
@@2:
  mov   eax, 2
  ret
@@3:
  mov   eax, 3
end;

function StrLen_JOH_SSE2_1_a(const Str: PChar): Cardinal;
asm
  lea      ecx, [eax+16]
  test     ecx, $ff0
  jz       @@NearPageEnd
@@WithinPage:
  pxor     xmm0, xmm0
  movdqu   xmm1, [eax]
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jnz      @@SetResult
  and      eax, -16
@@AlignedLoop:
  movdqa   xmm1, [eax]
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jz       @@AlignedLoop
@@SetResult:
  bsf      edx, edx
  add      eax, edx
  sub      eax, ecx
  ret
@@NearPageEnd:
  mov      edx, eax
@@Loop:
  cmp      byte ptr [eax], 0
  je       @@SetResult2
  add      eax, 1
  test     eax, 15
  jnz      @@Loop
  jmp      @@WithinPage
@@SetResult2:
  sub      eax, edx
end;

function StrLen_JOH_SSE2_1_b(const Str: PChar): Cardinal;
asm
  lea      ecx, [eax+16]
  test     ecx, $ff0
  jz       @@NearPageEnd
@@WithinPage:
  pxor     xmm0, xmm0
  movdqu   xmm1, [eax]
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jnz      @@SetResult
  and      eax, -16
@@AlignedLoop:
  movdqa   xmm1, [eax]
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jz       @@AlignedLoop
@@SetResult:
  bsf      edx, edx
  add      eax, edx
  sub      eax, ecx
  ret
@@NearPageEnd:
  mov      edx, eax
@@Loop:
  cmp      byte ptr [eax], 0
  je       @@SetResult2
  add      eax, 1
  test     eax, 15
  jnz      @@Loop
  jmp      @@WithinPage
@@SetResult2:
  sub      eax, edx
end;

procedure Filler9;
asm
 nop
end;

function StrLen_JOH_SSE2_1_c(const Str: PChar): Cardinal;
asm
  lea      ecx, [eax+16]
  test     ecx, $ff0
  jz       @@NearPageEnd
@@WithinPage:
  pxor     xmm0, xmm0
  movdqu   xmm1, [eax]
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jnz      @@SetResult
  and      eax, -16
@@AlignedLoop:
  movdqa   xmm1, [eax]
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jz       @@AlignedLoop
@@SetResult:
  bsf      edx, edx
  add      eax, edx
  sub      eax, ecx
  ret
@@NearPageEnd:
  mov      edx, eax
@@Loop:
  cmp      byte ptr [eax], 0
  je       @@SetResult2
  add      eax, 1
  test     eax, 15
  jnz      @@Loop
  jmp      @@WithinPage
@@SetResult2:
  sub      eax, edx
end;

function StrLen_JOH_SSE2_1_d(const Str: PChar): Cardinal;
asm
  lea      ecx, [eax+16]
  test     ecx, $ff0
  jz       @@NearPageEnd
@@WithinPage:
  pxor     xmm0, xmm0
  movdqu   xmm1, [eax]
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jnz      @@SetResult
  and      eax, -16
@@AlignedLoop:
  movdqa   xmm1, [eax]
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jz       @@AlignedLoop
@@SetResult:
  bsf      edx, edx
  add      eax, edx
  sub      eax, ecx
  ret
@@NearPageEnd:
  mov      edx, eax
@@Loop:
  cmp      byte ptr [eax], 0
  je       @@SetResult2
  add      eax, 1
  test     eax, 15
  jnz      @@Loop
  jmp      @@WithinPage
@@SetResult2:
  sub      eax, edx
end;

function StrLen_JOH_SSE2_2_a(const Str: PChar): Cardinal; //Unreleased
asm
  lea      ecx, [eax+16]
  test     ecx, $ff0
  pxor     xmm0, xmm0
  jz       @@NearPageEnd     {Within 16 Bytes of Page End}
@@WithinPage:
  movdqu   xmm1, [eax]       {Check First 16 Bytes for #0}
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jnz      @@SetResult
  and      eax, -16          {Align Memory Reads}
@@AlignedLoop:
  movdqa   xmm1, [eax]       {Check Next 16 Bytes for #0}
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jz       @@AlignedLoop
@@SetResult:
  bsf      edx, edx          {#0 Found - Set Result}
  add      eax, edx
  sub      eax, ecx
  ret
@@NearPageEnd:
  mov      edx, eax
@@Loop:
  cmp      byte ptr [eax], 0 {Loop until #0 Found or 16-Byte Aligned}
  je       @@SetResult2
  add      eax, 1
  test     eax, 15
  jnz      @@Loop
  jmp      @@AlignedLoop
@@SetResult2:
  sub      eax, edx
end;

function StrLen_JOH_SSE2_2_b(const Str: PChar): Cardinal; //Unreleased
asm
  lea      ecx, [eax+16]
  test     ecx, $ff0
  pxor     xmm0, xmm0
  jz       @@NearPageEnd     {Within 16 Bytes of Page End}
@@WithinPage:
  movdqu   xmm1, [eax]       {Check First 16 Bytes for #0}
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jnz      @@SetResult
  and      eax, -16          {Align Memory Reads}
@@AlignedLoop:
  movdqa   xmm1, [eax]       {Check Next 16 Bytes for #0}
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jz       @@AlignedLoop
@@SetResult:
  bsf      edx, edx          {#0 Found - Set Result}
  add      eax, edx
  sub      eax, ecx
  ret
@@NearPageEnd:
  mov      edx, eax
@@Loop:
  cmp      byte ptr [eax], 0 {Loop until #0 Found or 16-Byte Aligned}
  je       @@SetResult2
  add      eax, 1
  test     eax, 15
  jnz      @@Loop
  jmp      @@AlignedLoop
@@SetResult2:
  sub      eax, edx
end;

procedure Filler10;
asm
 nop
end;

function StrLen_JOH_SSE2_2_c(const Str: PChar): Cardinal; //Unreleased
asm
  lea      ecx, [eax+16]
  test     ecx, $ff0
  pxor     xmm0, xmm0
  jz       @@NearPageEnd     {Within 16 Bytes of Page End}
@@WithinPage:
  movdqu   xmm1, [eax]       {Check First 16 Bytes for #0}
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jnz      @@SetResult
  and      eax, -16          {Align Memory Reads}
@@AlignedLoop:
  movdqa   xmm1, [eax]       {Check Next 16 Bytes for #0}
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jz       @@AlignedLoop
@@SetResult:
  bsf      edx, edx          {#0 Found - Set Result}
  add      eax, edx
  sub      eax, ecx
  ret
@@NearPageEnd:
  mov      edx, eax
@@Loop:
  cmp      byte ptr [eax], 0 {Loop until #0 Found or 16-Byte Aligned}
  je       @@SetResult2
  add      eax, 1
  test     eax, 15
  jnz      @@Loop
  jmp      @@AlignedLoop
@@SetResult2:
  sub      eax, edx
end;

function StrLen_JOH_SSE2_2_d(const Str: PChar): Cardinal; //Unreleased
asm
  lea      ecx, [eax+16]
  test     ecx, $ff0
  pxor     xmm0, xmm0
  jz       @@NearPageEnd     {Within 16 Bytes of Page End}
@@WithinPage:
  movdqu   xmm1, [eax]       {Check First 16 Bytes for #0}
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jnz      @@SetResult
  and      eax, -16          {Align Memory Reads}
@@AlignedLoop:
  movdqa   xmm1, [eax]       {Check Next 16 Bytes for #0}
  add      eax, 16
  pcmpeqb  xmm1, xmm0
  pmovmskb edx, xmm1
  test     edx, edx
  jz       @@AlignedLoop
@@SetResult:
  bsf      edx, edx          {#0 Found - Set Result}
  add      eax, edx
  sub      eax, ecx
  ret
@@NearPageEnd:
  mov      edx, eax
@@Loop:
  cmp      byte ptr [eax], 0 {Loop until #0 Found or 16-Byte Aligned}
  je       @@SetResult2
  add      eax, 1
  test     eax, 15
  jnz      @@Loop
  jmp      @@AlignedLoop
@@SetResult2:
  sub      eax, edx
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;
 Filler7;
 Filler9;
 Filler10;

end.
