unit RectSub_JOH;

interface

uses
 ComplexDataTypesUnit;

function RectSub_JOH_IA32(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
function RectSub_JOH_IA32(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
function RectSub_JOH_IA32(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;

implementation

function RectSub_JOH_IA32(const X, Y : TRegtangularComplexS) : TRegtangularComplexS; overload;
asm
  fld   X.RealPart
  fsub  Y.RealPart
  fld   X.ImaginaryPart
  fsub  Y.ImaginaryPart
  fstp  Result.ImaginaryPart
  fstp  Result.RealPart
  wait
end;

function RectSub_JOH_IA32(const X, Y : TRegtangularComplexD) : TRegtangularComplexD; overload;
asm
  fld   X.RealPart
  fsub  Y.RealPart
  fld   X.ImaginaryPart
  fsub  Y.ImaginaryPart
  fstp  Result.ImaginaryPart
  fstp  Result.RealPart
  wait
end;

function RectSub_JOH_IA32(const X, Y : TRegtangularComplexE) : TRegtangularComplexE; overload;
asm
  fld   X.RealPart
  fld   Y.RealPart
  fSubp
  fstp  Result.RealPart
  fld   X.ImaginaryPart
  fld   Y.ImaginaryPart
  fSubp
  fstp  Result.ImaginaryPart
  wait
end;

end.
