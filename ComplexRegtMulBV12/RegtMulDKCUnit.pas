unit RegtMulDKCUnit;

interface

uses
 ComplexDataTypesUnit;

function RegtMulDKCPas1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtMulDKCPas1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtMulDKCPas1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtMulDKCIA32_1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtMulDKCIA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtMulDKCIA32_2(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtMulDKC_SSE2_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtMulDKCIA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              21/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtMulDKCPas1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
begin
 Result.RealPart := (X.RealPart * Y.RealPart) - (X.ImaginaryPart * Y.ImaginaryPart);
 Result.ImaginaryPart := (X.RealPart * Y.ImaginaryPart) + (X.ImaginaryPart * y.RealPart);
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtMulDKCPas1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
begin
 Result.RealPart := (X.RealPart * Y.RealPart) - (X.ImaginaryPart * Y.ImaginaryPart);
 Result.ImaginaryPart := (X.RealPart * Y.ImaginaryPart) + (X.ImaginaryPart * y.RealPart);
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtMulDKCIA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Result.RealPart := (X.RealPart * Y.RealPart) - (X.ImaginaryPart * Y.ImaginaryPart);
 fld   qword ptr [eax]
 fld   qword ptr [edx]
 fld   st(0)
 fmul  st(0),st(2)
 fld   qword ptr [eax+$08]
 fld   qword ptr [edx+$08]
 fld   st(0)
 fmul  st(0),st(2)
 fsubr st(0),st(3)
 ffree st(3)
 fstp  qword ptr [ecx]
 //Result.ImaginaryPart := (X.RealPart * Y.ImaginaryPart) + (X.ImaginaryPart * y.RealPart);
 fmul  st(0),st(4)
 ffree st(4)
 fxch  st(1)
 fmul  st(0),st(3)
 ffree st(3)
 faddp
 fstp  qword ptr [ecx+$08]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtMulDKCIA32_2(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Result.RealPart := (X.RealPart * Y.RealPart) - (X.ImaginaryPart * Y.ImaginaryPart);
 fld   qword ptr [eax]
 fld   qword ptr [edx]
 fld   st(0)
 fmul  st(0),st(2)
 fld   qword ptr [eax+$08]
 fld   qword ptr [edx+$08]
 fld   st(0)
 fmul  st(0),st(2)
 fsubr st(0),st(3)
 ffree st(3)
 fstp  qword ptr [ecx]
 //Result.ImaginaryPart := (X.RealPart * Y.ImaginaryPart) + (X.ImaginaryPart * y.RealPart);
 fmulp  st(4),st(0)
 fmul   st(0),st(2)
 ffree  st(2)
 fadd   st(0),st(3)
 ffree  st(3)
 fstp  qword ptr [ecx+$08]
 wait
end;

{
var
 XMM0Reg : array[1..2] of Double;
 XMM1Reg : array[1..2] of Double;

function RegtMulDKC_SSE2_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Result.RealPart := (X.RealPart * Y.RealPart) - (X.ImaginaryPart * Y.ImaginaryPart);
 movupd xmm0, [eax]

 movupd XMM0Reg, xmm0

 movupd xmm1, [edx]

 movupd XMM1Reg, xmm1

 mulpd  xmm0, xmm1

 movupd XMM0Reg, xmm0

 movapd xmm1, xmm0

 movupd XMM1Reg, xmm1

 shufpd xmm0, xmm0, 1

 movupd XMM0Reg, xmm0

 subsd  xmm1, xmm0

 movupd XMM1Reg, xmm1

 movsd [ecx], xmm1
 //Result.ImaginaryPart := (X.RealPart * Y.ImaginaryPart) + (X.ImaginaryPart * y.RealPart);
 movupd xmm0, [eax]
 movupd xmm1, [edx]
 shufpd xmm0, xmm0, 1

 movupd XMM0Reg, xmm0
 movupd XMM1Reg, xmm1

 mulpd  xmm0, xmm1

 movupd XMM0Reg, xmm0

 movapd xmm1, xmm0

 movupd XMM1Reg, xmm1

 shufpd xmm0, xmm0, 1

 addsd  xmm0, xmm1

 movupd XMM0Reg, xmm0

 movsd  [ecx+8], xmm0

end;
}

//Author:            Dennis Kjaer Christensen
//Date:              23/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32, SSE2

function RegtMulDKC_SSE2_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 sub     esp,8
 //bit 7-12 masks exceptions. We want overflow and underflow exceptions
 //bit 10 + 11 must be cleared, and 7-9 + 12 set
 stmxcsr [esp+4]
 mov     [esp], $1B80 //10011 1000 0000b
 ldmxcsr [esp]
 //Result.RealPart := (X.RealPart * Y.RealPart) - (X.ImaginaryPart * Y.ImaginaryPart);
 movupd xmm0, [eax]
 movupd xmm1, [edx]
 mulpd  xmm0, xmm1
 movapd xmm1, xmm0
 shufpd xmm0, xmm0, 1
 subsd  xmm1, xmm0
 movsd [ecx], xmm1
 //Result.ImaginaryPart := (X.RealPart * Y.ImaginaryPart) + (X.ImaginaryPart * y.RealPart);
 movupd xmm0, [eax]
 movupd xmm1, [edx]
 shufpd xmm0, xmm0, 1
 mulpd  xmm0, xmm1
 movapd xmm1, xmm0
 shufpd xmm0, xmm0, 1
 addsd  xmm0, xmm1
 movsd  [ecx+8], xmm0
 ldmxcsr [esp+4]
 add     esp,8
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtMulDKCPas1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
begin
 Result.RealPart := (X.RealPart * Y.RealPart) - (X.ImaginaryPart * Y.ImaginaryPart);
 Result.ImaginaryPart := (X.RealPart * Y.ImaginaryPart) + (X.ImaginaryPart * y.RealPart);
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtMulDKCIA32_1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
 //Result.RealPart := (X.RealPart * Y.RealPart) - (X.ImaginaryPart * Y.ImaginaryPart);
 fld   tbyte ptr [eax]
 fld   tbyte ptr [eax+$10]
 fld   tbyte ptr [edx]
 fld   st(0)
 fld   tbyte ptr [edx+$10]
 fld   st(0)
 fmul  st(0),st(4)
 fxch  st(2)
 fmul  st(0),st(5)
 fsub  st(0),st(2)
 ffree st(2)
 //Result.ImaginaryPart := (X.RealPart * Y.ImaginaryPart) + (X.ImaginaryPart * y.RealPart);
 fstp  tbyte ptr [ecx]
 fmul  st(0),st(4)
 fxch  st(2)
 ffree st(4)
 fmul  st(0),st(3)
 ffree st(3)
 fadd  st(0),st(2)
 ffree st(2)
 fstp  tbyte ptr [ecx+$10]
end;

//Author:            Dennis Kjaer Christensen
//Date:              26/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtMulDKCIA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 //Result.RealPart := (X.RealPart * Y.RealPart) - (X.ImaginaryPart * Y.ImaginaryPart);
 fld   dword ptr [eax]
 fld   dword ptr [edx]
 fld   st(0)
 fmul  st(0),st(2)
 fld   dword ptr [eax+4]
 fld   dword ptr [edx+4]
 fld   st(0)
 fmul  st(0),st(2)
 fsubr st(0),st(3)
 ffree st(3)
 fstp  dword ptr [ecx]
 //Result.ImaginaryPart := (X.RealPart * Y.ImaginaryPart) + (X.ImaginaryPart * y.RealPart);
 fmulp st(4),st(0)
 fmul  st(0),st(2)
 ffree st(2)
 fadd  st(0),st(3)
 ffree st(3)
 fstp  dword ptr [ecx+4]
 wait
end;

end.
