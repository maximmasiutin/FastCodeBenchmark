unit PolSubDKCUnit;

interface

uses
 ComplexDataTypesUnit;

function PolSub_DKC_Pas_1(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
function PolSub_DKC_Pas_1(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
function PolSub_DKC_Pas_1(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
function PolSub_DKC_Pas_2(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
function PolSub_DKC_Pas_2(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
function PolSub_DKC_Pas_2(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
function PolSub_DKC_IA32_1(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
//function PolSub_DKC_IA32_1(const X, Y : TPolarComplexD) : TPolarComplexD; overload; // Removed 18.01.2006 : gets stuck on Pentium 2
//function PolSub_DKC_IA32_1(const X, Y : TPolarComplexS) : TPolarComplexS; overload; // Removed 18.01.2006 : gets stuck on Pentium 2
function PolSub_DKC_IA32_2(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
//function PolSub_DKC_IA32_2(const X, Y : TPolarComplexD) : TPolarComplexD; overload; // Removed 18.01.2006 : gets stuck on Pentium 2
//function PolSub_DKC_IA32_2(const X, Y : TPolarComplexS) : TPolarComplexS; overload; // Removed 18.01.2006 : gets stuck on Pentium 2

function PolSub_DKC_Pas_3(const X, Y : TPolarComplexD) : TPolarComplexD; overload;

implementation

uses
 Math;

function RectToPolDKCPas1(const X : TRectangularComplexE) : TPolarComplexE; overload;
begin
 Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
 Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
end;

function RectToPolDKCPas1(const X : TRectangularComplexD) : TPolarComplexD; overload;
begin
 Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
 Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart);
end;

function RectToPolDKCPas1(const X : TRectangularComplexS) : TPolarComplexS; overload;
begin
 Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
 Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart);
end;

function PolToRectDKCPas1(const X : TPolarComplexE) : TRectangularComplexE; overload;
begin
 Result.RealPart := Cos(X.Phase) * X.Amplitude;
 Result.ImaginaryPart := Sin(X.Phase) * X.Amplitude;
end;

function PolToRectDKCPas1(const X : TPolarComplexD) : TRectangularComplexD; overload;
begin
 Result.RealPart := Cos(X.Phase) * X.Amplitude;
 Result.ImaginaryPart := Sin(X.Phase) * X.Amplitude;
end;

function PolToRectDKCPas1(const X : TPolarComplexS) : TRectangularComplexS; overload;
begin
 Result.RealPart := Cos(X.Phase) * X.Amplitude;
 Result.ImaginaryPart := Sin(X.Phase) * X.Amplitude;
end;

function RectSubDKCPas1(const X, Y : TRectangularComplexE) : TRectangularComplexE; overload;
begin
 Result.RealPart := X.RealPart - Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart - Y.ImaginaryPart;
end;

function RectSubDKCPas1(const X, Y : TRectangularComplexD) : TRectangularComplexD; overload;
begin
 Result.RealPart := X.RealPart - Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart - Y.ImaginaryPart;
end;

function RectSubDKCPas1(const X, Y : TRectangularComplexS) : TRectangularComplexS; overload;
begin
 Result.RealPart := X.RealPart - Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart - Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

function PolSub_DKC_Pas_1(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;

begin
 Temp1 := PolToRectDKCPas1(X);
 Temp2 := PolToRectDKCPas1(Y);
 Temp3 := RectSubDKCPas1(Temp1, Temp2);
 Result := RectToPolDKCPas1(Temp3);
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

function PolSub_DKC_Pas_1(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;
 Resulta, Xa, Ya : TPolarComplexE;

begin
 Xa.Amplitude := X.Amplitude;
 Xa.Phase := X.Phase;
 Temp1 := PolToRectDKCPas1(Xa);
 Ya.Amplitude := Y.Amplitude;
 Ya.Phase := Y.Phase;
 Temp2 := PolToRectDKCPas1(Ya);
 Temp3 := RectSubDKCPas1(Temp1, Temp2);
 Resulta := RectToPolDKCPas1(Temp3);
 Result.Amplitude := Resulta.Amplitude;
 Result.Phase := Resulta.Phase;
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

function PolSub_DKC_Pas_1(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;
 Resulta, Xa, Ya : TPolarComplexE;

begin
 Xa.Amplitude := X.Amplitude;
 Xa.Phase := X.Phase;
 Temp1 := PolToRectDKCPas1(Xa);
 Ya.Amplitude := Y.Amplitude;
 Ya.Phase := Y.Phase;
 Temp2 := PolToRectDKCPas1(Ya);
 Temp3 := RectSubDKCPas1(Temp1, Temp2);
 Resulta := RectToPolDKCPas1(Temp3);
 Result.Amplitude := Resulta.Amplitude;
 Result.Phase := Resulta.Phase;
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

function PolSub_DKC_Pas_2(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;
 CosXPhase, SinXPhase, CosYPhase, SinYPhase : Extended;

begin
 SinCos(X.Phase, SinXPhase, CosXPhase);
 Temp1.RealPart := CosXPhase * X.Amplitude;
 Temp1.ImaginaryPart := SinXPhase * X.Amplitude;
 SinCos(Y.Phase, SinYPhase, CosYPhase);
 Temp2.RealPart := CosYPhase * Y.Amplitude;
 Temp2.ImaginaryPart := SinYPhase * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart - Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart - Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

function PolSub_DKC_Pas_2(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;
 CosXPhase, SinXPhase, CosYPhase, SinYPhase : Extended;

begin
 SinCos(X.Phase, SinXPhase, CosXPhase);
 Temp1.RealPart := CosXPhase * X.Amplitude;
 Temp1.ImaginaryPart := SinXPhase * X.Amplitude;
 SinCos(Y.Phase, SinYPhase, CosYPhase);
 Temp2.RealPart := CosYPhase * Y.Amplitude;
 Temp2.ImaginaryPart := SinYPhase * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart - Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart - Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

function PolSub_DKC_Pas_2(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;
 CosXPhase, SinXPhase, CosYPhase, SinYPhase : Extended;

begin
 SinCos(X.Phase, SinXPhase, CosXPhase);
 Temp1.RealPart := CosXPhase * X.Amplitude;
 Temp1.ImaginaryPart := SinXPhase * X.Amplitude;
 SinCos(Y.Phase, SinYPhase, CosYPhase);
 Temp2.RealPart := CosYPhase * Y.Amplitude;
 Temp2.ImaginaryPart := SinYPhase * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart - Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart - Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

function PolSub_DKC_IA32_1(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
asm
  fld     X.Phase
  fsincos
  fld     X.Amplitude
  fmul    st(1),st(0)
  fmulp   st(2),st(0)
  fld     Y.Phase
  fsincos
  fld     Y.Amplitude
  fmul    st(1),st(0)
  fmulp   st(2),st(0)
  fsubp   st(2),st(0)
  fsubp   st(2),st(0)
  fld     st(1)
  fld     st(1)
  fmul    st(0),st(0)
  fxch    st(1)
  fmul    st(0),st(0)
  faddp
  fsqrt
  fstp    Result.Amplitude
  fpatan
  fstp    Result.Phase
  fwait
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

//function PolSub_DKC_IA32_1(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
//asm
//  fld     X.Phase
//  fsincos
//  fld     X.Amplitude
//  fmul    st(1),st(0)
//  fmulp   st(2),st(0)
//  fld     Y.Phase
//  fsincos
//  fld     Y.Amplitude
//  fmul    st(1),st(0)
//  fmulp   st(2),st(0)
//  fsubp   st(2),st(0)
//  fsubp   st(2),st(0)
//  fld     st(1)
//  fld     st(1)
//  fmul    st(0),st(0)
//  fxch    st(1)
//  fmul    st(0),st(0)
//  faddp
//  fsqrt
//  fstp    Result.Amplitude
//  fpatan
//  fstp    Result.Phase
//  fwait
//end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

//function PolSub_DKC_IA32_1(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
//asm
//  fld     X.Phase
//  fsincos
//  fld     X.Amplitude
//  fmul    st(1),st(0)
//  fmulp   st(2),st(0)
//  fld     Y.Phase
//  fsincos
//  fld     Y.Amplitude
//  fmul    st(1),st(0)
//  fmulp   st(2),st(0)
//  fsubp   st(2),st(0)
//  fsubp   st(2),st(0)
//  fld     st(1)
//  fld     st(1)
//  fmul    st(0),st(0)
//  fxch    st(1)
//  fmul    st(0),st(0)
//  faddp
//  fsqrt
//  fstp    Result.Amplitude
//  fpatan
//  fstp    Result.Phase
//  fwait
//end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

function PolSub_DKC_IA32_2(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
asm
  fld     X.Phase
  fsincos
  fld     X.Amplitude
  fmul    st(1),st(0)
  fmulp   st(2),st(0)
  fld     Y.Phase
  fsincos
  fld     Y.Amplitude
  fmul    st(1),st(0)
  fmulp   st(2),st(0)
  fsubp   st(2),st(0)
  fsubp   st(2),st(0)
  fld     st(1)
  fld     st(1)
  fmul    st(0),st(0)
  fxch    st(1)
  fmul    st(0),st(0)
  faddp
  fsqrt
  fstp    Result.Amplitude
  fpatan
  fstp    Result.Phase
  fwait
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

//function PolSub_DKC_IA32_2(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
//asm
//  fld     X.Phase
//  fsincos
//  fld     X.Amplitude
//  fmul    st(1),st(0)
//  fmulp   st(2),st(0)
//  fld     Y.Phase
//  fsincos
//  fld     Y.Amplitude
//  fmul    st(1),st(0)
//  fmulp   st(2),st(0)
//  fsubp   st(2),st(0)
//  fsubp   st(2),st(0)
//  fld     st(1)
//  fld     st(1)
//  fmul    st(0),st(0)
//  fxch    st(1)
//  fmul    st(0),st(0)
//  faddp
//  fsqrt
//  fstp    Result.Amplitude
//  fpatan
//  fstp    Result.Phase
//  fwait
//end;

//Author:            Dennis Kjaer Christensen
//Date:              1/4 2005
//Instructionset(s): IA32

//function PolSub_DKC_IA32_2(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
//asm
//  fld     X.Phase
//  fsincos
//  fld     X.Amplitude
//  fmul    st(1),st(0)
//  fmulp   st(2),st(0)
//  fld     Y.Phase
//  fsincos
//  fld     Y.Amplitude
//  fmul    st(1),st(0)
//  fmulp   st(2),st(0)
//  fsubp   st(2),st(0)
//  fsubp   st(2),st(0)
//  fld     st(1)
//  fld     st(1)
//  fmul    st(0),st(0)
//  fxch    st(1)
//  fmul    st(0),st(0)
//  faddp
//  fsqrt
//  fstp    Result.Amplitude
//  fpatan
//  fstp    Result.Phase
//  fwait
//end;

//Author:            Dennis Kjaer Christensen
//Date:              21/5 2005
//Instructionset(s): IA32

function PolSub_DKC_Pas_3(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexD;

begin
 Temp1 := PolToRectDKCPas1(X);
 Temp2 := PolToRectDKCPas1(Y);
 Temp3 := RectSubDKCPas1(Temp1, Temp2);
 Result := RectToPolDKCPas1(Temp3);
end;

end.
