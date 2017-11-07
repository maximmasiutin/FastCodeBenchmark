unit PolToRectJOHUnit;

interface
                                   
uses
  Math, ComplexDataTypesUnit;

function PolToRect_JOH_PAS_1(const X : TPolarComplexS) : TRegtangularComplexS; overload;
function PolToRect_JOH_PAS_1(const X : TPolarComplexD) : TRegtangularComplexD; overload;
function PolToRect_JOH_PAS_1(const X : TPolarComplexE) : TRegtangularComplexE; overload;

function PolToRect_JOH_IA32_1(const X : TPolarComplexS) : TRegtangularComplexS; overload;
function PolToRect_JOH_IA32_1(const X : TPolarComplexD) : TRegtangularComplexD; overload;
function PolToRect_JOH_IA32_1(const X : TPolarComplexE) : TRegtangularComplexE; overload;

implementation

function PolToRect_JOH_IA32_1(const X : TPolarComplexS) : TRegtangularComplexS; overload;   
asm
 fld    X.Phase
 fsincos                               
 fld    X.Amplitude
 fmul   st(1), st(0)
 fmulp  st(2), st(0)
 fstp   Result.RealPart
 fstp   Result.ImaginaryPart
 fwait
end;

function PolToRect_JOH_IA32_1(const X : TPolarComplexD) : TRegtangularComplexD; overload;
asm
 fld    X.Phase
 fsincos
 fld    X.Amplitude
 fmul   st(1), st(0)
 fmulp  st(2), st(0)
 fstp   Result.RealPart
 fstp   Result.ImaginaryPart
 fwait
end;

function PolToRect_JOH_IA32_1(const X : TPolarComplexE) : TRegtangularComplexE; overload;
asm
 fld    X.Phase
 fsincos
 fld    X.Amplitude
 fmul   st(1), st(0)
 fmulp  st(2), st(0)
 fstp   Result.RealPart
 fstp   Result.ImaginaryPart
 fwait
end;

function PolToRect_JOH_PAS_1(const X : TPolarComplexS) : TRegtangularComplexS; overload;
var
  SinX, CosX: Extended;
begin
  SinCos(X.Phase, SinX, CosX);
  Result.RealPart := CosX * X.Amplitude;
  Result.ImaginaryPart := SinX * X.Amplitude;
end;

function PolToRect_JOH_PAS_1(const X : TPolarComplexD) : TRegtangularComplexD; overload;
var
  SinX, CosX: Extended;
begin
  SinCos(X.Phase, SinX, CosX);
  Result.RealPart := CosX * X.Amplitude;
  Result.ImaginaryPart := SinX * X.Amplitude;
end;

function PolToRect_JOH_PAS_1(const X : TPolarComplexE) : TRegtangularComplexE; overload;
var
  SinX, CosX: Extended;
begin
  SinCos(X.Phase, SinX, CosX);
  Result.RealPart := CosX * X.Amplitude;
  Result.ImaginaryPart := SinX * X.Amplitude;
end;

end.
