unit ArcSinUnit;

interface

function ArcSinDKC(const X: Extended): Extended; overload;
function ArcSinDKC(const X: Double): Double; overload;
function ArcSinDKC(const X: Single): Single; overload;
function ArcSinDKCPas1(const X : Single): Single; overload;
function ArcSinNJ(const X : Extended) : Extended; overload;
function ArcSinNJ(const X : Double) : Double; overload;
function ArcSinNJ(const X : Single) : Single; overload;

implementation

function ArcSinDKC(const X: Extended): Extended; overload;
asm
 //Result := ArcTan2(X, Sqrt(1 - X * X))
 FLD   X
 FLD   ST(0)
 FMUL  ST(0), ST(1)
 FLD1
 FSUBRP
 FSQRT
 FPATAN
end;

function ArcSinDKC(const X: Double): Double; overload;
asm
 //Result := ArcTan2(X, Sqrt(1 - X * X))
 FLD   X
 FLD   ST(0)
 FMUL  ST(0), ST(1)
 FLD1
 FSUBRP
 FSQRT
 FPATAN
end;

function ArcSinDKC(const X: Single): Single; overload;
asm
 //Result := ArcTan2(X, Sqrt(1 - X * X))
 FLD   X
 FLD   ST(0)
 FMUL  ST(0), ST(1)
 FLD1
 FSUBRP
 FSQRT
 FPATAN
end;

//Author Norbert Juffa

function ArcSinNJ(const X : Extended) : Extended; overload;
asm
 //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
 FLD   X
 FLD1
 FADD  ST(0), ST(1)
 FLD1
 FSUB  ST(0), ST(2)
 FMULP ST(1), ST(0)
 FSQRT
 FPATAN
end;

function ArcSinNJ(const X : Double) : Double; overload;
asm
 //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
 FLD   X
 FLD1
 FADD  ST(0), ST(1)
 FLD1
 FSUB  ST(0), ST(2)
 FMULP ST(1), ST(0)
 FSQRT
 FPATAN
end;

function ArcSinNJ(const X : Single) : Single; overload;
asm
 //Result := ArcTan2(X, Sqrt((1+X) * (1-X)))
 FLD   X
 FLD1
 FADD  ST(0), ST(1)
 FLD1
 FSUB  ST(0), ST(2)
 FMULP ST(1), ST(0)
 FSQRT
 FPATAN
end;

function ArcSinDKCPas1a(const X : Single): Single; overload;
var
 W, V, S, Sold, Delta, Update, TempResult : Extended;
 a, b, X1, X2, Y1, Y2 : Extended;
const
 LIMIT : Extended = 1E-11;

begin
 if (-0.9999 < X) and (X < 0.9999) then
  begin
   TempResult := X;
   W := 1;
   V := 2;
   Sold := 1;
   S := 3;
   Update := X;
   repeat
    Delta :=  Sold * ((W / V) * X * X) / S;
    Update := Update * Delta;
    TempResult := TempResult + Update;
    W := W + 2;
    V := V + 2;
    Sold := S;
    S := S + 2;
   until(Abs(Update) < LIMIT);
   Result := TempResult;
  end
 else
  begin
   //Linear interpolation
   X1 := 0.9999;
   X2 := 1;
   Y1 := 1.55665407331738;
   Y2 := PI/2;
   a := (Y2-Y1) / (X2-X1);
   //Y2 := PI/2 = X2*a + b -> b = PI/2 - X2*a;
   b := PI*0.5 - X2*a;
   //a := 140.111000000048;
   //b := -138.541999999945;
   if (X > 0) then
    Result := a * X + b
   else
    Result := -(-a * X + b);
  end;
end;

function ArcSinDKCPas1b(const X : Single): Single; overload;
var
 W, V, S, Sold, Delta, Update, TempResult : Extended;
 a, b : Extended;
const
 LIMIT : Extended = 1E-11;

begin
 if (-0.9999 < X) and (X < 0.9999) then
  begin
   TempResult := X;
   W := 1;
   V := 2;
   Sold := 1;
   S := 3;
   Update := X;
   repeat
    Delta :=  Sold * ((W / V) * X * X) / S;
    Update := Update * Delta;
    TempResult := TempResult + Update;
    W := W + 2;
    V := V + 2;
    Sold := S;
    S := S + 2;
   until(Abs(Update) < LIMIT);
   Result := TempResult;
  end
 else
  begin
   a := 140.111000000048;
   b := -138.541999999945;
   if (X > 0) then
    Result := a * X + b
   else
    Result := -(-a * X + b);
  end;
end;
                  //A = 26,4679999999996 B = -53,9004000000002  C = 29,0004
function ArcSinDKCPas1(const X : Single): Single; overload;
var
 W, V, S, Sold, Delta, Update, TempResult : Extended;
 a, b, c : Extended;
const
 LIMIT : Extended = 1E-11;

begin
 if (-0.9999 < X) and (X < 0.9999) then
  begin
   TempResult := X;
   W := 1;
   V := 2;
   Sold := 1;
   S := 3;
   Update := X;
   repeat
    Delta :=  Sold * ((W / V) * X * X) / S;
    Update := Update * Delta;
    TempResult := TempResult + Update;
    W := W + 2;
    V := V + 2;
    Sold := S;
    S := S + 2;
   until(Abs(Update) < LIMIT);
   Result := TempResult;
  end
 else
  begin
   a := 26.4679999999996;
   b := -53.9004000000002;
   c := 29.0004;
   if (X > 0) then
    Result := a * X * X * X + b * X + c
   else
    Result := -(-a * X * X * X - b * X + c);
  end;
end;

end.
