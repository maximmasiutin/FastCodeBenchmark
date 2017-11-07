unit PolSubPLRUnit;

interface

uses
  ComplexDataTypesUnit, Math;

//function PolSub_PLR_IA32_1(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS; overload; // Removed 18.01.2006 : gets stuck on Pentium 2
//function PolSub_PLR_IA32_1(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD; overload; // Removed 18.01.2006 : gets stuck on Pentium 2
function PolSub_PLR_IA32_1(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE; overload;

function PolSub_PLR_IA32_2(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS; overload;
function PolSub_PLR_IA32_2(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD; overload;
function PolSub_PLR_IA32_2(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE; overload;

function PolSub_PLR_IA32_3(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS; overload;
function PolSub_PLR_IA32_3(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD; overload;
function PolSub_PLR_IA32_3(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE; overload;

function PolSub_PLR_IA32_4(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS; overload;
function PolSub_PLR_IA32_4(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD; overload;
function PolSub_PLR_IA32_4(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE; overload;

function PolSub_PLR_PAS_1(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS; overload;
function PolSub_PLR_PAS_1(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD; overload;
function PolSub_PLR_PAS_1(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE; overload;

implementation

//function PolSub_PLR_IA32_1(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS;
//asm
//  {On entry:
//    eax = @APolarComplex1
//    edx = @APolarComplex2
//    ecx = @Result}
//  {----Convert APolarComplex1 to cartesian coordinates----}
//  fld TPolarComplexS[eax].Phase
//  {Calculate the sine and cosine}
//  fsincos
//  {Load the amplitude}
//  fld TPolarComplexS[eax].Amplitude
//  {x = r cos(angle)}
//  fmul st(1), st(0)
//  {y = r sin(angle)}
//  fmulp st(2), st(0)
//  {----Convert APolarComplex2 to cartesian coordinates----}
//  fld TPolarComplexS[edx].Phase
//  {Calculate the sine and cosine}
//  fsincos
//  {Load the amplitude}
//  fld TPolarComplexS[edx].Amplitude
//  {x = r cos(angle)}
//  fmul st(1), st(0)
//  {y = r sin(angle)}
//  fmulp st(2), st(0)
//  {----Subtract the second cartesian coordinate----}
//  fsubp st(2), st(0)
//  fsubp st(2), st(0)
//  {----Calculate the amplitude----}
//  {Copy x coordinate}
//  fld st(0)
//  {Square it}
//  fmul st(0), st(0);
//  {Copy y coordinate}
//  fld st(2)
//  {Square it}
//  fmul st(0), st(0);
//  {Sum x^2 and y^2}
//  faddp st(1), st(0)
//  {Get the square root}
//  fsqrt
//  {Store the amplitude}
//  fstp TPolarComplexS[ecx].Amplitude
//  {----Calculate the phase----}
//  fpatan
//  fstp TPolarComplexS[ecx].Phase
//end;
//
//function PolSub_PLR_IA32_1(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD;
//asm
//  {On entry:
//    eax = @APolarComplex1
//    edx = @APolarComplex2
//    ecx = @Result}
//  {----Convert APolarComplex1 to cartesian coordinates----}
//  fld TPolarComplexD[eax].Phase
//  {Calculate the sine and cosine}
//  fsincos
//  {Load the amplitude}
//  fld TPolarComplexD[eax].Amplitude
//  {x = r cos(angle)}
//  fmul st(1), st(0)
//  {y = r sin(angle)}
//  fmulp st(2), st(0)
//  {----Convert APolarComplex2 to cartesian coordinates----}
//  fld TPolarComplexD[edx].Phase
//  {Calculate the sine and cosine}
//  fsincos
//  {Load the amplitude}
//  fld TPolarComplexD[edx].Amplitude
//  {x = r cos(angle)}
//  fmul st(1), st(0)
//  {y = r sin(angle)}
//  fmulp st(2), st(0)
//  {----Subtract the second cartesian coordinate----}
//  fsubp st(2), st(0)
//  fsubp st(2), st(0)
//  {----Calculate the amplitude----}
//  {Copy x coordinate}
//  fld st(0)
//  {Square it}
//  fmul st(0), st(0);
//  {Copy y coordinate}
//  fld st(2)
//  {Square it}
//  fmul st(0), st(0);
//  {Sum x^2 and y^2}
//  faddp st(1), st(0)
//  {Get the square root}
//  fsqrt
//  {Store the amplitude}
//  fstp TPolarComplexD[ecx].Amplitude
//  {----Calculate the phase----}
//  fpatan
//  fstp TPolarComplexD[ecx].Phase
//end;

function PolSub_PLR_IA32_1(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {----Convert APolarComplex1 to cartesian coordinates----}
  fld TPolarComplexE[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexE[eax].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  fld TPolarComplexE[edx].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexE[edx].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the amplitude----}
  {Copy x coordinate}
  fld st(0)
  {Square it}
  fmul st(0), st(0);
  {Copy y coordinate}
  fld st(2)
  {Square it}
  fmul st(0), st(0);
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexE[ecx].Amplitude
  {----Calculate the phase----}
  fpatan
  fstp TPolarComplexE[ecx].Phase
end;

function PolSub_PLR_IA32_2(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {----Convert APolarComplex1 to cartesian coordinates----}
  fld TPolarComplexS[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexS[eax].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  fld TPolarComplexS[edx].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexS[edx].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the phase----}
  fld st(1)
  fld st(1)
  fpatan
  fstp TPolarComplexS[ecx].Phase
  {----Calculate the amplitude----}
  {Square x coordinate}
  fmul st(0), st(0)
  {Swap x and y}
  fxch st(1)
  {Square y coordinate}
  fmul st(0), st(0)
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexS[ecx].Amplitude
  {Wait for the last operation to complete, in case an exception occurs}
  fwait
end;

function PolSub_PLR_IA32_2(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {----Convert APolarComplex1 to cartesian coordinates----}
  fld TPolarComplexD[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexD[eax].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  fld TPolarComplexD[edx].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexD[edx].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the phase----}
  fld st(1)
  fld st(1)
  fpatan
  fstp TPolarComplexD[ecx].Phase
  {----Calculate the amplitude----}
  {Square x coordinate}
  fmul st(0), st(0)
  {Swap x and y}
  fxch st(1)
  {Square y coordinate}
  fmul st(0), st(0)
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexD[ecx].Amplitude
  {Wait for the last operation to complete, in case an exception occurs}
  fwait
end;

function PolSub_PLR_IA32_2(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {----Convert APolarComplex1 to cartesian coordinates----}
  fld TPolarComplexE[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexE[eax].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  fld TPolarComplexE[edx].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexE[edx].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the phase----}
  fld st(1)
  fld st(1)
  fpatan
  fstp TPolarComplexE[ecx].Phase
  {----Calculate the amplitude----}
  {Square x coordinate}
  fmul st(0), st(0)
  {Swap x and y}
  fxch st(1)
  {Square y coordinate}
  fmul st(0), st(0)
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexE[ecx].Amplitude
  {Wait for the last operation to complete, in case an exception occurs}
  fwait
end;

function PolSub_PLR_IA32_3(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {----Convert APolarComplex1 to cartesian coordinates----}
  fld TPolarComplexS[eax].Amplitude
  fld TPolarComplexS[eax].Phase
  fsincos
  fld st(2)
  fmulp st(2), st(0)
  fmulp st(2), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  fld TPolarComplexS[edx].Amplitude
  fld TPolarComplexS[edx].Phase
  fsincos
  fld st(2)
  fmulp st(2), st(0)
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the phase----}
  fld st(0)
  fld st(2)
  fpatan
  fstp TPolarComplexS[ecx].Phase
  {----Calculate the amplitude----}
  {Square x coordinate}
  fmul st(0), st(0)
  {Swap x and y}
  fxch st(1)
  {Square y coordinate}
  fmul st(0), st(0)
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexS[ecx].Amplitude
  {Catch any exceptions}
  fwait
end;

function PolSub_PLR_IA32_3(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {----Convert APolarComplex1 to cartesian coordinates----}
  fld TPolarComplexD[eax].Amplitude
  fld TPolarComplexD[eax].Phase
  fsincos
  fld st(2)
  fmulp st(2), st(0)
  fmulp st(2), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  fld TPolarComplexD[edx].Amplitude
  fld TPolarComplexD[edx].Phase
  fsincos
  fld st(2)
  fmulp st(2), st(0)
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the phase----}
  fld st(0)
  fld st(2)
  fpatan
  fstp TPolarComplexD[ecx].Phase
  {----Calculate the amplitude----}
  {Square x coordinate}
  fmul st(0), st(0)
  {Swap x and y}
  fxch st(1)
  {Square y coordinate}
  fmul st(0), st(0)
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexD[ecx].Amplitude
  {Catch any exceptions}
  fwait
end;

function PolSub_PLR_IA32_3(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {----Convert APolarComplex1 to cartesian coordinates----}
  fld TPolarComplexE[eax].Amplitude
  fld TPolarComplexE[eax].Phase
  fsincos
  fld st(2)
  fmulp st(2), st(0)
  fmulp st(2), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  fld TPolarComplexE[edx].Amplitude
  fld TPolarComplexE[edx].Phase
  fsincos
  fld st(2)
  fmulp st(2), st(0)
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the phase----}
  fld st(0)
  fld st(2)
  fpatan
  fstp TPolarComplexE[ecx].Phase
  {----Calculate the amplitude----}
  {Square x coordinate}
  fmul st(0), st(0)
  {Swap x and y}
  fxch st(1)
  {Square y coordinate}
  fmul st(0), st(0)
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexE[ecx].Amplitude
  {No need for fwait here - the fstp cannot fail}
end;

function PolSub_PLR_IA32_4(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {---Get the sin and cos for Phase1---}
  fld TPolarComplexS[eax].Phase
  fsincos
  {---Get the sin and cos for Phase2---}
  fld TPolarComplexS[edx].Phase
  fsincos
  {----Convert APolarComplex1 to cartesian coordinates----}
  {Load Amplitude1}
  fld TPolarComplexS[eax].Amplitude
  {x1 = r1 cos(angle1)}
  fmul st(3), st(0)
  {y1 = r1 sin(angle1)}
  fmulp st(4), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  {Load Amplitude2}
  fld TPolarComplexS[edx].Amplitude
  {x2 = r2 cos(angle2)}
  fmul st(1), st(0)
  {y2 = r2 sin(angle2)}
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the phase----}
  fld st(1)
  fld st(1)
  fpatan
  fstp TPolarComplexS[ecx].Phase
  {----Calculate the amplitude----}
  {Square x coordinate}
  fmul st(0), st(0)
  {Swap x and y}
  fxch st(1)
  {Square y coordinate}
  fmul st(0), st(0)
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexS[ecx].Amplitude
  {Wait for possible exception to be handled}
  fwait
end;

function PolSub_PLR_IA32_4(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {---Get the sin and cos for Phase1---}
  fld TPolarComplexD[eax].Phase
  fsincos
  {---Get the sin and cos for Phase2---}
  fld TPolarComplexD[edx].Phase
  fsincos
  {----Convert APolarComplex1 to cartesian coordinates----}
  {Load Amplitude1}
  fld TPolarComplexD[eax].Amplitude
  {x1 = r1 cos(angle1)}
  fmul st(3), st(0)
  {y1 = r1 sin(angle1)}
  fmulp st(4), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  {Load Amplitude2}
  fld TPolarComplexD[edx].Amplitude
  {x2 = r2 cos(angle2)}
  fmul st(1), st(0)
  {y2 = r2 sin(angle2)}
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the phase----}
  fld st(1)
  fld st(1)
  fpatan
  fstp TPolarComplexD[ecx].Phase
  {----Calculate the amplitude----}
  {Square x coordinate}
  fmul st(0), st(0)
  {Swap x and y}
  fxch st(1)
  {Square y coordinate}
  fmul st(0), st(0)
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexD[ecx].Amplitude
  {Wait for possible exception to be handled}
  fwait
end;

function PolSub_PLR_IA32_4(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE;
asm
  {On entry:
    eax = @APolarComplex1
    edx = @APolarComplex2
    ecx = @Result}
  {---Get the sin and cos for Phase1---}
  fld TPolarComplexE[eax].Phase
  fsincos
  {---Get the sin and cos for Phase2---}
  fld TPolarComplexE[edx].Phase
  fsincos
  {----Convert APolarComplex1 to cartesian coordinates----}
  {Load Amplitude1}
  fld TPolarComplexE[eax].Amplitude
  {x1 = r1 cos(angle1)}
  fmul st(3), st(0)
  {y1 = r1 sin(angle1)}
  fmulp st(4), st(0)
  {----Convert APolarComplex2 to cartesian coordinates----}
  {Load Amplitude2}
  fld TPolarComplexE[edx].Amplitude
  {x2 = r2 cos(angle2)}
  fmul st(1), st(0)
  {y2 = r2 sin(angle2)}
  fmulp st(2), st(0)
  {----Subtract the second cartesian coordinate----}
  fsubp st(2), st(0)
  fsubp st(2), st(0)
  {----Calculate the phase----}
  fld st(1)
  fld st(1)
  fpatan
  fstp TPolarComplexE[ecx].Phase
  {----Calculate the amplitude----}
  {Square x coordinate}
  fmul st(0), st(0)
  {Swap x and y}
  fxch st(1)
  {Square y coordinate}
  fmul st(0), st(0)
  {Sum x^2 and y^2}
  faddp st(1), st(0)
  {Get the square root}
  fsqrt
  {Store the amplitude}
  fstp TPolarComplexE[ecx].Amplitude
  {No need for fwait here - the fstp cannot fail}
end;

function PolSub_PLR_PAS_1(const APolarComplex1, APolarComplex2: TPolarComplexS): TPolarComplexS; overload;
var
  LSinVal, LCosVal, X, Y: Extended;
begin
  {Convert first coordinate to cartesian}
  SinCos(APolarComplex1.Phase, LSinVal, LCosVal);
  X := APolarComplex1.Amplitude * LCosVal;
  Y := APolarComplex1.Amplitude * LSinVal;
  {Convert second coordinate to cartesian and subtract it}
  SinCos(APolarComplex2.Phase, LSinVal, LCosVal);
  X := X - APolarComplex2.Amplitude * LCosVal;
  Y := Y - APolarComplex2.Amplitude * LSinVal;
  {Calculate the phase}
  Result.Phase := ArcTan2(Y, X);
  {Calculate the amplitude}
  Result.Amplitude := Sqrt(X * X + Y * Y);
end;

function PolSub_PLR_PAS_1(const APolarComplex1, APolarComplex2: TPolarComplexD): TPolarComplexD; overload;
var
  LSinVal, LCosVal, X, Y: Extended;
begin
  {Convert first coordinate to cartesian}
  SinCos(APolarComplex1.Phase, LSinVal, LCosVal);
  X := APolarComplex1.Amplitude * LCosVal;
  Y := APolarComplex1.Amplitude * LSinVal;
  {Convert second coordinate to cartesian and subtract it}
  SinCos(APolarComplex2.Phase, LSinVal, LCosVal);
  X := X - APolarComplex2.Amplitude * LCosVal;
  Y := Y - APolarComplex2.Amplitude * LSinVal;
  {Calculate the phase}
  Result.Phase := ArcTan2(Y, X);
  {Calculate the amplitude}
  Result.Amplitude := Sqrt(X * X + Y * Y);
end;

function PolSub_PLR_PAS_1(const APolarComplex1, APolarComplex2: TPolarComplexE): TPolarComplexE; overload;
var
  LSinVal, LCosVal, X, Y: Extended;
begin
  {Convert first coordinate to cartesian}
  SinCos(APolarComplex1.Phase, LSinVal, LCosVal);
  X := APolarComplex1.Amplitude * LCosVal;
  Y := APolarComplex1.Amplitude * LSinVal;
  {Convert second coordinate to cartesian and subtract it}
  SinCos(APolarComplex2.Phase, LSinVal, LCosVal);
  X := X - APolarComplex2.Amplitude * LCosVal;
  Y := Y - APolarComplex2.Amplitude * LSinVal;
  {Calculate the phase}
  Result.Phase := ArcTan2(Y, X);
  {Calculate the amplitude}
  Result.Amplitude := Sqrt(X * X + Y * Y);
end;

end.
