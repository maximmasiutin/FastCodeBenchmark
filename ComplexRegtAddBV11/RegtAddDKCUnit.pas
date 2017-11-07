unit RegtAddDKCUnit;

interface

uses
 ComplexDataTypesUnit;

function RegtAddDKCPas1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtAddDKCPas1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtAddDKCPas1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtAddDKCIA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtAddDKCIA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtAddDDKC_SSE_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtAddDDKC_SSE2_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              11/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtAddDKCPas1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
begin
 Result.RealPart := X.RealPart + Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              11/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtAddDKCPas1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
begin
 Result.RealPart := X.RealPart + Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              13/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtAddDKCIA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld  qword ptr [eax]
 fadd qword ptr [edx]
 fstp qword ptr [ecx]
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fld  qword ptr [eax+8]
 fadd qword ptr [edx+8]
 fstp qword ptr [ecx+8]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              11/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtAddDKCPas1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
begin
 Result.RealPart := X.RealPart + Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              12/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtAddDKCIA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld  dword ptr [eax]
 fadd dword ptr [edx]
 fstp dword ptr [ecx]
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fld  dword ptr [eax+$04]
 fadd dword ptr [edx+$04]
 fstp dword ptr [ecx+$04]
 wait
end;

function RegtAddDDKC_SSE_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 sub     esp,8
 //bit 7-12 masks exceptions. We want overflow and underflow exceptions
 //bit 10 + 11 must be cleared, and 7-9 + 12 set
 stmxcsr [esp+4]
 mov     [esp], $1B80 //10011 1000 0000b
 ldmxcsr [esp]
 //Result.RealPart := X.RealPart + Y.RealPart;
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 movlps  xmm0, [eax]
 movlps  xmm1, [edx]
 addps   xmm0, xmm1
 movlps  [ecx], xmm0
 ldmxcsr [esp+4]
 add     esp,8
end;

function RegtAddDDKC_SSE2_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 sub     esp,8
 //bit 7-12 masks exceptions. We want overflow and underflow exceptions
 //bit 10 + 11 must be cleared, and 7-9 + 12 set
 stmxcsr [esp+4]
 mov     [esp], $1B80 //10011 1000 0000b
 ldmxcsr [esp]
 //Result.RealPart := X.RealPart + Y.RealPart;
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 movupd  xmm0, [eax]
 movupd  xmm1, [edx]
 addpd   xmm0, xmm1
 movupd  [ecx], xmm0
 ldmxcsr [esp+4]
 add     esp,8
end;

end.
