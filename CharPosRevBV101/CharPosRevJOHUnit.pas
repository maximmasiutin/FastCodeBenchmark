unit CharPosRevJOHUnit;

interface

{$R-,Q-}

implementation

uses
 MainUnit;

function CharPosRev_JOH_PAS_1_a(SearchChar : Char; const S: string) : Integer;
begin {32 Bytes}
  for Result := Length(S) downto 1 do
    if S[Result] = SearchChar then
      Exit;
  Result := 0;
end;

procedure Filler1;
asm
 nop
end;

function CharPosRev_JOH_PAS_1_b(SearchChar : Char; const S: string) : Integer;
begin {32 Bytes}
  for Result := Length(S) downto 1 do
    if S[Result] = SearchChar then
      Exit;
  Result := 0;
end;

procedure Filler2;
asm
 nop
end;

function CharPosRev_JOH_PAS_1_c(SearchChar : Char; const S: string) : Integer;
begin {32 Bytes}
  for Result := Length(S) downto 1 do
    if S[Result] = SearchChar then
      Exit;
  Result := 0;
end;

procedure Filler3;
asm
 nop
end;

function CharPosRev_JOH_PAS_1_d(SearchChar : Char; const S: string) : Integer;
begin {32 Bytes}
  for Result := Length(S) downto 1 do
    if S[Result] = SearchChar then
      Exit;
  Result := 0;
end;

function CharPosRev_JOH_PAS_2_a(SearchChar : Char; const S: string) : Integer;
begin {68 Bytes}
  Result := Length(S);
  while Result > 0 do
    begin
      if S[Result] = SearchChar then
        Exit;
      if S[Result-1] = SearchChar then
        begin
          Dec(Result);
          Break;
        end;
      if S[Result-2] = SearchChar then
        begin
          Dec(Result, 2);
          Break;
        end;
      if S[Result-3] = SearchChar then
        begin
          Dec(Result, 3);
          Break;
        end;
      Dec(Result, 4);
   end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_JOH_PAS_2_b(SearchChar : Char; const S: string) : Integer;
begin {68 Bytes}
  Result := Length(S);
  while Result > 0 do
    begin
      if S[Result] = SearchChar then
        Exit;
      if S[Result-1] = SearchChar then
        begin
          Dec(Result);
          Break;
        end;
      if S[Result-2] = SearchChar then
        begin
          Dec(Result, 2);
          Break;
        end;
      if S[Result-3] = SearchChar then
        begin
          Dec(Result, 3);
          Break;
        end;
      Dec(Result, 4);
   end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_JOH_PAS_2_c(SearchChar : Char; const S: string) : Integer;
begin {68 Bytes}
  Result := Length(S);
  while Result > 0 do
    begin
      if S[Result] = SearchChar then
        Exit;
      if S[Result-1] = SearchChar then
        begin
          Dec(Result);
          Break;
        end;
      if S[Result-2] = SearchChar then
        begin
          Dec(Result, 2);
          Break;
        end;
      if S[Result-3] = SearchChar then
        begin
          Dec(Result, 3);
          Break;
        end;
      Dec(Result, 4);
   end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_JOH_PAS_2_d(SearchChar : Char; const S: string) : Integer;
begin {68 Bytes}
  Result := Length(S);
  while Result > 0 do
    begin
      if S[Result] = SearchChar then
        Exit;
      if S[Result-1] = SearchChar then
        begin
          Dec(Result);
          Break;
        end;
      if S[Result-2] = SearchChar then
        begin
          Dec(Result, 2);
          Break;
        end;
      if S[Result-3] = SearchChar then
        begin
          Dec(Result, 3);
          Break;
        end;
      Dec(Result, 4);
   end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_JOH_PAS_3_a(SearchChar : Char; const S: string) : Integer;
var
  P: PChar;
begin {156 Bytes}
  Result := Length(S);
  if Result > 0 then
    begin
      P := @S[Result-11];
      repeat

        if P[11] = SearchChar then
          Exit;
        if P[10] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[9] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[8] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        if P[7] = SearchChar then
          Exit;
        if P[6] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[5] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[4] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        if P[3] = SearchChar then
          Exit;
        if P[2] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[1] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[0] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        Dec(P, 12);
      until False;
      if Result < 0 then {Match Found before First Char}
        Result := 0;
    end;
end;

function CharPosRev_JOH_PAS_3_b(SearchChar : Char; const S: string) : Integer;
var
  P: PChar;
begin {156 Bytes}
  Result := Length(S);
  if Result > 0 then
    begin
      P := @S[Result-11];
      repeat

        if P[11] = SearchChar then
          Exit;
        if P[10] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[9] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[8] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        if P[7] = SearchChar then
          Exit;
        if P[6] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[5] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[4] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        if P[3] = SearchChar then
          Exit;
        if P[2] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[1] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[0] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        Dec(P, 12);
      until False;
      if Result < 0 then {Match Found before First Char}
        Result := 0;
    end;
end;

function CharPosRev_JOH_PAS_3_c(SearchChar : Char; const S: string) : Integer;
var
  P: PChar;
begin {156 Bytes}
  Result := Length(S);
  if Result > 0 then
    begin
      P := @S[Result-11];
      repeat

        if P[11] = SearchChar then
          Exit;
        if P[10] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[9] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[8] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        if P[7] = SearchChar then
          Exit;
        if P[6] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[5] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[4] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        if P[3] = SearchChar then
          Exit;
        if P[2] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[1] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[0] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        Dec(P, 12);
      until False;
      if Result < 0 then {Match Found before First Char}
        Result := 0;
    end;
end;

function CharPosRev_JOH_PAS_3_d(SearchChar : Char; const S: string) : Integer;
var
  P: PChar;
begin {156 Bytes}
  Result := Length(S);
  if Result > 0 then
    begin
      P := @S[Result-11];
      repeat

        if P[11] = SearchChar then
          Exit;
        if P[10] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[9] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[8] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        if P[7] = SearchChar then
          Exit;
        if P[6] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[5] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[4] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        if P[3] = SearchChar then
          Exit;
        if P[2] = SearchChar then
          begin
            Dec(Result);
            Break;
          end;
        if P[1] = SearchChar then
          begin
            Dec(Result, 2);
            Break;
          end;
        if P[0] = SearchChar then
          begin
            Dec(Result, 3);
            Break;
          end;
        Dec(Result, 4);
        if Result <= 0 then
          Break;

        Dec(P, 12);
      until False;
      if Result < 0 then {Match Found before First Char}
        Result := 0;
    end;
end;

function CharPosRev_JOH_IA32_1_a(SearchChar : Char; const S: string) : Integer;
asm {24 Bytes}
  test  edx, edx      {S = nil?}
  jz    @@Zero        {Yes, Exit with Result = 0}
  mov   ecx, [edx-4]  {No, Get Length(S)}
@@Loop:               {Loop until Match Found or All Characters Checked}
  sub   ecx, 1        {Any Characters Left?}
  jc    @@Zero        {No,  Exit with Result = 0}
  cmp   al, [edx+ecx] {Compare Next Character}
  jne   @@Loop        {Loop until Match or No Characters Left}
  lea   eax, [ecx+1]  {Result := Match Position}
  ret                 {Finished}
@@Zero:               {No Match Found}
  xor   eax, eax      {Result := 0}
end;

function CharPosRev_JOH_IA32_1_b(SearchChar : Char; const S: string) : Integer;
asm {24 Bytes}
  test  edx, edx      {S = nil?}
  jz    @@Zero        {Yes, Exit with Result = 0}
  mov   ecx, [edx-4]  {No, Get Length(S)}
@@Loop:               {Loop until Match Found or All Characters Checked}
  sub   ecx, 1        {Any Characters Left?}
  jc    @@Zero        {No,  Exit with Result = 0}
  cmp   al, [edx+ecx] {Compare Next Character}
  jne   @@Loop        {Loop until Match or No Characters Left}
  lea   eax, [ecx+1]  {Result := Match Position}
  ret                 {Finished}
@@Zero:               {No Match Found}
  xor   eax, eax      {Result := 0}
end;

procedure Filler4;
asm
 nop
end;

function CharPosRev_JOH_IA32_1_c(SearchChar : Char; const S: string) : Integer;
asm {24 Bytes}
  test  edx, edx      {S = nil?}
  jz    @@Zero        {Yes, Exit with Result = 0}
  mov   ecx, [edx-4]  {No, Get Length(S)}
@@Loop:               {Loop until Match Found or All Characters Checked}
  sub   ecx, 1        {Any Characters Left?}
  jc    @@Zero        {No,  Exit with Result = 0}
  cmp   al, [edx+ecx] {Compare Next Character}
  jne   @@Loop        {Loop until Match or No Characters Left}
  lea   eax, [ecx+1]  {Result := Match Position}
  ret                 {Finished}
@@Zero:               {No Match Found}
  xor   eax, eax      {Result := 0}
end;

function CharPosRev_JOH_IA32_1_d(SearchChar : Char; const S: string) : Integer;
asm {24 Bytes}
  test  edx, edx      {S = nil?}
  jz    @@Zero        {Yes, Exit with Result = 0}
  mov   ecx, [edx-4]  {No, Get Length(S)}
@@Loop:               {Loop until Match Found or All Characters Checked}
  sub   ecx, 1        {Any Characters Left?}
  jc    @@Zero        {No,  Exit with Result = 0}
  cmp   al, [edx+ecx] {Compare Next Character}
  jne   @@Loop        {Loop until Match or No Characters Left}
  lea   eax, [ecx+1]  {Result := Match Position}
  ret                 {Finished}
@@Zero:               {No Match Found}
  xor   eax, eax      {Result := 0}
end;

function CharPosRev_JOH_IA32_2_a(SearchChar : Char; const S: string) : Integer;
asm {48 Bytes}
  test  edx, edx        {S = nil?}
  jz    @@NotFound      {Yes, Exit with Result = 0}
  mov   ecx, eax        {SearchChar}
  mov   eax, [edx-4]    {Length(S)}
@@Loop:
  cmp   cl, [eax+edx-1] {Check Next Character from End}
  je    @@1             {Exit on Match}
  cmp   cl, [eax+edx-2] {Check Character Before}
  je    @@2             {Exit on Match}
  cmp   cl, [eax+edx-3] {Check Character Before}
  je    @@3             {Exit on Match}
  cmp   cl, [eax+edx-4] {Check Character Before}
  je    @@4             {Exit on Match}
  sub   eax, 4          {All Characters Checked?}
  jg    @@Loop          {No, Loop}
@@NotFound:
  xor   eax, eax        {Result := 0}
  ret
@@4:
  dec   eax
@@3:
  dec   eax
@@2:
  dec   eax
  js    @@NotFound      {Match Found before First Char}
@@1:
end;

procedure Filler5;
asm
 nop
end;

function CharPosRev_JOH_IA32_2_b(SearchChar : Char; const S: string) : Integer;
asm {48 Bytes}
  test  edx, edx        {S = nil?}
  jz    @@NotFound      {Yes, Exit with Result = 0}
  mov   ecx, eax        {SearchChar}
  mov   eax, [edx-4]    {Length(S)}
@@Loop:
  cmp   cl, [eax+edx-1] {Check Next Character from End}
  je    @@1             {Exit on Match}
  cmp   cl, [eax+edx-2] {Check Character Before}
  je    @@2             {Exit on Match}
  cmp   cl, [eax+edx-3] {Check Character Before}
  je    @@3             {Exit on Match}
  cmp   cl, [eax+edx-4] {Check Character Before}
  je    @@4             {Exit on Match}
  sub   eax, 4          {All Characters Checked?}
  jg    @@Loop          {No, Loop}
@@NotFound:
  xor   eax, eax        {Result := 0}
  ret
@@4:
  dec   eax
@@3:
  dec   eax
@@2:
  dec   eax
  js    @@NotFound      {Match Found before First Char}
@@1:
end;

procedure Filler6;
asm
 nop
end;

function CharPosRev_JOH_IA32_2_c(SearchChar : Char; const S: string) : Integer;
asm {48 Bytes}
  test  edx, edx        {S = nil?}
  jz    @@NotFound      {Yes, Exit with Result = 0}
  mov   ecx, eax        {SearchChar}
  mov   eax, [edx-4]    {Length(S)}
@@Loop:
  cmp   cl, [eax+edx-1] {Check Next Character from End}
  je    @@1             {Exit on Match}
  cmp   cl, [eax+edx-2] {Check Character Before}
  je    @@2             {Exit on Match}
  cmp   cl, [eax+edx-3] {Check Character Before}
  je    @@3             {Exit on Match}
  cmp   cl, [eax+edx-4] {Check Character Before}
  je    @@4             {Exit on Match}
  sub   eax, 4          {All Characters Checked?}
  jg    @@Loop          {No, Loop}
@@NotFound:
  xor   eax, eax        {Result := 0}
  ret
@@4:
  dec   eax
@@3:
  dec   eax
@@2:
  dec   eax
  js    @@NotFound      {Match Found before First Char}
@@1:
end;

procedure Filler7;
asm
 nop
end;

function CharPosRev_JOH_IA32_2_d(SearchChar : Char; const S: string) : Integer;
asm {48 Bytes}
  test  edx, edx        {S = nil?}
  jz    @@NotFound      {Yes, Exit with Result = 0}
  mov   ecx, eax        {SearchChar}
  mov   eax, [edx-4]    {Length(S)}
@@Loop:
  cmp   cl, [eax+edx-1] {Check Next Character from End}
  je    @@1             {Exit on Match}
  cmp   cl, [eax+edx-2] {Check Character Before}
  je    @@2             {Exit on Match}
  cmp   cl, [eax+edx-3] {Check Character Before}
  je    @@3             {Exit on Match}
  cmp   cl, [eax+edx-4] {Check Character Before}
  je    @@4             {Exit on Match}
  sub   eax, 4          {All Characters Checked?}
  jg    @@Loop          {No, Loop}
@@NotFound:
  xor   eax, eax        {Result := 0}
  ret
@@4:
  dec   eax
@@3:
  dec   eax
@@2:
  dec   eax
  js    @@NotFound      {Match Found before First Char}
@@1:
end;

function CharPosRev_JOH_IA32_3_a(SearchChar : Char; const S: string) : Integer;
asm {124 Bytes}
  test  edx, edx        {S = nil?}
  mov   ecx, eax        {SearchChar}
  jz    @@NotFound      {Yes, Exit with Result = 0}
  mov   eax, [edx-4]    {Length(S)}
  add   edx, eax        {End of String}
@@Loop:
  cmp   cl, [edx-1]
  je    @@1
  cmp   cl, [edx-2]
  je    @@2
  cmp   cl, [edx-3]
  je    @@3
  cmp   cl, [edx-4]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-5]
  je    @@1
  cmp   cl, [edx-6]
  je    @@2
  cmp   cl, [edx-7]
  je    @@3
  cmp   cl, [edx-8]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-9]
  je    @@1
  cmp   cl, [edx-10]
  je    @@2
  cmp   cl, [edx-11]
  je    @@3
  cmp   cl, [edx-12]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-13]
  je    @@1
  cmp   cl, [edx-14]
  je    @@2
  cmp   cl, [edx-15]
  je    @@3
  cmp   cl, [edx-16]
  je    @@4
  sub   edx, 16         {Prepare for Next Loop}
  sub   eax, 4          {All Characters Checked?}
  jg    @@Loop          {No, Loop}
@@NotFound:
  xor   eax, eax        {Result := 0}
@@1:
  ret
@@4:
  dec   eax
@@3:
  dec   eax
@@2:
  dec   eax
  js    @@NotFound      {Match Found before First Char}
end;

function CharPosRev_JOH_IA32_3_b(SearchChar : Char; const S: string) : Integer;
asm {124 Bytes}
  test  edx, edx        {S = nil?}
  mov   ecx, eax        {SearchChar}
  jz    @@NotFound      {Yes, Exit with Result = 0}
  mov   eax, [edx-4]    {Length(S)}
  add   edx, eax        {End of String}
@@Loop:
  cmp   cl, [edx-1]
  je    @@1
  cmp   cl, [edx-2]
  je    @@2
  cmp   cl, [edx-3]
  je    @@3
  cmp   cl, [edx-4]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-5]
  je    @@1
  cmp   cl, [edx-6]
  je    @@2
  cmp   cl, [edx-7]
  je    @@3
  cmp   cl, [edx-8]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-9]
  je    @@1
  cmp   cl, [edx-10]
  je    @@2
  cmp   cl, [edx-11]
  je    @@3
  cmp   cl, [edx-12]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-13]
  je    @@1
  cmp   cl, [edx-14]
  je    @@2
  cmp   cl, [edx-15]
  je    @@3
  cmp   cl, [edx-16]
  je    @@4
  sub   edx, 16         {Prepare for Next Loop}
  sub   eax, 4          {All Characters Checked?}
  jg    @@Loop          {No, Loop}
@@NotFound:
  xor   eax, eax        {Result := 0}
@@1:
  ret
@@4:
  dec   eax
@@3:
  dec   eax
@@2:
  dec   eax
  js    @@NotFound      {Match Found before First Char}
end;

function CharPosRev_JOH_IA32_3_c(SearchChar : Char; const S: string) : Integer;
asm {124 Bytes}
  test  edx, edx        {S = nil?}
  mov   ecx, eax        {SearchChar}
  jz    @@NotFound      {Yes, Exit with Result = 0}
  mov   eax, [edx-4]    {Length(S)}
  add   edx, eax        {End of String}
@@Loop:
  cmp   cl, [edx-1]
  je    @@1
  cmp   cl, [edx-2]
  je    @@2
  cmp   cl, [edx-3]
  je    @@3
  cmp   cl, [edx-4]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-5]
  je    @@1
  cmp   cl, [edx-6]
  je    @@2
  cmp   cl, [edx-7]
  je    @@3
  cmp   cl, [edx-8]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-9]
  je    @@1
  cmp   cl, [edx-10]
  je    @@2
  cmp   cl, [edx-11]
  je    @@3
  cmp   cl, [edx-12]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-13]
  je    @@1
  cmp   cl, [edx-14]
  je    @@2
  cmp   cl, [edx-15]
  je    @@3
  cmp   cl, [edx-16]
  je    @@4
  sub   edx, 16         {Prepare for Next Loop}
  sub   eax, 4          {All Characters Checked?}
  jg    @@Loop          {No, Loop}
@@NotFound:
  xor   eax, eax        {Result := 0}
@@1:
  ret
@@4:
  dec   eax
@@3:
  dec   eax
@@2:
  dec   eax
  js    @@NotFound      {Match Found before First Char}
end;

function CharPosRev_JOH_IA32_3_d(SearchChar : Char; const S: string) : Integer;
asm {124 Bytes}
  test  edx, edx        {S = nil?}
  mov   ecx, eax        {SearchChar}
  jz    @@NotFound      {Yes, Exit with Result = 0}
  mov   eax, [edx-4]    {Length(S)}
  add   edx, eax        {End of String}
@@Loop:
  cmp   cl, [edx-1]
  je    @@1
  cmp   cl, [edx-2]
  je    @@2
  cmp   cl, [edx-3]
  je    @@3
  cmp   cl, [edx-4]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-5]
  je    @@1
  cmp   cl, [edx-6]
  je    @@2
  cmp   cl, [edx-7]
  je    @@3
  cmp   cl, [edx-8]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-9]
  je    @@1
  cmp   cl, [edx-10]
  je    @@2
  cmp   cl, [edx-11]
  je    @@3
  cmp   cl, [edx-12]
  je    @@4
  sub   eax, 4          {All Characters Checked?}
  jle   @@NotFound      {Yes, Not Found}
  cmp   cl, [edx-13]
  je    @@1
  cmp   cl, [edx-14]
  je    @@2
  cmp   cl, [edx-15]
  je    @@3
  cmp   cl, [edx-16]
  je    @@4
  sub   edx, 16         {Prepare for Next Loop}
  sub   eax, 4          {All Characters Checked?}
  jg    @@Loop          {No, Loop}
@@NotFound:
  xor   eax, eax        {Result := 0}
@@1:
  ret
@@4:
  dec   eax
@@3:
  dec   eax
@@2:
  dec   eax
  js    @@NotFound      {Match Found before First Char}
end;

function CharPosRev_JOH_MMX_3_a(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test      edx, edx        {S = nil?}
  jz        @@NotFound      {Yes, Exit with Result = 0}
  mov       ecx, eax        {SearchChar}
  mov       eax, [edx-4]    {Length(S)}
  cmp       eax, 16
  jg        @@Large         {Length(S)>32}
@@Loop:
  cmp       cl, [eax+edx-1] {Check Next Character from End}
  je        @@1             {Exit on Match}
  cmp       cl, [eax+edx-2] {Check Character Before}
  je        @@2             {Exit on Match}
  cmp       cl, [eax+edx-3] {Check Character Before}
  je        @@3             {Exit on Match}
  cmp       cl, [eax+edx-4] {Check Character Before}
  je        @@4             {Exit on Match}
  sub       eax, 4          {All Characters Checked?}
  jg        @@Loop          {No, Loop}
@@NotFound:
  xor       eax, eax        {Result := 0}
  ret
@@4:
  dec       eax
@@3:
  dec       eax
@@2:
  dec       eax
  js        @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov       ch, cl
  movd      mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  movq      mm1, [eax+edx-8]{Check Last 8 Characters}
  pcmpeqb   mm1, mm0
  packsswb  mm1, mm1
  movd      ecx, mm1
  test      ecx, ecx        {Match Found?}
  jnz       @@Match         {Yes, Calc Result}
  add       eax, edx        {QWORD Align [eax+edx]}
  and       eax, -8
  sub       eax, edx
@@LargeLoop:
  movq      mm1, [eax+edx-8]{Check 8 Chars per Loop}
  pcmpeqb   mm1, mm0
  packsswb  mm1, mm1
  movd      ecx, mm1
  test      ecx, ecx        {Match Found?}
  jnz       @@Match         {Yes, Calc Result}
  sub       eax, 8
  jg        @@LargeLoop
  xor       eax, eax
  emms
  ret                      {Return 0}
@@Match:
  emms
  bsr       ecx, ecx        {Set Match Offset}
  shr       ecx, 1          {Calculate Result}
  adc       eax, -7
  shr       ecx, 2
  add       ecx, ecx
  add       eax, ecx
  jl        @@NotFound
end;

function CharPosRev_JOH_MMX_3_b(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test      edx, edx        {S = nil?}
  jz        @@NotFound      {Yes, Exit with Result = 0}
  mov       ecx, eax        {SearchChar}
  mov       eax, [edx-4]    {Length(S)}
  cmp       eax, 16
  jg        @@Large         {Length(S)>32}
@@Loop:
  cmp       cl, [eax+edx-1] {Check Next Character from End}
  je        @@1             {Exit on Match}
  cmp       cl, [eax+edx-2] {Check Character Before}
  je        @@2             {Exit on Match}
  cmp       cl, [eax+edx-3] {Check Character Before}
  je        @@3             {Exit on Match}
  cmp       cl, [eax+edx-4] {Check Character Before}
  je        @@4             {Exit on Match}
  sub       eax, 4          {All Characters Checked?}
  jg        @@Loop          {No, Loop}
@@NotFound:
  xor       eax, eax        {Result := 0}
  ret
@@4:
  dec       eax
@@3:
  dec       eax
@@2:
  dec       eax
  js        @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov       ch, cl
  movd      mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  movq      mm1, [eax+edx-8]{Check Last 8 Characters}
  pcmpeqb   mm1, mm0
  packsswb  mm1, mm1
  movd      ecx, mm1
  test      ecx, ecx        {Match Found?}
  jnz       @@Match         {Yes, Calc Result}
  add       eax, edx        {QWORD Align [eax+edx]}
  and       eax, -8
  sub       eax, edx
@@LargeLoop:
  movq      mm1, [eax+edx-8]{Check 8 Chars per Loop}
  pcmpeqb   mm1, mm0
  packsswb  mm1, mm1
  movd      ecx, mm1
  test      ecx, ecx        {Match Found?}
  jnz       @@Match         {Yes, Calc Result}
  sub       eax, 8
  jg        @@LargeLoop
  xor       eax, eax
  emms
  ret                      {Return 0}
@@Match:
  emms
  bsr       ecx, ecx        {Set Match Offset}
  shr       ecx, 1          {Calculate Result}
  adc       eax, -7
  shr       ecx, 2
  add       ecx, ecx
  add       eax, ecx
  jl        @@NotFound
end;

procedure Filler8;
asm
 nop
end;

function CharPosRev_JOH_MMX_3_c(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test      edx, edx        {S = nil?}
  jz        @@NotFound      {Yes, Exit with Result = 0}
  mov       ecx, eax        {SearchChar}
  mov       eax, [edx-4]    {Length(S)}
  cmp       eax, 16
  jg        @@Large         {Length(S)>32}
@@Loop:
  cmp       cl, [eax+edx-1] {Check Next Character from End}
  je        @@1             {Exit on Match}
  cmp       cl, [eax+edx-2] {Check Character Before}
  je        @@2             {Exit on Match}
  cmp       cl, [eax+edx-3] {Check Character Before}
  je        @@3             {Exit on Match}
  cmp       cl, [eax+edx-4] {Check Character Before}
  je        @@4             {Exit on Match}
  sub       eax, 4          {All Characters Checked?}
  jg        @@Loop          {No, Loop}
@@NotFound:
  xor       eax, eax        {Result := 0}
  ret
@@4:
  dec       eax
@@3:
  dec       eax
@@2:
  dec       eax
  js        @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov       ch, cl
  movd      mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  movq      mm1, [eax+edx-8]{Check Last 8 Characters}
  pcmpeqb   mm1, mm0
  packsswb  mm1, mm1
  movd      ecx, mm1
  test      ecx, ecx        {Match Found?}
  jnz       @@Match         {Yes, Calc Result}
  add       eax, edx        {QWORD Align [eax+edx]}
  and       eax, -8
  sub       eax, edx
@@LargeLoop:
  movq      mm1, [eax+edx-8]{Check 8 Chars per Loop}
  pcmpeqb   mm1, mm0
  packsswb  mm1, mm1
  movd      ecx, mm1
  test      ecx, ecx        {Match Found?}
  jnz       @@Match         {Yes, Calc Result}
  sub       eax, 8
  jg        @@LargeLoop
  xor       eax, eax
  emms
  ret                      {Return 0}
@@Match:
  emms
  bsr       ecx, ecx        {Set Match Offset}
  shr       ecx, 1          {Calculate Result}
  adc       eax, -7
  shr       ecx, 2
  add       ecx, ecx
  add       eax, ecx
  jl        @@NotFound
end;

function CharPosRev_JOH_MMX_3_d(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test      edx, edx        {S = nil?}
  jz        @@NotFound      {Yes, Exit with Result = 0}
  mov       ecx, eax        {SearchChar}
  mov       eax, [edx-4]    {Length(S)}
  cmp       eax, 16
  jg        @@Large         {Length(S)>32}
@@Loop:
  cmp       cl, [eax+edx-1] {Check Next Character from End}
  je        @@1             {Exit on Match}
  cmp       cl, [eax+edx-2] {Check Character Before}
  je        @@2             {Exit on Match}
  cmp       cl, [eax+edx-3] {Check Character Before}
  je        @@3             {Exit on Match}
  cmp       cl, [eax+edx-4] {Check Character Before}
  je        @@4             {Exit on Match}
  sub       eax, 4          {All Characters Checked?}
  jg        @@Loop          {No, Loop}
@@NotFound:
  xor       eax, eax        {Result := 0}
  ret
@@4:
  dec       eax
@@3:
  dec       eax
@@2:
  dec       eax
  js        @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov       ch, cl
  movd      mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  movq      mm1, [eax+edx-8]{Check Last 8 Characters}
  pcmpeqb   mm1, mm0
  packsswb  mm1, mm1
  movd      ecx, mm1
  test      ecx, ecx        {Match Found?}
  jnz       @@Match         {Yes, Calc Result}
  add       eax, edx        {QWORD Align [eax+edx]}
  and       eax, -8
  sub       eax, edx
@@LargeLoop:
  movq      mm1, [eax+edx-8]{Check 8 Chars per Loop}
  pcmpeqb   mm1, mm0
  packsswb  mm1, mm1
  movd      ecx, mm1
  test      ecx, ecx        {Match Found?}
  jnz       @@Match         {Yes, Calc Result}
  sub       eax, 8
  jg        @@LargeLoop
  xor       eax, eax
  emms
  ret                      {Return 0}
@@Match:
  emms
  bsr       ecx, ecx        {Set Match Offset}
  shr       ecx, 1          {Calculate Result}
  adc       eax, -7
  shr       ecx, 2
  add       ecx, ecx
  add       eax, ecx
  jl        @@NotFound
end;

function CharPosRev_JOH_SSE_3_a(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test     edx, edx        {S = nil?}
  jz       @@NotFound      {Yes, Exit with Result = 0}
  mov      ecx, eax        {SearchChar}
  mov      eax, [edx-4]    {Length(S)}
  cmp      eax, 16
  jg       @@Large         {Length(S)>32}
@@Loop:
  cmp      cl, [eax+edx-1] {Check Next Character from End}
  je       @@1             {Exit on Match}
  cmp      cl, [eax+edx-2] {Check Character Before}
  je       @@2             {Exit on Match}
  cmp      cl, [eax+edx-3] {Check Character Before}
  je       @@3             {Exit on Match}
  cmp      cl, [eax+edx-4] {Check Character Before}
  je       @@4             {Exit on Match}
  sub      eax, 4          {All Characters Checked?}
  jg       @@Loop          {No, Loop}
@@NotFound:
  xor      eax, eax        {Result := 0}
  ret
@@4:
  dec      eax
@@3:
  dec      eax
@@2:
  dec      eax
  js       @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov      ch, cl
  movd     mm0, ecx
  pshufw   mm0, mm0, 0     {All 8 Bytes of mm0 = cl}
  movq     mm1, [eax+edx-8]{Check Last 8 Characters}
  pcmpeqb  mm1, mm0
  packsswb mm1, mm1
  movd     ecx, mm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  add      eax, edx        {QWORD Align [eax+edx]}
  and      eax, -8
  sub      eax, edx
@@LargeLoop:
  movq     mm1, [eax+edx-8]{Check 8 Chars per Loop}
  pcmpeqb  mm1, mm0
  packsswb mm1, mm1
  movd     ecx, mm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  sub      eax, 8
  jg       @@LargeLoop
  xor      eax, eax
  emms
  ret                      {Return 0}
@@Match:
  emms
  bsr      ecx, ecx        {Set Match Offset}
  shr      ecx, 1          {Calculate Result}
  adc      eax, -7
  shr      ecx, 2
  add      ecx, ecx
  add      eax, ecx
  jl       @@NotFound
end;

function CharPosRev_JOH_SSE_3_b(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test     edx, edx        {S = nil?}
  jz       @@NotFound      {Yes, Exit with Result = 0}
  mov      ecx, eax        {SearchChar}
  mov      eax, [edx-4]    {Length(S)}
  cmp      eax, 16
  jg       @@Large         {Length(S)>32}
@@Loop:
  cmp      cl, [eax+edx-1] {Check Next Character from End}
  je       @@1             {Exit on Match}
  cmp      cl, [eax+edx-2] {Check Character Before}
  je       @@2             {Exit on Match}
  cmp      cl, [eax+edx-3] {Check Character Before}
  je       @@3             {Exit on Match}
  cmp      cl, [eax+edx-4] {Check Character Before}
  je       @@4             {Exit on Match}
  sub      eax, 4          {All Characters Checked?}
  jg       @@Loop          {No, Loop}
@@NotFound:
  xor      eax, eax        {Result := 0}
  ret
@@4:
  dec      eax
@@3:
  dec      eax
@@2:
  dec      eax
  js       @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov      ch, cl
  movd     mm0, ecx
  pshufw   mm0, mm0, 0     {All 8 Bytes of mm0 = cl}
  movq     mm1, [eax+edx-8]{Check Last 8 Characters}
  pcmpeqb  mm1, mm0
  packsswb mm1, mm1
  movd     ecx, mm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  add      eax, edx        {QWORD Align [eax+edx]}
  and      eax, -8
  sub      eax, edx
@@LargeLoop:
  movq     mm1, [eax+edx-8]{Check 8 Chars per Loop}
  pcmpeqb  mm1, mm0
  packsswb mm1, mm1
  movd     ecx, mm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  sub      eax, 8
  jg       @@LargeLoop
  xor      eax, eax
  emms
  ret                      {Return 0}
@@Match:
  emms
  bsr      ecx, ecx        {Set Match Offset}
  shr      ecx, 1          {Calculate Result}
  adc      eax, -7
  shr      ecx, 2
  add      ecx, ecx
  add      eax, ecx
  jl       @@NotFound
end;

procedure Filler9;
asm
 nop
end;

function CharPosRev_JOH_SSE_3_c(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test     edx, edx        {S = nil?}
  jz       @@NotFound      {Yes, Exit with Result = 0}
  mov      ecx, eax        {SearchChar}
  mov      eax, [edx-4]    {Length(S)}
  cmp      eax, 16
  jg       @@Large         {Length(S)>32}
@@Loop:
  cmp      cl, [eax+edx-1] {Check Next Character from End}
  je       @@1             {Exit on Match}
  cmp      cl, [eax+edx-2] {Check Character Before}
  je       @@2             {Exit on Match}
  cmp      cl, [eax+edx-3] {Check Character Before}
  je       @@3             {Exit on Match}
  cmp      cl, [eax+edx-4] {Check Character Before}
  je       @@4             {Exit on Match}
  sub      eax, 4          {All Characters Checked?}
  jg       @@Loop          {No, Loop}
@@NotFound:
  xor      eax, eax        {Result := 0}
  ret
@@4:
  dec      eax
@@3:
  dec      eax
@@2:
  dec      eax
  js       @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov      ch, cl
  movd     mm0, ecx
  pshufw   mm0, mm0, 0     {All 8 Bytes of mm0 = cl}
  movq     mm1, [eax+edx-8]{Check Last 8 Characters}
  pcmpeqb  mm1, mm0
  packsswb mm1, mm1
  movd     ecx, mm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  add      eax, edx        {QWORD Align [eax+edx]}
  and      eax, -8
  sub      eax, edx
@@LargeLoop:
  movq     mm1, [eax+edx-8]{Check 8 Chars per Loop}
  pcmpeqb  mm1, mm0
  packsswb mm1, mm1
  movd     ecx, mm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  sub      eax, 8
  jg       @@LargeLoop
  xor      eax, eax
  emms
  ret                      {Return 0}
@@Match:
  emms
  bsr      ecx, ecx        {Set Match Offset}
  shr      ecx, 1          {Calculate Result}
  adc      eax, -7
  shr      ecx, 2
  add      ecx, ecx
  add      eax, ecx
  jl       @@NotFound
end;

function CharPosRev_JOH_SSE_3_d(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test     edx, edx        {S = nil?}
  jz       @@NotFound      {Yes, Exit with Result = 0}
  mov      ecx, eax        {SearchChar}
  mov      eax, [edx-4]    {Length(S)}
  cmp      eax, 16
  jg       @@Large         {Length(S)>32}
@@Loop:
  cmp      cl, [eax+edx-1] {Check Next Character from End}
  je       @@1             {Exit on Match}
  cmp      cl, [eax+edx-2] {Check Character Before}
  je       @@2             {Exit on Match}
  cmp      cl, [eax+edx-3] {Check Character Before}
  je       @@3             {Exit on Match}
  cmp      cl, [eax+edx-4] {Check Character Before}
  je       @@4             {Exit on Match}
  sub      eax, 4          {All Characters Checked?}
  jg       @@Loop          {No, Loop}
@@NotFound:
  xor      eax, eax        {Result := 0}
  ret
@@4:
  dec      eax
@@3:
  dec      eax
@@2:
  dec      eax
  js       @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov      ch, cl
  movd     mm0, ecx
  pshufw   mm0, mm0, 0     {All 8 Bytes of mm0 = cl}
  movq     mm1, [eax+edx-8]{Check Last 8 Characters}
  pcmpeqb  mm1, mm0
  packsswb mm1, mm1
  movd     ecx, mm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  add      eax, edx        {QWORD Align [eax+edx]}
  and      eax, -8
  sub      eax, edx
@@LargeLoop:
  movq     mm1, [eax+edx-8]{Check 8 Chars per Loop}
  pcmpeqb  mm1, mm0
  packsswb mm1, mm1
  movd     ecx, mm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  sub      eax, 8
  jg       @@LargeLoop
  xor      eax, eax
  emms
  ret                      {Return 0}
@@Match:
  emms
  bsr      ecx, ecx        {Set Match Offset}
  shr      ecx, 1          {Calculate Result}
  adc      eax, -7
  shr      ecx, 2
  add      ecx, ecx
  add      eax, ecx
  jl       @@NotFound
end;

function CharPosRev_JOH_SSE2_3_a(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test     edx, edx        {S = nil?}
  jz       @@NotFound      {Yes, Exit with Result = 0}
  mov      ecx, eax        {SearchChar}
  mov      eax, [edx-4]    {Length(S)}
  cmp      eax, 32
  jg       @@Large         {Length(S)>32}
@@Loop:
  cmp      cl, [eax+edx-1] {Check Next Character from End}
  je       @@1             {Exit on Match}
  cmp      cl, [eax+edx-2] {Check Character Before}
  je       @@2             {Exit on Match}
  cmp      cl, [eax+edx-3] {Check Character Before}
  je       @@3             {Exit on Match}
  cmp      cl, [eax+edx-4] {Check Character Before}
  je       @@4             {Exit on Match}
  sub      eax, 4          {All Characters Checked?}
  jg       @@Loop          {No, Loop}
@@NotFound:
  xor      eax, eax        {Result := 0}
  ret
@@4:
  dec      eax
@@3:
  dec      eax
@@2:
  dec      eax
  js       @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov      ch, cl
  sub      eax, 16         {Length(S)-16}
  movd     xmm0, ecx
  pshuflw  xmm0, xmm0, 0
  pshufd   xmm0, xmm0, 0   {All 16 Bytes of xmm0 = cl}
  movdqu   xmm1, [eax+edx] {Check Last 16 Chars}
  pcmpeqb  xmm1, xmm0
  pmovmskb ecx, xmm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  add      eax, edx        {DQWORD Align [eax+edx]}
  and      eax, -16
  sub      eax, edx
@@LargeLoop:
  movdqa   xmm1, [eax+edx] {Check 16 Chars per Loop}
  pcmpeqb  xmm1, xmm0
  pmovmskb ecx, xmm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  sub      eax, 16
  jge      @@LargeLoop
  movd     ecx, xmm0       {Put SearchChar back into CL}
  add      eax, 16
  jg       @@Loop          {Search any Remaining Chars}
  ret                      {No Remainder, Return 0}
@@Match:
  bsr      ecx, ecx        {Set Match Offset}
  lea      eax, [eax+ecx+1]{Set Result}
end;

function CharPosRev_JOH_SSE2_3_b(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test     edx, edx        {S = nil?}
  jz       @@NotFound      {Yes, Exit with Result = 0}
  mov      ecx, eax        {SearchChar}
  mov      eax, [edx-4]    {Length(S)}
  cmp      eax, 32
  jg       @@Large         {Length(S)>32}
@@Loop:
  cmp      cl, [eax+edx-1] {Check Next Character from End}
  je       @@1             {Exit on Match}
  cmp      cl, [eax+edx-2] {Check Character Before}
  je       @@2             {Exit on Match}
  cmp      cl, [eax+edx-3] {Check Character Before}
  je       @@3             {Exit on Match}
  cmp      cl, [eax+edx-4] {Check Character Before}
  je       @@4             {Exit on Match}
  sub      eax, 4          {All Characters Checked?}
  jg       @@Loop          {No, Loop}
@@NotFound:
  xor      eax, eax        {Result := 0}
  ret
@@4:
  dec      eax
@@3:
  dec      eax
@@2:
  dec      eax
  js       @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov      ch, cl
  sub      eax, 16         {Length(S)-16}
  movd     xmm0, ecx
  pshuflw  xmm0, xmm0, 0
  pshufd   xmm0, xmm0, 0   {All 16 Bytes of xmm0 = cl}
  movdqu   xmm1, [eax+edx] {Check Last 16 Chars}
  pcmpeqb  xmm1, xmm0
  pmovmskb ecx, xmm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  add      eax, edx        {DQWORD Align [eax+edx]}
  and      eax, -16
  sub      eax, edx
@@LargeLoop:
  movdqa   xmm1, [eax+edx] {Check 16 Chars per Loop}
  pcmpeqb  xmm1, xmm0
  pmovmskb ecx, xmm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  sub      eax, 16
  jge      @@LargeLoop
  movd     ecx, xmm0       {Put SearchChar back into CL}
  add      eax, 16
  jg       @@Loop          {Search any Remaining Chars}
  ret                      {No Remainder, Return 0}
@@Match:
  bsr      ecx, ecx        {Set Match Offset}
  lea      eax, [eax+ecx+1]{Set Result}
end;

procedure Filler10;
asm
 nop
end;

function CharPosRev_JOH_SSE2_3_c(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test     edx, edx        {S = nil?}
  jz       @@NotFound      {Yes, Exit with Result = 0}
  mov      ecx, eax        {SearchChar}
  mov      eax, [edx-4]    {Length(S)}
  cmp      eax, 32
  jg       @@Large         {Length(S)>32}
@@Loop:
  cmp      cl, [eax+edx-1] {Check Next Character from End}
  je       @@1             {Exit on Match}
  cmp      cl, [eax+edx-2] {Check Character Before}
  je       @@2             {Exit on Match}
  cmp      cl, [eax+edx-3] {Check Character Before}
  je       @@3             {Exit on Match}
  cmp      cl, [eax+edx-4] {Check Character Before}
  je       @@4             {Exit on Match}
  sub      eax, 4          {All Characters Checked?}
  jg       @@Loop          {No, Loop}
@@NotFound:
  xor      eax, eax        {Result := 0}
  ret
@@4:
  dec      eax
@@3:
  dec      eax
@@2:
  dec      eax
  js       @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov      ch, cl
  sub      eax, 16         {Length(S)-16}
  movd     xmm0, ecx
  pshuflw  xmm0, xmm0, 0
  pshufd   xmm0, xmm0, 0   {All 16 Bytes of xmm0 = cl}
  movdqu   xmm1, [eax+edx] {Check Last 16 Chars}
  pcmpeqb  xmm1, xmm0
  pmovmskb ecx, xmm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  add      eax, edx        {DQWORD Align [eax+edx]}
  and      eax, -16
  sub      eax, edx
@@LargeLoop:
  movdqa   xmm1, [eax+edx] {Check 16 Chars per Loop}
  pcmpeqb  xmm1, xmm0
  pmovmskb ecx, xmm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  sub      eax, 16
  jge      @@LargeLoop
  movd     ecx, xmm0       {Put SearchChar back into CL}
  add      eax, 16
  jg       @@Loop          {Search any Remaining Chars}
  ret                      {No Remainder, Return 0}
@@Match:
  bsr      ecx, ecx        {Set Match Offset}
  lea      eax, [eax+ecx+1]{Set Result}
end;

function CharPosRev_JOH_SSE2_3_d(SearchChar : Char; const S: string) : Integer;
asm {136 Bytes}
  test     edx, edx        {S = nil?}
  jz       @@NotFound      {Yes, Exit with Result = 0}
  mov      ecx, eax        {SearchChar}
  mov      eax, [edx-4]    {Length(S)}
  cmp      eax, 32
  jg       @@Large         {Length(S)>32}
@@Loop:
  cmp      cl, [eax+edx-1] {Check Next Character from End}
  je       @@1             {Exit on Match}
  cmp      cl, [eax+edx-2] {Check Character Before}
  je       @@2             {Exit on Match}
  cmp      cl, [eax+edx-3] {Check Character Before}
  je       @@3             {Exit on Match}
  cmp      cl, [eax+edx-4] {Check Character Before}
  je       @@4             {Exit on Match}
  sub      eax, 4          {All Characters Checked?}
  jg       @@Loop          {No, Loop}
@@NotFound:
  xor      eax, eax        {Result := 0}
  ret
@@4:
  dec      eax
@@3:
  dec      eax
@@2:
  dec      eax
  js       @@NotFound      {Match Found before First Char}
@@1:
  ret
@@Large:
  mov      ch, cl
  sub      eax, 16         {Length(S)-16}
  movd     xmm0, ecx
  pshuflw  xmm0, xmm0, 0
  pshufd   xmm0, xmm0, 0   {All 16 Bytes of xmm0 = cl}
  movdqu   xmm1, [eax+edx] {Check Last 16 Chars}
  pcmpeqb  xmm1, xmm0
  pmovmskb ecx, xmm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  add      eax, edx        {DQWORD Align [eax+edx]}
  and      eax, -16
  sub      eax, edx
@@LargeLoop:
  movdqa   xmm1, [eax+edx] {Check 16 Chars per Loop}
  pcmpeqb  xmm1, xmm0
  pmovmskb ecx, xmm1
  test     ecx, ecx        {Match Found?}
  jnz      @@Match         {Yes, Calc Result}
  sub      eax, 16
  jge      @@LargeLoop
  movd     ecx, xmm0       {Put SearchChar back into CL}
  add      eax, 16
  jg       @@Loop          {Search any Remaining Chars}
  ret                      {No Remainder, Return 0}
@@Match:
  bsr      ecx, ecx        {Set Match Offset}
  lea      eax, [eax+ecx+1]{Set Result}
end;

initialization
  Filler1;
  Filler2;
  Filler3;
  Filler4;
  Filler5;
  Filler6;
  Filler7;
  Filler8;
  Filler9;
  Filler10;
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_1_a', @CharPosRev_JOH_PAS_1_a);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_1_b', @CharPosRev_JOH_PAS_1_b);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_1_c', @CharPosRev_JOH_PAS_1_c);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_1_d', @CharPosRev_JOH_PAS_1_d);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_2_a', @CharPosRev_JOH_PAS_2_a);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_2_b', @CharPosRev_JOH_PAS_2_b);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_2_c', @CharPosRev_JOH_PAS_2_c);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_2_d', @CharPosRev_JOH_PAS_2_d);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_3_a', @CharPosRev_JOH_PAS_3_a);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_3_b', @CharPosRev_JOH_PAS_3_b);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_3_c', @CharPosRev_JOH_PAS_3_c);
  MainForm.RegisterFunction('CharPosRev_JOH_PAS_3_d', @CharPosRev_JOH_PAS_3_d);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_1_a', @CharPosRev_JOH_IA32_1_a);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_1_b', @CharPosRev_JOH_IA32_1_b);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_1_c', @CharPosRev_JOH_IA32_1_c);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_1_d', @CharPosRev_JOH_IA32_1_d);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_2_a', @CharPosRev_JOH_IA32_2_a);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_2_b', @CharPosRev_JOH_IA32_2_b);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_2_c', @CharPosRev_JOH_IA32_2_c);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_2_d', @CharPosRev_JOH_IA32_2_d);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_3_a', @CharPosRev_JOH_IA32_3_a);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_3_b', @CharPosRev_JOH_IA32_3_b);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_3_c', @CharPosRev_JOH_IA32_3_c);
  MainForm.RegisterFunction('CharPosRev_JOH_IA32_3_d', @CharPosRev_JOH_IA32_3_d);
  MainForm.RegisterFunction('CharPosRev_JOH_MMX_3_a', @CharPosRev_JOH_MMX_3_a);
  MainForm.RegisterFunction('CharPosRev_JOH_MMX_3_b', @CharPosRev_JOH_MMX_3_b);
  MainForm.RegisterFunction('CharPosRev_JOH_MMX_3_c', @CharPosRev_JOH_MMX_3_c);
  MainForm.RegisterFunction('CharPosRev_JOH_MMX_3_d', @CharPosRev_JOH_MMX_3_d);
  MainForm.RegisterFunction('CharPosRev_JOH_SSE_3_a', @CharPosRev_JOH_SSE_3_a);
  MainForm.RegisterFunction('CharPosRev_JOH_SSE_3_b', @CharPosRev_JOH_SSE_3_b);
  MainForm.RegisterFunction('CharPosRev_JOH_SSE_3_c', @CharPosRev_JOH_SSE_3_c);
  MainForm.RegisterFunction('CharPosRev_JOH_SSE_3_d', @CharPosRev_JOH_SSE_3_d);
  MainForm.RegisterFunction('CharPosRev_JOH_SSE2_3_a', @CharPosRev_JOH_SSE2_3_a);
  MainForm.RegisterFunction('CharPosRev_JOH_SSE2_3_b', @CharPosRev_JOH_SSE2_3_b);
  MainForm.RegisterFunction('CharPosRev_JOH_SSE2_3_c', @CharPosRev_JOH_SSE2_3_c);
  MainForm.RegisterFunction('CharPosRev_JOH_SSE2_3_d', @CharPosRev_JOH_SSE2_3_d);
end.
