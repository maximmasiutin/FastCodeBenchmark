unit ArcSinJOHUnit;

interface

function ArcSinJOH(const X : Extended) : Extended; overload;
function ArcSinJOH(const X : Double) : Double; overload;
function ArcSinJOH(const X : Single) : Single; overload;

implementation

function ArcSinJOH(const X : Extended) : Extended; overload;
asm
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fpatan
end;

function ArcSinJOH(const X : Double) : Double; overload;
asm
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fpatan
end;

function ArcSinJOH(const X : Single) : Single; overload;
asm
  fld1
  fld    X
  fst    st(2)
  fmul   st(0), st(0)
  fsubp
  fsqrt
  fpatan
end;

end.

