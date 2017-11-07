unit RectDiv_JOH;

interface

uses
 ComplexDataTypesUnit;

function RectDiv_JOH_IA32(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RectDiv_JOH_IA32(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RectDiv_JOH_IA32(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;

implementation

function RectDiv_JOH_IA32(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
  fld   Y.RealPart           //yr
  fld   Y.ImaginaryPart      //yi      yr
  fld   st(1)                //yr      yi      yr
  fmul  st, st               //yr^2    yi      yr
  fld   st(1)                //yi      yr^2    yi      yr
  fmul  st, st               //yi^2    yr^2    yi      yr
  faddp                      //1/temp  yi      yr
  fld1                       //1       1/temp  yi      yr
  fdivrp                     //Temp    yi,     yr
  fld   st(2)                //yr      Temp    yi      yr
  fld   st(2)                //yi      yr      Temp    yi      yr
  fld   X.RealPart           //xr      yi      yr      Temp    yi      yr
  fld   st(0)                 //xr      xr      yi      yr      Temp    yi      yr
  fmulp st(6), st            //xr      yi      yr      Temp    yi      xr*yr
  fmulp st(1), st            //xr*yi   yr      Temp    yi      xr*yr
  fld   X.ImaginaryPart      //xi      xr*yi   yr      Temp    yi      xr*yr
  fld   st(0)                //xi      xi      xr*yi   yr      Temp    yi      xr*yr
  fmulp st(5), st            //xi      xr*yi   yr      Temp    xi*yi   xr*yr
  fmulp st(2), st            //xr*yi   xi*yr   Temp    xi*yi   xr*yr
  fsubp st(1), st            //xi*yr-xr*yi   Temp    xi*yi   xr*yr
  fmul  st, st(1)            //xi*yr-xr*yi*Temp    Temp    xi*yi   xr*yr
  fstp  Result.ImaginaryPart //Temp    xi*yi   xr*yr
  fld   st(1)                //xi*yi   Temp    xi*yi   xr*yr
  fld   st(3)                //xr*yr   xi*yi   Temp    xi*yi   xr*yr
  faddp st(1), st            //xr*yr+xi*yi   Temp    xi*yi   xr*yr
  fmulp st(1), st            //xr*yr+xi*yi*Temp    xi*yi   xr*yr
  fstp  Result.RealPart      //xi*yi   xr*yr
  ffree st(0)
  ffree st(1)
  wait
end;

function RectDiv_JOH_IA32(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
  fld   Y.RealPart
  fld   Y.ImaginaryPart
  fld   st(1)
  fmul  st, st
  fld   st(1)
  fmul  st, st
  faddp
  fld1
  fdivrp
  fld   st(2)
  fld   st(2)
  fld   X.RealPart
  fld   st(0)
  fmulp st(6), st
  fmulp st(1), st
  fld   X.ImaginaryPart
  fld   st(0)
  fmulp st(5), st
  fmulp st(2), st
  fsubp st(1), st
  fmul  st, st(1)
  fstp  Result.ImaginaryPart
  fld   st(1)
  fld   st(3)
  faddp st(1), st
  fmulp st(1), st
  fstp  Result.RealPart
  ffree st(0)
  ffree st(1)
  wait
end;

function RectDiv_JOH_IA32(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
  fld   Y.RealPart
  fld   Y.ImaginaryPart
  fld   st(1)
  fmul  st, st
  fld   st(1)
  fmul  st, st
  faddp
  fld1
  fdivrp
  fld   st(2)
  fld   st(2)
  fld   X.RealPart
  fld   st(0)
  fmulp st(6), st
  fmulp st(1), st
  fld   X.ImaginaryPart
  fld   st(0)
  fmulp st(5), st
  fmulp st(2), st
  fsubp st(1), st
  fmul  st, st(1)
  fstp  Result.ImaginaryPart
  fld   st(1)
  fld   st(3)
  faddp st(1), st
  fmulp st(1), st
  fstp  Result.RealPart
  ffree st(0)
  ffree st(1)
  wait
end;

end.
