unit CharPosIExJOHUnit;

interface

implementation

uses
  SysUtils, MainUnit;

var
  UpcaseLookUp : array[Char] of Char;

procedure InitializeLookUpTable;
var
  C : Char;
begin
 for C := #0 to #255 do
   UpcaseLookUp[C] := UpCase(C);
end;

//No Lookup Table Used (Size = 105 Bytes)
function CharPosIEx_JOH_Pas_1_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 L: Integer;
 Ch, Ch2: Char;
begin
  Result := 0;
  L := Length(S);
  if (Offset <= 0) or (Offset > L) then
    Exit;
  Ch := SearchChar;
  if Ch in ['A'..'Z'] then
    Inc(Ch, Ord('a')-Ord('A')); {Lowercase(Char)}
  repeat
    Ch2 := Char(Byte(S[Offset]) or $20);
    if (Byte(Ch) and Byte(Ch2)) = Byte(ch) then
      begin {Possible Match}
        Ch2 := S[Offset];
        if Ch2 in ['A'..'Z'] then
          Inc(Ch2, Ord('a')-Ord('A'));
        if ch = ch2 then
          begin
            Result := Offset;
            Exit;
          end;
      end;
    inc(Offset);
  until Offset > L;
end;

function CharPosIEx_JOH_Pas_1_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 L: Integer;
 Ch, Ch2: Char;
begin
  Result := 0;
  L := Length(S);
  if (Offset <= 0) or (Offset > L) then
    Exit;
  Ch := SearchChar;
  if Ch in ['A'..'Z'] then
    Inc(Ch, Ord('a')-Ord('A')); {Lowercase(Char)}
  repeat
    Ch2 := Char(Byte(S[Offset]) or $20);
    if (Byte(Ch) and Byte(Ch2)) = Byte(ch) then
      begin {Possible Match}
        Ch2 := S[Offset];
        if Ch2 in ['A'..'Z'] then
          Inc(Ch2, Ord('a')-Ord('A'));
        if ch = ch2 then
          begin
            Result := Offset;
            Exit;
          end;
      end;
    inc(Offset);
  until Offset > L;
end;

function CharPosIEx_JOH_Pas_1_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 L: Integer;
 Ch, Ch2: Char;
begin
  Result := 0;
  L := Length(S);
  if (Offset <= 0) or (Offset > L) then
    Exit;
  Ch := SearchChar;
  if Ch in ['A'..'Z'] then
    Inc(Ch, Ord('a')-Ord('A')); {Lowercase(Char)}
  repeat
    Ch2 := Char(Byte(S[Offset]) or $20);
    if (Byte(Ch) and Byte(Ch2)) = Byte(ch) then
      begin {Possible Match}
        Ch2 := S[Offset];
        if Ch2 in ['A'..'Z'] then
          Inc(Ch2, Ord('a')-Ord('A'));
        if ch = ch2 then
          begin
            Result := Offset;
            Exit;
          end;
      end;
    inc(Offset);
  until Offset > L;
end;

function CharPosIEx_JOH_Pas_1_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 L: Integer;
 Ch, Ch2: Char;
begin
  Result := 0;
  L := Length(S);
  if (Offset <= 0) or (Offset > L) then
    Exit;
  Ch := SearchChar;
  if Ch in ['A'..'Z'] then
    Inc(Ch, Ord('a')-Ord('A')); {Lowercase(Char)}
  repeat
    Ch2 := Char(Byte(S[Offset]) or $20);
    if (Byte(Ch) and Byte(Ch2)) = Byte(ch) then
      begin {Possible Match}
        Ch2 := S[Offset];
        if Ch2 in ['A'..'Z'] then
          Inc(Ch2, Ord('a')-Ord('A'));
        if ch = ch2 then
          begin
            Result := Offset;
            Exit;
          end;
      end;
    inc(Offset);
  until Offset > L;
end;

//Uses Lookup Table (Size = 58 Bytes + 256 Byte Table = 314 Bytes)
function CharPosIEx_JOH_Pas_2_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 L: Integer;
 Ch: Char;
begin
  Result := Offset;
  L := Length(S);
  if (Result > 0) and (Result <= L) then
    begin
      Ch := UpcaseLookUp[SearchChar];
      repeat
        if UpcaseLookUp[S[Result]] = Ch then
          Exit;
        Inc(Result);
      until Result > L;
    end;
  Result := 0;
end;

function CharPosIEx_JOH_Pas_2_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 L: Integer;
 Ch: Char;
begin
  Result := Offset;
  L := Length(S);
  if (Result > 0) and (Result <= L) then
    begin
      Ch := UpcaseLookUp[SearchChar];
      repeat
        if UpcaseLookUp[S[Result]] = Ch then
          Exit;
        Inc(Result);
      until Result > L;
    end;
  Result := 0;
end;

function CharPosIEx_JOH_Pas_2_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 L: Integer;
 Ch: Char;
begin
  Result := Offset;
  L := Length(S);
  if (Result > 0) and (Result <= L) then
    begin
      Ch := UpcaseLookUp[SearchChar];
      repeat
        if UpcaseLookUp[S[Result]] = Ch then
          Exit;
        Inc(Result);
      until Result > L;
    end;
  Result := 0;
end;

function CharPosIEx_JOH_Pas_2_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 L: Integer;
 Ch: Char;
begin
  Result := Offset;
  L := Length(S);
  if (Result > 0) and (Result <= L) then
    begin
      Ch := UpcaseLookUp[SearchChar];
      repeat
        if UpcaseLookUp[S[Result]] = Ch then
          Exit;
        Inc(Result);
      until Result > L;
    end;
  Result := 0;
end;

//No Lookup Table Used (Size = 88 Bytes)
function CharPosIEx_JOH_IA32_1_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound       {S=Nil}
  sub   ecx, 1
  js    @@NotFound       {Offset <= 0}
  mov   edi, [edx-4]     {Length(S)}
  cmp   ecx, edi
  jge   @@NotFound       {Offset > Length(S)}
  movzx eax, al
  mov   esi, edx         {@S}
  mov   ebx, eax         {SearchChar}
  add   bl, $bf
  sub   bl, $1a
  sbb   ebx, ebx
  and   ebx, $20
  add   eax, ebx         {Lowercase(SearchChar)}
@@Loop:
  movzx edx, [esi+ecx]   {Next Char of S}
  inc   ecx              {Prepare for Next Loop}
  mov   ebx, edx         {Next Char of S}
  or    edx, $20         {'A'..'Z' > 'a'..'z'}
  and   edx, eax
  cmp   eax, edx
  je    @@Check          {Possible Match}
@@Next:
  cmp   ecx, edi
  jl    @@Loop           {Loop until all Chars Tested}
@@NotFound:
  xor   eax, eax
  jmp   @@Exit
@@Check:
  mov   edx, ebx         {Next Char of S}
  add   dl, $bf
  sub   dl, $1a
  sbb   edx, edx
  and   edx, $20
  add   ebx, edx         {Lowercase(Next Char of S)}
  cmp   eax, ebx
  jnz   @@Next           {No Match}
  mov   eax, ecx         {Result = Match Position}
@@Exit:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_1_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound       {S=Nil}
  sub   ecx, 1
  js    @@NotFound       {Offset <= 0}
  mov   edi, [edx-4]     {Length(S)}
  cmp   ecx, edi
  jge   @@NotFound       {Offset > Length(S)}
  movzx eax, al
  mov   esi, edx         {@S}
  mov   ebx, eax         {SearchChar}
  add   bl, $bf
  sub   bl, $1a
  sbb   ebx, ebx
  and   ebx, $20
  add   eax, ebx         {Lowercase(SearchChar)}
@@Loop:
  movzx edx, [esi+ecx]   {Next Char of S}
  inc   ecx              {Prepare for Next Loop}
  mov   ebx, edx         {Next Char of S}
  or    edx, $20         {'A'..'Z' > 'a'..'z'}
  and   edx, eax
  cmp   eax, edx
  je    @@Check          {Possible Match}
@@Next:
  cmp   ecx, edi
  jl    @@Loop           {Loop until all Chars Tested}
@@NotFound:
  xor   eax, eax
  jmp   @@Exit
@@Check:
  mov   edx, ebx         {Next Char of S}
  add   dl, $bf
  sub   dl, $1a
  sbb   edx, edx
  and   edx, $20
  add   ebx, edx         {Lowercase(Next Char of S)}
  cmp   eax, ebx
  jnz   @@Next           {No Match}
  mov   eax, ecx         {Result = Match Position}
@@Exit:
  pop   esi
  pop   edi
  pop   ebx
end;

procedure filler1;
asm
  nop
end;

function CharPosIEx_JOH_IA32_1_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound       {S=Nil}
  sub   ecx, 1
  js    @@NotFound       {Offset <= 0}
  mov   edi, [edx-4]     {Length(S)}
  cmp   ecx, edi
  jge   @@NotFound       {Offset > Length(S)}
  movzx eax, al
  mov   esi, edx         {@S}
  mov   ebx, eax         {SearchChar}
  add   bl, $bf
  sub   bl, $1a
  sbb   ebx, ebx
  and   ebx, $20
  add   eax, ebx         {Lowercase(SearchChar)}
@@Loop:
  movzx edx, [esi+ecx]   {Next Char of S}
  inc   ecx              {Prepare for Next Loop}
  mov   ebx, edx         {Next Char of S}
  or    edx, $20         {'A'..'Z' > 'a'..'z'}
  and   edx, eax
  cmp   eax, edx
  je    @@Check          {Possible Match}
@@Next:
  cmp   ecx, edi
  jl    @@Loop           {Loop until all Chars Tested}
@@NotFound:
  xor   eax, eax
  jmp   @@Exit
@@Check:
  mov   edx, ebx         {Next Char of S}
  add   dl, $bf
  sub   dl, $1a
  sbb   edx, edx
  and   edx, $20
  add   ebx, edx         {Lowercase(Next Char of S)}
  cmp   eax, ebx
  jnz   @@Next           {No Match}
  mov   eax, ecx         {Result = Match Position}
@@Exit:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_1_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound       {S=Nil}
  sub   ecx, 1
  js    @@NotFound       {Offset <= 0}
  mov   edi, [edx-4]     {Length(S)}
  cmp   ecx, edi
  jge   @@NotFound       {Offset > Length(S)}
  movzx eax, al
  mov   esi, edx         {@S}
  mov   ebx, eax         {SearchChar}
  add   bl, $bf
  sub   bl, $1a
  sbb   ebx, ebx
  and   ebx, $20
  add   eax, ebx         {Lowercase(SearchChar)}
@@Loop:
  movzx edx, [esi+ecx]   {Next Char of S}
  inc   ecx              {Prepare for Next Loop}
  mov   ebx, edx         {Next Char of S}
  or    edx, $20         {'A'..'Z' > 'a'..'z'}
  and   edx, eax
  cmp   eax, edx
  je    @@Check          {Possible Match}
@@Next:
  cmp   ecx, edi
  jl    @@Loop           {Loop until all Chars Tested}
@@NotFound:
  xor   eax, eax
  jmp   @@Exit
@@Check:
  mov   edx, ebx         {Next Char of S}
  add   dl, $bf
  sub   dl, $1a
  sbb   edx, edx
  and   edx, $20
  add   ebx, edx         {Lowercase(Next Char of S)}
  cmp   eax, ebx
  jnz   @@Next           {No Match}
  mov   eax, ecx         {Result = Match Position}
@@Exit:
  pop   esi
  pop   edi
  pop   ebx
end;

//Uses Lookup Table (Size = 49 Bytes + 256 Byte Table = 305 Bytes)
function CharPosIEx_JOH_IA32_2_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  esi
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   ebx, [edx-4]           {Length(S)}
  cmp   ecx, ebx
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al                {SearchChar}
  mov   esi, edx               {S}
  mov   al, [eax+UpcaseLookUp] {Uppercase(SearchChar)}
@@Loop:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult
  cmp   ecx, ebx
  jl    @@Loop                 {Loop until all Chars Tested}
@@NotFound:
  xor   ecx, ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
  pop   esi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_2_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  esi
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   ebx, [edx-4]           {Length(S)}
  cmp   ecx, ebx
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al                {SearchChar}
  mov   esi, edx               {S}
  mov   al, [eax+UpcaseLookUp] {Uppercase(SearchChar)}
@@Loop:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult
  cmp   ecx, ebx
  jl    @@Loop                 {Loop until all Chars Tested}
@@NotFound:
  xor   ecx, ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
  pop   esi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_2_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  esi
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   ebx, [edx-4]           {Length(S)}
  cmp   ecx, ebx
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al                {SearchChar}
  mov   esi, edx               {S}
  mov   al, [eax+UpcaseLookUp] {Uppercase(SearchChar)}
@@Loop:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult
  cmp   ecx, ebx
  jl    @@Loop                 {Loop until all Chars Tested}
@@NotFound:
  xor   ecx, ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
  pop   esi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_2_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  esi
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   ebx, [edx-4]           {Length(S)}
  cmp   ecx, ebx
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al                {SearchChar}
  mov   esi, edx               {S}
  mov   al, [eax+UpcaseLookUp] {Uppercase(SearchChar)}
@@Loop:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult
  cmp   ecx, ebx
  jl    @@Loop                 {Loop until all Chars Tested}
@@NotFound:
  xor   ecx, ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
  pop   esi
  pop   ebx
end;

//Uses Lookup Table (Size = 131 Bytes + 256 Byte Table = 387 Bytes)
function CharPosIEx_JOH_IA32_3_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  esi
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   ebx, [edx-4]           {Length(S)}
  cmp   ecx, ebx
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al                {SearchChar}
  mov   esi, edx               {S}
  mov   al, [eax+UpcaseLookUp] {Uppercase(SearchChar)}
  lea   edx, [esi+ebx+3]       {Does the end of S fall within the}
  test  edx, $ffc              {  last 4 bytes  of a Windows Page?}
  jz    @@NearPageEnd          {Yes, Do not read past end of S}
@@Loop:
  movzx edx, [esi+ecx]
  cmp   al, [edx+UpcaseLookUp]  
  movzx edx, [esi+ecx+1]
  je    @@SetResult1
  cmp   al, [edx+UpcaseLookUp]
  movzx edx, [esi+ecx+2]
  je    @@SetResult2
  cmp   al, [edx+UpcaseLookUp]
  movzx edx, [esi+ecx+3]
  je    @@SetResult3
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult4
  add   ecx, 4
  cmp   ecx, ebx
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  pop   esi
  pop   ebx
  ret
@@NearPageEnd:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult
  cmp   ecx, ebx
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   ecx
@@SetResult3:
  inc   ecx
@@SetResult2:
  inc   ecx
  cmp   ecx, ebx
  jge   @@NotFound
@@SetResult1:
  inc   ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
  pop   esi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_3_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  esi
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   ebx, [edx-4]           {Length(S)}
  cmp   ecx, ebx
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al                {SearchChar}
  mov   esi, edx               {S}
  mov   al, [eax+UpcaseLookUp] {Uppercase(SearchChar)}
  lea   edx, [esi+ebx+3]       {Does the end of S fall within the}
  test  edx, $ffc              {  last 4 bytes  of a Windows Page?}
  jz    @@NearPageEnd          {Yes, Do not read past end of S}
@@Loop:
  movzx edx, [esi+ecx]
  cmp   al, [edx+UpcaseLookUp]  
  movzx edx, [esi+ecx+1]
  je    @@SetResult1
  cmp   al, [edx+UpcaseLookUp]
  movzx edx, [esi+ecx+2]
  je    @@SetResult2
  cmp   al, [edx+UpcaseLookUp]
  movzx edx, [esi+ecx+3]
  je    @@SetResult3
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult4
  add   ecx, 4
  cmp   ecx, ebx
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  pop   esi
  pop   ebx
  ret
@@NearPageEnd:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult
  cmp   ecx, ebx
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   ecx
@@SetResult3:
  inc   ecx
@@SetResult2:
  inc   ecx
  cmp   ecx, ebx
  jge   @@NotFound
@@SetResult1:
  inc   ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
  pop   esi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_3_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  esi
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   ebx, [edx-4]           {Length(S)}
  cmp   ecx, ebx
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al                {SearchChar}
  mov   esi, edx               {S}
  mov   al, [eax+UpcaseLookUp] {Uppercase(SearchChar)}
  lea   edx, [esi+ebx+3]       {Does the end of S fall within the}
  test  edx, $ffc              {  last 4 bytes  of a Windows Page?}
  jz    @@NearPageEnd          {Yes, Do not read past end of S}
@@Loop:
  movzx edx, [esi+ecx]
  cmp   al, [edx+UpcaseLookUp]  
  movzx edx, [esi+ecx+1]
  je    @@SetResult1
  cmp   al, [edx+UpcaseLookUp]
  movzx edx, [esi+ecx+2]
  je    @@SetResult2
  cmp   al, [edx+UpcaseLookUp]
  movzx edx, [esi+ecx+3]
  je    @@SetResult3
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult4
  add   ecx, 4
  cmp   ecx, ebx
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  pop   esi
  pop   ebx
  ret
@@NearPageEnd:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult
  cmp   ecx, ebx
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   ecx
@@SetResult3:
  inc   ecx
@@SetResult2:
  inc   ecx
  cmp   ecx, ebx
  jge   @@NotFound
@@SetResult1:
  inc   ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
  pop   esi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_3_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  esi
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   ebx, [edx-4]           {Length(S)}
  cmp   ecx, ebx
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al                {SearchChar}
  mov   esi, edx               {S}
  mov   al, [eax+UpcaseLookUp] {Uppercase(SearchChar)}
  lea   edx, [esi+ebx+3]       {Does the end of S fall within the}
  test  edx, $ffc              {  last 4 bytes  of a Windows Page?}
  jz    @@NearPageEnd          {Yes, Do not read past end of S}
@@Loop:
  movzx edx, [esi+ecx]
  cmp   al, [edx+UpcaseLookUp]  
  movzx edx, [esi+ecx+1]
  je    @@SetResult1
  cmp   al, [edx+UpcaseLookUp]
  movzx edx, [esi+ecx+2]
  je    @@SetResult2
  cmp   al, [edx+UpcaseLookUp]
  movzx edx, [esi+ecx+3]
  je    @@SetResult3
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult4
  add   ecx, 4
  cmp   ecx, ebx
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  pop   esi
  pop   ebx
  ret
@@NearPageEnd:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   al, [edx+UpcaseLookUp]
  je    @@SetResult
  cmp   ecx, ebx
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   ecx
@@SetResult3:
  inc   ecx
@@SetResult2:
  inc   ecx
  cmp   ecx, ebx
  jge   @@NotFound
@@SetResult1:
  inc   ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
  pop   esi
  pop   ebx
end;

//Uses Lookup Table (Size = 120 Bytes + 256 Byte Table = 376 Bytes)
function CharPosIEx_JOH_IA32_4_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  edi
  push  esi
  jz    @@NotFound             {S=Nil}
  movzx ebx, al                {SearchChar}
  dec   ecx                    {Offset-1}
  mov   esi, [edx-4]           {Length(S)}
  lea   edi, UpcaseLookUp
  cmp   ecx, esi
  mov   eax, ecx               {Offset-1}
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  mov   cl, [ebx+edi]          {Uppercase(SearchChar)}
  lea   ebx, [edx+esi+3]       {Does the end of S fall within the last 4 bytes  of a Windows Page?}
  test  bx, $ffc
  jz    @@NearPageEnd          {Do not read past end of S}
@@Loop:
  movzx ebx, [edx+eax]
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+1]
  je    @@SetResult1
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+2]
  je    @@SetResult2
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+3]
  je    @@SetResult3
  cmp   cl, [ebx+edi]
  je    @@SetResult4
  add   eax, 4
  cmp   eax, esi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  pop   esi
  pop   edi
  pop   ebx
  ret
@@NearPageEnd:
  movzx ebx, [edx+eax]         {Next Char of S}
  inc   eax                    {Prepare for Next Loop}
  cmp   cl, [ebx+edi]
  je    @@SetResult
  cmp   eax, esi
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   eax
@@SetResult3:
  inc   eax
@@SetResult2:
  inc   eax
  cmp   eax, esi
  jge   @@NotFound
@@SetResult1:
  inc   eax
@@SetResult:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_4_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  edi
  push  esi
  jz    @@NotFound             {S=Nil}
  movzx ebx, al                {SearchChar}
  dec   ecx                    {Offset-1}
  mov   esi, [edx-4]           {Length(S)}
  lea   edi, UpcaseLookUp
  cmp   ecx, esi
  mov   eax, ecx               {Offset-1}
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  mov   cl, [ebx+edi]          {Uppercase(SearchChar)}
  lea   ebx, [edx+esi+3]       {Does the end of S fall within the last 4 bytes  of a Windows Page?}
  test  bx, $ffc
  jz    @@NearPageEnd          {Do not read past end of S}
@@Loop:
  movzx ebx, [edx+eax]
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+1]
  je    @@SetResult1
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+2]
  je    @@SetResult2
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+3]
  je    @@SetResult3
  cmp   cl, [ebx+edi]
  je    @@SetResult4
  add   eax, 4
  cmp   eax, esi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  pop   esi
  pop   edi
  pop   ebx
  ret
@@NearPageEnd:
  movzx ebx, [edx+eax]         {Next Char of S}
  inc   eax                    {Prepare for Next Loop}
  cmp   cl, [ebx+edi]
  je    @@SetResult
  cmp   eax, esi
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   eax
@@SetResult3:
  inc   eax
@@SetResult2:
  inc   eax
  cmp   eax, esi
  jge   @@NotFound
@@SetResult1:
  inc   eax
@@SetResult:
  pop   esi
  pop   edi
  pop   ebx
end;

procedure filler2;
asm
  nop
end;

function CharPosIEx_JOH_IA32_4_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  edi
  push  esi
  jz    @@NotFound             {S=Nil}
  movzx ebx, al                {SearchChar}
  dec   ecx                    {Offset-1}
  mov   esi, [edx-4]           {Length(S)}
  lea   edi, UpcaseLookUp
  cmp   ecx, esi
  mov   eax, ecx               {Offset-1}
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  mov   cl, [ebx+edi]          {Uppercase(SearchChar)}
  lea   ebx, [edx+esi+3]       {Does the end of S fall within the last 4 bytes  of a Windows Page?}
  test  bx, $ffc
  jz    @@NearPageEnd          {Do not read past end of S}
@@Loop:
  movzx ebx, [edx+eax]
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+1]
  je    @@SetResult1
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+2]
  je    @@SetResult2
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+3]
  je    @@SetResult3
  cmp   cl, [ebx+edi]
  je    @@SetResult4
  add   eax, 4
  cmp   eax, esi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  pop   esi
  pop   edi
  pop   ebx
  ret
@@NearPageEnd:
  movzx ebx, [edx+eax]         {Next Char of S}
  inc   eax                    {Prepare for Next Loop}
  cmp   cl, [ebx+edi]
  je    @@SetResult
  cmp   eax, esi
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   eax
@@SetResult3:
  inc   eax
@@SetResult2:
  inc   eax
  cmp   eax, esi
  jge   @@NotFound
@@SetResult1:
  inc   eax
@@SetResult:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_4_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  test  edx, edx
  push  ebx
  push  edi
  push  esi
  jz    @@NotFound             {S=Nil}
  movzx ebx, al                {SearchChar}
  dec   ecx                    {Offset-1}
  mov   esi, [edx-4]           {Length(S)}
  lea   edi, UpcaseLookUp
  cmp   ecx, esi
  mov   eax, ecx               {Offset-1}
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  mov   cl, [ebx+edi]          {Uppercase(SearchChar)}
  lea   ebx, [edx+esi+3]       {Does the end of S fall within the last 4 bytes  of a Windows Page?}
  test  bx, $ffc
  jz    @@NearPageEnd          {Do not read past end of S}
@@Loop:
  movzx ebx, [edx+eax]
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+1]
  je    @@SetResult1
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+2]
  je    @@SetResult2
  cmp   cl, [ebx+edi]
  movzx ebx, [edx+eax+3]
  je    @@SetResult3
  cmp   cl, [ebx+edi]
  je    @@SetResult4
  add   eax, 4
  cmp   eax, esi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  pop   esi
  pop   edi
  pop   ebx
  ret
@@NearPageEnd:
  movzx ebx, [edx+eax]         {Next Char of S}
  inc   eax                    {Prepare for Next Loop}
  cmp   cl, [ebx+edi]
  je    @@SetResult
  cmp   eax, esi
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   eax
@@SetResult3:
  inc   eax
@@SetResult2:
  inc   eax
  cmp   eax, esi
  jge   @@NotFound
@@SetResult1:
  inc   eax
@@SetResult:
  pop   esi
  pop   edi
  pop   ebx
end;

//No Lookup Table Used (Size = 76 Bytes)
function CharPosIEx_JOH_IA32_5_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@Loop
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@Loop:
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult
  cmp   ebx, edx
  je    @@SetResult
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   ecx, ecx
@@SetResult:
  pop   esi
  pop   edi
  pop   ebx
  mov   eax, ecx               {Result = Match Position}
end;

function CharPosIEx_JOH_IA32_5_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@Loop
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@Loop:
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult
  cmp   ebx, edx
  je    @@SetResult
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   ecx, ecx
@@SetResult:
  pop   esi
  pop   edi
  pop   ebx
  mov   eax, ecx               {Result = Match Position}
end;

function CharPosIEx_JOH_IA32_5_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@Loop
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@Loop:
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult
  cmp   ebx, edx
  je    @@SetResult
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   ecx, ecx
@@SetResult:
  pop   esi
  pop   edi
  pop   ebx
  mov   eax, ecx               {Result = Match Position}
end;

function CharPosIEx_JOH_IA32_5_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@Loop
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@Loop:
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult
  cmp   ebx, edx
  je    @@SetResult
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   ecx, ecx
@@SetResult:
  pop   esi
  pop   edi
  pop   ebx
  mov   eax, ecx               {Result = Match Position}
end;

//No Lookup Table Used (Size = 92 Bytes)
function CharPosIEx_JOH_IA32_6_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@Loop
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@Loop:
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult1
  cmp   ebx, edx
  je    @@SetResult1
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult2
  cmp   ebx, edx
  je    @@SetResult2
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  jmp   @@Done
@@SetResult2:
  cmp   ecx, edi
  jg    @@NotFound
@@SetResult1:
  mov   eax, ecx               {Result = Match Position}
@@Done:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_6_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@Loop
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@Loop:
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult1
  cmp   ebx, edx
  je    @@SetResult1
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult2
  cmp   ebx, edx
  je    @@SetResult2
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  jmp   @@Done
@@SetResult2:
  cmp   ecx, edi
  jg    @@NotFound
@@SetResult1:
  mov   eax, ecx               {Result = Match Position}
@@Done:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_6_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@Loop
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@Loop:
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult1
  cmp   ebx, edx
  je    @@SetResult1
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult2
  cmp   ebx, edx
  je    @@SetResult2
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  jmp   @@Done
@@SetResult2:
  cmp   ecx, edi
  jg    @@NotFound
@@SetResult1:
  mov   eax, ecx               {Result = Match Position}
@@Done:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_6_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@Loop
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@Loop:
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult1
  cmp   ebx, edx
  je    @@SetResult1
  movzx edx, [esi+ecx]
  inc   ecx
  cmp   eax, edx
  je    @@SetResult2
  cmp   ebx, edx
  je    @@SetResult2
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  jmp   @@Done
@@SetResult2:
  cmp   ecx, edi
  jg    @@NotFound
@@SetResult1:
  mov   eax, ecx               {Result = Match Position}
@@Done:
  pop   esi
  pop   edi
  pop   ebx
end;

//No Lookup Table Used (Size = 156 Bytes)
function CharPosIEx_JOH_IA32_7_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@CaseSet
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@CaseSet:
  lea   edx, [esi+edi+3]       {Does the end of S fall within the}
  test  edx, $ffc              {  last 4 bytes  of a Windows Page?}
  jz    @@NearPageEnd          {Yes, Do not read past end of S}
@@Loop:
  movzx edx, [esi+ecx]
  cmp   eax, edx
  je    @@SetResult1
  cmp   ebx, edx
  je    @@SetResult1
  movzx edx, [esi+ecx+1]
  cmp   eax, edx
  je    @@SetResult2
  cmp   ebx, edx
  je    @@SetResult2
  movzx edx, [esi+ecx+2]
  cmp   eax, edx
  je    @@SetResult3
  cmp   ebx, edx
  je    @@SetResult3
  movzx edx, [esi+ecx+3]
  cmp   eax, edx
  je    @@SetResult4
  cmp   ebx, edx
  je    @@SetResult4
  add   ecx, 4
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  jmp   @@Done
@@NearPageEnd:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   eax, edx
  je    @@SetResult
  cmp   ebx, edx
  je    @@SetResult
  cmp   ecx, edi
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   ecx
@@SetResult3:
  inc   ecx
@@SetResult2:
  inc   ecx
  cmp   ecx, edi
  jge   @@NotFound
@@SetResult1:
  inc   ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
@@Done:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_7_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@CaseSet
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@CaseSet:
  lea   edx, [esi+edi+3]       {Does the end of S fall within the}
  test  edx, $ffc              {  last 4 bytes  of a Windows Page?}
  jz    @@NearPageEnd          {Yes, Do not read past end of S}
@@Loop:
  movzx edx, [esi+ecx]
  cmp   eax, edx
  je    @@SetResult1
  cmp   ebx, edx
  je    @@SetResult1
  movzx edx, [esi+ecx+1]
  cmp   eax, edx
  je    @@SetResult2
  cmp   ebx, edx
  je    @@SetResult2
  movzx edx, [esi+ecx+2]
  cmp   eax, edx
  je    @@SetResult3
  cmp   ebx, edx
  je    @@SetResult3
  movzx edx, [esi+ecx+3]
  cmp   eax, edx
  je    @@SetResult4
  cmp   ebx, edx
  je    @@SetResult4
  add   ecx, 4
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  jmp   @@Done
@@NearPageEnd:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   eax, edx
  je    @@SetResult
  cmp   ebx, edx
  je    @@SetResult
  cmp   ecx, edi
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   ecx
@@SetResult3:
  inc   ecx
@@SetResult2:
  inc   ecx
  cmp   ecx, edi
  jge   @@NotFound
@@SetResult1:
  inc   ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
@@Done:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_7_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@CaseSet
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@CaseSet:
  lea   edx, [esi+edi+3]       {Does the end of S fall within the}
  test  edx, $ffc              {  last 4 bytes  of a Windows Page?}
  jz    @@NearPageEnd          {Yes, Do not read past end of S}
@@Loop:
  movzx edx, [esi+ecx]
  cmp   eax, edx
  je    @@SetResult1
  cmp   ebx, edx
  je    @@SetResult1
  movzx edx, [esi+ecx+1]
  cmp   eax, edx
  je    @@SetResult2
  cmp   ebx, edx
  je    @@SetResult2
  movzx edx, [esi+ecx+2]
  cmp   eax, edx
  je    @@SetResult3
  cmp   ebx, edx
  je    @@SetResult3
  movzx edx, [esi+ecx+3]
  cmp   eax, edx
  je    @@SetResult4
  cmp   ebx, edx
  je    @@SetResult4
  add   ecx, 4
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  jmp   @@Done
@@NearPageEnd:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   eax, edx
  je    @@SetResult
  cmp   ebx, edx
  je    @@SetResult
  cmp   ecx, edi
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   ecx
@@SetResult3:
  inc   ecx
@@SetResult2:
  inc   ecx
  cmp   ecx, edi
  jge   @@NotFound
@@SetResult1:
  inc   ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
@@Done:
  pop   esi
  pop   edi
  pop   ebx
end;

function CharPosIEx_JOH_IA32_7_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
asm
  push  ebx
  push  edi
  push  esi
  test  edx, edx
  jz    @@NotFound             {S=Nil}
  dec   ecx                    {Offset-1}
  mov   edi, [edx-4]           {Length(S)}
  cmp   ecx, edi
  jae   @@NotFound             {Offset>Length(S) or Offset<=0}
  movzx eax, al
  mov   esi, edx               {S}
  mov   ebx, eax
  sub   eax, 'A'
  cmp   eax, 'Z'-'A'
  jbe   @@SetCase              {'A'..'Z'}
  sub   eax, 'a'-'A'
  cmp   eax, 'z'-'a'
  jbe   @@SetCase              {'a'..'z'}
  mov   eax, ebx
  jmp   @@CaseSet
@@SetCase:
  add   eax, 'A'               {Uppercase(SearchChar}
  lea   ebx, [eax+'a'-'A']     {Lowercase(SearchChar}
@@CaseSet:
  lea   edx, [esi+edi+3]       {Does the end of S fall within the}
  test  edx, $ffc              {  last 4 bytes  of a Windows Page?}
  jz    @@NearPageEnd          {Yes, Do not read past end of S}
@@Loop:
  movzx edx, [esi+ecx]
  cmp   eax, edx
  je    @@SetResult1
  cmp   ebx, edx
  je    @@SetResult1
  movzx edx, [esi+ecx+1]
  cmp   eax, edx
  je    @@SetResult2
  cmp   ebx, edx
  je    @@SetResult2
  movzx edx, [esi+ecx+2]
  cmp   eax, edx
  je    @@SetResult3
  cmp   ebx, edx
  je    @@SetResult3
  movzx edx, [esi+ecx+3]
  cmp   eax, edx
  je    @@SetResult4
  cmp   ebx, edx
  je    @@SetResult4
  add   ecx, 4
  cmp   ecx, edi
  jl    @@Loop
@@NotFound:
  xor   eax, eax
  jmp   @@Done
@@NearPageEnd:
  movzx edx, [esi+ecx]         {Next Char of S}
  inc   ecx                    {Prepare for Next Loop}
  cmp   eax, edx
  je    @@SetResult
  cmp   ebx, edx
  je    @@SetResult
  cmp   ecx, edi
  jl    @@NearPageEnd          {Loop until all Chars Tested}
  jmp   @@NotFound
@@SetResult4:
  inc   ecx
@@SetResult3:
  inc   ecx
@@SetResult2:
  inc   ecx
  cmp   ecx, edi
  jge   @@NotFound
@@SetResult1:
  inc   ecx
@@SetResult:
  mov   eax, ecx               {Result = Match Position}
@@Done:
  pop   esi
  pop   edi
  pop   ebx
end;

initialization
  InitializeLookUpTable;
  Filler1;
  filler2;
  MainForm.RegisterFunction('CharPosIEx_JOH_Pas_1_a', @CharPosIEx_JOH_Pas_1_a);
  MainForm.RegisterFunction('CharPosIEx_JOH_Pas_1_b', @CharPosIEx_JOH_Pas_1_b);
  MainForm.RegisterFunction('CharPosIEx_JOH_Pas_1_c', @CharPosIEx_JOH_Pas_1_c);
  MainForm.RegisterFunction('CharPosIEx_JOH_Pas_1_d', @CharPosIEx_JOH_Pas_1_d);

  MainForm.RegisterFunction('CharPosIEx_JOH_Pas_2_a', @CharPosIEx_JOH_Pas_2_a);
  MainForm.RegisterFunction('CharPosIEx_JOH_Pas_2_b', @CharPosIEx_JOH_Pas_2_b);
  MainForm.RegisterFunction('CharPosIEx_JOH_Pas_2_c', @CharPosIEx_JOH_Pas_2_c);
  MainForm.RegisterFunction('CharPosIEx_JOH_Pas_2_d', @CharPosIEx_JOH_Pas_2_d);

  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_1_a', @CharPosIEx_JOH_IA32_1_a);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_1_b', @CharPosIEx_JOH_IA32_1_b);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_1_c', @CharPosIEx_JOH_IA32_1_c);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_1_d', @CharPosIEx_JOH_IA32_1_d);

  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_2_a', @CharPosIEx_JOH_IA32_2_a);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_2_b', @CharPosIEx_JOH_IA32_2_b);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_2_c', @CharPosIEx_JOH_IA32_2_c);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_2_d', @CharPosIEx_JOH_IA32_2_d);

  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_3_a', @CharPosIEx_JOH_IA32_3_a);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_3_b', @CharPosIEx_JOH_IA32_3_b);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_3_c', @CharPosIEx_JOH_IA32_3_c);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_3_d', @CharPosIEx_JOH_IA32_3_d);

  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_4_a', @CharPosIEx_JOH_IA32_4_a);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_4_b', @CharPosIEx_JOH_IA32_4_b);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_4_c', @CharPosIEx_JOH_IA32_4_c);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_4_d', @CharPosIEx_JOH_IA32_4_d);

  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_5_a', @CharPosIEx_JOH_IA32_5_a);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_5_b', @CharPosIEx_JOH_IA32_5_b);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_5_c', @CharPosIEx_JOH_IA32_5_c);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_5_d', @CharPosIEx_JOH_IA32_5_d);

  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_6_a', @CharPosIEx_JOH_IA32_6_a);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_6_b', @CharPosIEx_JOH_IA32_6_b);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_6_c', @CharPosIEx_JOH_IA32_6_c);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_6_d', @CharPosIEx_JOH_IA32_6_d);

  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_7_a', @CharPosIEx_JOH_IA32_7_a);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_7_b', @CharPosIEx_JOH_IA32_7_b);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_7_c', @CharPosIEx_JOH_IA32_7_c);
  MainForm.RegisterFunction('CharPosIEx_JOH_IA32_7_d', @CharPosIEx_JOH_IA32_7_d);

end.

