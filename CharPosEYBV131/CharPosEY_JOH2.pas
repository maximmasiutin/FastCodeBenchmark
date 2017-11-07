unit CharPosEY_JOH2;

interface

{Does Not Read Past NULL Terminator}
function CharPosEY_JOH_PAS_1_a (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_1_b (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_1_c (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_1_d (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;

function CharPosEY_JOH_PAS_3_a (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_3_b (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_3_c (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_3_d (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;

function CharPosEY_JOH_IA32_1_a(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_1_b(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_1_c(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_1_d(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;

function CharPosEY_JOH_IA32_3_a(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_3_b(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_3_c(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_3_d(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;

{Can Read DWORD containing NULL Charatcer}
function CharPosEY_JOH_PAS_2_a (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_2_b (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_2_c (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_2_d (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;

function CharPosEY_JOH_PAS_4_a (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_4_b (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_4_c (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_PAS_4_d (const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;

function CharPosEY_JOH_IA32_2(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_4_a(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_4_b(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_4_c(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
function CharPosEY_JOH_IA32_4_d(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;

{$DEFINE AllowLengthShortcut}

implementation

function CharPosEY_JOH_PAS_1_a(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr + Count <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 2);
      end
end;

function CharPosEY_JOH_PAS_1_b(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr + Count <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 2);
      end
end;

function CharPosEY_JOH_PAS_1_c(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr + Count <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 2);
      end
end;

function CharPosEY_JOH_PAS_1_d(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr + Count <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 2);
      end
end;

function CharPosEY_JOH_PAS_2_a(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr + Count <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[2] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+1 < PMax then {Within Valid Range}
                  Result := PStr + 3 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[3] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+2 < PMax then {Within Valid Range}
                  Result := PStr + 4 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 4);
      end
end;

function CharPosEY_JOH_PAS_2_b(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr + Count <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[2] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+1 < PMax then {Within Valid Range}
                  Result := PStr + 3 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[3] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+2 < PMax then {Within Valid Range}
                  Result := PStr + 4 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 4);
      end
end;

function CharPosEY_JOH_PAS_2_c(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr + Count <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[2] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+1 < PMax then {Within Valid Range}
                  Result := PStr + 3 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[3] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+2 < PMax then {Within Valid Range}
                  Result := PStr + 4 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 4);
      end
end;

function CharPosEY_JOH_PAS_2_d(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr + Count <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[2] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+1 < PMax then {Within Valid Range}
                  Result := PStr + 3 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[3] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+2 < PMax then {Within Valid Range}
                  Result := PStr + 4 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 4);
      end
end;

function CharPosEY_JOH_IA32_1_a(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm
  push   ebx
  push   edi
  push   edx                   {@SourceString}
  test   edx, edx
  jz     @@NotFound            {Exit if SourceString = ''}
  sub    ecx, 1                {Occurrence - 1}
  jl     @@NotFound            {Exit if Occurence < 1}
  cmp    StartPos, 1
  jl     @@NotFound            {Exit if StartPos < 1}
  mov    ebx, [edx-4]          {Length(SourceString)}
  lea    ebx, [edx+ebx-1]      {Last Character Position}
  mov    edx, StartPos
  add    edx, [esp]            {@SourceString}
  sub    edx, 1                {@SourceString + StartPos - 1}
  jmp    @@CheckFinish
@@Loop:
  cmp    al, [edx]
  jne    @@Done1
  sub    ecx, 1                {Match}
  jc     @@SetResult1
@@Done1:
  cmp    al, [edx+1]
  jne    @@Done2
  sub    ecx, 1                {Match}
  jnc    @@Done2
  cmp    edx, ebx
  jl     @@SetResult2
@@Done2:
  add    edx, 2
@@CheckFinish:
  lea    edi, [edx+ecx]
  cmp    edi, ebx
  jle    @@Loop
@@NotFound:
  xor    eax, eax
  pop    edx
  jmp    @@Exit
@@SetResult2:
  add    edx, 1
@@SetResult1:
  pop    ecx                   {@SourceString}
  neg    ecx
  lea    eax, [edx+ecx+1]
@@Exit:
  pop    edi
  pop    ebx
end;

function CharPosEY_JOH_IA32_1_b(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm
  push   ebx
  push   edi
  push   edx                   {@SourceString}
  test   edx, edx
  jz     @@NotFound            {Exit if SourceString = ''}
  sub    ecx, 1                {Occurrence - 1}
  jl     @@NotFound            {Exit if Occurence < 1}
  cmp    StartPos, 1
  jl     @@NotFound            {Exit if StartPos < 1}
  mov    ebx, [edx-4]          {Length(SourceString)}
  lea    ebx, [edx+ebx-1]      {Last Character Position}
  mov    edx, StartPos
  add    edx, [esp]            {@SourceString}
  sub    edx, 1                {@SourceString + StartPos - 1}
  jmp    @@CheckFinish
@@Loop:
  cmp    al, [edx]
  jne    @@Done1
  sub    ecx, 1                {Match}
  jc     @@SetResult1
@@Done1:
  cmp    al, [edx+1]
  jne    @@Done2
  sub    ecx, 1                {Match}
  jnc    @@Done2
  cmp    edx, ebx
  jl     @@SetResult2
@@Done2:
  add    edx, 2
@@CheckFinish:
  lea    edi, [edx+ecx]
  cmp    edi, ebx
  jle    @@Loop
@@NotFound:
  xor    eax, eax
  pop    edx
  jmp    @@Exit
@@SetResult2:
  add    edx, 1
@@SetResult1:
  pop    ecx                   {@SourceString}
  neg    ecx
  lea    eax, [edx+ecx+1]
@@Exit:
  pop    edi
  pop    ebx
end;

function CharPosEY_JOH_IA32_1_c(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm
  push   ebx
  push   edi
  push   edx                   {@SourceString}
  test   edx, edx
  jz     @@NotFound            {Exit if SourceString = ''}
  sub    ecx, 1                {Occurrence - 1}
  jl     @@NotFound            {Exit if Occurence < 1}
  cmp    StartPos, 1
  jl     @@NotFound            {Exit if StartPos < 1}
  mov    ebx, [edx-4]          {Length(SourceString)}
  lea    ebx, [edx+ebx-1]      {Last Character Position}
  mov    edx, StartPos
  add    edx, [esp]            {@SourceString}
  sub    edx, 1                {@SourceString + StartPos - 1}
  jmp    @@CheckFinish
@@Loop:
  cmp    al, [edx]
  jne    @@Done1
  sub    ecx, 1                {Match}
  jc     @@SetResult1
@@Done1:
  cmp    al, [edx+1]
  jne    @@Done2
  sub    ecx, 1                {Match}
  jnc    @@Done2
  cmp    edx, ebx
  jl     @@SetResult2
@@Done2:
  add    edx, 2
@@CheckFinish:
  lea    edi, [edx+ecx]
  cmp    edi, ebx
  jle    @@Loop
@@NotFound:
  xor    eax, eax
  pop    edx
  jmp    @@Exit
@@SetResult2:
  add    edx, 1
@@SetResult1:
  pop    ecx                   {@SourceString}
  neg    ecx
  lea    eax, [edx+ecx+1]
@@Exit:
  pop    edi
  pop    ebx
end;

function CharPosEY_JOH_IA32_1_d(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm
  push   ebx
  push   edi
  push   edx                   {@SourceString}
  test   edx, edx
  jz     @@NotFound            {Exit if SourceString = ''}
  sub    ecx, 1                {Occurrence - 1}
  jl     @@NotFound            {Exit if Occurence < 1}
  cmp    StartPos, 1
  jl     @@NotFound            {Exit if StartPos < 1}
  mov    ebx, [edx-4]          {Length(SourceString)}
  lea    ebx, [edx+ebx-1]      {Last Character Position}
  mov    edx, StartPos
  add    edx, [esp]            {@SourceString}
  sub    edx, 1                {@SourceString + StartPos - 1}
  jmp    @@CheckFinish
@@Loop:
  cmp    al, [edx]
  jne    @@Done1
  sub    ecx, 1                {Match}
  jc     @@SetResult1
@@Done1:
  cmp    al, [edx+1]
  jne    @@Done2
  sub    ecx, 1                {Match}
  jnc    @@Done2
  cmp    edx, ebx
  jl     @@SetResult2
@@Done2:
  add    edx, 2
@@CheckFinish:
  lea    edi, [edx+ecx]
  cmp    edi, ebx
  jle    @@Loop
@@NotFound:
  xor    eax, eax
  pop    edx
  jmp    @@Exit
@@SetResult2:
  add    edx, 1
@@SetResult1:
  pop    ecx                   {@SourceString}
  neg    ecx
  lea    eax, [edx+ecx+1]
@@Exit:
  pop    edi
  pop    ebx
end;

function CharPosEY_JOH_IA32_2(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm
  push   ebx
  push   edi
  push   edx                   {@SourceString}
  test   edx, edx
  jz     @@NotFound            {Exit if SourceString = ''}
  sub    ecx, 1                {Occurrence - 1}
  jl     @@NotFound            {Exit if Occurence < 1}
  cmp    StartPos, 1
  jl     @@NotFound            {Exit if StartPos < 1}
  mov    ebx, [edx-4]          {Length(SourceString)}
  lea    ebx, [edx+ebx-1]      {Last Character Position}
  mov    edx, StartPos
  add    edx, [esp]            {@SourceString}
  sub    edx, 1                {@SourceString + StartPos - 1}
  jmp    @@CheckFinish
@@Loop:
  cmp    al, [edx]
  jne    @@Done1
  sub    ecx, 1                {Match}
  jc     @@SetResult1
@@Done1:
  cmp    al, [edx+1]
  jne    @@Done2
  sub    ecx, 1                {Match}
  jnc    @@Done2
  cmp    edx, ebx
  jge    @@NotFound
  jmp    @@SetResult2
@@Done2:
  cmp    al, [edx+2]
  jne    @@Done3
  sub    ecx, 1                {Match}
  jnc    @@Done3
  cmp    edx, ebx
  jg     @@NotFound
  jmp    @@SetResult3
@@Done3:
  cmp    al, [edx+3]
  jne    @@Done4
  sub    ecx, 1                {Match}
  jnc    @@Done4
  add    edx, 3
  cmp    edx, ebx
  jle    @@SetResult1
@@Done4:
  add    edx, 4
@@CheckFinish:
  lea    edi, [edx+ecx]
  cmp    edi, ebx
  jle    @@Loop
@@NotFound:
  xor    eax, eax
  pop    edx
  jmp    @@Exit;
@@SetResult3:
  add    edx, 1
@@SetResult2:
  add    edx, 1
@@SetResult1:
  pop    ecx                   {@SourceString}
  neg    ecx
  lea    eax, [edx+ecx+1]
@@Exit:
  pop    edi
  pop    ebx
end;

function CharPosEY_JOH_PAS_3_a(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 2);
      end
end;

function CharPosEY_JOH_PAS_3_b(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 2);
      end
end;

function CharPosEY_JOH_PAS_3_c(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 2);
      end
end;

function CharPosEY_JOH_PAS_3_d(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 2);
      end
end;

{Can Read DWORD containing NULL Charatcer}
function CharPosEY_JOH_PAS_4_a(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[2] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+1 < PMax then {Within Valid Range}
                  Result := PStr + 3 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[3] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+2 < PMax then {Within Valid Range}
                  Result := PStr + 4 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 4);
      end
end;

function CharPosEY_JOH_PAS_4_b(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[2] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+1 < PMax then {Within Valid Range}
                  Result := PStr + 3 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[3] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+2 < PMax then {Within Valid Range}
                  Result := PStr + 4 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 4);
      end
end;

function CharPosEY_JOH_PAS_4_c(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[2] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+1 < PMax then {Within Valid Range}
                  Result := PStr + 3 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[3] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+2 < PMax then {Within Valid Range}
                  Result := PStr + 4 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 4);
      end
end;

function CharPosEY_JOH_PAS_4_d(const SearchCharacter : Char;
                             const SourceString : AnsiString;
                             Occurrence : Integer = 1;
                             StartPos   : Integer = 1): Integer;
var
  Count      : Integer;
  PStr, PMax : PChar;
begin
  Result := 0;
  if SourceString = '' then Exit;
  PStr := Pointer(SourceString);
  Dec(PStr);
{$IFDEF AllowLengthShortcut}
  PMax := PStr + PCardinal(Cardinal(SourceString) - 4)^; {Max Start Position}
{$ELSE}
  PMax := PStr + Length(SourceString); {Maximum Start Position}
{$ENDIF}
  Inc(PStr, StartPos);
  Count := Occurrence - 1;
  if (StartPos > 0) and (Count >= 0) then
    while PStr <= PMax do
      begin
        if PStr^ = SearchCharacter then
          begin
            if Count = 0 then
              begin
                Result := PStr + 1 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[1] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr < PMax then {Within Valid Range}
                  Result := PStr + 2 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[2] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+1 < PMax then {Within Valid Range}
                  Result := PStr + 3 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        if PStr[3] = SearchCharacter then
          begin
            if Count = 0 then
              begin
                if PStr+2 < PMax then {Within Valid Range}
                  Result := PStr + 4 - Pointer(SourceString);
                Exit;
              end;
            Dec(Count);
          end;
        Inc(PStr, 4);
      end
end;

{Does Not Read Past NULL Terminator}
function CharPosEY_JOH_IA32_3_A(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm  {81 Bytes}
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
  add    ebp, 2
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check1:
  sub    ecx,1
  jnz    @@Next
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jz     @@NotFound
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

function CharPosEY_JOH_IA32_3_b(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm  {81 Bytes}
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
  add    ebp, 2
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check1:
  sub    ecx,1
  jnz    @@Next
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jz     @@NotFound
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

function CharPosEY_JOH_IA32_3_c(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm  {81 Bytes}
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
  add    ebp, 2
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check1:
  sub    ecx,1
  jnz    @@Next
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jz     @@NotFound
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

function CharPosEY_JOH_IA32_3_d(const SearchCharacter : Char;
                              const SourceString : AnsiString;
                              Occurrence : Integer = 1;
                              StartPos   : Integer = 1): Integer;
asm  {81 Bytes}
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
  add    ebp, 2
  jl     @@Loop
@@NotFound:
  pop    ebx
@@NotFoundExit:
  xor    eax, eax
  jmp    @@Exit
@@Check1:
  sub    ecx,1
  jnz    @@Next
  jmp    @@SetResult
@@Check2:
  sub    ecx, 1
  jnz    @@Next2
  add    ebp, 1
  jz     @@NotFound
@@SetResult:
  lea    eax, [ebx+ebp+1]
  sub    eax, edx
  pop    ebx
@@Exit:
end;

{Can Read DWORD containing NULL Charatcer}
function CharPosEY_JOH_IA32_4_a(const SearchCharacter : Char;
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

function CharPosEY_JOH_IA32_4_b(const SearchCharacter : Char;
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

function CharPosEY_JOH_IA32_4_c(const SearchCharacter : Char;
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

function CharPosEY_JOH_IA32_4_d(const SearchCharacter : Char;
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

end.
