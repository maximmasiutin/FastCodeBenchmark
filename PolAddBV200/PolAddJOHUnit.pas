unit PolAddJOHUnit;

interface                

uses
  ComplexDataTypesUnit, Math;

function PolAdd_JOH_IA32_1(const X, Y: TPolarComplexS): TPolarComplexS; overload;
function PolAdd_JOH_IA32_1(const X, Y: TPolarComplexD): TPolarComplexD; overload;
function PolAdd_JOH_IA32_1(const X, Y: TPolarComplexE): TPolarComplexE; overload;

function PolAdd_JOH_PAS_1(const X, Y: TPolarComplexS): TPolarComplexS; overload;
function PolAdd_JOH_PAS_1(const X, Y: TPolarComplexD): TPolarComplexD; overload;
function PolAdd_JOH_PAS_1(const X, Y: TPolarComplexE): TPolarComplexE; overload;

implementation

function PolAdd_JOH_IA32_1(const X, Y: TPolarComplexS): TPolarComplexS; overload;
asm
  fld    X.Amplitude
  fld    st(0)
  fld    X.Phase
  fsincos
  fmulp  st(2), st(0)
  fmulp  st(2), st(0)
  fld    Y.Amplitude
  fld    st(0)
  fld    Y.Phase
  fsincos
  fmulp  st(2), st(0)
  fmulp  st(2), st(0)
  faddp  st(2), st(0)
  faddp  st(2), st(0)
  fld    st(1)
  fld    st(1)
  fpatan
  fstp   Result.Phase
  fmul   st(0), st(0)
  fxch
  fmul   st(0), st(0)
  faddp
  fsqrt
  fstp   Result.Amplitude
  fwait
end;

function PolAdd_JOH_IA32_1(const X, Y: TPolarComplexD): TPolarComplexD; overload;
asm
  fld    X.Amplitude
  fld    st(0)
  fld    X.Phase
  fsincos
  fmulp  st(2), st(0)
  fmulp  st(2), st(0)
  fld    Y.Amplitude
  fld    st(0)
  fld    Y.Phase
  fsincos
  fmulp  st(2), st(0)
  fmulp  st(2), st(0)
  faddp  st(2), st(0)
  faddp  st(2), st(0)
  fld    st(1)
  fld    st(1)
  fpatan
  fstp   Result.Phase
  fmul   st(0), st(0)
  fxch
  fmul   st(0), st(0)
  faddp
  fsqrt
  fstp   Result.Amplitude
  fwait
end;

function PolAdd_JOH_IA32_1(const X, Y: TPolarComplexE): TPolarComplexE; overload;
asm
  fld    X.Amplitude
  fld    st(0)
  fld    X.Phase
  fsincos
  fmulp  st(2), st(0)
  fmulp  st(2), st(0)
  fld    Y.Amplitude
  fld    st(0)
  fld    Y.Phase
  fsincos
  fmulp  st(2), st(0)
  fmulp  st(2), st(0)
  faddp  st(2), st(0)
  faddp  st(2), st(0)
  fld    st(1)
  fld    st(1)
  fpatan
  fstp   Result.Phase
  fmul   st(0), st(0)
  fxch
  fmul   st(0), st(0)
  faddp
  fsqrt
  fstp   Result.Amplitude
  fwait
end;

function PolAdd_JOH_PAS_1(const X, Y: TPolarComplexS): TPolarComplexS; overload;
var
 x1, y1, x2, y2: Single; {Should be Extended for Better Precision}
 CosX, SinX, CosY, SinY: Extended;
begin
 SinCos(X.Phase, SinX, CosX);
 SinCos(Y.Phase, SinY, CosY);
 x1 := CosX * X.Amplitude;
 y1 := SinX * X.Amplitude;
 x2 := CosY * Y.Amplitude;
 y2 := SinY * Y.Amplitude;
 x1 := x1 + x2;
 y1 := y1 + y2;
 Result.Amplitude := Sqrt((x1 * x1) + (y1 * y1));
 Result.Phase := ArcTan2(y1, x1);
end;

function PolAdd_JOH_PAS_1(const X, Y: TPolarComplexD): TPolarComplexD; overload;
var
 x1, y1, x2, y2: Double; {Should be Extended for Better Precision}
 CosX, SinX, CosY, SinY: Extended;
begin
 SinCos(X.Phase, SinX, CosX);
 SinCos(Y.Phase, SinY, CosY);
 x1 := CosX * X.Amplitude;
 y1 := SinX * X.Amplitude;
 x2 := CosY * Y.Amplitude;
 y2 := SinY * Y.Amplitude;
 x1 := x1 + x2;
 y1 := y1 + y2;
 Result.Amplitude := Sqrt((x1 * x1) + (y1 * y1));
 Result.Phase := ArcTan2(y1, x1);
end;

function PolAdd_JOH_PAS_1(const X, Y: TPolarComplexE): TPolarComplexE; overload;
var
 x1, y1, x2, y2: Extended;
 CosX, SinX, CosY, SinY: Extended;
begin
 SinCos(X.Phase, SinX, CosX);
 SinCos(Y.Phase, SinY, CosY);
 x1 := CosX * X.Amplitude;
 y1 := SinX * X.Amplitude;
 x2 := CosY * Y.Amplitude;
 y2 := SinY * Y.Amplitude;
 x1 := x1 + x2;
 y1 := y1 + y2;
 Result.Amplitude := Sqrt((x1 * x1) + (y1 * y1));
 Result.Phase := ArcTan2(y1, x1);
end;


end.
