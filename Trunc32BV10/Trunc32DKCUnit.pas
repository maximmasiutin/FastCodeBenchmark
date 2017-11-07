unit Trunc32DKCUnit;

interface

function Trunc32ExtendedDKC1(const X : Extended) : Integer;
function Trunc32DoubleDKC1(const X : Double) : Integer;
function Trunc32DoubleDKCSSE2(const X : Double) : Integer;
function Trunc32DoubleDKCSSE2_2(const X : Double) : Integer;
function Trunc32SingleDKC1(const X : Single) : Integer;
function Trunc32SingleDKCSSE(const X : Single) : Integer;
function Trunc32SingleDKCSSE_2(const X : Single) : Integer;

implementation

uses
 SysUtils, Math;

function Trunc32ExtendedDKC1(const X : Extended) : Integer;
asm
 sub    esp, 12
 fnstcw [esp].Word         //Get current controlword
 mov    ax, [esp]          //into eax
 or     ax, 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  dword ptr [esp+4]
 mov    eax, [esp+4]
 fldcw  word ptr [esp]     //Restore controlword
 add    esp, 12
end;

function Trunc32DoubleDKC1(const X : Double) : Integer;
asm
 sub    esp, 12
 fnstcw [esp].Word            //Get current controlword
 mov    ax, [esp]             //into eax
 or     ax, 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  dword ptr [esp+4]
 mov    eax, [esp+4]
 fldcw  word ptr [esp]        //Restore controlword
 add    esp, 12
end;

function Trunc32DoubleDKCSSE2(const X : Double) : Integer;
asm
 cvttsd2si eax,X
end;

function Trunc32SingleDKC1(const X : Single) : Integer;
asm
 sub    esp, 12
 fnstcw [esp].Word                 //Get current controlword
 fnstcw [esp+4].Word               //Get current controlword
 or     [esp+4], 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 fldcw  word ptr [esp+4]
 fld    X
 fistp  dword ptr [esp+4]
 mov    eax, [esp+4]
 fldcw  word ptr [esp]             //Restore controlword
 add    esp, 12
end;

function Trunc32SingleDKCSSE(const X : Single) : Integer;
asm
 cvttss2si eax,X
end;

function Trunc32DoubleDKCSSE2_2(const X : Double) : Integer;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvttsd2si eax,X
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


function Trunc32SingleDKCSSE_2(const X : Single) : Integer;
const
 ExceptionText : AnsiString = 'Integer owerflow';
asm
  cvttss2si eax,X
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
