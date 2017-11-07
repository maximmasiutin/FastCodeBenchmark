unit RectAdd_JOH;

interface

uses
 ComplexDataTypesUnit;

function RectAdd_JOH_IA32(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RectAdd_JOH_IA32(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RectAdd_JOH_IA32(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;

implementation

function RectAdd_JOH_IA32(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
  fld   X.RealPart
  fadd  Y.RealPart
  fld   X.ImaginaryPart
  fadd  Y.ImaginaryPart
  fstp  Result.ImaginaryPart
  fstp  Result.RealPart
  wait
end;

function RectAdd_JOH_IA32(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
  fld   X.RealPart
  fadd  Y.RealPart
  fld   X.ImaginaryPart
  fadd  Y.ImaginaryPart
  fstp  Result.ImaginaryPart
  fstp  Result.RealPart
  wait
end;

function RectAdd_JOH_IA32(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
  fld   X.RealPart
  fld   Y.RealPart
  faddp
  fstp  Result.RealPart
  fld   X.ImaginaryPart
  fld   Y.ImaginaryPart
  faddp
  fstp  Result.ImaginaryPart
  wait
end;

end.
