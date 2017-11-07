unit Trunc32DFLUnit;

interface

function Trunc32ExtendedDFLSSE3_1(const X : Extended) : Integer;
function Trunc32DoubleDFLSSE3(const X : Double) : Integer;
function Trunc32SingleDFL1SSE3(const X : Single) : Integer;

implementation

function Trunc32ExtendedDFLSSE3_1(const X : Extended) : Integer;
asm
 fld X
 sub esp,16
 // fisttp dword ptr [esp+8]
 DB  $DB
 DB  $4C
 DB  $24
 DB  $08
 mov eax, [esp+8]
 add esp,16
 wait
end;

function Trunc32DoubleDFLSSE3(const X : Double) : Integer;
asm
 fld    X
 // fisttp dword ptr [esp-8]
 DB $DB
 DB $4C
 DB $24
 DB $F8
 sub esp,8
 mov    eax, [esp]
 add esp,8
 wait
end;

function Trunc32SingleDFL1SSE3(const X : Single) : Integer;
asm
 fld    X
 // fisttp dword ptr [esp-8]
 DB $DB
 DB $4C
 DB $24
 DB $F8
 sub esp,8
 mov    eax, [esp]
 add esp,8
 wait
end;

end.
