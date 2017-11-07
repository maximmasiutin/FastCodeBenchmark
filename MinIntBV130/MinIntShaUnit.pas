unit MinIntShaUnit;

interface

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

procedure Filler1;
asm
 nop
end;

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function MinShaIntegerPas_b(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a<b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

procedure Filler2;
asm
 nop
end;

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function MinShaIntegerPas_c(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a<b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

procedure Filler3;
asm
 nop
end;

{$UNDEF SaveQ}
{$IFOPT Q+} {$DEFINE SaveQ} {$Q-} {$ENDIF}
function MinShaIntegerPas_d(const a, b: integer): integer;
begin;
  Result:=a + (b-a) and (ord(a<b) - 1);
  end;
{$IFDEF SaveQ} {$UNDEF SaveQ} {$Q+} {$ENDIF}

procedure Filler4;
asm
 nop
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

procedure Filler5;
asm
 nop
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

procedure Filler6;
asm
 nop
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

procedure Filler7;
asm
 nop
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

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;
 Filler7;

end.
