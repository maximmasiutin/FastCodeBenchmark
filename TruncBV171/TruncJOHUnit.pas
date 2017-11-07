unit TruncJOHUnit;

interface

function TruncExtended_JOH_IA32_1(const X : Extended) : Int64;
function TruncDouble_JOH_IA32_1  (const X : Double  ) : Int64;
function TruncSingle_JOH_IA32_1  (const X : Single  ) : Int64;

implementation

function TruncExtended_JOH_IA32_1(const X : Extended) : Int64;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  mov    ax, OldCW
  or     ax, $0F00 {Set Bits 8, 9, 10 and 11}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round towards 0 Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;

function TruncDouble_JOH_IA32_1(const X : Double  ) : Int64;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  mov    ax, OldCW
  or     ax, $0F00 {Set Bits 8, 9, 10 and 11}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round towards 0 Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;

function TruncSingle_JOH_IA32_1(const X : Single) : Int64;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  mov    ax, OldCW
  or     ax, $0F00 {Set Bits 8, 9, 10 and 11}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round towards 0 Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;

end.

