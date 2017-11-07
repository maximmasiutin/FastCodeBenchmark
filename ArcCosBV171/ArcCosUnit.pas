unit ArcCosUnit;

interface

function ArcCosDKC1(const X : Extended): Extended; overload;
function ArcCosDKC1(const X : Double): Double; overload;
function ArcCosDKC1(const X : Single): Single; overload;
function ArcCosNJ1(const X : Extended) : Extended; overload;
function ArcCosNJ1(const X : Double) : Double; overload;
function ArcCosNJ1(const X : Single) : Single; overload;

implementation


//Author Norbert Juffa

function ArcCosNJ1(const X : Extended) : Extended; overload;
asm
 //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
 FLD   X
 FLD1
 FADD  ST(0), ST(1)
 FLD1
 FSUB  ST(0), ST(2)
 FMULP ST(1), ST(0)
 FSQRT
 FXCH
 FPATAN
end;

function ArcCosNJ1(const X : Double) : Double; overload;
asm
 //Result := ArcTan2(Sqrt((1+X) * (1-X)), X)
 FLD   X
 FLD1
 FADD  ST(0), ST(1)
 FLD1
 FSUB  ST(0), ST(2)
 FMULP ST(1), ST(0)
 FSQRT
 FXCH
 FPATAN
end;

function ArcCosNJ1(const X : Single) : Single; overload;
asm
 //Result := ArcTan2(X, Sqrt((1+X) * (1-X)), X)
 FLD   X
 FLD1
 FADD  ST(0), ST(1)
 FLD1
 FSUB  ST(0), ST(2)
 FMULP ST(1), ST(0)
 FSQRT
 FXCH
 FPATAN
end;

function ArcCosDKC1(const X : Extended): Extended; overload;
//Result := ArcTan2(Sqrt(1 - X * X), X);
asm
      FLD     X
      FLD     ST(0)
      FLD     ST(0)
      FMULP
      FLD1
      FSUBRP  ST(1), ST(0)
      FSQRT
      FXCH
      FPATAN
end;

function ArcCosDKC1(const X : Double): Double; overload;
//Result := ArcTan2(Sqrt(1 - X * X), X);
asm
      FLD     X
      FLD     ST(0)
      FLD     ST(0)
      FMULP
      FLD1
      FSUBRP  ST(1), ST(0)
      FSQRT
      FXCH
      FPATAN
end;

function ArcCosDKC1(const X : Single): Single; overload;
//Result := ArcTan2(Sqrt(1 - X * X), X);
asm
      FLD     X
      FLD     ST(0)
      FLD     ST(0)
      FMULP
      FLD1
      FSUBRP  ST(1), ST(0)
      FSQRT
      FXCH
      FPATAN
end;

end.
