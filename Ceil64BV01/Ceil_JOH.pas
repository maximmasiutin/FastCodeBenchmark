unit Ceil_JOH;

//modified 15/10/03

interface

function CeilExtendedJOH2(const X : Extended) : Int64;
function CeilDoubleJOH2  (const X : Double  ) : Int64;
function CeilSingleJOH2  (const X : Single  ) : Int64;

implementation

function CeilExtendedJOH2(const X : Extended) : Int64;
asm
  sub    esp, 12
  fnstcw [esp]               {Save Current Control Word}
  movzx  eax, word ptr [esp]
  and    ax, $FBFF           {Clear Bit 10}
  or     ax, $0B00           {Set Bits 8, 9 and 11}
  mov    [esp+2], ax         {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  [esp+2]             {Set Round towards 0 Mode with 64 Bit Precision}
  fld    tbyte ptr [esp+20]  {X}
  fistp  qword ptr [esp+4]   {Result}
  fldcw  word ptr [esp]      {Restore Original Control Word}
  wait
  mov    eax, [esp+4]
  mov    edx, [esp+8]
  add    esp, 12
end;

function CeilDoubleJOH2(const X : Double  ) : Int64;
asm
  sub    esp, 12
  fnstcw [esp]               {Save Current Control Word}
  movzx  eax, word ptr [esp]
  and    ax, $FBFF           {Clear Bit 10}
  or     ax, $0B00           {Set Bits 8, 9 and 11}
  mov    [esp+2], ax         {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  [esp+2]             {Set Round towards 0 Mode with 64 Bit Precision}
  fld    qword ptr [esp+20]  {X}
  fistp  qword ptr [esp+4]   {Result}
  fldcw  word ptr [esp]      {Restore Original Control Word}
  wait
  mov    eax, [esp+4]
  mov    edx, [esp+8]
  add    esp, 12
end;

function CeilSingleJOH2(const X : Single) : Int64;
asm
  sub    esp, 12
  fnstcw [esp]               {Save Current Control Word}
  movzx  eax, word ptr [esp]
  and    ax, $FBFF           {Clear Bit 10}
  or     ax, $0B00           {Set Bits 8, 9 and 11}
  mov    [esp+2], ax         {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  [esp+2]             {Set Round towards 0 Mode with 64 Bit Precision}
  fld    dword ptr [esp+20]  {X}
  fistp  qword ptr [esp+4]   {Result}
  fldcw  word ptr [esp]      {Restore Original Control Word}
  wait
  mov    eax, [esp+4]
  mov    edx, [esp+8]
  add    esp, 12
end;

end.

