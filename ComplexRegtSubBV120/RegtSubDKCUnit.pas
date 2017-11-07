unit RegtSubDKCUnit;

interface

uses
 ComplexDataTypesUnit;

function RegtSubDKCPas1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtSubDKCPas1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtSubDKCPas1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtSubDKCIA32_1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtSubDKCIA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtSubDKCIA32_2(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtSubDKCIA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtsubDDKC_SSE2_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtSubDDKC_SSE_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              21/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtSubDKCPas1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
begin
 Result.RealPart := X.RealPart - Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart - Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtSubDKCPas1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
begin
 Result.RealPart := X.RealPart - Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart - Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtSubDKCPas1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
begin
 Result.RealPart := X.RealPart - Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart - Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtSubDKCIA32_1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld tbyte ptr [eax]
 fld tbyte ptr [edx]
 fSubp
 fstp tbyte ptr [ecx]
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fld tbyte ptr [eax+16]
 fld tbyte ptr [edx+16]
 fSubp
 fstp tbyte ptr [ecx+16]
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtSubDKCIA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld  qword ptr [eax]
 fsub qword ptr [edx]
 fstp qword ptr [ecx]
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fld  qword ptr [eax+8]
 fsub qword ptr [edx+8]
 fstp qword ptr [ecx+8]
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtSubDKCIA32_2(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld   qword ptr [eax]
 fld   qword ptr [eax+8]
 fld   qword ptr [edx]
 fld   qword ptr [edx+8]
 fsubr st(0),st(2)
 ffree st(2)
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fxch  st(1)
 fsubr st(0),st(3)
 ffree st(3)
 fstp  qword ptr [ecx]
 fstp  qword ptr [ecx+8]
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtSubDKCIA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld  dword ptr [eax]
 fsub dword ptr [edx]
 fstp dword ptr [ecx]
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fld  dword ptr [eax+$04]
 fsub dword ptr [edx+$04]
 fstp dword ptr [ecx+$04]
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtSubDDKC_SSE_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 movlps  xmm0, [eax]
 movlps  xmm1, [edx]
 subps   xmm0, xmm1
 movlps  [ecx], xmm0
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtsubDDKC_SSE2_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 movupd  xmm0, [eax]
 movupd  xmm1, [edx]
 subpd   xmm0, xmm1
 movupd  [ecx], xmm0
end;

end.
