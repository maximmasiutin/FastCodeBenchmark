unit MaxIntUnit;

interface

function Max_RTL_IA32_1_a(const A, B: Integer): Integer;
function Max_RTL_IA32_1_b(const A, B: Integer): Integer;
function Max_RTL_IA32_1_c(const A, B: Integer): Integer;
function Max_RTL_IA32_1_d(const A, B: Integer): Integer;
function Max_LBG_IA32_1_a(const A, B : Integer) : Integer;
function Max_LBG_IA32_1_b(const A, B : Integer) : Integer;
function Max_LBG_IA32_1_c(const A, B : Integer) : Integer;
function Max_LBG_IA32_1_d(const A, B : Integer) : Integer;
function Max_DKC_Pas_1_a(const A, B : Integer) : Integer;
function Max_DKC_Pas_1_b(const A, B : Integer) : Integer;
function Max_DKC_Pas_1_c(const A, B : Integer) : Integer;
function Max_DKC_Pas_1_d(const A, B : Integer) : Integer;
function Max_DKC_IA32_1_a(const A, B : Integer) : Integer;
function Max_DKC_IA32_1_b(const A, B : Integer) : Integer;
function Max_DKC_IA32_1_c(const A, B : Integer) : Integer;
function Max_DKC_IA32_1_d(const A, B : Integer) : Integer;
function Max_Sha_IA32_1_a(const a, b: integer): integer;
function Max_Sha_IA32_1_b(const a, b: integer): integer;
function Max_Sha_IA32_1_c(const a, b: integer): integer;
function Max_Sha_IA32_1_d(const a, b: integer): integer;
function Max_Sha_Pas_1_a(const a, b: integer): integer;
function Max_Sha_Pas_1_b(const a, b: integer): integer;
function Max_Sha_Pas_1_c(const a, b: integer): integer;
function Max_Sha_Pas_1_d(const a, b: integer): integer;

implementation

function Max_RTL_IA32_1_a(const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

procedure Filler1;
asm
 nop
end;

function Max_RTL_IA32_1_b(const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Max_RTL_IA32_1_c(const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

procedure Filler2;
asm
 nop
end;

function Max_RTL_IA32_1_d(const A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

function Max_DKC_Pas_1_a(const A, B : Integer) : Integer;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

function Max_DKC_Pas_1_b(const A, B : Integer) : Integer;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

procedure Filler3;
asm
 nop
end;

function Max_DKC_Pas_1_c(const A, B : Integer) : Integer;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

function Max_DKC_Pas_1_d(const A, B : Integer) : Integer;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

function Max_DKC_IA32_1_a(const A, B : Integer) : Integer;
asm
 cmp edx,eax
 jle @Exit
 mov eax,edx
@Exit :
end;

function Max_DKC_IA32_1_b(const A, B : Integer) : Integer;
asm
 cmp edx,eax
 jle @Exit
 mov eax,edx
@Exit :
end;

procedure Filler4;
asm
 nop
end;

function Max_DKC_IA32_1_c(const A, B : Integer) : Integer;
asm
 cmp edx,eax
 jle @Exit
 mov eax,edx
@Exit :
end;

function Max_DKC_IA32_1_d(const A, B : Integer) : Integer;
asm
 cmp edx,eax
 jle @Exit
 mov eax,edx
@Exit :
end;

function Max_LBG_IA32_1_a(const A, B : Integer) : Integer;
asm
                    // A in EAX
                    // B in EDX
   CMP EDX,EAX      // Is edx > eax  ?
   CMOVG EAX,EDX    // Conditional move if greater
                    // Does not affect the destination operand if the condition is false.
end;

function Max_LBG_IA32_1_b(const A, B : Integer) : Integer;
asm
                    // A in EAX
                    // B in EDX
   CMP EDX,EAX      // Is edx > eax  ?
   CMOVG EAX,EDX    // Conditional move if greater
                    // Does not affect the destination operand if the condition is false.
end;

procedure Filler5;
asm
 nop
end;

function Max_LBG_IA32_1_c(const A, B : Integer) : Integer;
asm
                    // A in EAX
                    // B in EDX
   CMP EDX,EAX      // Is edx > eax  ?
   CMOVG EAX,EDX    // Conditional move if greater
                    // Does not affect the destination operand if the condition is false.
end;

function Max_LBG_IA32_1_d(const A, B : Integer) : Integer;
asm
                    // A in EAX
                    // B in EDX
   CMP EDX,EAX      // Is edx > eax  ?
   CMOVG EAX,EDX    // Conditional move if greater
                    // Does not affect the destination operand if the condition is false.
end;

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function Max_Sha_Pas_1_a(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a>b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

procedure Filler6;
asm
 nop
end;

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function Max_Sha_Pas_1_b(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a>b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

procedure Filler7;
asm
 nop
end;

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function Max_Sha_Pas_1_c(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a>b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

procedure Filler8;
asm
 nop
end;

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function Max_Sha_Pas_1_d(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a>b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

function Max_Sha_IA32_1_a(const a, b: integer): integer;
asm
  xor ecx,ecx
  sub edx,eax
  setl cl
  sub ecx,1
  and edx,ecx
  add eax,edx
end;

procedure Filler9;
asm
 nop
end;

function Max_Sha_IA32_1_b(const a, b: integer): integer;
asm
  xor ecx,ecx
  sub edx,eax
  setl cl
  sub ecx,1
  and edx,ecx
  add eax,edx
end;

procedure Filler10;
asm
 nop
end;

function Max_Sha_IA32_1_c(const a, b: integer): integer;
asm
  xor ecx,ecx
  sub edx,eax
  setl cl
  sub ecx,1
  and edx,ecx
  add eax,edx
end;

procedure Filler11;
asm
 nop
end;

function Max_Sha_IA32_1_d(const a, b: integer): integer;
asm
  xor ecx,ecx
  sub edx,eax
  setl cl
  sub ecx,1
  and edx,ecx
  add eax,edx
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

end.
