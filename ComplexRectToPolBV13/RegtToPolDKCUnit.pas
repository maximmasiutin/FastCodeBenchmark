unit RegtToPolDKCUnit;

interface

uses
 ComplexDataTypesUnit;

function RegtToPolDKCPas1(const X : TRegtangularComplexE) : TPolarComplexE; overload;
function RegtToPolDKCIA32_1(const X : TRegtangularComplexE) : TPolarComplexE; overload;
function RegtToPolDKCPas1(const X : TRegtangularComplexD) : TPolarComplexD; overload;
function RegtToPolDKCIA32_1(const X : TRegtangularComplexD) : TPolarComplexD; overload;
function RegtToPolDKCPas1(const X : TRegtangularComplexS) : TPolarComplexS; overload;
function RegtToPolDKCIA32_1(const X : TRegtangularComplexS) : TPolarComplexS; overload;
function RegtToPolDKCIA32_2(const X : TRegtangularComplexS) : TPolarComplexS; overload;

implementation

uses
 Math;

function RegtToPolDKCPas1(const X : TRegtangularComplexE) : TPolarComplexE; overload;
begin
 Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
 Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
end;

function RegtToPolDKCIA32_1(const X : TRegtangularComplexE) : TPolarComplexE; overload;
asm
   //Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
   fld   tbyte ptr [eax+16]
   fld   st(0)
   fmul  st(0), st(0)
   fxch  st(1)
   fld   tbyte ptr [eax]
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(0),st(3)
   ffree st(3)
   fsqrt
   fstp  tbyte ptr [edx]
   //Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
   fpatan
   fstp  tbyte ptr [edx+16]
end;

function RegtToPolDKCPas1(const X : TRegtangularComplexD) : TPolarComplexD; overload;
begin
 Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
 Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart);
end;

function RegtToPolDKCIA32_1(const X : TRegtangularComplexD) : TPolarComplexD; overload;
asm
   //Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
   fld   qword ptr [eax+$08]
   fld   st(0)
   fmul  st(0), st(0)
   fxch  st(1)
   fld   qword ptr [eax]
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(0),st(3)
   ffree st(3)
   fsqrt
   fstp  qword ptr [edx]
   //Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
   fpatan
   fstp  qword ptr [edx+$08]
end;

function RegtToPolDKCPas1(const X : TRegtangularComplexS) : TPolarComplexS; overload;
begin
 Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
 Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart);
end;

function RegtToPolDKCIA32_1(const X : TRegtangularComplexS) : TPolarComplexS; overload;
asm
   //Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
   fld   dword ptr [eax]
   fmul  st(0), st(0)
   fld   dword ptr [eax+$04]
   fmul  st(0),st(0)
   faddp
   fsqrt
   fstp  dword ptr [edx]
   //Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
   fld   dword ptr [eax+$04]
   fld   dword ptr [eax]
   fpatan
   fstp  dword ptr [edx+$04]
end;

function RegtToPolDKCIA32_2(const X : TRegtangularComplexS) : TPolarComplexS; overload;
asm
   //Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
   fld   dword ptr [eax+$04]
   fld   st(0)
   fmul  st(0), st(0)
   fxch  st(1)
   fld   dword ptr [eax]
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(0),st(3)
   ffree st(3)
   fsqrt
   fstp  dword ptr [edx]
   //Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
   fpatan
   fstp  dword ptr [edx+$04]
end;

end.
