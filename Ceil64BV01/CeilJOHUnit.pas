unit CeilJOHUnit;

interface

function CeilExtendedJOH(const X : Extended) : Int64;
function CeilDoubleJOH  (const X : Double  ) : Int64;
function CeilSingleJOH  (const X : Single  ) : Int64;

implementation

function CeilExtendedJOH(const X : Extended) : Int64;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  mov    ax, OldCW
  and    ax, $FBFF {Clear Bit 10}
  or     ax, $0B00 {Set Bits 8, 9 and 11}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round to +ve Infinity Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;

function CeilDoubleJOH(const X : Double  ) : Int64;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  mov    ax, OldCW
  and    ax, $FBFF {Clear Bit 10}
  or     ax, $0B00 {Set Bits 8, 9 and 11}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round to +ve Infinity Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;

function CeilSingleJOH(const X : Single) : Int64;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  mov    ax, OldCW
  and    ax, $FBFF {Clear Bit 10}
  or     ax, $0B00 {Set Bits 8, 9 and 11}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round to +ve Infinity Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;


end.

