unit RegtDivDKCUnit;

interface

uses
 ComplexDataTypesUnit;

function RegtDivDKCPas1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtDivDKCPas2(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtDivDKCPas3(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtDivDKCIA32_1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtDivDKCIA32_2(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtDivDKCIA32_3(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
function RegtDivDKCPas1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtDivDKCPas2(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtDivDKCPas3(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtDivDKCIA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtDivDKCIA32_2(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtDivDKCIA32_3(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RegtDivDKCPas1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtDivDKCPas2(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtDivDKCPas3(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtDivDKCIA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtDivDKCIA32_2(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RegtDivDKCIA32_3(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCPas1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
begin
 Result.RealPart := (X.RealPart * Y.RealPart + X.ImaginaryPart * Y.ImaginaryPart)
                  / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart)
                       / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCPas2(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
var
 Temp : Extended;

begin
 Temp := Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart;
 Result.RealPart := (X.RealPart * Y.RealPart + X.ImaginaryPart * Y.ImaginaryPart) / Temp;
 Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) / Temp;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCPas3(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
var
 Temp : Extended;

begin
 Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 Result.RealPart := (X.RealPart * Y.RealPart + X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCIA32_1(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
 //Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 fld   tbyte ptr [edx]
 fld   tbyte ptr [edx]
 fmulp
 fld   tbyte ptr [edx+$10]
 fld   tbyte ptr [edx+$10]
 fmulp
 faddp
 fld1
 fdivrp
 wait
 //Result.RealPart := (X.RealPart * Y.RealPart) + (X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 fld   tbyte ptr [eax]
 fld   tbyte ptr [edx]
 fmulp
 fld   tbyte ptr [eax+$10]
 fld   tbyte ptr [edx+$10]
 fmulp
 faddp
 fmul  st(0), st(1)
 fstp  tbyte ptr [ecx]
 wait
 //Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
 fld   tbyte ptr [eax+$10]
 fld   tbyte ptr [edx]
 fmulp
 fld   tbyte ptr [eax]
 fld   tbyte ptr [edx+$10]
 fmulp
 fsubp
 fmulp st(1), st(0)
 fstp  tbyte ptr [ecx+$10]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCIA32_2(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
 //Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 fld   tbyte ptr [edx]
 fld   st(0)
 fmul  st(0), st(0)
 fld   tbyte ptr [edx+$10]
 fld   st(0)
 fmul  st(0), st(0)
 fadd  st(0), st(2)
 ffree st(2)
 fld1
 fdivrp
 wait
 //Result.RealPart := (X.RealPart * Y.RealPart) + (X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 fld   tbyte [eax]
 fld   st(0)
 fmul  st(0), st(5)
 fld   tbyte ptr [eax+$10]
 fld   st(0)
 fmul  st(0), st(5)
 fadd  st(0), st(2);
 ffree st(2)
 fmul  st(0), st(4)
 fstp  tbyte ptr [ecx]
 wait
 //Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
 fmul  st(0), st(6)
 ffree st(6)
 fxch  st(2)
 fmul  st(0), st(4)
 ffree st(4)
 fsubr st(0), st(2)
 ffree st(2)
 fmul  st(0), st(3)
 ffree st(3)
 fstp  tbyte ptr [ecx+$10]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCIA32_3(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
 //Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 fld   tbyte ptr [edx]
 fmul  st(0),st(0)
 fld   tbyte ptr [edx+$10]
 fmul  st(0),st(0)
 faddp
 fld1
 fdivrp
 wait
 //Result.RealPart := (X.RealPart * Y.RealPart) + (X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 fld   tbyte ptr [eax]
 fld   tbyte ptr [edx]
 fmulp
 fld   tbyte ptr [eax+$10]
 fld   tbyte ptr [edx+$10]
 fmulp
 faddp
 fmul  st(0), st(1)
 fstp  tbyte ptr [ecx]
 wait
 //Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
 fld   tbyte ptr [eax+$10]
 fld   tbyte ptr [edx]
 fmulp
 fld   tbyte ptr [eax]
 fld   tbyte ptr [edx+$10]
 fmulp
 fsubp
 fmulp st(1), st(0)
 fstp  tbyte ptr [ecx+$10]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCPas1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
begin
 Result.RealPart := (X.RealPart * Y.RealPart + X.ImaginaryPart * Y.ImaginaryPart)
                   / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart)
                       / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCPas2(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
var
 Temp : Extended;

begin
 Temp := Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart;
 Result.RealPart := (X.RealPart * Y.RealPart + X.ImaginaryPart * Y.ImaginaryPart) / Temp;
 Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) / Temp;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCPas3(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
var
 Temp : Extended;

begin
 Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 Result.RealPart := (X.RealPart * Y.RealPart + X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCIA32_1(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 fld   qword ptr [edx]
 fmul  qword ptr [edx]
 fld   qword ptr [edx+$08]
 fmul  qword ptr [edx+$08]
 faddp
 fld1
 fdivrp
 wait
 //Result.RealPart := (X.RealPart * Y.RealPart) + (X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 fld   qword ptr [eax]
 fmul  qword ptr [edx]
 fld   qword ptr [eax+$08]
 fmul  qword ptr [edx+$08]
 faddp
 fmul  st(0), st(1)
 fstp  qword ptr [ecx]
 wait
 //Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
 fld   qword ptr [eax+$08]
 fmul  qword ptr [edx]
 fld   qword ptr [eax]
 fmul  qword ptr [edx+$08]
 fsubp
 fmulp st(1), st(0)
 fstp  qword ptr [ecx+$08]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCIA32_2(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 fld   qword ptr [edx]
 fld   st(0)
 fmul  st(0), st(0)
 fld   qword ptr [edx+$08]
 fld   st(0)
 fmul  st(0), st(0)
 fadd  st(0), st(2)
 ffree st(2)
 fld1
 fdivrp
 wait
 //Result.RealPart := (X.RealPart * Y.RealPart) + (X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 fld   qword ptr [eax]
 fld   st(0)
 fmul  st(0), st(5)
 fld   qword ptr [eax+$08]
 fld   st(0)
 fmul  st(0), st(5)
 fadd  st(0), st(2);
 ffree st(2)
 fmul  st(0), st(4)
 fstp  qword ptr [ecx]
 wait
 //Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
 fmul  st(0), st(6)
 ffree st(6)
 fxch  st(2)
 fmul  st(0), st(4)
 ffree st(4)
 fsubr st(0), st(2)
 ffree st(2)
 fmul  st(0), st(3)
 ffree st(3)
 fstp  qword ptr [ecx+$08]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCIA32_3(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
 //Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 fld   qword ptr [edx]
 fmul  st(0),st(0)
 fld   qword ptr [edx+$08]
 fmul  st(0),st(0)
 faddp
 fld1
 fdivrp
 wait
 //Result.RealPart := (X.RealPart * Y.RealPart) + (X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 fld   qword ptr [eax]
 fmul  qword ptr [edx]
 fld   qword ptr [eax+$08]
 fmul  qword ptr [edx+$08]
 faddp
 fmul  st(0), st(1)
 fstp  qword ptr [ecx]
 wait
 //Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
 fld   qword ptr [eax+$08]
 fmul  qword ptr [edx]
 fld   qword ptr [eax]
 fmul  qword ptr [edx+$08]
 fsubp
 fmulp st(1), st(0)
 fstp  qword ptr [ecx+$08]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCPas1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
begin
 Result.RealPart := (X.RealPart * Y.RealPart + X.ImaginaryPart * Y.ImaginaryPart)
                  / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart)
                       / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCPas2(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
var
 Temp : Double;

begin
 Temp := Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart;
 Result.RealPart := (X.RealPart * Y.RealPart + X.ImaginaryPart * Y.ImaginaryPart) / Temp;
 Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) / Temp;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCPas3(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
var
 Temp : Double;

begin
 Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 Result.RealPart := (X.RealPart * Y.RealPart + X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/1 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCIA32_1(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 //Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 fld   dword ptr [edx]
 fmul  dword ptr [edx]
 fld   dword ptr [edx+$04]
 fmul  dword ptr [edx+$04]
 faddp
 fld1
 fdivrp
 wait
 //Result.RealPart := (X.RealPart * Y.RealPart) + (X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 fld   dword ptr [eax]
 fmul  dword ptr [edx]
 fld   dword ptr [eax+$04]
 fmul  dword ptr [edx+$04]
 faddp
 fmul  st(0), st(1)
 fstp  dword ptr [ecx]
 wait
 //Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
 fld   dword ptr [eax+$04]
 fmul  dword ptr [edx]
 fld   dword ptr [eax]
 fmul  dword ptr [edx+$04]
 fsubp
 fmulp st(1), st(0)
 fstp  dword ptr [ecx+$04]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCIA32_2(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 //Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 fld   dword ptr [edx]
 fld   st(0)
 fmul  st(0), st(0)
 fld   dword ptr [edx+$04]
 fld   st(0)
 fmul  st(0), st(0)
 fadd  st(0), st(2)
 ffree st(2)
 fld1
 fdivrp
 wait
 //Result.RealPart := (X.RealPart * Y.RealPart) + (X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 fld   dword ptr [eax]
 fld   st(0)
 fmul  st(0), st(5)
 fld   dword ptr [eax+$04]
 fld   st(0)
 fmul  st(0), st(5)
 fadd  st(0), st(2);
 ffree st(2)
 fmul  st(0), st(4)
 fstp  dword ptr [ecx]
 wait
 //Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
 fmul  st(0), st(6)
 ffree st(6)
 fxch  st(2)
 fmul  st(0), st(4)
 ffree st(4)
 fsubr st(0), st(2)
 ffree st(2)
 fmul  st(0), st(3)
 ffree st(3)
 fstp  dword ptr [ecx+$04]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function RegtDivDKCIA32_3(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
 //Temp := 1 / (Y.RealPart * Y.RealPart + Y.ImaginaryPart * Y.ImaginaryPart);
 fld   dword ptr [edx]
 fmul  st(0),st(0)
 fld   dword ptr [edx+$04]
 fmul  st(0),st(0)
 faddp
 fld1
 fdivrp
 wait
 //Result.RealPart := (X.RealPart * Y.RealPart) + (X.ImaginaryPart * Y.ImaginaryPart) * Temp;
 fld   dword ptr [eax]
 fmul  dword ptr [edx]
 fld   dword ptr [eax+$04]
 fmul  dword ptr [edx+$04]
 faddp
 fmul  st(0), st(1)
 fstp  dword ptr [ecx]
 wait
 //Result.ImaginaryPart := (X.ImaginaryPart * Y.RealPart - X.RealPart * Y.ImaginaryPart) * Temp;
 fld   dword ptr [eax+$04]
 fmul  dword ptr [edx]
 fld   dword ptr [eax]
 fmul  dword ptr [edx+$04]
 fsubp
 fmulp st(1), st(0)
 fstp  dword ptr [ecx+$04]
 wait
end;

end.
