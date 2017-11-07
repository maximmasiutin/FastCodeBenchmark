unit MaxInt64RTLUnit;

interface

function MaxRTL_a(const A, B: Int64): Int64;
function MaxRTL_b(const A, B: Int64): Int64;
function MaxRTL_c(const A, B: Int64): Int64;
function MaxRTL_d(const A, B: Int64): Int64;

implementation

function MaxRTL_a(const A, B: Int64): Int64;
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

function MaxRTL_b(const A, B: Int64): Int64;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

procedure Filler2;
asm
 nop
 nop
end;

function MaxRTL_c(const A, B: Int64): Int64;
begin
  if A > B then
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

function MaxRTL_D(const A, B: Int64): Int64;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;

initialization
 Filler1;
 Filler2;
 Filler3;

end.
