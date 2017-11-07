unit CharPosEYSHAUnit;

interface

function CharPosEY_Sha_Pas_1_a(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_1_b(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_1_c(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_1_d(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_2_a(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_2_b(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_2_c(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_2_d(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_3_a(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_3_b(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_3_c(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Pas_3_d(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Asm_1_a(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Asm_1_b(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Asm_1_c(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
function CharPosEY_Sha_Asm_1_d(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;

implementation

function CharPosEY_Sha_Pas_1_a(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
var
  Len: integer;
begin;
  Len:=Length(SourceString);
  Result:=StartPos;
  if (Occurrence>0) and (Result>0) and (Result<=Len) then repeat;
    if SourceString[Result]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then exit;
      end;
    inc(Result);
    until cardinal(Result)>cardinal(Len);
  Result:=0;
  end;

function CharPosEY_Sha_Pas_1_b(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
var
  Len: integer;
begin;
  Len:=Length(SourceString);
  Result:=StartPos;
  if (Occurrence>0) and (Result>0) and (Result<=Len) then repeat;
    if SourceString[Result]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then exit;
      end;
    inc(Result);
    until cardinal(Result)>cardinal(Len);
  Result:=0;
  end;

function CharPosEY_Sha_Pas_1_c(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
var
  Len: integer;
begin;
  Len:=Length(SourceString);
  Result:=StartPos;
  if (Occurrence>0) and (Result>0) and (Result<=Len) then repeat;
    if SourceString[Result]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then exit;
      end;
    inc(Result);
    until cardinal(Result)>cardinal(Len);
  Result:=0;
  end;

function CharPosEY_Sha_Pas_1_d(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
var
  Len: integer;
begin;
  Len:=Length(SourceString);
  Result:=StartPos;
  if (Occurrence>0) and (Result>0) and (Result<=Len) then repeat;
    if SourceString[Result]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then exit;
      end;
    inc(Result);
    until cardinal(Result)>cardinal(Len);
  Result:=0;
  end;

  {$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CharPosEY_Sha_Pas_2_a(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
var
  Len: integer;
begin;
  Len:=Length(SourceString);
  Result:=StartPos;
  if (Occurrence>0) and (Result>0) and (Result<=Len) then repeat;
    if SourceString[Result]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then exit;
      end;
    if SourceString[Result+1]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then begin;
        if Result>=Len then break;
        inc(Result);
        exit;
        end;
      end;
    Result:=Result+2;
    until cardinal(Result)>cardinal(Len);
  Result:=0;
  end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CharPosEY_Sha_Pas_2_b(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
var
  Len: integer;
begin;
  Len:=Length(SourceString);
  Result:=StartPos;
  if (Occurrence>0) and (Result>0) and (Result<=Len) then repeat;
    if SourceString[Result]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then exit;
      end;
    if SourceString[Result+1]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then begin;
        if Result>=Len then break;
        inc(Result);
        exit;
        end;
      end;
    Result:=Result+2;
    until cardinal(Result)>cardinal(Len);
  Result:=0;
  end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CharPosEY_Sha_Pas_2_c(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
var
  Len: integer;
begin;
  Len:=Length(SourceString);
  Result:=StartPos;
  if (Occurrence>0) and (Result>0) and (Result<=Len) then repeat;
    if SourceString[Result]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then exit;
      end;
    if SourceString[Result+1]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then begin;
        if Result>=Len then break;
        inc(Result);
        exit;
        end;
      end;
    Result:=Result+2;
    until cardinal(Result)>cardinal(Len);
  Result:=0;
  end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CharPosEY_Sha_Pas_2_d(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
var
  Len: integer;
begin;
  Len:=Length(SourceString);
  Result:=StartPos;
  if (Occurrence>0) and (Result>0) and (Result<=Len) then repeat;
    if SourceString[Result]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then exit;
      end;
    if SourceString[Result+1]=SearchCharacter then begin;
      dec(Occurrence);
      if Occurrence<=0 then begin;
        if Result>=Len then break;
        inc(Result);
        exit;
        end;
      end;
    Result:=Result+2;
    until cardinal(Result)>cardinal(Len);
  Result:=0;
  end;
{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CharPosEY_Sha_Pas_3_a(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
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

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CharPosEY_Sha_Pas_3_b(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
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

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CharPosEY_Sha_Pas_3_c(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
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

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
function CharPosEY_Sha_Pas_3_d(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
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

function CharPosEY_Sha_Asm_1_a(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
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

function CharPosEY_Sha_Asm_1_b(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
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

function CharPosEY_Sha_Asm_1_c(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
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
  
function CharPosEY_Sha_Asm_1_d(const SearchCharacter: char;
  const SourceString: AnsiString;
  Occurrence: integer= 1;
  StartPos: integer= 1): integer;
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

end.
