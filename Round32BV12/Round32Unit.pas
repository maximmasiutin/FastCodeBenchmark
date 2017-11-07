unit Round32Unit;

interface

//function Round32ExtendedDKCPas(const X : Extended) : Integer;
function Round32ExtendedDKC1(const X : Extended) : Integer;
function Round32DoubleDKC1(const X : Double) : Integer;
//function Round32DoubleDKCSSE2_1(const X : Double) : Integer;
function Round32DoubleDKCSSE2_2(const X : Double) : Integer;
function Round32SingleDKC1(const X : Single) : Integer;
//function Round32SingleDKCSSE_1(const X : Single) : Integer;
function Round32SingleDKCSSE_2(const X : Single) : Integer;

implementation

uses
 Math, SysUtils;

function Round32ExtendedDKCPas(const X : Extended) : Integer;
begin
 Result := Round(X);
end;

function Round32ExtendedDKC1(const X : Extended) : Integer;
asm
 sub   esp,8
 fld   X
 fistp dword ptr [esp]
 wait
 mov   eax, [esp]
 add   esp,8
end;

function Round32DoubleDKC1(const X : Double) : Integer;
asm
 sub   esp,8
 fld   X
 fistp dword ptr [esp]
 wait
 mov   eax, [esp]
 add   esp,8
end;

{
function Round32DoubleDKCSSE2_1(const X : Double) : Integer;

 function Round32DoubleDKCSSE2Internal : Integer;
 asm
  cvtsd2si  eax,X
 end;

begin
 Result := Round32DoubleDKCSSE2Internal;
 if Result = -2147483648 then
  raise Exception.Create('Integer owerflow');
end;
}
function Round32DoubleDKCSSE2_2(const X : Double) : Integer;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvtsd2si eax,X
  cmp      eax, -2147483648
  jne      @Exit
  mov      ecx,[ExceptionText]
  mov      dl,$01
  mov      eax,[$00407510]
  call     SysUtils.Exception.Create
  call     SysUtils.@RaiseExcept
  mov      eax,ecx
@Exit :
end;

function Round32SingleDKC1(const X : Single) : Integer;
asm
 sub   esp,8
 fld   X
 fistp dword ptr [esp]
 wait
 mov   eax, [esp]
 add   esp,8
end;
{
function Round32SingleDKCSSE_1(const X : Single) : Integer;

 function Round32SingleDKCSSEInternal : Integer;
 asm
  cvtss2si eax,X
 end;

begin
 Result := Round32SingleDKCSSEInternal;
 if Result = -2147483648 then
  raise Exception.Create('Integer owerflow');
end;
}
function Round32SingleDKCSSE_2(const X : Single) : Integer;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvtss2si eax,X
  cmp      eax, -2147483648
  jne      @Exit
  mov      ecx,[ExceptionText]
  mov      dl,$01
  mov      eax,[$00407510]
  call     SysUtils.Exception.Create
  call     SysUtils.@RaiseExcept
  mov      eax,ecx
@Exit :
end;

end.
