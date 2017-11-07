unit Trunc32JOHUnit;

interface

function Trunc32ExtendedJOH(const X : Extended) : Integer;
function Trunc32DoubleJOH  (const X : Double  ) : Integer;
function Trunc32SingleJOH  (const X : Single  ) : Integer;

implementation

function Trunc32ExtendedJOH(const X : Extended) : Integer;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  movzx  eax, OldCW
  or     ax, $0F00 {Set Bits 8, 9, 10 and 11}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round towards 0 Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;

function Trunc32DoubleJOH(const X : Double) : Integer;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  movzx  eax, OldCW
  or     ax, $0F00 {Set Bits 8, 9, 10 and 11}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round towards 0 Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;

function Trunc32SingleJOH(const X : Single) : Integer;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  movzx  eax, OldCW
  or     ax, $0F00 {Set Bits 8, 9, 10 and 11}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round towards 0 Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;

end.

