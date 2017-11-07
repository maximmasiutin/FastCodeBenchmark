unit PosExAZUnit;

interface

function PosEx_AZ_Pas_1_a(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_Pas_1_b(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_Pas_1_c(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_Pas_1_d(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_Pas_2_a(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_Pas_2_b(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_Pas_2_c(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_Pas_2_d(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_IA32_1_a(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_IA32_1_b(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_IA32_1_c(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_IA32_1_d(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_IA32_2_a(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_IA32_2_b(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_IA32_2_c(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_IA32_2_d(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_SSE_1_a(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_SSE_1_b(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_SSE_1_c(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_SSE_1_d(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_SSE2_1_a(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_SSE2_1_b(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_SSE2_1_c(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_AZ_SSE2_1_d(const SubStr, S: string; Offset: Integer = 1): Integer;

implementation

function PosEx_AZ_Pas_1_a(const SubStr, S: string; Offset: Integer = 1):Integer;
var
  FirstChar: Char;
  I, J, SearchCharCount: Integer;
  StringPChar: PChar;
label
  NextFirstChar;
begin
  Result := 0;
  if (Length(SubStr) = 0) or (Offset <= 0) then Exit;
  SearchCharCount := Length(S)-Length(SubStr)-Offset+2;
  if SearchCharCount <= 0 then Exit;

  FirstChar := SubStr[1];
  StringPChar := PChar(LongWord(S)+LongWord(Offset)-1);
  for I := SearchCharCount downto 1 do
  begin
    if StringPChar^ = FirstChar then
    begin
      for J := Length(SubStr) downto 2 do
        if SubStr[J] <> PChar(LongWord(StringPChar)+LongWord(J)-1)^ then
          goto NextFirstChar;
      Result := LongWord(StringPChar) - LongWord(S)+1;
      Exit;
    end;
NextFirstChar:
    Inc(StringPChar);
  end;
end;

procedure Filler1;
asm
 nop
end;

function PosEx_AZ_Pas_1_b(const SubStr, S: string; Offset: Integer = 1):Integer;
var
  FirstChar: Char;
  I, J, SearchCharCount: Integer;
  StringPChar: PChar;
label
  NextFirstChar;
begin
  Result := 0;
  if (Length(SubStr) = 0) or (Offset <= 0) then Exit;
  SearchCharCount := Length(S)-Length(SubStr)-Offset+2;
  if SearchCharCount <= 0 then Exit;

  FirstChar := SubStr[1];
  StringPChar := PChar(LongWord(S)+LongWord(Offset)-1);
  for I := SearchCharCount downto 1 do
  begin
    if StringPChar^ = FirstChar then
    begin
      for J := Length(SubStr) downto 2 do
        if SubStr[J] <> PChar(LongWord(StringPChar)+LongWord(J)-1)^ then
          goto NextFirstChar;
      Result := LongWord(StringPChar) - LongWord(S)+1;
      Exit;
    end;
NextFirstChar:
    Inc(StringPChar);
  end;
end;

procedure Filler2;
asm
 nop
end;

function PosEx_AZ_Pas_1_c(const SubStr, S: string; Offset: Integer = 1):Integer;
var
  FirstChar: Char;
  I, J, SearchCharCount: Integer;
  StringPChar: PChar;
label
  NextFirstChar;
begin
  Result := 0;
  if (Length(SubStr) = 0) or (Offset <= 0) then Exit;
  SearchCharCount := Length(S)-Length(SubStr)-Offset+2;
  if SearchCharCount <= 0 then Exit;

  FirstChar := SubStr[1];
  StringPChar := PChar(LongWord(S)+LongWord(Offset)-1);
  for I := SearchCharCount downto 1 do
  begin
    if StringPChar^ = FirstChar then
    begin
      for J := Length(SubStr) downto 2 do
        if SubStr[J] <> PChar(LongWord(StringPChar)+LongWord(J)-1)^ then
          goto NextFirstChar;
      Result := LongWord(StringPChar) - LongWord(S)+1;
      Exit;
    end;
NextFirstChar:
    Inc(StringPChar);
  end;
end;

procedure Filler3;
asm
 nop
end;


function PosEx_AZ_Pas_1_d(const SubStr, S: string; Offset: Integer = 1):Integer;
var
  FirstChar: Char;
  I, J, SearchCharCount: Integer;
  StringPChar: PChar;
label
  NextFirstChar;
begin
  Result := 0;
  if (Length(SubStr) = 0) or (Offset <= 0) then Exit;
  SearchCharCount := Length(S)-Length(SubStr)-Offset+2;
  if SearchCharCount <= 0 then Exit;

  FirstChar := SubStr[1];
  StringPChar := PChar(LongWord(S)+LongWord(Offset)-1);
  for I := SearchCharCount downto 1 do
  begin
    if StringPChar^ = FirstChar then
    begin
      for J := Length(SubStr) downto 2 do
        if SubStr[J] <> PChar(LongWord(StringPChar)+LongWord(J)-1)^ then
          goto NextFirstChar;
      Result := LongWord(StringPChar) - LongWord(S)+1;
      Exit;
    end;
NextFirstChar:
    Inc(StringPChar);
  end;
end;

{$RANGECHECKS OFF}
{$OVERFLOWCHECKS OFF}
{$BOOLEVAL OFF}

function PosEx_AZ_Pas_2_a(const SubStr, S: string; Offset: Integer = 1): Integer;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..0] of Byte;
var
  DWordCurr, FirstChar: LongWord;
  I: LongInt;
  LenS, LenSubStr, PntCurr, PntEnd: LongWord;
  WordCurr: Word;
label
  FindFirstChar, FindFirstCharAligned, FoundFirstChar, FoundFirstChar1,
  FoundFirstChar2, FoundFirstChar3;
begin
  if (Pointer(SubStr) = nil) or (Pointer(S) = nil) or (Offset <= 0) then
  begin
    Result := 0;
    Exit;
  end;

  PntCurr := LongWord(S) + LongWord(Offset-1);
  LenS := PLongWord(LongWord(S)-4)^;
  if LenS = 0 then
  begin
    Result := 0;
    Exit;
  end;
  LenSubStr := PLongWord(LongWord(SubStr)-4)^;
  if LenSubStr = 0 then
  begin
    Result := 0;
    Exit;
  end;
  PntEnd := LongWord(S) + LenS - LenSubStr+1;
  if PntCurr >= PntEnd then
  begin
    Result := 0;
    Exit;
  end;

  FirstChar := Byte(SubStr[1])*$01010101;

FindFirstChar:
  case PntCurr and 3 of
    0:
    begin
    FindFirstCharAligned:
      DWordCurr := PLongWord(PntCurr)^ xor FirstChar;
      if DWordCurr and $000000FF = 0 then goto FoundFirstChar;
      if DWordCurr and $0000FF00 = 0 then goto FoundFirstChar1;
      if DWordCurr and $00FF0000 = 0 then goto FoundFirstChar2;
      if DWordCurr and $FF000000 = 0 then goto FoundFirstChar3;
      PntCurr := PntCurr+4;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    1:
    begin
      DWordCurr := PLongWord(PntCurr-1)^ xor FirstChar;
      if DWordCurr and $0000FF00 = 0 then goto FoundFirstChar;
      if DWordCurr and $00FF0000 = 0 then goto FoundFirstChar1;
      if DWordCurr and $FF000000 = 0 then goto FoundFirstChar2;
      PntCurr := PntCurr+3;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    2:
    begin
      WordCurr := PWord(PntCurr)^ xor Word(FirstChar);
      if WordCurr and $00FF = 0 then goto FoundFirstChar;
      if WordCurr and $FF00 = 0 then goto FoundFirstChar1;
      PntCurr := PntCurr+2;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    3:
    begin
      if PByte(PntCurr)^ = Byte(FirstChar) then goto FoundFirstChar;
      Inc(PntCurr);
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;
  end;

  Result := 0;
  Exit;

FoundFirstChar3:
  PntCurr := PntCurr+3;
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar2:
  PntCurr := PntCurr+2;
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar1:
  Inc(PntCurr);
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar:
  for I := PLongInt(LongWord(SubStr)-4)^-1 downto 1 do
    if PByteArray(PntCurr)^[I] <> PByteArray(SubStr)^[I] then
    begin
      Inc(PntCurr);
      if PntCurr >= PntEnd then
      begin
        Result := 0;
        Exit;
      end
      else
        goto FindFirstChar;
    end;

  Result := PntCurr-LongWord(S)+1;
end;

function PosEx_AZ_Pas_2_b(const SubStr, S: string; Offset: Integer = 1): Integer;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..0] of Byte;
var
  DWordCurr, FirstChar: LongWord;
  I: LongInt;
  LenS, LenSubStr, PntCurr, PntEnd: LongWord;
  WordCurr: Word;
label
  FindFirstChar, FindFirstCharAligned, FoundFirstChar, FoundFirstChar1,
  FoundFirstChar2, FoundFirstChar3;
begin
  if (Pointer(SubStr) = nil) or (Pointer(S) = nil) or (Offset <= 0) then
  begin
    Result := 0;
    Exit;
  end;

  PntCurr := LongWord(S) + LongWord(Offset-1);
  LenS := PLongWord(LongWord(S)-4)^;
  if LenS = 0 then
  begin
    Result := 0;
    Exit;
  end;
  LenSubStr := PLongWord(LongWord(SubStr)-4)^;
  if LenSubStr = 0 then
  begin
    Result := 0;
    Exit;
  end;
  PntEnd := LongWord(S) + LenS - LenSubStr+1;
  if PntCurr >= PntEnd then
  begin
    Result := 0;
    Exit;
  end;

  FirstChar := Byte(SubStr[1])*$01010101;

FindFirstChar:
  case PntCurr and 3 of
    0:
    begin
    FindFirstCharAligned:
      DWordCurr := PLongWord(PntCurr)^ xor FirstChar;
      if DWordCurr and $000000FF = 0 then goto FoundFirstChar;
      if DWordCurr and $0000FF00 = 0 then goto FoundFirstChar1;
      if DWordCurr and $00FF0000 = 0 then goto FoundFirstChar2;
      if DWordCurr and $FF000000 = 0 then goto FoundFirstChar3;
      PntCurr := PntCurr+4;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    1:
    begin
      DWordCurr := PLongWord(PntCurr-1)^ xor FirstChar;
      if DWordCurr and $0000FF00 = 0 then goto FoundFirstChar;
      if DWordCurr and $00FF0000 = 0 then goto FoundFirstChar1;
      if DWordCurr and $FF000000 = 0 then goto FoundFirstChar2;
      PntCurr := PntCurr+3;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    2:
    begin
      WordCurr := PWord(PntCurr)^ xor Word(FirstChar);
      if WordCurr and $00FF = 0 then goto FoundFirstChar;
      if WordCurr and $FF00 = 0 then goto FoundFirstChar1;
      PntCurr := PntCurr+2;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    3:
    begin
      if PByte(PntCurr)^ = Byte(FirstChar) then goto FoundFirstChar;
      Inc(PntCurr);
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;
  end;

  Result := 0;
  Exit;

FoundFirstChar3:
  PntCurr := PntCurr+3;
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar2:
  PntCurr := PntCurr+2;
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar1:
  Inc(PntCurr);
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar:
  for I := PLongInt(LongWord(SubStr)-4)^-1 downto 1 do
    if PByteArray(PntCurr)^[I] <> PByteArray(SubStr)^[I] then
    begin
      Inc(PntCurr);
      if PntCurr >= PntEnd then
      begin
        Result := 0;
        Exit;
      end
      else
        goto FindFirstChar;
    end;

  Result := PntCurr-LongWord(S)+1;
end;

function PosEx_AZ_Pas_2_c(const SubStr, S: string; Offset: Integer = 1): Integer;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..0] of Byte;
var
  DWordCurr, FirstChar: LongWord;
  I: LongInt;
  LenS, LenSubStr, PntCurr, PntEnd: LongWord;
  WordCurr: Word;
label
  FindFirstChar, FindFirstCharAligned, FoundFirstChar, FoundFirstChar1,
  FoundFirstChar2, FoundFirstChar3;
begin
  if (Pointer(SubStr) = nil) or (Pointer(S) = nil) or (Offset <= 0) then
  begin
    Result := 0;
    Exit;
  end;

  PntCurr := LongWord(S) + LongWord(Offset-1);
  LenS := PLongWord(LongWord(S)-4)^;
  if LenS = 0 then
  begin
    Result := 0;
    Exit;
  end;
  LenSubStr := PLongWord(LongWord(SubStr)-4)^;
  if LenSubStr = 0 then
  begin
    Result := 0;
    Exit;
  end;
  PntEnd := LongWord(S) + LenS - LenSubStr+1;
  if PntCurr >= PntEnd then
  begin
    Result := 0;
    Exit;
  end;

  FirstChar := Byte(SubStr[1])*$01010101;

FindFirstChar:
  case PntCurr and 3 of
    0:
    begin
    FindFirstCharAligned:
      DWordCurr := PLongWord(PntCurr)^ xor FirstChar;
      if DWordCurr and $000000FF = 0 then goto FoundFirstChar;
      if DWordCurr and $0000FF00 = 0 then goto FoundFirstChar1;
      if DWordCurr and $00FF0000 = 0 then goto FoundFirstChar2;
      if DWordCurr and $FF000000 = 0 then goto FoundFirstChar3;
      PntCurr := PntCurr+4;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    1:
    begin
      DWordCurr := PLongWord(PntCurr-1)^ xor FirstChar;
      if DWordCurr and $0000FF00 = 0 then goto FoundFirstChar;
      if DWordCurr and $00FF0000 = 0 then goto FoundFirstChar1;
      if DWordCurr and $FF000000 = 0 then goto FoundFirstChar2;
      PntCurr := PntCurr+3;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    2:
    begin
      WordCurr := PWord(PntCurr)^ xor Word(FirstChar);
      if WordCurr and $00FF = 0 then goto FoundFirstChar;
      if WordCurr and $FF00 = 0 then goto FoundFirstChar1;
      PntCurr := PntCurr+2;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    3:
    begin
      if PByte(PntCurr)^ = Byte(FirstChar) then goto FoundFirstChar;
      Inc(PntCurr);
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;
  end;

  Result := 0;
  Exit;

FoundFirstChar3:
  PntCurr := PntCurr+3;
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar2:
  PntCurr := PntCurr+2;
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar1:
  Inc(PntCurr);
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar:
  for I := PLongInt(LongWord(SubStr)-4)^-1 downto 1 do
    if PByteArray(PntCurr)^[I] <> PByteArray(SubStr)^[I] then
    begin
      Inc(PntCurr);
      if PntCurr >= PntEnd then
      begin
        Result := 0;
        Exit;
      end
      else
        goto FindFirstChar;
    end;

  Result := PntCurr-LongWord(S)+1;
end;

function PosEx_AZ_Pas_2_d(const SubStr, S: string; Offset: Integer = 1): Integer;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..0] of Byte;
var
  DWordCurr, FirstChar: LongWord;
  I: LongInt;
  LenS, LenSubStr, PntCurr, PntEnd: LongWord;
  WordCurr: Word;
label
  FindFirstChar, FindFirstCharAligned, FoundFirstChar, FoundFirstChar1,
  FoundFirstChar2, FoundFirstChar3;
begin
  if (Pointer(SubStr) = nil) or (Pointer(S) = nil) or (Offset <= 0) then
  begin
    Result := 0;
    Exit;
  end;

  PntCurr := LongWord(S) + LongWord(Offset-1);
  LenS := PLongWord(LongWord(S)-4)^;
  if LenS = 0 then
  begin
    Result := 0;
    Exit;
  end;
  LenSubStr := PLongWord(LongWord(SubStr)-4)^;
  if LenSubStr = 0 then
  begin
    Result := 0;
    Exit;
  end;
  PntEnd := LongWord(S) + LenS - LenSubStr+1;
  if PntCurr >= PntEnd then
  begin
    Result := 0;
    Exit;
  end;

  FirstChar := Byte(SubStr[1])*$01010101;

FindFirstChar:
  case PntCurr and 3 of
    0:
    begin
    FindFirstCharAligned:
      DWordCurr := PLongWord(PntCurr)^ xor FirstChar;
      if DWordCurr and $000000FF = 0 then goto FoundFirstChar;
      if DWordCurr and $0000FF00 = 0 then goto FoundFirstChar1;
      if DWordCurr and $00FF0000 = 0 then goto FoundFirstChar2;
      if DWordCurr and $FF000000 = 0 then goto FoundFirstChar3;
      PntCurr := PntCurr+4;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    1:
    begin
      DWordCurr := PLongWord(PntCurr-1)^ xor FirstChar;
      if DWordCurr and $0000FF00 = 0 then goto FoundFirstChar;
      if DWordCurr and $00FF0000 = 0 then goto FoundFirstChar1;
      if DWordCurr and $FF000000 = 0 then goto FoundFirstChar2;
      PntCurr := PntCurr+3;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    2:
    begin
      WordCurr := PWord(PntCurr)^ xor Word(FirstChar);
      if WordCurr and $00FF = 0 then goto FoundFirstChar;
      if WordCurr and $FF00 = 0 then goto FoundFirstChar1;
      PntCurr := PntCurr+2;
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;

    3:
    begin
      if PByte(PntCurr)^ = Byte(FirstChar) then goto FoundFirstChar;
      Inc(PntCurr);
      if PntCurr < PntEnd then
        goto FindFirstCharAligned;
    end;
  end;

  Result := 0;
  Exit;

FoundFirstChar3:
  PntCurr := PntCurr+3;
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar2:
  PntCurr := PntCurr+2;
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar1:
  Inc(PntCurr);
  if PntCurr < PntEnd then goto FoundFirstChar;
  Result := 0;
  Exit;

FoundFirstChar:
  for I := PLongInt(LongWord(SubStr)-4)^-1 downto 1 do
    if PByteArray(PntCurr)^[I] <> PByteArray(SubStr)^[I] then
    begin
      Inc(PntCurr);
      if PntCurr >= PntEnd then
      begin
        Result := 0;
        Exit;
      end
      else
        goto FindFirstChar;
    end;

  Result := PntCurr-LongWord(S)+1;
end;

//{$RANGECHECKS DEFAULT} :-)

function PosEx_AZ_IA32_1_a(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   esi
  push   edi

  test   ecx,   ecx
  jz     @MatchNotFound
  test   eax,   edx
  jz     @ParamsPossiblyNil

@ParamsNotNil:
  mov    esi,   [edx-$04]
  test   esi,   esi
  lea    edi,   [edx+ecx-$01]
  jz     @MatchNotFound
  cmp    ecx,   esi
  ja     @MatchNotFound
  neg    ecx
  mov    ebx,   eax
  lea    ecx,   [ecx+esi+$02]
  mov    esi,   [eax-$04]
  test   esi,   esi
  mov    al,    [eax]
  jz     @MatchNotFound
  sub    ecx,   esi
  jle    @MatchNotFound

@FindFirstChar:
  repne  scasb
  jne    @MatchNotFound

@MatchSubStr:
  mov    esi,   [ebx-$04]
  sub    esi,   $01
  jz     @FoundSubStr

@MatchSubStrChar:
  mov    ah,    [ebx+esi]
  cmp    [edi+esi-$01], ah
  jne    @FindFirstChar
  sub    esi,   $01
  jnz    @MatchSubStrChar

@FoundSubStr:
  mov    eax,   edi
  sub    eax,   edx

  pop    edi
  pop    esi
  pop    ebx
  ret

@ParamsPossiblyNil:
  test   eax,   eax
  jz     @MatchNotFoundEaxZ
  test   edx,   edx
  jnz    @ParamsNotNil

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edi
  pop    esi
  pop    ebx
end;

procedure Filler4;
asm
 nop
end;

function PosEx_AZ_IA32_1_b(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   esi
  push   edi

  test   ecx,   ecx
  jz     @MatchNotFound
  test   eax,   edx
  jz     @ParamsPossiblyNil

@ParamsNotNil:
  mov    esi,   [edx-$04]
  test   esi,   esi
  lea    edi,   [edx+ecx-$01]
  jz     @MatchNotFound
  cmp    ecx,   esi
  ja     @MatchNotFound
  neg    ecx
  mov    ebx,   eax
  lea    ecx,   [ecx+esi+$02]
  mov    esi,   [eax-$04]
  test   esi,   esi
  mov    al,    [eax]
  jz     @MatchNotFound
  sub    ecx,   esi
  jle    @MatchNotFound

@FindFirstChar:
  repne  scasb
  jne    @MatchNotFound

@MatchSubStr:
  mov    esi,   [ebx-$04]
  sub    esi,   $01
  jz     @FoundSubStr

@MatchSubStrChar:
  mov    ah,    [ebx+esi]
  cmp    [edi+esi-$01], ah
  jne    @FindFirstChar
  sub    esi,   $01
  jnz    @MatchSubStrChar

@FoundSubStr:
  mov    eax,   edi
  sub    eax,   edx

  pop    edi
  pop    esi
  pop    ebx
  ret

@ParamsPossiblyNil:
  test   eax,   eax
  jz     @MatchNotFoundEaxZ
  test   edx,   edx
  jnz    @ParamsNotNil

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edi
  pop    esi
  pop    ebx
end;

procedure Filler5;
asm
 nop
end;

function PosEx_AZ_IA32_1_c(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   esi
  push   edi

  test   ecx,   ecx
  jz     @MatchNotFound
  test   eax,   edx
  jz     @ParamsPossiblyNil

@ParamsNotNil:
  mov    esi,   [edx-$04]
  test   esi,   esi
  lea    edi,   [edx+ecx-$01]
  jz     @MatchNotFound
  cmp    ecx,   esi
  ja     @MatchNotFound
  neg    ecx
  mov    ebx,   eax
  lea    ecx,   [ecx+esi+$02]
  mov    esi,   [eax-$04]
  test   esi,   esi
  mov    al,    [eax]
  jz     @MatchNotFound
  sub    ecx,   esi
  jle    @MatchNotFound

@FindFirstChar:
  repne  scasb
  jne    @MatchNotFound

@MatchSubStr:
  mov    esi,   [ebx-$04]
  sub    esi,   $01
  jz     @FoundSubStr

@MatchSubStrChar:
  mov    ah,    [ebx+esi]
  cmp    [edi+esi-$01], ah
  jne    @FindFirstChar
  sub    esi,   $01
  jnz    @MatchSubStrChar

@FoundSubStr:
  mov    eax,   edi
  sub    eax,   edx

  pop    edi
  pop    esi
  pop    ebx
  ret

@ParamsPossiblyNil:
  test   eax,   eax
  jz     @MatchNotFoundEaxZ
  test   edx,   edx
  jnz    @ParamsNotNil

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edi
  pop    esi
  pop    ebx
end;

procedure Filler6;
asm
 nop
end;

function PosEx_AZ_IA32_1_d(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   esi
  push   edi

  test   ecx,   ecx
  jz     @MatchNotFound
  test   eax,   edx
  jz     @ParamsPossiblyNil

@ParamsNotNil:
  mov    esi,   [edx-$04]
  test   esi,   esi
  lea    edi,   [edx+ecx-$01]
  jz     @MatchNotFound
  cmp    ecx,   esi
  ja     @MatchNotFound
  neg    ecx
  mov    ebx,   eax
  lea    ecx,   [ecx+esi+$02]
  mov    esi,   [eax-$04]
  test   esi,   esi
  mov    al,    [eax]
  jz     @MatchNotFound
  sub    ecx,   esi
  jle    @MatchNotFound

@FindFirstChar:
  repne  scasb
  jne    @MatchNotFound

@MatchSubStr:
  mov    esi,   [ebx-$04]
  sub    esi,   $01
  jz     @FoundSubStr

@MatchSubStrChar:
  mov    ah,    [ebx+esi]
  cmp    [edi+esi-$01], ah
  jne    @FindFirstChar
  sub    esi,   $01
  jnz    @MatchSubStrChar

@FoundSubStr:
  mov    eax,   edi
  sub    eax,   edx

  pop    edi
  pop    esi
  pop    ebx
  ret

@ParamsPossiblyNil:
  test   eax,   eax
  jz     @MatchNotFoundEaxZ
  test   edx,   edx
  jnz    @ParamsNotNil

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edi
  pop    esi
  pop    ebx
end;

function PosEx_AZ_IA32_2_a(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi

  test   eax,   edx
  jz     @ParamsPossiblyNil

@ParamsNotNil:
  test   ecx,   ecx
  mov    ebp,   [edx-$04]
  mov    esi,   [eax-$04]
  jz     @MatchNotFound
  xor    ebx,   ebx
  cmp    ecx,   ebp
  mov    bl,    [eax]
  ja     @MatchNotFound
  sub    ebp,   esi
  test   esi,   esi
  mov    bh,    bl
  lea    esi,   [ecx-2]
  mov    ecx,   ebx
  lea    edi,   [edx+ebp+1]
  jz     @MatchNotFound
  shl    ecx,   $10
  sub    esi,   ebp
  jge    @MatchNotFound
  or     ebx,   ecx

{ Current situation:
    - Length(SubStr) <> 0
    - S              <> nil
    - EAX            holds pointer to SubStr
    - EDX            holds pointer to S
    - EBX            holds SubStr[1]*$01010101
    - -ESI           holds number of first characters that are to be
tested (<> 0)
    - EDI+ESI        holds pointer to first byte to test }

@SearchFirstChar:
  lea    ecx,   [edi+esi]
  and    ecx,   $03
  jmp    dword ptr [@JumpTableAlignment+4*ecx]

@JumpTableAlignment:
  dd     @SearchFirstCharAligned
  dd     @SearchFirstCharAlignedPlus1
  dd     @SearchFirstCharAlignedPlus2
  dd     @SearchFirstCharAlignedPlus3

@FoundFirstChar:
  mov    ebp,   [eax-$04]
  sub    ebp,   $01
  jz     @MatchFound

  lea    ecx,   [edi+esi]

@FindOtherChar:
  mov    bl,    [ecx+ebp]
  cmp    [eax+ebp], bl
  jne    @SearchNextFirstChar
  sub    ebp,   $01
  jnz    @FindOtherChar

@MatchFound:
  lea    eax,   [edi+esi+1]
  sub    eax,   edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@SearchNextFirstChar:
  add    esi,   $01
  mov    bl,    bh
  jnc    @SearchFirstChar
  jmp    @MatchNotFound

@FoundFirstCharPos2:
  add    esi,   1
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@FoundFirstCharPos3:
  add    esi,   2
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@FoundFirstCharPos4:
  add    esi,   3
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@SearchFirstCharAligned:
  mov    ecx,   [edi+esi]
  xor    ecx,   ebx
  test   ecx,   $000000FF
  jz     @FoundFirstChar
  test   ecx,   $0000FF00
  jz     @FoundFirstCharPos2
  test   ecx,   $00FF0000
  jz     @FoundFirstCharPos3
  test   ecx,   $FF000000
  jz     @FoundFirstCharPos4
  add    esi,   4
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus1:
  mov    ecx,   [edi+esi-$01]
  xor    ecx,   ebx
  test   ecx,   $0000FF00
  jz     @FoundFirstChar
  test   ecx,   $00FF0000
  jz     @FoundFirstCharPos2
  test   ecx,   $FF000000
  jz     @FoundFirstCharPos3
  add    esi,   3
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus2:
  mov    cx,   [edi+esi]
  cmp    cl,   bl
  je     @FoundFirstChar
  cmp    ch,   bl
  jz     @FoundFirstCharPos2
  add    esi,   2
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus3:
  cmp    bl,   [edi+esi]
  je     @FoundFirstChar
  add    esi,   1
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@ParamsPossiblyNil:
  test   eax,   eax
  jz     @MatchNotFoundEaxZ
  test   edx,   edx
  jnz    @ParamsNotNil

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

procedure Filler7;
asm
 nop
end;

function PosEx_AZ_IA32_2_b(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi

  test   eax,   edx
  jz     @ParamsPossiblyNil

@ParamsNotNil:
  test   ecx,   ecx
  mov    ebp,   [edx-$04]
  mov    esi,   [eax-$04]
  jz     @MatchNotFound
  xor    ebx,   ebx
  cmp    ecx,   ebp
  mov    bl,    [eax]
  ja     @MatchNotFound
  sub    ebp,   esi
  test   esi,   esi
  mov    bh,    bl
  lea    esi,   [ecx-2]
  mov    ecx,   ebx
  lea    edi,   [edx+ebp+1]
  jz     @MatchNotFound
  shl    ecx,   $10
  sub    esi,   ebp
  jge    @MatchNotFound
  or     ebx,   ecx

{ Current situation:
    - Length(SubStr) <> 0
    - S              <> nil
    - EAX            holds pointer to SubStr
    - EDX            holds pointer to S
    - EBX            holds SubStr[1]*$01010101
    - -ESI           holds number of first characters that are to be
tested (<> 0)
    - EDI+ESI        holds pointer to first byte to test }

@SearchFirstChar:
  lea    ecx,   [edi+esi]
  and    ecx,   $03
  jmp    dword ptr [@JumpTableAlignment+4*ecx]

@JumpTableAlignment:
  dd     @SearchFirstCharAligned
  dd     @SearchFirstCharAlignedPlus1
  dd     @SearchFirstCharAlignedPlus2
  dd     @SearchFirstCharAlignedPlus3

@FoundFirstChar:
  mov    ebp,   [eax-$04]
  sub    ebp,   $01
  jz     @MatchFound

  lea    ecx,   [edi+esi]

@FindOtherChar:
  mov    bl,    [ecx+ebp]
  cmp    [eax+ebp], bl
  jne    @SearchNextFirstChar
  sub    ebp,   $01
  jnz    @FindOtherChar

@MatchFound:
  lea    eax,   [edi+esi+1]
  sub    eax,   edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@SearchNextFirstChar:
  add    esi,   $01
  mov    bl,    bh
  jnc    @SearchFirstChar
  jmp    @MatchNotFound

@FoundFirstCharPos2:
  add    esi,   1
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@FoundFirstCharPos3:
  add    esi,   2
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@FoundFirstCharPos4:
  add    esi,   3
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@SearchFirstCharAligned:
  mov    ecx,   [edi+esi]
  xor    ecx,   ebx
  test   ecx,   $000000FF
  jz     @FoundFirstChar
  test   ecx,   $0000FF00
  jz     @FoundFirstCharPos2
  test   ecx,   $00FF0000
  jz     @FoundFirstCharPos3
  test   ecx,   $FF000000
  jz     @FoundFirstCharPos4
  add    esi,   4
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus1:
  mov    ecx,   [edi+esi-$01]
  xor    ecx,   ebx
  test   ecx,   $0000FF00
  jz     @FoundFirstChar
  test   ecx,   $00FF0000
  jz     @FoundFirstCharPos2
  test   ecx,   $FF000000
  jz     @FoundFirstCharPos3
  add    esi,   3
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus2:
  mov    cx,   [edi+esi]
  cmp    cl,   bl
  je     @FoundFirstChar
  cmp    ch,   bl
  jz     @FoundFirstCharPos2
  add    esi,   2
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus3:
  cmp    bl,   [edi+esi]
  je     @FoundFirstChar
  add    esi,   1
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@ParamsPossiblyNil:
  test   eax,   eax
  jz     @MatchNotFoundEaxZ
  test   edx,   edx
  jnz    @ParamsNotNil

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

procedure Filler8;
asm
 nop
end;

function PosEx_AZ_IA32_2_c(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi

  test   eax,   edx
  jz     @ParamsPossiblyNil

@ParamsNotNil:
  test   ecx,   ecx
  mov    ebp,   [edx-$04]
  mov    esi,   [eax-$04]
  jz     @MatchNotFound
  xor    ebx,   ebx
  cmp    ecx,   ebp
  mov    bl,    [eax]
  ja     @MatchNotFound
  sub    ebp,   esi
  test   esi,   esi
  mov    bh,    bl
  lea    esi,   [ecx-2]
  mov    ecx,   ebx
  lea    edi,   [edx+ebp+1]
  jz     @MatchNotFound
  shl    ecx,   $10
  sub    esi,   ebp
  jge    @MatchNotFound
  or     ebx,   ecx

{ Current situation:
    - Length(SubStr) <> 0
    - S              <> nil
    - EAX            holds pointer to SubStr
    - EDX            holds pointer to S
    - EBX            holds SubStr[1]*$01010101
    - -ESI           holds number of first characters that are to be
tested (<> 0)
    - EDI+ESI        holds pointer to first byte to test }

@SearchFirstChar:
  lea    ecx,   [edi+esi]
  and    ecx,   $03
  jmp    dword ptr [@JumpTableAlignment+4*ecx]

@JumpTableAlignment:
  dd     @SearchFirstCharAligned
  dd     @SearchFirstCharAlignedPlus1
  dd     @SearchFirstCharAlignedPlus2
  dd     @SearchFirstCharAlignedPlus3

@FoundFirstChar:
  mov    ebp,   [eax-$04]
  sub    ebp,   $01
  jz     @MatchFound

  lea    ecx,   [edi+esi]

@FindOtherChar:
  mov    bl,    [ecx+ebp]
  cmp    [eax+ebp], bl
  jne    @SearchNextFirstChar
  sub    ebp,   $01
  jnz    @FindOtherChar

@MatchFound:
  lea    eax,   [edi+esi+1]
  sub    eax,   edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@SearchNextFirstChar:
  add    esi,   $01
  mov    bl,    bh
  jnc    @SearchFirstChar
  jmp    @MatchNotFound

@FoundFirstCharPos2:
  add    esi,   1
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@FoundFirstCharPos3:
  add    esi,   2
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@FoundFirstCharPos4:
  add    esi,   3
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@SearchFirstCharAligned:
  mov    ecx,   [edi+esi]
  xor    ecx,   ebx
  test   ecx,   $000000FF
  jz     @FoundFirstChar
  test   ecx,   $0000FF00
  jz     @FoundFirstCharPos2
  test   ecx,   $00FF0000
  jz     @FoundFirstCharPos3
  test   ecx,   $FF000000
  jz     @FoundFirstCharPos4
  add    esi,   4
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus1:
  mov    ecx,   [edi+esi-$01]
  xor    ecx,   ebx
  test   ecx,   $0000FF00
  jz     @FoundFirstChar
  test   ecx,   $00FF0000
  jz     @FoundFirstCharPos2
  test   ecx,   $FF000000
  jz     @FoundFirstCharPos3
  add    esi,   3
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus2:
  mov    cx,   [edi+esi]
  cmp    cl,   bl
  je     @FoundFirstChar
  cmp    ch,   bl
  jz     @FoundFirstCharPos2
  add    esi,   2
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus3:
  cmp    bl,   [edi+esi]
  je     @FoundFirstChar
  add    esi,   1
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@ParamsPossiblyNil:
  test   eax,   eax
  jz     @MatchNotFoundEaxZ
  test   edx,   edx
  jnz    @ParamsNotNil

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

procedure Filler9;
asm
 nop
end;

function PosEx_AZ_IA32_2_d(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi

  test   eax,   edx
  jz     @ParamsPossiblyNil

@ParamsNotNil:
  test   ecx,   ecx
  mov    ebp,   [edx-$04]
  mov    esi,   [eax-$04]
  jz     @MatchNotFound
  xor    ebx,   ebx
  cmp    ecx,   ebp
  mov    bl,    [eax]
  ja     @MatchNotFound
  sub    ebp,   esi
  test   esi,   esi
  mov    bh,    bl
  lea    esi,   [ecx-2]
  mov    ecx,   ebx
  lea    edi,   [edx+ebp+1]
  jz     @MatchNotFound
  shl    ecx,   $10
  sub    esi,   ebp
  jge    @MatchNotFound
  or     ebx,   ecx

{ Current situation:
    - Length(SubStr) <> 0
    - S              <> nil
    - EAX            holds pointer to SubStr
    - EDX            holds pointer to S
    - EBX            holds SubStr[1]*$01010101
    - -ESI           holds number of first characters that are to be
tested (<> 0)
    - EDI+ESI        holds pointer to first byte to test }

@SearchFirstChar:
  lea    ecx,   [edi+esi]
  and    ecx,   $03
  jmp    dword ptr [@JumpTableAlignment+4*ecx]

@JumpTableAlignment:
  dd     @SearchFirstCharAligned
  dd     @SearchFirstCharAlignedPlus1
  dd     @SearchFirstCharAlignedPlus2
  dd     @SearchFirstCharAlignedPlus3

@FoundFirstChar:
  mov    ebp,   [eax-$04]
  sub    ebp,   $01
  jz     @MatchFound

  lea    ecx,   [edi+esi]

@FindOtherChar:
  mov    bl,    [ecx+ebp]
  cmp    [eax+ebp], bl
  jne    @SearchNextFirstChar
  sub    ebp,   $01
  jnz    @FindOtherChar

@MatchFound:
  lea    eax,   [edi+esi+1]
  sub    eax,   edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@SearchNextFirstChar:
  add    esi,   $01
  mov    bl,    bh
  jnc    @SearchFirstChar
  jmp    @MatchNotFound

@FoundFirstCharPos2:
  add    esi,   1
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@FoundFirstCharPos3:
  add    esi,   2
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@FoundFirstCharPos4:
  add    esi,   3
  jc     @MatchNotFound
  jmp    @FoundFirstChar

@SearchFirstCharAligned:
  mov    ecx,   [edi+esi]
  xor    ecx,   ebx
  test   ecx,   $000000FF
  jz     @FoundFirstChar
  test   ecx,   $0000FF00
  jz     @FoundFirstCharPos2
  test   ecx,   $00FF0000
  jz     @FoundFirstCharPos3
  test   ecx,   $FF000000
  jz     @FoundFirstCharPos4
  add    esi,   4
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus1:
  mov    ecx,   [edi+esi-$01]
  xor    ecx,   ebx
  test   ecx,   $0000FF00
  jz     @FoundFirstChar
  test   ecx,   $00FF0000
  jz     @FoundFirstCharPos2
  test   ecx,   $FF000000
  jz     @FoundFirstCharPos3
  add    esi,   3
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus2:
  mov    cx,   [edi+esi]
  cmp    cl,   bl
  je     @FoundFirstChar
  cmp    ch,   bl
  jz     @FoundFirstCharPos2
  add    esi,   2
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@SearchFirstCharAlignedPlus3:
  cmp    bl,   [edi+esi]
  je     @FoundFirstChar
  add    esi,   1
  jnc    @SearchFirstCharAligned
  jmp    @MatchNotFound

@ParamsPossiblyNil:
  test   eax,   eax
  jz     @MatchNotFoundEaxZ
  test   edx,   edx
  jnz    @ParamsNotNil

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

function PosEx_AZ_SSE_1_a(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi
  push   edx

  test   edx,   edx
  jz     @MatchNotFound
  test   eax,   eax
  mov    edi,   [edx-$04]
  jz     @MatchNotFoundEaxZ
  test   ecx,   ecx
  mov    esi,   [eax-$04]
  jz     @MatchNotFound
  cmp    ecx,   edi
  mov    bl,    [eax]
  lea    ebp,   [edx+edi+$01]
  ja     @MatchNotFound
  test   esi,   esi
  mov    bh,    bl
  lea    edx,   [edx+ecx-$01]
  jz     @MatchNotFound
  test   edi,   edi
  movd   mm0,   ebx
  mov    ecx,   edx
  jz     @MatchNotFound
  and    edx,   $FFFFFFF8
  pshufw mm0,   mm0,   $00
  sub    ebp,   esi
  and    ecx,   $07
  movq   mm1,   [edx]
  pcmpeqb mm1,  mm0
  pmovmskb esi, mm1

@MatchFirstCharPart:
  mov    ebx,   esi
  shr    ebx,   cl
  test   ebx,   ebx // SHR doesn't set ZF if CL = 0
  jz     @MatchFirstChar
  bsf    ebx,   ebx
  add    ecx,   ebx
  jmp    @FindOtherChars

@MatchFirstChar:
  add    edx,   8
  cmp    edx,   ebp
  jae    @MatchNotFoundEmms
  movq   mm1,   [edx]
  pcmpeqb mm1,  mm0
  pmovmskb esi, mm1
  test   esi,   esi
  jz     @MatchFirstChar

  bsf    ecx,   esi

@FindOtherChars:
  add    edx,   ecx
  cmp    edx,   ebp
  mov    edi,   [eax-$04]
  jae    @MatchNotFoundEmms
  sub    edi,   $01
  jz     @FoundOtherChars

@FindOtherCharsLoop:
  mov    bl,    [eax+edi]
  cmp    bl,    [edx+edi]
  jne    @FindOtherCharsFailed
  sub    edi,   $01
  jnz    @FindOtherCharsLoop

@FoundOtherChars:
  lea    eax,   [edx+$01]
  sub    eax,   [esp]
  emms
  add    esp,   $04
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@FindOtherCharsFailed:
  sub    edx,   ecx
  cmp    ecx,   $07
  je     @MatchFirstChar
  add    ecx,   $01
  jmp    @MatchFirstCharPart

@MatchNotFoundEmms:
  emms
@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

procedure Filler10;
asm
 nop
end;

function PosEx_AZ_SSE_1_b(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi
  push   edx

  test   edx,   edx
  jz     @MatchNotFound
  test   eax,   eax
  mov    edi,   [edx-$04]
  jz     @MatchNotFoundEaxZ
  test   ecx,   ecx
  mov    esi,   [eax-$04]
  jz     @MatchNotFound
  cmp    ecx,   edi
  mov    bl,    [eax]
  lea    ebp,   [edx+edi+$01]
  ja     @MatchNotFound
  test   esi,   esi
  mov    bh,    bl
  lea    edx,   [edx+ecx-$01]
  jz     @MatchNotFound
  test   edi,   edi
  movd   mm0,   ebx
  mov    ecx,   edx
  jz     @MatchNotFound
  and    edx,   $FFFFFFF8
  pshufw mm0,   mm0,   $00
  sub    ebp,   esi
  and    ecx,   $07
  movq   mm1,   [edx]
  pcmpeqb mm1,  mm0
  pmovmskb esi, mm1

@MatchFirstCharPart:
  mov    ebx,   esi
  shr    ebx,   cl
  test   ebx,   ebx // SHR doesn't set ZF if CL = 0
  jz     @MatchFirstChar
  bsf    ebx,   ebx
  add    ecx,   ebx
  jmp    @FindOtherChars

@MatchFirstChar:
  add    edx,   8
  cmp    edx,   ebp
  jae    @MatchNotFoundEmms
  movq   mm1,   [edx]
  pcmpeqb mm1,  mm0
  pmovmskb esi, mm1
  test   esi,   esi
  jz     @MatchFirstChar

  bsf    ecx,   esi

@FindOtherChars:
  add    edx,   ecx
  cmp    edx,   ebp
  mov    edi,   [eax-$04]
  jae    @MatchNotFoundEmms
  sub    edi,   $01
  jz     @FoundOtherChars

@FindOtherCharsLoop:
  mov    bl,    [eax+edi]
  cmp    bl,    [edx+edi]
  jne    @FindOtherCharsFailed
  sub    edi,   $01
  jnz    @FindOtherCharsLoop

@FoundOtherChars:
  lea    eax,   [edx+$01]
  sub    eax,   [esp]
  emms
  add    esp,   $04
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@FindOtherCharsFailed:
  sub    edx,   ecx
  cmp    ecx,   $07
  je     @MatchFirstChar
  add    ecx,   $01
  jmp    @MatchFirstCharPart

@MatchNotFoundEmms:
  emms
@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

procedure Filler11;
asm
 nop
end;

function PosEx_AZ_SSE_1_c(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi
  push   edx

  test   edx,   edx
  jz     @MatchNotFound
  test   eax,   eax
  mov    edi,   [edx-$04]
  jz     @MatchNotFoundEaxZ
  test   ecx,   ecx
  mov    esi,   [eax-$04]
  jz     @MatchNotFound
  cmp    ecx,   edi
  mov    bl,    [eax]
  lea    ebp,   [edx+edi+$01]
  ja     @MatchNotFound
  test   esi,   esi
  mov    bh,    bl
  lea    edx,   [edx+ecx-$01]
  jz     @MatchNotFound
  test   edi,   edi
  movd   mm0,   ebx
  mov    ecx,   edx
  jz     @MatchNotFound
  and    edx,   $FFFFFFF8
  pshufw mm0,   mm0,   $00
  sub    ebp,   esi
  and    ecx,   $07
  movq   mm1,   [edx]
  pcmpeqb mm1,  mm0
  pmovmskb esi, mm1

@MatchFirstCharPart:
  mov    ebx,   esi
  shr    ebx,   cl
  test   ebx,   ebx // SHR doesn't set ZF if CL = 0
  jz     @MatchFirstChar
  bsf    ebx,   ebx
  add    ecx,   ebx
  jmp    @FindOtherChars

@MatchFirstChar:
  add    edx,   8
  cmp    edx,   ebp
  jae    @MatchNotFoundEmms
  movq   mm1,   [edx]
  pcmpeqb mm1,  mm0
  pmovmskb esi, mm1
  test   esi,   esi
  jz     @MatchFirstChar

  bsf    ecx,   esi

@FindOtherChars:
  add    edx,   ecx
  cmp    edx,   ebp
  mov    edi,   [eax-$04]
  jae    @MatchNotFoundEmms
  sub    edi,   $01
  jz     @FoundOtherChars

@FindOtherCharsLoop:
  mov    bl,    [eax+edi]
  cmp    bl,    [edx+edi]
  jne    @FindOtherCharsFailed
  sub    edi,   $01
  jnz    @FindOtherCharsLoop

@FoundOtherChars:
  lea    eax,   [edx+$01]
  sub    eax,   [esp]
  emms
  add    esp,   $04
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@FindOtherCharsFailed:
  sub    edx,   ecx
  cmp    ecx,   $07
  je     @MatchFirstChar
  add    ecx,   $01
  jmp    @MatchFirstCharPart

@MatchNotFoundEmms:
  emms
@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

procedure Filler12;
asm
 nop
end;

function PosEx_AZ_SSE_1_d(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi
  push   edx

  test   edx,   edx
  jz     @MatchNotFound
  test   eax,   eax
  mov    edi,   [edx-$04]
  jz     @MatchNotFoundEaxZ
  test   ecx,   ecx
  mov    esi,   [eax-$04]
  jz     @MatchNotFound
  cmp    ecx,   edi
  mov    bl,    [eax]
  lea    ebp,   [edx+edi+$01]
  ja     @MatchNotFound
  test   esi,   esi
  mov    bh,    bl
  lea    edx,   [edx+ecx-$01]
  jz     @MatchNotFound
  test   edi,   edi
  movd   mm0,   ebx
  mov    ecx,   edx
  jz     @MatchNotFound
  and    edx,   $FFFFFFF8
  pshufw mm0,   mm0,   $00
  sub    ebp,   esi
  and    ecx,   $07
  movq   mm1,   [edx]
  pcmpeqb mm1,  mm0
  pmovmskb esi, mm1

@MatchFirstCharPart:
  mov    ebx,   esi
  shr    ebx,   cl
  test   ebx,   ebx // SHR doesn't set ZF if CL = 0
  jz     @MatchFirstChar
  bsf    ebx,   ebx
  add    ecx,   ebx
  jmp    @FindOtherChars

@MatchFirstChar:
  add    edx,   8
  cmp    edx,   ebp
  jae    @MatchNotFoundEmms
  movq   mm1,   [edx]
  pcmpeqb mm1,  mm0
  pmovmskb esi, mm1
  test   esi,   esi
  jz     @MatchFirstChar

  bsf    ecx,   esi

@FindOtherChars:
  add    edx,   ecx
  cmp    edx,   ebp
  mov    edi,   [eax-$04]
  jae    @MatchNotFoundEmms
  sub    edi,   $01
  jz     @FoundOtherChars

@FindOtherCharsLoop:
  mov    bl,    [eax+edi]
  cmp    bl,    [edx+edi]
  jne    @FindOtherCharsFailed
  sub    edi,   $01
  jnz    @FindOtherCharsLoop

@FoundOtherChars:
  lea    eax,   [edx+$01]
  sub    eax,   [esp]
  emms
  add    esp,   $04
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@FindOtherCharsFailed:
  sub    edx,   ecx
  cmp    ecx,   $07
  je     @MatchFirstChar
  add    ecx,   $01
  jmp    @MatchFirstCharPart

@MatchNotFoundEmms:
  emms
@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

function PosEx_AZ_SSE2_1_a(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi
  push   edx

  test   edx,   edx
  jz     @MatchNotFound
  xor    ebx,   ebx
  test   eax,   eax
  mov    edi,   [edx-$04]
  jz     @MatchNotFoundEaxZ
  mov    bl,    [eax]
  mov    bh,    bl
  test   ecx,   ecx
  mov    esi,   [eax-$04]
  mov    ebp,   ebx
  jz     @MatchNotFound
  shl    ebp,   16
  or     ebx,   ebp
  cmp    ecx,   edi
  lea    ebp,   [edx+edi+$01]
  ja     @MatchNotFound
  test   esi,   esi

  lea    edx,   [edx+ecx-$01]
  jz     @MatchNotFound
  test   edi,   edi
  movd   xmm0,  ebx
  mov    ecx,   edx
  jz     @MatchNotFound
  and    edx,   $FFFFFFF0
  pshufd xmm0,  xmm0,   $00
  sub    ebp,   esi
  and    ecx,   $0F
  movdqa xmm1,  [edx]
  pcmpeqb xmm1, xmm0
  pmovmskb esi, xmm1

@MatchFirstCharPart:
  mov    ebx,   esi
  shr    ebx,   cl
  test   ebx,   ebx // SHR doesn't set ZF if CL = 0
  jz     @MatchFirstChar
  bsf    ebx,   ebx
  add    ecx,   ebx
  jmp    @FindOtherChars

@MatchFirstChar:
  add    edx,   16
  cmp    edx,   ebp
  jae    @MatchNotFound
  movdqa xmm1,  [edx]
  pcmpeqb xmm1, xmm0
  pmovmskb esi, xmm1
  test   esi,   esi
  jz     @MatchFirstChar

  bsf    ecx,   esi

@FindOtherChars:
  add    edx,   ecx
  cmp    edx,   ebp
  mov    edi,   [eax-$04]
  jae    @MatchNotFound
  sub    edi,   $01
  jz     @FoundOtherChars

@FindOtherCharsLoop:
  mov    bl,    [eax+edi]
  cmp    bl,    [edx+edi]
  jne    @FindOtherCharsFailed
  sub    edi,   $01
  jnz    @FindOtherCharsLoop

@FoundOtherChars:
  lea    eax,   [edx+$01]
  sub    eax,   [esp]
  add    esp,   $04
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@FindOtherCharsFailed:
  sub    edx,   ecx
  cmp    ecx,   $0F
  je     @MatchFirstChar
  add    ecx,   $01
  jmp    @MatchFirstCharPart

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

function PosEx_AZ_SSE2_1_b(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi
  push   edx

  test   edx,   edx
  jz     @MatchNotFound
  xor    ebx,   ebx
  test   eax,   eax
  mov    edi,   [edx-$04]
  jz     @MatchNotFoundEaxZ
  mov    bl,    [eax]
  mov    bh,    bl
  test   ecx,   ecx
  mov    esi,   [eax-$04]
  mov    ebp,   ebx
  jz     @MatchNotFound
  shl    ebp,   16
  or     ebx,   ebp
  cmp    ecx,   edi
  lea    ebp,   [edx+edi+$01]
  ja     @MatchNotFound
  test   esi,   esi

  lea    edx,   [edx+ecx-$01]
  jz     @MatchNotFound
  test   edi,   edi
  movd   xmm0,  ebx
  mov    ecx,   edx
  jz     @MatchNotFound
  and    edx,   $FFFFFFF0
  pshufd xmm0,  xmm0,   $00
  sub    ebp,   esi
  and    ecx,   $0F
  movdqa xmm1,  [edx]
  pcmpeqb xmm1, xmm0
  pmovmskb esi, xmm1

@MatchFirstCharPart:
  mov    ebx,   esi
  shr    ebx,   cl
  test   ebx,   ebx // SHR doesn't set ZF if CL = 0
  jz     @MatchFirstChar
  bsf    ebx,   ebx
  add    ecx,   ebx
  jmp    @FindOtherChars

@MatchFirstChar:
  add    edx,   16
  cmp    edx,   ebp
  jae    @MatchNotFound
  movdqa xmm1,  [edx]
  pcmpeqb xmm1, xmm0
  pmovmskb esi, xmm1
  test   esi,   esi
  jz     @MatchFirstChar

  bsf    ecx,   esi

@FindOtherChars:
  add    edx,   ecx
  cmp    edx,   ebp
  mov    edi,   [eax-$04]
  jae    @MatchNotFound
  sub    edi,   $01
  jz     @FoundOtherChars

@FindOtherCharsLoop:
  mov    bl,    [eax+edi]
  cmp    bl,    [edx+edi]
  jne    @FindOtherCharsFailed
  sub    edi,   $01
  jnz    @FindOtherCharsLoop

@FoundOtherChars:
  lea    eax,   [edx+$01]
  sub    eax,   [esp]
  add    esp,   $04
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@FindOtherCharsFailed:
  sub    edx,   ecx
  cmp    ecx,   $0F
  je     @MatchFirstChar
  add    ecx,   $01
  jmp    @MatchFirstCharPart

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

function PosEx_AZ_SSE2_1_c(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi
  push   edx

  test   edx,   edx
  jz     @MatchNotFound
  xor    ebx,   ebx
  test   eax,   eax
  mov    edi,   [edx-$04]
  jz     @MatchNotFoundEaxZ
  mov    bl,    [eax]
  mov    bh,    bl
  test   ecx,   ecx
  mov    esi,   [eax-$04]
  mov    ebp,   ebx
  jz     @MatchNotFound
  shl    ebp,   16
  or     ebx,   ebp
  cmp    ecx,   edi
  lea    ebp,   [edx+edi+$01]
  ja     @MatchNotFound
  test   esi,   esi

  lea    edx,   [edx+ecx-$01]
  jz     @MatchNotFound
  test   edi,   edi
  movd   xmm0,  ebx
  mov    ecx,   edx
  jz     @MatchNotFound
  and    edx,   $FFFFFFF0
  pshufd xmm0,  xmm0,   $00
  sub    ebp,   esi
  and    ecx,   $0F
  movdqa xmm1,  [edx]
  pcmpeqb xmm1, xmm0
  pmovmskb esi, xmm1

@MatchFirstCharPart:
  mov    ebx,   esi
  shr    ebx,   cl
  test   ebx,   ebx // SHR doesn't set ZF if CL = 0
  jz     @MatchFirstChar
  bsf    ebx,   ebx
  add    ecx,   ebx
  jmp    @FindOtherChars

@MatchFirstChar:
  add    edx,   16
  cmp    edx,   ebp
  jae    @MatchNotFound
  movdqa xmm1,  [edx]
  pcmpeqb xmm1, xmm0
  pmovmskb esi, xmm1
  test   esi,   esi
  jz     @MatchFirstChar

  bsf    ecx,   esi

@FindOtherChars:
  add    edx,   ecx
  cmp    edx,   ebp
  mov    edi,   [eax-$04]
  jae    @MatchNotFound
  sub    edi,   $01
  jz     @FoundOtherChars

@FindOtherCharsLoop:
  mov    bl,    [eax+edi]
  cmp    bl,    [edx+edi]
  jne    @FindOtherCharsFailed
  sub    edi,   $01
  jnz    @FindOtherCharsLoop

@FoundOtherChars:
  lea    eax,   [edx+$01]
  sub    eax,   [esp]
  add    esp,   $04
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@FindOtherCharsFailed:
  sub    edx,   ecx
  cmp    ecx,   $0F
  je     @MatchFirstChar
  add    ecx,   $01
  jmp    @MatchFirstCharPart

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
end;

function PosEx_AZ_SSE2_1_d(const SubStr, S: string; Offset: Integer = 1): Integer;
asm
  push   ebx
  push   ebp
  push   esi
  push   edi
  push   edx

  test   edx,   edx
  jz     @MatchNotFound
  xor    ebx,   ebx
  test   eax,   eax
  mov    edi,   [edx-$04]
  jz     @MatchNotFoundEaxZ
  mov    bl,    [eax]
  mov    bh,    bl
  test   ecx,   ecx
  mov    esi,   [eax-$04]
  mov    ebp,   ebx
  jz     @MatchNotFound
  shl    ebp,   16
  or     ebx,   ebp
  cmp    ecx,   edi
  lea    ebp,   [edx+edi+$01]
  ja     @MatchNotFound
  test   esi,   esi

  lea    edx,   [edx+ecx-$01]
  jz     @MatchNotFound
  test   edi,   edi
  movd   xmm0,  ebx
  mov    ecx,   edx
  jz     @MatchNotFound
  and    edx,   $FFFFFFF0
  pshufd xmm0,  xmm0,   $00
  sub    ebp,   esi
  and    ecx,   $0F
  movdqa xmm1,  [edx]
  pcmpeqb xmm1, xmm0
  pmovmskb esi, xmm1

@MatchFirstCharPart:
  mov    ebx,   esi
  shr    ebx,   cl
  test   ebx,   ebx // SHR doesn't set ZF if CL = 0
  jz     @MatchFirstChar
  bsf    ebx,   ebx
  add    ecx,   ebx
  jmp    @FindOtherChars

@MatchFirstChar:
  add    edx,   16
  cmp    edx,   ebp
  jae    @MatchNotFound
  movdqa xmm1,  [edx]
  pcmpeqb xmm1, xmm0
  pmovmskb esi, xmm1
  test   esi,   esi
  jz     @MatchFirstChar

  bsf    ecx,   esi

@FindOtherChars:
  add    edx,   ecx
  cmp    edx,   ebp
  mov    edi,   [eax-$04]
  jae    @MatchNotFound
  sub    edi,   $01
  jz     @FoundOtherChars

@FindOtherCharsLoop:
  mov    bl,    [eax+edi]
  cmp    bl,    [edx+edi]
  jne    @FindOtherCharsFailed
  sub    edi,   $01
  jnz    @FindOtherCharsLoop

@FoundOtherChars:
  lea    eax,   [edx+$01]
  sub    eax,   [esp]
  add    esp,   $04
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
  ret

@FindOtherCharsFailed:
  sub    edx,   ecx
  cmp    ecx,   $0F
  je     @MatchFirstChar
  add    ecx,   $01
  jmp    @MatchFirstCharPart

@MatchNotFound:
  xor    eax,   eax
@MatchNotFoundEaxZ:
  pop    edx
  pop    edi
  pop    esi
  pop    ebp
  pop    ebx
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
 Filler11;
 Filler12;

end.
