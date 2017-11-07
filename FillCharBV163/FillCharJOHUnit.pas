unit FillCharJOHUnit;

interface

procedure FillChar_JOH_PAS_1_a (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_PAS_1_b (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_PAS_1_c (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_PAS_1_d (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_3_a (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_3_b (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_3_c (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_3_d (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_1_a(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_1_b(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_1_c(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_1_d(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_2_a (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_2_b (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_2_c (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_IA32_2_d (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_MMX_1_a (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_MMX_1_b (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_MMX_1_c (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_MMX_1_d (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_SSE_1_a (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_SSE_1_b (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_SSE_1_c (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_SSE_1_d (var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_SSE2_1_a(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_SSE2_1_b(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_SSE2_1_c(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_SSE2_1_d(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_MMX_4_a(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_MMX_4_b(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_MMX_4_c(var Dest; count: Integer; Value: Char);
procedure FillChar_JOH_MMX_4_d(var Dest; count: Integer; Value: Char);

implementation

uses
  SysUtils;

procedure FillChar_JOH_PAS_1_a(var Dest; count: Integer; Value: Char);
var {Size = 132 Byte}
  I, J, K : Integer;
  P       : PByte;
begin
  I := Count;
  P := @Dest;
  if I >= 8 then
    begin
      J := Byte(Value);
      J := J or (J shl  8);
      J := J or (J shl 16);
      PInteger(P)^ := J;
      if I > 128 then
        begin {Alligned Fill 16 Chars per Loop}
          K := (Integer(P) and 3) - 20;
          Inc(P, I - 16);
          Inc(I, K);
          PintegerArray(P)[0] := J;
          PintegerArray(P)[1] := J;
          PintegerArray(P)[2] := J;
          PintegerArray(P)[3] := J;
          repeat
            PintegerArray(Integer(P)-I)[0] := J;
            PintegerArray(Integer(P)-I)[1] := J;
            PintegerArray(Integer(P)-I)[2] := J;
            PintegerArray(Integer(P)-I)[3] := J;
            Dec(I, 16);
          until I <= 0;
        end
      else
        begin {Fill 4 Chars per Loop}
          Inc(P, I);
          PInteger(Integer(P)-4)^ := J;
          repeat
            PInteger(Integer(P)-I)^ := J;
            Dec(I, 4);
          until I <= 4;
        end;
    end
  else
    if I > 0 then
      repeat
        Dec(I);
        PByteArray(P)[I] := Ord(Value);
      until I = 0;
end;

procedure FillChar_JOH_PAS_1_b(var Dest; count: Integer; Value: Char);
var {Size = 132 Byte}
  I, J, K : Integer;
  P       : PByte;
begin
  I := Count;
  P := @Dest;
  if I >= 8 then
    begin
      J := Byte(Value);
      J := J or (J shl  8);
      J := J or (J shl 16);
      PInteger(P)^ := J;
      if I > 128 then
        begin {Alligned Fill 16 Chars per Loop}
          K := (Integer(P) and 3) - 20;
          Inc(P, I - 16);
          Inc(I, K);
          PintegerArray(P)[0] := J;
          PintegerArray(P)[1] := J;
          PintegerArray(P)[2] := J;
          PintegerArray(P)[3] := J;
          repeat
            PintegerArray(Integer(P)-I)[0] := J;
            PintegerArray(Integer(P)-I)[1] := J;
            PintegerArray(Integer(P)-I)[2] := J;
            PintegerArray(Integer(P)-I)[3] := J;
            Dec(I, 16);
          until I <= 0;
        end
      else
        begin {Fill 4 Chars per Loop}
          Inc(P, I);
          PInteger(Integer(P)-4)^ := J;
          repeat
            PInteger(Integer(P)-I)^ := J;
            Dec(I, 4);
          until I <= 4;
        end;
    end
  else
    if I > 0 then
      repeat
        Dec(I);
        PByteArray(P)[I] := Ord(Value);
      until I = 0;
end;

procedure FillChar_JOH_PAS_1_c(var Dest; count: Integer; Value: Char);
var {Size = 132 Byte}
  I, J, K : Integer;
  P       : PByte;
begin
  I := Count;
  P := @Dest;
  if I >= 8 then
    begin
      J := Byte(Value);
      J := J or (J shl  8);
      J := J or (J shl 16);
      PInteger(P)^ := J;
      if I > 128 then
        begin {Alligned Fill 16 Chars per Loop}
          K := (Integer(P) and 3) - 20;
          Inc(P, I - 16);
          Inc(I, K);
          PintegerArray(P)[0] := J;
          PintegerArray(P)[1] := J;
          PintegerArray(P)[2] := J;
          PintegerArray(P)[3] := J;
          repeat
            PintegerArray(Integer(P)-I)[0] := J;
            PintegerArray(Integer(P)-I)[1] := J;
            PintegerArray(Integer(P)-I)[2] := J;
            PintegerArray(Integer(P)-I)[3] := J;
            Dec(I, 16);
          until I <= 0;
        end
      else
        begin {Fill 4 Chars per Loop}
          Inc(P, I);
          PInteger(Integer(P)-4)^ := J;
          repeat
            PInteger(Integer(P)-I)^ := J;
            Dec(I, 4);
          until I <= 4;
        end;
    end
  else
    if I > 0 then
      repeat
        Dec(I);
        PByteArray(P)[I] := Ord(Value);
      until I = 0;
end;

procedure FillChar_JOH_PAS_1_d(var Dest; count: Integer; Value: Char);
var {Size = 132 Byte}
  I, J, K : Integer;
  P       : PByte;
begin
  I := Count;
  P := @Dest;
  if I >= 8 then
    begin
      J := Byte(Value);
      J := J or (J shl  8);
      J := J or (J shl 16);
      PInteger(P)^ := J;
      if I > 128 then
        begin {Alligned Fill 16 Chars per Loop}
          K := (Integer(P) and 3) - 20;
          Inc(P, I - 16);
          Inc(I, K);
          PintegerArray(P)[0] := J;
          PintegerArray(P)[1] := J;
          PintegerArray(P)[2] := J;
          PintegerArray(P)[3] := J;
          repeat
            PintegerArray(Integer(P)-I)[0] := J;
            PintegerArray(Integer(P)-I)[1] := J;
            PintegerArray(Integer(P)-I)[2] := J;
            PintegerArray(Integer(P)-I)[3] := J;
            Dec(I, 16);
          until I <= 0;
        end
      else
        begin {Fill 4 Chars per Loop}
          Inc(P, I);
          PInteger(Integer(P)-4)^ := J;
          repeat
            PInteger(Integer(P)-I)^ := J;
            Dec(I, 4);
          until I <= 4;
        end;
    end
  else
    if I > 0 then
      repeat
        Dec(I);
        PByteArray(P)[I] := Ord(Value);
      until I = 0;
end;

procedure FillChar_JOH_IA32_3_a(var Dest; count: Integer; Value: Char);
asm {Size = 90 Bytes}
  cmp   edx, 12
  mov   ch, cl            {Copy Value into both Bytes of CX}
  jl    @@Small
  push  ebx
  lea   edx, [eax+edx-8]
  mov   bx, cx            {Copy Value into each Byte of ECX}
  shl   ecx, 16
  mov   cx, bx
  mov   [eax], ecx        {Fill First 4 Bytes}
  mov   [edx], ecx        {Fill Last 8 Bytes}
  mov   [edx+4], ecx
  add   eax, 3            {4-Byte Align Writes}
  and   eax, -4
@@Loop:
  mov   [eax], ecx        {Fill 8 Bytes per Loop}
  mov   [eax+4], ecx
  add   eax, 8
  cmp   eax, edx
  jl    @@Loop
  pop   ebx
  ret
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl   {Copy Value to Last Byte}
  and   edx, -2
  jz    @@Done
  mov   [eax], cx         {Copy Value to First 2 Bytes}
  mov   [eax+edx-2], cx   {Copy Value to Last 2 Bytes}
  shr   edx, 2
  mov   [eax+edx], cx     {Copy/Overwrite other Bytes}
  lea   eax, [eax+edx*2]
  mov   [eax], cx         {Copy/Overwrite other Bytes}
  and   edx, -2
  mov   [eax+edx], cx     {Copy/Overwrite other Bytes}
@@Done:
end;

procedure FillChar_JOH_IA32_3_b(var Dest; count: Integer; Value: Char);
asm {Size = 90 Bytes}
  cmp   edx, 12
  mov   ch, cl            {Copy Value into both Bytes of CX}
  jl    @@Small
  push  ebx
  lea   edx, [eax+edx-8]
  mov   bx, cx            {Copy Value into each Byte of ECX}
  shl   ecx, 16
  mov   cx, bx
  mov   [eax], ecx        {Fill First 4 Bytes}
  mov   [edx], ecx        {Fill Last 8 Bytes}
  mov   [edx+4], ecx
  add   eax, 3            {4-Byte Align Writes}
  and   eax, -4
@@Loop:
  mov   [eax], ecx        {Fill 8 Bytes per Loop}
  mov   [eax+4], ecx
  add   eax, 8
  cmp   eax, edx
  jl    @@Loop
  pop   ebx
  ret
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl   {Copy Value to Last Byte}
  and   edx, -2
  jz    @@Done
  mov   [eax], cx         {Copy Value to First 2 Bytes}
  mov   [eax+edx-2], cx   {Copy Value to Last 2 Bytes}
  shr   edx, 2
  mov   [eax+edx], cx     {Copy/Overwrite other Bytes}
  lea   eax, [eax+edx*2]
  mov   [eax], cx         {Copy/Overwrite other Bytes}
  and   edx, -2
  mov   [eax+edx], cx     {Copy/Overwrite other Bytes}
@@Done:
end;

procedure FillChar_JOH_IA32_3_c(var Dest; count: Integer; Value: Char);
asm {Size = 90 Bytes}
  cmp   edx, 12
  mov   ch, cl            {Copy Value into both Bytes of CX}
  jl    @@Small
  push  ebx
  lea   edx, [eax+edx-8]
  mov   bx, cx            {Copy Value into each Byte of ECX}
  shl   ecx, 16
  mov   cx, bx
  mov   [eax], ecx        {Fill First 4 Bytes}
  mov   [edx], ecx        {Fill Last 8 Bytes}
  mov   [edx+4], ecx
  add   eax, 3            {4-Byte Align Writes}
  and   eax, -4
@@Loop:
  mov   [eax], ecx        {Fill 8 Bytes per Loop}
  mov   [eax+4], ecx
  add   eax, 8
  cmp   eax, edx
  jl    @@Loop
  pop   ebx
  ret
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl   {Copy Value to Last Byte}
  and   edx, -2
  jz    @@Done
  mov   [eax], cx         {Copy Value to First 2 Bytes}
  mov   [eax+edx-2], cx   {Copy Value to Last 2 Bytes}
  shr   edx, 2
  mov   [eax+edx], cx     {Copy/Overwrite other Bytes}
  lea   eax, [eax+edx*2]
  mov   [eax], cx         {Copy/Overwrite other Bytes}
  and   edx, -2
  mov   [eax+edx], cx     {Copy/Overwrite other Bytes}
@@Done:
end;

procedure FillChar_JOH_IA32_3_d(var Dest; count: Integer; Value: Char);
asm {Size = 90 Bytes}
  cmp   edx, 12
  mov   ch, cl            {Copy Value into both Bytes of CX}
  jl    @@Small
  push  ebx
  lea   edx, [eax+edx-8]
  mov   bx, cx            {Copy Value into each Byte of ECX}
  shl   ecx, 16
  mov   cx, bx
  mov   [eax], ecx        {Fill First 4 Bytes}
  mov   [edx], ecx        {Fill Last 8 Bytes}
  mov   [edx+4], ecx
  add   eax, 3            {4-Byte Align Writes}
  and   eax, -4
@@Loop:
  mov   [eax], ecx        {Fill 8 Bytes per Loop}
  mov   [eax+4], ecx
  add   eax, 8
  cmp   eax, edx
  jl    @@Loop
  pop   ebx
  ret
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl   {Copy Value to Last Byte}
  and   edx, -2
  jz    @@Done
  mov   [eax], cx         {Copy Value to First 2 Bytes}
  mov   [eax+edx-2], cx   {Copy Value to Last 2 Bytes}
  shr   edx, 2
  mov   [eax+edx], cx     {Copy/Overwrite other Bytes}
  lea   eax, [eax+edx*2]
  mov   [eax], cx         {Copy/Overwrite other Bytes}
  and   edx, -2
  mov   [eax+edx], cx     {Copy/Overwrite other Bytes}
@@Done:
end;

procedure FillChar_JOH_IA32_1_a(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp   edx, 32
  mov   ch, cl                    {Copy Value into both Bytes of CX}
  jl    @@Small
  push  ebx
  sub   edx, 16
  mov   bx, cx                    {Copy Value into each Byte of ECX}
  shl   ecx, 16
  mov   cx, bx
  mov   [eax], ecx                {Fill First 4 Bytes}
  mov   [eax+edx], ecx            {Fill Last 16 Bytes}
  mov   [eax+edx+4], ecx
  mov   [eax+edx+8], ecx
  mov   [eax+edx+12], ecx
  mov   ebx, eax                  {4-Byte Align Writes}
  and   ebx, 3
  sub   ebx, 4
  sub   eax, ebx
  add   edx, ebx
  add   eax, edx
  neg   edx
@@Loop:
  mov   [eax+edx], ecx            {Fill 16 Bytes per Loop}
  mov   [eax+edx+4], ecx
  mov   [eax+edx+8], ecx
  mov   [eax+edx+12], ecx
  add   edx, 16
  jl    @@Loop
  pop   ebx
  ret
  nop
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl       {Fill Last Byte}
  and   edx, -2               {No. of Words to Fill}
  neg   edx
  lea   edx, [@@SmallFill + 60 + edx * 2]
  jmp   edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov   [eax+28], cx
  mov   [eax+26], cx
  mov   [eax+24], cx
  mov   [eax+22], cx
  mov   [eax+20], cx
  mov   [eax+18], cx
  mov   [eax+16], cx
  mov   [eax+14], cx
  mov   [eax+12], cx
  mov   [eax+10], cx
  mov   [eax+ 8], cx
  mov   [eax+ 6], cx
  mov   [eax+ 4], cx
  mov   [eax+ 2], cx
  mov   [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_IA32_1_b(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp   edx, 32
  mov   ch, cl                    {Copy Value into both Bytes of CX}
  jl    @@Small
  push  ebx
  sub   edx, 16
  mov   bx, cx                    {Copy Value into each Byte of ECX}
  shl   ecx, 16
  mov   cx, bx
  mov   [eax], ecx                {Fill First 4 Bytes}
  mov   [eax+edx], ecx            {Fill Last 16 Bytes}
  mov   [eax+edx+4], ecx
  mov   [eax+edx+8], ecx
  mov   [eax+edx+12], ecx
  mov   ebx, eax                  {4-Byte Align Writes}
  and   ebx, 3
  sub   ebx, 4
  sub   eax, ebx
  add   edx, ebx
  add   eax, edx
  neg   edx
@@Loop:
  mov   [eax+edx], ecx            {Fill 16 Bytes per Loop}
  mov   [eax+edx+4], ecx
  mov   [eax+edx+8], ecx
  mov   [eax+edx+12], ecx
  add   edx, 16
  jl    @@Loop
  pop   ebx
  ret
  nop
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl       {Fill Last Byte}
  and   edx, -2               {No. of Words to Fill}
  neg   edx
  lea   edx, [@@SmallFill + 60 + edx * 2]
  jmp   edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov   [eax+28], cx
  mov   [eax+26], cx
  mov   [eax+24], cx
  mov   [eax+22], cx
  mov   [eax+20], cx
  mov   [eax+18], cx
  mov   [eax+16], cx
  mov   [eax+14], cx
  mov   [eax+12], cx
  mov   [eax+10], cx
  mov   [eax+ 8], cx
  mov   [eax+ 6], cx
  mov   [eax+ 4], cx
  mov   [eax+ 2], cx
  mov   [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_IA32_1_c(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp   edx, 32
  mov   ch, cl                    {Copy Value into both Bytes of CX}
  jl    @@Small
  push  ebx
  sub   edx, 16
  mov   bx, cx                    {Copy Value into each Byte of ECX}
  shl   ecx, 16
  mov   cx, bx
  mov   [eax], ecx                {Fill First 4 Bytes}
  mov   [eax+edx], ecx            {Fill Last 16 Bytes}
  mov   [eax+edx+4], ecx
  mov   [eax+edx+8], ecx
  mov   [eax+edx+12], ecx
  mov   ebx, eax                  {4-Byte Align Writes}
  and   ebx, 3
  sub   ebx, 4
  sub   eax, ebx
  add   edx, ebx
  add   eax, edx
  neg   edx
@@Loop:
  mov   [eax+edx], ecx            {Fill 16 Bytes per Loop}
  mov   [eax+edx+4], ecx
  mov   [eax+edx+8], ecx
  mov   [eax+edx+12], ecx
  add   edx, 16
  jl    @@Loop
  pop   ebx
  ret
  nop
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl       {Fill Last Byte}
  and   edx, -2               {No. of Words to Fill}
  neg   edx
  lea   edx, [@@SmallFill + 60 + edx * 2]
  jmp   edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov   [eax+28], cx
  mov   [eax+26], cx
  mov   [eax+24], cx
  mov   [eax+22], cx
  mov   [eax+20], cx
  mov   [eax+18], cx
  mov   [eax+16], cx
  mov   [eax+14], cx
  mov   [eax+12], cx
  mov   [eax+10], cx
  mov   [eax+ 8], cx
  mov   [eax+ 6], cx
  mov   [eax+ 4], cx
  mov   [eax+ 2], cx
  mov   [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_IA32_1_d(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp   edx, 32
  mov   ch, cl                    {Copy Value into both Bytes of CX}
  jl    @@Small
  push  ebx
  sub   edx, 16
  mov   bx, cx                    {Copy Value into each Byte of ECX}
  shl   ecx, 16
  mov   cx, bx
  mov   [eax], ecx                {Fill First 4 Bytes}
  mov   [eax+edx], ecx            {Fill Last 16 Bytes}
  mov   [eax+edx+4], ecx
  mov   [eax+edx+8], ecx
  mov   [eax+edx+12], ecx
  mov   ebx, eax                  {4-Byte Align Writes}
  and   ebx, 3
  sub   ebx, 4
  sub   eax, ebx
  add   edx, ebx
  add   eax, edx
  neg   edx
@@Loop:
  mov   [eax+edx], ecx            {Fill 16 Bytes per Loop}
  mov   [eax+edx+4], ecx
  mov   [eax+edx+8], ecx
  mov   [eax+edx+12], ecx
  add   edx, 16
  jl    @@Loop
  pop   ebx
  ret
  nop
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl       {Fill Last Byte}
  and   edx, -2               {No. of Words to Fill}
  neg   edx
  lea   edx, [@@SmallFill + 60 + edx * 2]
  jmp   edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov   [eax+28], cx
  mov   [eax+26], cx
  mov   [eax+24], cx
  mov   [eax+22], cx
  mov   [eax+20], cx
  mov   [eax+18], cx
  mov   [eax+16], cx
  mov   [eax+14], cx
  mov   [eax+12], cx
  mov   [eax+10], cx
  mov   [eax+ 8], cx
  mov   [eax+ 6], cx
  mov   [eax+ 4], cx
  mov   [eax+ 2], cx
  mov   [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_IA32_2_a(var Dest; count: Integer; Value: Char);
asm {Size = 153 Bytes}
  cmp   edx, 32
  mov   ch, cl                    {Copy Value into both Bytes of CX}
  jl    @@Small
  mov   [eax  ], cx               {Fill First 8 Bytes}
  mov   [eax+2], cx
  mov   [eax+4], cx
  mov   [eax+6], cx
  sub   edx, 16
  fld   qword ptr [eax]
  fst   qword ptr [eax+edx]       {Fill Last 16 Bytes}
  fst   qword ptr [eax+edx+8]
  mov   ecx, eax
  and   ecx, 7                    {8-Byte Align Writes}
  sub   ecx, 8
  sub   eax, ecx
  add   edx, ecx
  add   eax, edx
  neg   edx
@@Loop:
  fst   qword ptr [eax+edx]       {Fill 16 Bytes per Loop}
  fst   qword ptr [eax+edx+8]
  add   edx, 16
  jl    @@Loop
  ffree st(0)
  ret
  nop
  nop
  nop
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl       {Fill Last Byte}
  and   edx, -2               {No. of Words to Fill}
  neg   edx
  lea   edx, [@@SmallFill + 60 + edx * 2]
  jmp   edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov   [eax+28], cx
  mov   [eax+26], cx
  mov   [eax+24], cx
  mov   [eax+22], cx
  mov   [eax+20], cx
  mov   [eax+18], cx
  mov   [eax+16], cx
  mov   [eax+14], cx
  mov   [eax+12], cx
  mov   [eax+10], cx
  mov   [eax+ 8], cx
  mov   [eax+ 6], cx
  mov   [eax+ 4], cx
  mov   [eax+ 2], cx
  mov   [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_IA32_2_b(var Dest; count: Integer; Value: Char);
asm {Size = 153 Bytes}
  cmp   edx, 32
  mov   ch, cl                    {Copy Value into both Bytes of CX}
  jl    @@Small
  mov   [eax  ], cx               {Fill First 8 Bytes}
  mov   [eax+2], cx
  mov   [eax+4], cx
  mov   [eax+6], cx
  sub   edx, 16
  fld   qword ptr [eax]
  fst   qword ptr [eax+edx]       {Fill Last 16 Bytes}
  fst   qword ptr [eax+edx+8]
  mov   ecx, eax
  and   ecx, 7                    {8-Byte Align Writes}
  sub   ecx, 8
  sub   eax, ecx
  add   edx, ecx
  add   eax, edx
  neg   edx
@@Loop:
  fst   qword ptr [eax+edx]       {Fill 16 Bytes per Loop}
  fst   qword ptr [eax+edx+8]
  add   edx, 16
  jl    @@Loop
  ffree st(0)
  ret
  nop
  nop
  nop
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl       {Fill Last Byte}
  and   edx, -2               {No. of Words to Fill}
  neg   edx
  lea   edx, [@@SmallFill + 60 + edx * 2]
  jmp   edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov   [eax+28], cx
  mov   [eax+26], cx
  mov   [eax+24], cx
  mov   [eax+22], cx
  mov   [eax+20], cx
  mov   [eax+18], cx
  mov   [eax+16], cx
  mov   [eax+14], cx
  mov   [eax+12], cx
  mov   [eax+10], cx
  mov   [eax+ 8], cx
  mov   [eax+ 6], cx
  mov   [eax+ 4], cx
  mov   [eax+ 2], cx
  mov   [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_IA32_2_c(var Dest; count: Integer; Value: Char);
asm {Size = 153 Bytes}
  cmp   edx, 32
  mov   ch, cl                    {Copy Value into both Bytes of CX}
  jl    @@Small
  mov   [eax  ], cx               {Fill First 8 Bytes}
  mov   [eax+2], cx
  mov   [eax+4], cx
  mov   [eax+6], cx
  sub   edx, 16
  fld   qword ptr [eax]
  fst   qword ptr [eax+edx]       {Fill Last 16 Bytes}
  fst   qword ptr [eax+edx+8]
  mov   ecx, eax
  and   ecx, 7                    {8-Byte Align Writes}
  sub   ecx, 8
  sub   eax, ecx
  add   edx, ecx
  add   eax, edx
  neg   edx
@@Loop:
  fst   qword ptr [eax+edx]       {Fill 16 Bytes per Loop}
  fst   qword ptr [eax+edx+8]
  add   edx, 16
  jl    @@Loop
  ffree st(0)
  ret
  nop
  nop
  nop
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl       {Fill Last Byte}
  and   edx, -2               {No. of Words to Fill}
  neg   edx
  lea   edx, [@@SmallFill + 60 + edx * 2]
  jmp   edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov   [eax+28], cx
  mov   [eax+26], cx
  mov   [eax+24], cx
  mov   [eax+22], cx
  mov   [eax+20], cx
  mov   [eax+18], cx
  mov   [eax+16], cx
  mov   [eax+14], cx
  mov   [eax+12], cx
  mov   [eax+10], cx
  mov   [eax+ 8], cx
  mov   [eax+ 6], cx
  mov   [eax+ 4], cx
  mov   [eax+ 2], cx
  mov   [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_IA32_2_d(var Dest; count: Integer; Value: Char);
asm {Size = 153 Bytes}
  cmp   edx, 32
  mov   ch, cl                    {Copy Value into both Bytes of CX}
  jl    @@Small
  mov   [eax  ], cx               {Fill First 8 Bytes}
  mov   [eax+2], cx
  mov   [eax+4], cx
  mov   [eax+6], cx
  sub   edx, 16
  fld   qword ptr [eax]
  fst   qword ptr [eax+edx]       {Fill Last 16 Bytes}
  fst   qword ptr [eax+edx+8]
  mov   ecx, eax
  and   ecx, 7                    {8-Byte Align Writes}
  sub   ecx, 8
  sub   eax, ecx
  add   edx, ecx
  add   eax, edx
  neg   edx
@@Loop:
  fst   qword ptr [eax+edx]       {Fill 16 Bytes per Loop}
  fst   qword ptr [eax+edx+8]
  add   edx, 16
  jl    @@Loop
  ffree st(0)
  ret
  nop
  nop
  nop
@@Small:
  test  edx, edx
  jle   @@Done
  mov   [eax+edx-1], cl       {Fill Last Byte}
  and   edx, -2               {No. of Words to Fill}
  neg   edx
  lea   edx, [@@SmallFill + 60 + edx * 2]
  jmp   edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov   [eax+28], cx
  mov   [eax+26], cx
  mov   [eax+24], cx
  mov   [eax+22], cx
  mov   [eax+20], cx
  mov   [eax+18], cx
  mov   [eax+16], cx
  mov   [eax+14], cx
  mov   [eax+12], cx
  mov   [eax+10], cx
  mov   [eax+ 8], cx
  mov   [eax+ 6], cx
  mov   [eax+ 4], cx
  mov   [eax+ 2], cx
  mov   [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_MMX_1_a(var Dest; count: Integer; Value: Char);
asm {Size = 149 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  movd      mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  movq      [eax], mm0            {Fill First 8 Bytes}
  movq      [eax+edx], mm0        {Fill Last 16 Bytes}
  movq      [eax+edx+8], mm0
  mov       ecx, eax              {8-Byte Align Writes}
  and       ecx, 7
  sub       ecx, 8
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
@@Loop:
  movq      [eax+edx], mm0        {Fill 16 Bytes per Loop}
  movq      [eax+edx+8], mm0
  add       edx, 16
  jl        @@Loop
  emms
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_MMX_1_b(var Dest; count: Integer; Value: Char);
asm {Size = 149 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  movd      mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  movq      [eax], mm0            {Fill First 8 Bytes}
  movq      [eax+edx], mm0        {Fill Last 16 Bytes}
  movq      [eax+edx+8], mm0
  mov       ecx, eax              {8-Byte Align Writes}
  and       ecx, 7
  sub       ecx, 8
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
@@Loop:
  movq      [eax+edx], mm0        {Fill 16 Bytes per Loop}
  movq      [eax+edx+8], mm0
  add       edx, 16
  jl        @@Loop
  emms
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_MMX_1_c(var Dest; count: Integer; Value: Char);
asm {Size = 149 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  movd      mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  movq      [eax], mm0            {Fill First 8 Bytes}
  movq      [eax+edx], mm0        {Fill Last 16 Bytes}
  movq      [eax+edx+8], mm0
  mov       ecx, eax              {8-Byte Align Writes}
  and       ecx, 7
  sub       ecx, 8
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
@@Loop:
  movq      [eax+edx], mm0        {Fill 16 Bytes per Loop}
  movq      [eax+edx+8], mm0
  add       edx, 16
  jl        @@Loop
  emms
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_MMX_1_d(var Dest; count: Integer; Value: Char);
asm {Size = 149 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  movd      mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  movq      [eax], mm0            {Fill First 8 Bytes}
  movq      [eax+edx], mm0        {Fill Last 16 Bytes}
  movq      [eax+edx+8], mm0
  mov       ecx, eax              {8-Byte Align Writes}
  and       ecx, 7
  sub       ecx, 8
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
@@Loop:
  movq      [eax+edx], mm0        {Fill 16 Bytes per Loop}
  movq      [eax+edx+8], mm0
  add       edx, 16
  jl        @@Loop
  emms
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_SSE_1_a(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  mov       [eax], cx             {Fill First 4 Bytes}
  mov       [eax+2], cx
  movss     xmm0, [eax]           {Set each byte of XMM0 to Value}
  shufps    xmm0, xmm0, 0
  movups    [eax], xmm0           {Fill First 16 Bytes}
  movups    [eax+edx], xmm0       {Fill Last 16 Bytes}
  mov       ecx, eax              {16-Byte Align Writes}
  and       ecx, 15
  sub       ecx, 16
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
  cmp       edx, -512*1024
  jb        @@Large
@@Loop:
  movaps    [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Loop
  ret
@@Large:
  movntps   [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Large
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_SSE_1_b(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  mov       [eax], cx             {Fill First 4 Bytes}
  mov       [eax+2], cx
  movss     xmm0, [eax]           {Set each byte of XMM0 to Value}
  shufps    xmm0, xmm0, 0
  movups    [eax], xmm0           {Fill First 16 Bytes}
  movups    [eax+edx], xmm0       {Fill Last 16 Bytes}
  mov       ecx, eax              {16-Byte Align Writes}
  and       ecx, 15
  sub       ecx, 16
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
  cmp       edx, -512*1024
  jb        @@Large
@@Loop:
  movaps    [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Loop
  ret
@@Large:
  movntps   [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Large
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_SSE_1_c(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  mov       [eax], cx             {Fill First 4 Bytes}
  mov       [eax+2], cx
  movss     xmm0, [eax]           {Set each byte of XMM0 to Value}
  shufps    xmm0, xmm0, 0
  movups    [eax], xmm0           {Fill First 16 Bytes}
  movups    [eax+edx], xmm0       {Fill Last 16 Bytes}
  mov       ecx, eax              {16-Byte Align Writes}
  and       ecx, 15
  sub       ecx, 16
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
  cmp       edx, -512*1024
  jb        @@Large
@@Loop:
  movaps    [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Loop
  ret
@@Large:
  movntps   [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Large
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_SSE_1_d(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  mov       [eax], cx             {Fill First 4 Bytes}
  mov       [eax+2], cx
  movss     xmm0, [eax]           {Set each byte of XMM0 to Value}
  shufps    xmm0, xmm0, 0
  movups    [eax], xmm0           {Fill First 16 Bytes}
  movups    [eax+edx], xmm0       {Fill Last 16 Bytes}
  mov       ecx, eax              {16-Byte Align Writes}
  and       ecx, 15
  sub       ecx, 16
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
  cmp       edx, -512*1024
  jb        @@Large
@@Loop:
  movaps    [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Loop
  ret
@@Large:
  movntps   [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Large
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_SSE2_1_a(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  movd      xmm0, ecx
  pshuflw   xmm0, xmm0, 0
  pshufd    xmm0, xmm0, 0
  movups    [eax], xmm0           {Fill First 16 Bytes}
  movups    [eax+edx], xmm0       {Fill Last 16 Bytes}
  mov       ecx, eax              {16-Byte Align Writes}
  and       ecx, 15
  sub       ecx, 16
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
  cmp       edx, -512*1024
  jb        @@Large
@@Loop:
  movaps    [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Loop
  ret
@@Large:
  movntdq    [eax+edx], xmm0      {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Large
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_SSE2_1_b(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  movd      xmm0, ecx
  pshuflw   xmm0, xmm0, 0
  pshufd    xmm0, xmm0, 0
  movups    [eax], xmm0           {Fill First 16 Bytes}
  movups    [eax+edx], xmm0       {Fill Last 16 Bytes}
  mov       ecx, eax              {16-Byte Align Writes}
  and       ecx, 15
  sub       ecx, 16
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
  cmp       edx, -512*1024
  jb        @@Large
@@Loop:
  movaps    [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Loop
  ret
@@Large:
  movntdq    [eax+edx], xmm0      {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Large
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_SSE2_1_c(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  movd      xmm0, ecx
  pshuflw   xmm0, xmm0, 0
  pshufd    xmm0, xmm0, 0
  movups    [eax], xmm0           {Fill First 16 Bytes}
  movups    [eax+edx], xmm0       {Fill Last 16 Bytes}
  mov       ecx, eax              {16-Byte Align Writes}
  and       ecx, 15
  sub       ecx, 16
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
  cmp       edx, -512*1024
  jb        @@Large
@@Loop:
  movaps    [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Loop
  ret
@@Large:
  movntdq    [eax+edx], xmm0      {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Large
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_SSE2_1_d(var Dest; count: Integer; Value: Char);
asm {Size = 161 Bytes}
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  sub       edx, 16
  movd      xmm0, ecx
  pshuflw   xmm0, xmm0, 0
  pshufd    xmm0, xmm0, 0
  movups    [eax], xmm0           {Fill First 16 Bytes}
  movups    [eax+edx], xmm0       {Fill Last 16 Bytes}
  mov       ecx, eax              {16-Byte Align Writes}
  and       ecx, 15
  sub       ecx, 16
  sub       eax, ecx
  add       edx, ecx
  add       eax, edx
  neg       edx
  cmp       edx, -512*1024
  jb        @@Large
@@Loop:
  movaps    [eax+edx], xmm0       {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Loop
  ret
@@Large:
  movntdq    [eax+edx], xmm0      {Fill 16 Bytes per Loop}
  add       edx, 16
  jl        @@Large
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {No. of Words to Fill}
  neg       edx
  lea       edx, [@@SmallFill + 60 + edx * 2]
  jmp       edx
  nop                             {Align Jump Destinations}
  nop
@@SmallFill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_MMX_4_b(var Dest; count: Integer; Value: Char);
asm
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  movd      mm0, ecx
  mov       ecx, eax
  sub       edx, 16
  punpcklwd mm0, mm0
  punpckldq mm0, mm0              {Copy Value into all 8 Bytes of MM0}
  movq      [eax], mm0            {Fill First 8 Bytes}
  movq      [eax+edx], mm0        {Fill Last 16 Bytes}
  movq      [eax+edx+8], mm0
  add       eax, edx              {Qword align writes}
  and       ecx, 7
  sub       ecx, 8
  add       edx, ecx
  neg       edx
@@Loop:
  movq      [eax+edx], mm0        {Fill 16 Bytes per Loop}
  movq      [eax+edx+8], mm0
  add       edx, 16
  jl        @@Loop
  emms
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {Byte Pairs to Fill}
  neg       edx
  lea       edx, [@@Fill + 60 + edx * 2]
  jmp       edx
@@Fill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end; 

procedure FillChar_JOH_MMX_4_a(var Dest; count: Integer; Value: Char);
asm
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  movd      mm0, ecx
  mov       ecx, eax
  sub       edx, 16
  punpcklwd mm0, mm0
  punpckldq mm0, mm0              {Copy Value into all 8 Bytes of MM0}
  movq      [eax], mm0            {Fill First 8 Bytes}
  movq      [eax+edx], mm0        {Fill Last 16 Bytes}
  movq      [eax+edx+8], mm0
  add       eax, edx              {Qword align writes}
  and       ecx, 7
  sub       ecx, 8
  add       edx, ecx
  neg       edx
@@Loop:
  movq      [eax+edx], mm0        {Fill 16 Bytes per Loop}
  movq      [eax+edx+8], mm0
  add       edx, 16
  jl        @@Loop
  emms
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {Byte Pairs to Fill}
  neg       edx
  lea       edx, [@@Fill + 60 + edx * 2]
  jmp       edx
@@Fill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_MMX_4_c(var Dest; count: Integer; Value: Char);
asm
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  movd      mm0, ecx
  mov       ecx, eax
  sub       edx, 16
  punpcklwd mm0, mm0
  punpckldq mm0, mm0              {Copy Value into all 8 Bytes of MM0}
  movq      [eax], mm0            {Fill First 8 Bytes}
  movq      [eax+edx], mm0        {Fill Last 16 Bytes}
  movq      [eax+edx+8], mm0
  add       eax, edx              {Qword align writes}
  and       ecx, 7
  sub       ecx, 8
  add       edx, ecx
  neg       edx
@@Loop:
  movq      [eax+edx], mm0        {Fill 16 Bytes per Loop}
  movq      [eax+edx+8], mm0
  add       edx, 16
  jl        @@Loop
  emms
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {Byte Pairs to Fill}
  neg       edx
  lea       edx, [@@Fill + 60 + edx * 2]
  jmp       edx
@@Fill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end;

procedure FillChar_JOH_MMX_4_d(var Dest; count: Integer; Value: Char);
asm
  cmp       edx, 32
  mov       ch, cl                {Copy Value into both Bytes of CX}
  jl        @@Small
  movd      mm0, ecx
  mov       ecx, eax
  sub       edx, 16
  punpcklwd mm0, mm0
  punpckldq mm0, mm0              {Copy Value into all 8 Bytes of MM0}
  movq      [eax], mm0            {Fill First 8 Bytes}
  movq      [eax+edx], mm0        {Fill Last 16 Bytes}
  movq      [eax+edx+8], mm0
  add       eax, edx              {Qword align writes}
  and       ecx, 7
  sub       ecx, 8
  add       edx, ecx
  neg       edx
@@Loop:
  movq      [eax+edx], mm0        {Fill 16 Bytes per Loop}
  movq      [eax+edx+8], mm0
  add       edx, 16
  jl        @@Loop
  emms
  ret
@@Small:
  test      edx, edx
  jle       @@Done
  mov       [eax+edx-1], cl       {Fill Last Byte}
  and       edx, -2               {Byte Pairs to Fill}
  neg       edx
  lea       edx, [@@Fill + 60 + edx * 2]
  jmp       edx
@@Fill:
  mov       [eax+28], cx
  mov       [eax+26], cx
  mov       [eax+24], cx
  mov       [eax+22], cx
  mov       [eax+20], cx
  mov       [eax+18], cx
  mov       [eax+16], cx
  mov       [eax+14], cx
  mov       [eax+12], cx
  mov       [eax+10], cx
  mov       [eax+ 8], cx
  mov       [eax+ 6], cx
  mov       [eax+ 4], cx
  mov       [eax+ 2], cx
  mov       [eax   ], cx
  ret {DO NOT REMOVE - This is for Alignment}
@@Done:
end; 


end.

