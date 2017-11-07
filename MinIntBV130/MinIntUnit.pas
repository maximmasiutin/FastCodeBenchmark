unit MinIntUnit;

interface

function MinDKCPas_a(const A, B : Integer) : Integer;
function MinDKCPas_b(const A, B : Integer) : Integer;
function MinDKCPas_c(const A, B : Integer) : Integer;
function MinDKCPas_d(const A, B : Integer) : Integer;
function MinLBG_a(const A, B : Integer) : Integer;
function MinLBG_b(const A, B : Integer) : Integer;
function MinLBG_c(const A, B : Integer) : Integer;
function MinLBG_d(const A, B : Integer) : Integer;
function MinShaIntegerPas_a(const a, b: integer): integer;
function MinShaIntegerPas_b(const a, b: integer): integer;
function MinShaIntegerPas_c(const a, b: integer): integer;
function MinShaIntegerPas_d(const a, b: integer): integer;
function MinShaInteger_a(const a, b: integer): integer;
function MinShaInteger_b(const a, b: integer): integer;
function MinShaInteger_c(const a, b: integer): integer;
function MinShaInteger_d(const a, b: integer): integer;

implementation

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function MinShaIntegerPas_a(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a<b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function MinShaIntegerPas_b(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a<b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function MinShaIntegerPas_c(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a<b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function MinShaIntegerPas_d(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a<b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

function MinDKCPas_a(const A, B : Integer) : Integer;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

function MinDKCPas_b(const A, B : Integer) : Integer;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

function MinDKCPas_c(const A, B : Integer) : Integer;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

function MinDKCPas_d(const A, B : Integer) : Integer;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

function MinLBG_a(const A, B : Integer) : Integer;
asm
                        // A in EAX
                        // B in EDX
   CMP EDX,EAX          // Compare  EDX and EAX
   CMOVL EAX,EDX        // Move if less (SF<>OF)
                        // Does not affect the destination operand if the
                        // condition is false.
end;

function MinLBG_b(const A, B : Integer) : Integer;
asm
                        // A in EAX
                        // B in EDX
   CMP EDX,EAX          // Compare  EDX and EAX
   CMOVL EAX,EDX        // Move if less (SF<>OF)
                        // Does not affect the destination operand if the
                        // condition is false.
end;

function MinLBG_c(const A, B : Integer) : Integer;
asm
                        // A in EAX
                        // B in EDX
   CMP EDX,EAX          // Compare  EDX and EAX
   CMOVL EAX,EDX        // Move if less (SF<>OF)
                        // Does not affect the destination operand if the
                        // condition is false.
end;

function MinLBG_d(const A, B : Integer) : Integer;
asm
                        // A in EAX
                        // B in EDX
   CMP EDX,EAX          // Compare  EDX and EAX
   CMOVL EAX,EDX        // Move if less (SF<>OF)
                        // Does not affect the destination operand if the
                        // condition is false.
end;

function MinShaInteger_a(const a, b: integer): integer;
asm
  xor ecx,ecx
  sub edx,eax
  setge cl
  sub ecx,1
  and edx,ecx
  add eax,edx
end;

function MinShaInteger_b(const a, b: integer): integer;
asm
  xor ecx,ecx
  sub edx,eax
  setge cl
  sub ecx,1
  and edx,ecx
  add eax,edx
end;

function MinShaInteger_c(const a, b: integer): integer;
asm
  xor ecx,ecx
  sub edx,eax
  setge cl
  sub ecx,1
  and edx,ecx
  add eax,edx
end;

function MinShaInteger_d(const a, b: integer): integer;
asm
  xor ecx,ecx
  sub edx,eax
  setge cl
  sub ecx,1
  and edx,ecx
  add eax,edx
end;

end.
