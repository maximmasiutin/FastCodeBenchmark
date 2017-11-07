unit MinIntLBGUnit;

interface

function MinLBG_a(const A, B : Integer) : Integer;
function MinLBG_b(const A, B : Integer) : Integer;
function MinLBG_c(const A, B : Integer) : Integer;
function MinLBG_d(const A, B : Integer) : Integer;

implementation

function MinLBG_a(const A, B : Integer) : Integer;
asm
                        // A in EAX
                        // B in EDX
   CMP EDX,EAX          // Compare  EDX and EAX
   CMOVL EAX,EDX        // Move if less (SF<>OF)
                        // Does not affect the destination operand if the
                        // condition is false.
end;

procedure Filler1;
asm
 nop
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

procedure Filler2;
asm
 nop
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

procedure Filler3;
asm
 nop
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

initialization

 Filler1;
 Filler2;
 Filler3;

end.

