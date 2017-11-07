unit MinIntDKCUnit;

interface

function MinDKCPas_a(const A, B : Integer) : Integer;
function MinDKCPas_b(const A, B : Integer) : Integer;
function MinDKCPas_c(const A, B : Integer) : Integer;
function MinDKCPas_d(const A, B : Integer) : Integer;

implementation

function MinDKCPas_a(const A, B : Integer) : Integer;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

procedure Filler1;
asm
 nop
end;

function MinDKCPas_b(const A, B : Integer) : Integer;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

procedure Filler2;
asm
 nop
 nop
end;

function MinDKCPas_c(const A, B : Integer) : Integer;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

procedure Filler3;
asm
 nop
 nop
 nop
end;

function MinDKCPas_d(const A, B : Integer) : Integer;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

initialization

 Filler1;
 Filler2;
 Filler3;

end.
