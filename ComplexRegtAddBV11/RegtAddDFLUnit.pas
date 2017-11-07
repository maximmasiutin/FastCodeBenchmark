unit RegtAddDFLUnit;

interface

uses
 ComplexDataTypesUnit;

function RegtAddDFL_IA32_1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtAddDFL_IA32_2(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtAddDFL_IA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtAddDFL_SSE2_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtAddDFL_IA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtAddDFL_SSE_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;

implementation

//Author:            Dennis Fredberg Lauritzen
//Date:              14/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtAddDFL_IA32_1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld tbyte ptr [eax]
 fld tbyte ptr [edx]
 faddp
 fstp tbyte ptr [ecx]
 wait
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fld tbyte ptr [eax+16]
 fld tbyte ptr [edx+16]
 faddp
 fstp tbyte ptr [ecx+16]
 wait
end;

function RegtAddDFL_IA32_2(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld tbyte ptr [eax]
 fld tbyte ptr [edx]
 faddp
 fstp tbyte ptr [ecx]
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fld tbyte ptr [eax+16]
 fld tbyte ptr [edx+16]
 faddp
 fstp tbyte ptr [ecx+16]
end;

function RegtAddDFL_IA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld  dword ptr [eax]
 fadd dword ptr [edx]
 fstp dword ptr [ecx]
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fld  dword ptr [eax+$04]
 fadd dword ptr [edx+$04]
 fstp dword ptr [ecx+$04]
end;

function RegtAddDFL_IA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 fld  qword ptr [eax]
 fadd qword ptr [edx]
 fstp qword ptr [ecx]
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 fld  qword ptr [eax+8]
 fadd qword ptr [edx+8]
 fstp qword ptr [ecx+8]
end;

function RegtAddDFL_SSE2_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 movupd xmm0, [eax]
 movupd xmm1, [edx]
 addpd  xmm0, xmm1
 movupd [ecx], xmm0
end;

function RegtAddDFL_SSE_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 //Result.RealPart := X.RealPart + Y.RealPart;
 //Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
 movlps xmm0, [eax]
 movlps xmm1, [edx]
 addps  xmm0, xmm1
 movlps [ecx], xmm0
end;

end.
