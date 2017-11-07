unit ArcCosJOHUnit;

interface

function ArcCosJOH(const X : Extended) : Extended; overload;
function ArcCosJOH(const X : Double  ) : Double;   overload;
function ArcCosJOH(const X : Single  ) : Single;   overload;

implementation

function ArcCosJOH(const X : Extended) : Extended; overload;
asm
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fxch
  fpatan
end;

function ArcCosJOH(const X : Double) : Double; overload;
asm
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fxch
  fpatan
end;

function ArcCosJOH(const X : Single) : Single; overload;
asm
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fxch
  fpatan
end;

end.

