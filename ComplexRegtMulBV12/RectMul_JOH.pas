unit RectMul_JOH;

interface

uses
 ComplexDataTypesUnit;

function RectMul_JOH_IA32(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RectMul_JOH_IA32(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RectMul_JOH_IA32(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;

implementation

function RectMul_JOH_IA32(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
  fld   X.RealPart           //xr
  fld   Y.RealPart           //yr,     xr
  fld   st(0)                //yr,     yr,     xr
  fmul  st(0), st(2)         //xr*yr,  yr,     xr
  fld   X.ImaginaryPart      //xi,     xr*yr,  yr,     xr
  fld   st(0)                //xi,     xi,     xr*yr,  yr,     xr
  fmulp st(3), st            //xi,     xr*yr,  xi*yr,  xr
  fld   Y.ImaginaryPart      //yi,     xi,     xr*yr,  xi*yr,  xr
  fld   st(0)                //yi,     yi,     xi,     xr*yr,  xi*yr,  xr
  fmulp st(5), st            //yi,     xi,     xr*yr,  xi*yr,  xr*yi
  fmulp st(1), st            //xi*yi,  xr*yr,  xi*yr,  xr*yi
  fsubp st(1), st            //Real,   xi*yr,  xr*yi
  fstp  Result.RealPart      //xi*yr,  xr*yi
  faddp st(1), st            //Imag
  fstp  Result.ImaginaryPart
  wait
end;

function RectMul_JOH_IA32(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
  fld   X.RealPart
  fld   Y.RealPart
  fld   st(0)
  fmul  st(0), st(2)
  fld   X.ImaginaryPart
  fld   st(0)
  fmulp st(3), st
  fld   Y.ImaginaryPart
  fld   st(0)
  fmulp st(5), st
  fmulp st(1), st
  fsubp st(1), st
  fstp  Result.RealPart
  faddp st(1), st
  fstp  Result.ImaginaryPart
  wait
end;

function RectMul_JOH_IA32(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
  fld   X.RealPart
  fld   Y.RealPart
  fld   st(0)
  fmul  st(0), st(2)
  fld   X.ImaginaryPart
  fld   st(0)
  fmulp st(3), st
  fld   Y.ImaginaryPart
  fld   st(0)
  fmulp st(5), st
  fmulp st(1), st
  fsubp st(1), st
  fstp  Result.RealPart
  faddp st(1), st
  fstp  Result.ImaginaryPart
  wait
end;

end.
