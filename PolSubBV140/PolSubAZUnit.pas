unit PolSubAZUnit;

interface

uses
 ComplexDataTypesUnit;

function PolSub_AZ_IA32_1(const X, Y : TPolarComplexS): TPolarComplexS; overload;
function PolSub_AZ_IA32_1(const X, Y : TPolarComplexD): TPolarComplexD; overload;
function PolSub_AZ_IA32_1(const X, Y : TPolarComplexE): TPolarComplexE; overload;

implementation

function PolSub_AZ_IA32_1(const X, Y : TPolarComplexS): TPolarComplexS; overload;
asm
  fld    X.Phase
  fsincos
  fld    X.Amplitude
  fmul   st(2), st(0)
  fmulp  st(1), st(0)

  fld    Y.Phase
  fsincos
  fld    Y.Amplitude
  fmul   st(2), st(0)
  fmulp  st(1), st(0)

  fsubp  st(2), st(0)
  fsubp  st(2), st(0)

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

function PolSub_AZ_IA32_1(const X, Y : TPolarComplexD): TPolarComplexD; overload;
asm
  fld    X.Phase
  fsincos
  fld    X.Amplitude
  fmul   st(2), st(0)
  fmulp  st(1), st(0)

  fld    Y.Phase
  fsincos
  fld    Y.Amplitude
  fmul   st(2), st(0)
  fmulp  st(1), st(0)

  fsubp  st(2), st(0)
  fsubp  st(2), st(0)

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

function PolSub_AZ_IA32_1(const X, Y : TPolarComplexE): TPolarComplexE; overload;
asm
  fld    X.Phase
  fsincos
  fld    X.Amplitude
  fmul   st(2), st(0)
  fmulp  st(1), st(0)

  fld    Y.Phase
  fsincos
  fld    Y.Amplitude
  fmul   st(2), st(0)
  fmulp  st(1), st(0)

  fsubp  st(2), st(0)
  fsubp  st(2), st(0)

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

end.
