unit Trunc32Unit;

interface

function Trunc32ExtendedDKC1(const X : Extended) : Integer;
function Trunc32DoubleDKC1(const X : Double) : Integer;
function Trunc32DoubleDKCSSE2(const X : Double) : Integer;
function Trunc32SingleDKC1(const X : Single) : Integer;
function Trunc32SingleDKCSSE(const X : Single) : Integer;

implementation

uses
 Math;

function Trunc32ExtendedDKC1(const X : Extended) : Integer;
asm
 fnstcw [esp-12].Word         //Get current controlword
 mov    ax, [esp-12]          //into eax
 or     ax, 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 mov    [esp-8], ax
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 fldcw  word ptr [esp-12]     //Restore controlword
end;

function Trunc32DoubleDKC1(const X : Double) : Integer;
asm
 fnstcw [esp-12].Word         //Get current controlword
 mov    ax, [esp-12]          //into eax
 or     ax, 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 mov    [esp-8], ax
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 fldcw  word ptr [esp-12]     //Restore controlword
end;

function Trunc32DoubleDKCSSE2(const X : Double) : Integer;
asm
 cvttsd2si eax,X
end;

function Trunc32SingleDKC1(const X : Single) : Integer;
asm
 fnstcw [esp-12].Word              //Get current controlword
 fnstcw [esp-8].Word               //Get current controlword
 or     [esp-8], 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 fldcw  word ptr [esp-12]          //Restore controlword
end;

function Trunc32SingleDKCSSE(const X : Single) : Integer;
asm
 cvttss2si eax,X
end;

end.
