unit PolAddDKCUnit;

interface

uses
 ComplexDataTypesUnit;

function PolAdd_DKC_Pas_1(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
function PolAdd_DKC_Pas_1(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
function PolAdd_DKC_Pas_1(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
function PolAdd_DKC_Pas_2(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
function PolAdd_DKC_Pas_2(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
function PolAdd_DKC_Pas_2(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
function PolAdd_DKC_Pas_3(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
function PolAdd_DKC_Pas_3(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
function PolAdd_DKC_Pas_3(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
function PolAdd_DKC_IA32_1(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
function PolAdd_DKC_IA32_1(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
function PolAdd_DKC_IA32_1(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
function PolAdd_DKC_IA32_2(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
function PolAdd_DKC_IA32_2(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
function PolAdd_DKC_IA32_2(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
function PolAdd_DKC_IA32_3(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
//function PolAdd_DKC_IA32_3(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
//function PolAdd_DKC_IA32_3(const X, Y : TPolarComplexS) : TPolarComplexS; overload;

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

//Author:            Dennis Kjaer Christensen
//Date:              11/1 2004
//Instructionset(s): IA32

function RectAddDKCPas1(const X, Y : TRectangularComplexE) : TRectangularComplexE; overload;
begin
 Result.RealPart := X.RealPart + Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              11/1 2004
//Instructionset(s): IA32

function RectAddDKCPas1(const X, Y : TRectangularComplexD) : TRectangularComplexD; overload;
begin
 Result.RealPart := X.RealPart + Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              11/1 2004
//Instructionset(s): IA32

function RectAddDKCPas1(const X, Y : TRectangularComplexS) : TRectangularComplexS; overload;
begin
 Result.RealPart := X.RealPart + Y.RealPart;
 Result.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart;
end;

//Author:            Dennis Kjaer Christensen
//Date:              8/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_Pas_1(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;

begin
 Temp1 := PolToRectDKCPas1(X);
 Temp2 := PolToRectDKCPas1(Y);
 Temp3 := RectAddDKCPas1(Temp1, Temp2);
 Result := RectToPolDKCPas1(Temp3);
end;

//Author:            Dennis Kjaer Christensen
//Date:              8/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_Pas_1(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexD;

begin
 Temp1 := PolToRectDKCPas1(X);
 Temp2 := PolToRectDKCPas1(Y);
 Temp3 := RectAddDKCPas1(Temp1, Temp2);
 Result := RectToPolDKCPas1(Temp3);
end;

//Author:            Dennis Kjaer Christensen
//Date:              8/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_Pas_1(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexS;

begin
 Temp1 := PolToRectDKCPas1(X);
 Temp2 := PolToRectDKCPas1(Y);
 Temp3 := RectAddDKCPas1(Temp1, Temp2);
 Result := RectToPolDKCPas1(Temp3);
end;

//Author:            Dennis Kjaer Christensen
//Date:              26/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_Pas_2(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;

begin
 Temp1.RealPart := Cos(X.Phase) * X.Amplitude;
 Temp1.ImaginaryPart := Sin(X.Phase) * X.Amplitude;
 Temp2.RealPart := Cos(Y.Phase) * Y.Amplitude;
 Temp2.ImaginaryPart := Sin(Y.Phase) * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              26/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_Pas_2(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexD;

begin
 Temp1.RealPart := Cos(X.Phase) * X.Amplitude;
 Temp1.ImaginaryPart := Sin(X.Phase) * X.Amplitude;
 Temp2.RealPart := Cos(Y.Phase) * Y.Amplitude;
 Temp2.ImaginaryPart := Sin(Y.Phase) * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              26/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_Pas_2(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexS;

begin
 Temp1.RealPart := Cos(X.Phase) * X.Amplitude;
 Temp1.ImaginaryPart := Sin(X.Phase) * X.Amplitude;
 Temp2.RealPart := Cos(Y.Phase) * Y.Amplitude;
 Temp2.ImaginaryPart := Sin(Y.Phase) * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_Pas_3(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
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
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_Pas_3(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexD;
 CosXPhase, SinXPhase, CosYPhase, SinYPhase : Extended;

begin
 SinCos(X.Phase, SinXPhase, CosXPhase);
 Temp1.RealPart := CosXPhase * X.Amplitude;
 Temp1.ImaginaryPart := SinXPhase * X.Amplitude;
 SinCos(Y.Phase, SinYPhase, CosYPhase);
 Temp2.RealPart := CosYPhase * Y.Amplitude;
 Temp2.ImaginaryPart := SinYPhase * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_Pas_3(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexS;
 CosXPhase, SinXPhase, CosYPhase, SinYPhase : Extended;

begin
 SinCos(X.Phase, SinXPhase, CosXPhase);
 Temp1.RealPart := CosXPhase * X.Amplitude;
 Temp1.ImaginaryPart := SinXPhase * X.Amplitude;
 SinCos(Y.Phase, SinYPhase, CosYPhase);
 Temp2.RealPart := CosYPhase * Y.Amplitude;
 Temp2.ImaginaryPart := SinYPhase * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

function PolToRectDKCIA32_2(const X : TPolarComplexE) : TRectangularComplexE; overload;
asm
 fld     tbyte ptr [eax+$10]
 fsincos
 fld     tbyte ptr [eax]
 fmul    st(1), st(0)
 fmulp   st(2), st(0)
 fstp    tbyte ptr [edx]
 fstp    tbyte ptr [edx+$10]
 wait
end;

function PolToRectDKCIA32_2(const X : TPolarComplexD) : TRectangularComplexD; overload;
asm
 fld     qword ptr [eax+8]
 fsincos
 fld     qword ptr [eax]
 fmul    st(1), st(0)
 fmulp   st(2), st(0)
 fstp    qword ptr [edx]
 fstp    qword ptr [edx+8]
 wait
end;

function PolToRectDKCIA32_2(const X : TPolarComplexS) : TRectangularComplexS; overload;
asm
 fld     dword ptr [eax+4]
 fsincos
 fld     dword ptr [eax]
 fmul    st(1), st(0)
 fmulp   st(2), st(0)
 fstp    dword ptr [edx]
 fstp    dword ptr [edx+4]
 wait
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_IA32_1(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;
 CosYPhase, SinYPhase : Extended;

begin
 Temp1 := PolToRectDKCIA32_2(X);
 SinCos(Y.Phase, SinYPhase, CosYPhase);
 Temp2.RealPart := CosYPhase * Y.Amplitude;
 Temp2.ImaginaryPart := SinYPhase * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_IA32_1(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexD;
 CosYPhase, SinYPhase : Extended;

begin
 Temp1 := PolToRectDKCIA32_2(X);
 SinCos(Y.Phase, SinYPhase, CosYPhase);
 Temp2.RealPart := CosYPhase * Y.Amplitude;
 Temp2.ImaginaryPart := SinYPhase * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_IA32_1(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexS;
 CosYPhase, SinYPhase : Extended;

begin
 Temp1 := PolToRectDKCIA32_2(X);
 SinCos(Y.Phase, SinYPhase, CosYPhase);
 Temp2.RealPart := CosYPhase * Y.Amplitude;
 Temp2.ImaginaryPart := SinYPhase * Y.Amplitude;
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result.Amplitude := Sqrt(Temp3.RealPart * Temp3.RealPart + Temp3.ImaginaryPart * Temp3.ImaginaryPart);
 Result.Phase := ArcTan2(Temp3.ImaginaryPart, Temp3.RealPart)
end;

function RectToPolDKCIA32_3(const X : TRectangularComplexE) : TPolarComplexE; overload;
asm
   //Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
   fld   tbyte ptr [eax+16]
   fld   st(0)
   fmul  st(0), st(0)
   fxch  st(1)
   fld   tbyte ptr [eax]
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(0),st(3)
   ffree st(3)
   fsqrt
   fstp  tbyte ptr [edx]
   //Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
   fpatan
   fstp  tbyte ptr [edx+16]
end;

function RectToPolDKCIA32_3(const X : TRectangularComplexD) : TPolarComplexD; overload;
asm
   //Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
   fld   qword ptr [eax+$08]
   fld   st(0)
   fmul  st(0), st(0)
   fxch  st(1)
   fld   qword ptr [eax]
   fld   st(0)
   fmul  st(0),st(0)
   fadd  st(0),st(3)
   ffree st(3)
   fsqrt
   fstp  qword ptr [edx]
   //Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
   fpatan
   fstp  qword ptr [edx+$08]
end;

function RectToPolDKCIA32_3(const X : TRectangularComplexS) : TPolarComplexS; overload;
asm
   //Result.Amplitude := Sqrt(X.RealPart * X.RealPart + X.ImaginaryPart * X.ImaginaryPart);
   fld   dword ptr [eax]
   fmul  st(0), st(0)
   fld   dword ptr [eax+$04]
   fmul  st(0),st(0)
   faddp
   fsqrt
   fstp  dword ptr [edx]
   //Result.Phase := ArcTan2(X.ImaginaryPart, X.RealPart)
   fld   dword ptr [eax+$04]
   fld   dword ptr [eax]
   fpatan
   fstp  dword ptr [edx+$04]
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_IA32_2(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexE;

begin
 Temp1 := PolToRectDKCIA32_2(X);
 Temp2 := PolToRectDKCIA32_2(Y);
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result := RectToPolDKCIA32_3(Temp3);
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_IA32_2(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexD;

begin
 Temp1 := PolToRectDKCIA32_2(X);
 Temp2 := PolToRectDKCIA32_2(Y);
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result := RectToPolDKCIA32_3(Temp3);
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_IA32_2(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
var
 Temp1, Temp2, Temp3 : TRectangularComplexS;

begin
 Temp1 := PolToRectDKCIA32_2(X);
 Temp2 := PolToRectDKCIA32_2(Y);
 Temp3.RealPart := Temp1.RealPart + Temp2.RealPart;
 Temp3.ImaginaryPart := Temp1.ImaginaryPart + Temp2.ImaginaryPart;
 Result := RectToPolDKCIA32_3(Temp3);
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/3 2005
//Instructionset(s): IA32

function PolAdd_DKC_IA32_3(const X, Y : TPolarComplexE) : TPolarComplexE; overload;
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
  faddp   st(2),st(0)
  faddp   st(2),st(0)
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
//Date:              30/3 2005
//Instructionset(s): IA32

//function PolAdd_DKC_IA32_3(const X, Y : TPolarComplexD) : TPolarComplexD; overload;
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
//  faddp   st(2),st(0)
//  faddp   st(2),st(0)
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
//Date:              30/3 2005
//Instructionset(s): IA32

//function PolAdd_DKC_IA32_3(const X, Y : TPolarComplexS) : TPolarComplexS; overload;
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
//  faddp   st(2),st(0)
//  faddp   st(2),st(0)
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

end.
