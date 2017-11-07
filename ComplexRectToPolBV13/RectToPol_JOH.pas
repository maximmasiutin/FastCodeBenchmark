unit RectToPol_JOH;

interface

uses
 ComplexDataTypesUnit, Math;

function RectToPol_JOH_PAS (const X : TRegtangularComplexS) : TPolarComplexS; overload;
function RectToPol_JOH_PAS (const X : TRegtangularComplexD) : TPolarComplexD; overload;
function RectToPol_JOH_PAS (const X : TRegtangularComplexE) : TPolarComplexE; overload;

function RectToPol_JOH_IA32(const X : TRegtangularComplexS) : TPolarComplexS; overload;
function RectToPol_JOH_IA32(const X : TRegtangularComplexD) : TPolarComplexD; overload;
function RectToPol_JOH_IA32(const X : TRegtangularComplexE) : TPolarComplexE; overload;

function RectToPol_JOH_IA32_2(const X : TRegtangularComplexS) : TPolarComplexS; overload;
function RectToPol_JOH_IA32_2(const X : TRegtangularComplexD) : TPolarComplexD; overload;
function RectToPol_JOH_IA32_2(const X : TRegtangularComplexE) : TPolarComplexE; overload;

implementation

function RectToPol_JOH_PAS (const X : TRegtangularComplexS) : TPolarComplexS; overload;
var
  XR, XI, Temp : Single;
begin
  XR := Abs(X.RealPart);
  XI := Abs(X.ImaginaryPart);
  if XR > XI then
    begin
      Temp := XR;
      XR   := XI;
      XI   := Temp;
    end;
  if XR = 0 then
    Result.Amplitude := XI
  else
    Result.Amplitude := XI * Sqrt(1 + Sqr(XR/XI));
//Result.Amplitude := Hypot(X.RealPart, X.ImaginaryPart);
  Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
end;

function RectToPol_JOH_PAS (const X : TRegtangularComplexD) : TPolarComplexD; overload;
var
  XR, XI, Temp : Double;
begin
  XR := Abs(X.RealPart);                    
  XI := Abs(X.ImaginaryPart);
  if XR > XI then
    begin
      Temp := XR;
      XR   := XI;
      XI := Temp;
    end;
  if XR = 0 then
    Result.Amplitude := XI
  else
    Result.Amplitude := XI * Sqrt(1 + Sqr(XR/XI));
//Result.Amplitude := Hypot(X.RealPart, X.ImaginaryPart);
  Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
end;

function RectToPol_JOH_PAS(const X : TRegtangularComplexE) : TPolarComplexE; overload;
var
  XR, XI, Temp : Extended;
begin
  XR := Abs(X.RealPart);
  XI := Abs(X.ImaginaryPart);
  if XR > XI then
    begin
      Temp := XR;
      XR   := XI;
      XI   := Temp;
    end;
  if XR = 0 then
    Result.Amplitude := XI
  else
    Result.Amplitude := XI * Sqrt(1 + Sqr(XR/XI));
//Result.Amplitude := Hypot(X.RealPart, X.ImaginaryPart);
  Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
end;

function RectToPol_JOH_IA32(const X : TRegtangularComplexS) : TPolarComplexS; overload;
asm
  fld    X.ImaginaryPart
  fld    X.RealPart
  fld    st(1)
  fabs
  fld    st(1)
  fabs
  fcom
  fnstsw
  test   ah, $45
  jnz    @@TestZero
  fxch   st(1)
@@TestZero:
  fldz
  fcomp
  fnstsw
  test   ah, $40
  jz     @@Calc
  fstp   st
  jmp    @@SetResult
@@Calc:
  fdiv   st, st(1)
  fmul   st, st
  fld1
  fadd
  fsqrt
  fmul
@@SetResult:
  fstp  Result.Amplitude
  fpatan
  fstp  Result.Phase
  wait
end;

function RectToPol_JOH_IA32(const X : TRegtangularComplexD) : TPolarComplexD; overload;
asm
  fld    X.ImaginaryPart
  fld    X.RealPart
  fld    st(1)
  fabs
  fld    st(1)
  fabs
  fcom
  fnstsw
  test   ah, $45
  jnz    @@TestZero
  fxch   st(1)
@@TestZero:
  fldz
  fcomp
  fnstsw
  test   ah, $40
  jz     @@Calc
  fstp   st
  jmp    @@SetResult
@@Calc:
  fdiv   st, st(1)
  fmul   st, st
  fld1
  fadd
  fsqrt
  fmul
@@SetResult:
  fstp  Result.Amplitude
  fpatan
  fstp  Result.Phase
  wait
end;

function RectToPol_JOH_IA32(const X : TRegtangularComplexE) : TPolarComplexE; overload;
asm
  fld    X.ImaginaryPart
  fld    X.RealPart
  fld    st(1)
  fabs
  fld    st(1)
  fabs
  fcom
  fnstsw
  test   ah, $45
  jnz    @@TestZero
  fxch   st(1)
@@TestZero:
  fldz
  fcomp
  fnstsw
  test   ah, $40
  jz     @@Calc
  fstp   st
  jmp    @@SetResult
@@Calc:
  fdiv   st, st(1)    
  fmul   st, st
  fld1
  fadd
  fsqrt
  fmul
@@SetResult:
  fstp  Result.Amplitude
  fpatan
  fstp  Result.Phase
  wait
end;

function RectToPol_JOH_IA32_2(const X : TRegtangularComplexS) : TPolarComplexS; overload;
asm
  fld    X.ImaginaryPart  //xi
  fld    X.RealPart       //xr           xi
  fld    st(1)            //xi           xr       xi
  fmul   st, st(2)        //xi*xi        xr       xi
  fld    st(1)            //xr           xi*xi    xr       xi
  fmul   st, st(2)        //xr*xr        xi*xi    xr       xi
  faddp  st(1), st        //xr*xr+xi*xi  xr       xi
  fsqrt                   //amplitude    xr       xi
  fstp   Result.Amplitude //xr           xi
  fpatan                  //phase
  fstp   Result.Phase
  wait
end;

function RectToPol_JOH_IA32_2(const X : TRegtangularComplexD) : TPolarComplexD; overload;
asm
  fld    X.ImaginaryPart
  fld    X.RealPart
  fld    st(1)
  fmul   st, st(2)
  fld    st(1)
  fmul   st, st(2)
  faddp  st(1), st
  fsqrt
  fstp   Result.Amplitude
  fpatan
  fstp   Result.Phase
  wait
end;

function RectToPol_JOH_IA32_2(const X : TRegtangularComplexE) : TPolarComplexE; overload;
asm
  fld    X.ImaginaryPart
  fld    X.RealPart
  fld    st(1)
  fmul   st, st(2)
  fld    st(1)
  fmul   st, st(2)
  faddp  st(1), st
  fsqrt
  fstp   Result.Amplitude
  fpatan
  fstp   Result.Phase
  wait
end;

end.

