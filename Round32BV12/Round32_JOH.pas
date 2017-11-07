unit Round32_JOH;

interface

function Round32ExtendedJOH(const X : Extended) : Integer;
function Round32DoubleJOH  (const X : Double  ) : Integer;
function Round32SingleJOH  (const X : Single  ) : Integer;

function Round32ExtendedJOH_1(const X : Extended) : Integer;
function Round32DoubleJOH_1  (const X : Double  ) : Integer;
function Round32SingleJOH_1  (const X : Single  ) : Integer;

function Round32ExtendedJOH_2(const X : Extended) : Integer;
function Round32DoubleJOH_2  (const X : Double  ) : Integer;
function Round32SingleJOH_2  (const X : Single  ) : Integer;

implementation

function Round32ExtendedJOH(const X : Extended) : Integer;
asm
 sub   esp, 4
 fld   X
 fistp dword ptr [esp]
 wait
 pop   eax
end;

function Round32DoubleJOH  (const X : Double) : Integer;
asm
 sub   esp, 4
 fld   X
 fistp dword ptr [esp]
 wait
 pop   eax           
end;

function Round32SingleJOH  (const X : Single) : Integer;
asm
 sub   esp, 4
 fld   X
 fistp dword ptr [esp]
 wait
 pop   eax
end;

function Round32ExtendedJOH_1(const X : Extended) : Integer;
asm
 sub   esp, 4
 fld   X
 fistp dword ptr [esp]
 wait
 pop   eax
end;

function Round32DoubleJOH_1(const X : Double) : Integer;
asm
 sub   esp, 4
 fld   X
 fistp dword ptr [esp]
 wait
 pop   eax
end;

function Round32SingleJOH_1(const X : Single) : Integer;
asm
 sub   esp, 4
 fld   X
 fistp dword ptr [esp]
 wait
 pop   eax
end;

function Round32ExtendedJOH_2(const X : Extended) : Integer;
asm
 lea   ecx, [esp-4]
 sub   esp, 8
 and   ecx, -4
 fld   tbyte ptr [esp+16]
 fistp dword ptr [ecx]
 wait
 mov   eax,[ecx]
 add   esp, 8
end;

function Round32DoubleJOH_2(const X : Double) : Integer;
asm
 lea   ecx, [esp-4]
 sub   esp, 8
 and   ecx, -4
 fld   qword ptr [esp+16]
 fistp dword ptr [ecx]
 wait
 mov   eax,[ecx]
 add   esp, 8
end;

function Round32SingleJOH_2(const X : Single) : Integer;
asm
 lea   ecx, [esp-4]
 sub   esp, 8
 and   ecx, -4
 fld   dword ptr [esp+16]
 fistp dword ptr [ecx]
 wait
 mov   eax,[ecx]
 add   esp, 8
end;

end.
 