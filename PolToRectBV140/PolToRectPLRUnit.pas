unit PolToRectPLRUnit;

interface

uses
  ComplexDataTypesUnit, Math;

{IA32 target}
function PolToRect_PLR_IA32_1(const APolarCoordinates: TPolarComplexS): TRegtangularComplexS; overload;
function PolToRect_PLR_IA32_1(const APolarCoordinates: TPolarComplexD): TRegtangularComplexD; overload;
function PolToRect_PLR_IA32_1(const APolarCoordinates: TPolarComplexE): TRegtangularComplexE; overload;

function PolToRect_PLR_IA32_2(const APolarCoordinates: TPolarComplexS): TRegtangularComplexS; overload;
function PolToRect_PLR_IA32_2(const APolarCoordinates: TPolarComplexD): TRegtangularComplexD; overload;
function PolToRect_PLR_IA32_2(const APolarCoordinates: TPolarComplexE): TRegtangularComplexE; overload;

function PolToRect_PLR_IA32_3(const APolarCoordinates: TPolarComplexS): TRegtangularComplexS; overload;
function PolToRect_PLR_IA32_3(const APolarCoordinates: TPolarComplexD): TRegtangularComplexD; overload;

{Pascal target}
function PolToRect_PLR_PAS_1(const APolarCoordinates: TPolarComplexS): TRegtangularComplexS; overload;
function PolToRect_PLR_PAS_1(const APolarCoordinates: TPolarComplexD): TRegtangularComplexD; overload;
function PolToRect_PLR_PAS_1(const APolarCoordinates: TPolarComplexE): TRegtangularComplexE; overload;

implementation

function PolToRect_PLR_IA32_1(const APolarCoordinates: TPolarComplexS): TRegtangularComplexS; overload;
asm
  {On entry:
    eax = @APolarCoordinates
    edx = @Result}
  {Load the angle onto the FPU stack}
  fld TPolarComplexS[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexS[eax].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {Store the result}
  fstp TRegtangularComplexS[edx].RealPart
  fstp TRegtangularComplexS[edx].ImaginaryPart
end;

function PolToRect_PLR_IA32_1(const APolarCoordinates: TPolarComplexD): TRegtangularComplexD; overload;
asm
  {On entry:
    eax = @APolarCoordinates
    edx = @Result}
  {Load the angle onto the FPU stack}
  fld TPolarComplexD[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexD[eax].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {Store the result}
  fstp TRegtangularComplexD[edx].RealPart
  fstp TRegtangularComplexD[edx].ImaginaryPart
end;

function PolToRect_PLR_IA32_1(const APolarCoordinates: TPolarComplexE): TRegtangularComplexE; overload;
asm
  {On entry:
    eax = @APolarCoordinates
    edx = @Result}
  {Load the angle onto the FPU stack}
  fld TPolarComplexE[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {Load the amplitude}
  fld TPolarComplexE[eax].Amplitude
  {x = r cos(angle)}
  fmul st(1), st(0)
  {y = r sin(angle)}
  fmulp st(2), st(0)
  {Store the result}
  fstp TRegtangularComplexE[edx].RealPart
  fstp TRegtangularComplexE[edx].ImaginaryPart
end;

function PolToRect_PLR_IA32_2(const APolarCoordinates: TPolarComplexS): TRegtangularComplexS; overload;
asm
  {On entry:
    eax = @APolarCoordinates
    edx = @Result}
  {Load the amplitude onto the FPU stack}
  fld TPolarComplexS[eax].Amplitude
  {Load the angle onto the FPU stack}
  fld TPolarComplexS[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {x = r cos(angle)}
  fmul st(0), st(2)
  fstp TRegtangularComplexS[edx].RealPart
  {y = r sin(angle)}
  fmulp
  fstp TRegtangularComplexS[edx].ImaginaryPart
end;

function PolToRect_PLR_IA32_2(const APolarCoordinates: TPolarComplexD): TRegtangularComplexD; overload;
asm
  {On entry:
    eax = @APolarCoordinates
    edx = @Result}
  {Load the amplitude onto the FPU stack}
  fld TPolarComplexD[eax].Amplitude
  {Load the angle onto the FPU stack}
  fld TPolarComplexD[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {x = r cos(angle)}
  fmul st(0), st(2)
  fstp TRegtangularComplexD[edx].RealPart
  {y = r sin(angle)}
  fmulp
  fstp TRegtangularComplexD[edx].ImaginaryPart
end;

function PolToRect_PLR_IA32_2(const APolarCoordinates: TPolarComplexE): TRegtangularComplexE; overload;
asm
  {On entry:
    eax = @APolarCoordinates
    edx = @Result}
  {Load the amplitude onto the FPU stack}
  fld TPolarComplexE[eax].Amplitude
  {Load the angle onto the FPU stack}
  fld TPolarComplexE[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {x = r cos(angle)}
  fmul st(0), st(2)
  fstp TRegtangularComplexE[edx].RealPart
  {y = r sin(angle)}
  fmulp
  fstp TRegtangularComplexE[edx].ImaginaryPart
end;


function PolToRect_PLR_IA32_3(const APolarCoordinates: TPolarComplexS): TRegtangularComplexS; overload;
asm
  {Load the angle onto the FPU stack}
  fld TPolarComplexS[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {x = r cos(angle)}
  {Load the amplitude onto the FPU stack}
  fmul TPolarComplexS[eax].Amplitude
  fstp TRegtangularComplexS[edx].RealPart
  {y = r sin(angle)}
  fmul TPolarComplexS[eax].Amplitude
  fstp TRegtangularComplexS[edx].ImaginaryPart
end;

function PolToRect_PLR_IA32_3(const APolarCoordinates: TPolarComplexD): TRegtangularComplexD; overload;
asm
  {Load the angle onto the FPU stack}
  fld TPolarComplexD[eax].Phase
  {Calculate the sine and cosine}
  fsincos
  {x = r cos(angle)}
  {Load the amplitude onto the FPU stack}
  fmul TPolarComplexD[eax].Amplitude
  fstp TRegtangularComplexD[edx].RealPart
  {y = r sin(angle)}
  fmul TPolarComplexD[eax].Amplitude
  fstp TRegtangularComplexD[edx].ImaginaryPart
end;

function PolToRect_PLR_PAS_1(const APolarCoordinates: TPolarComplexS): TRegtangularComplexS; overload;
var
  LSinVal, LCosVal: Extended;
begin
  SinCos(APolarCoordinates.Phase, LSinVal, LCosVal);
  Result.RealPart := LCosVal * APolarCoordinates.Amplitude;
  Result.ImaginaryPart := LSinVal * APolarCoordinates.Amplitude;
end;

function PolToRect_PLR_PAS_1(const APolarCoordinates: TPolarComplexD): TRegtangularComplexD; overload;
var
  LSinVal, LCosVal: Extended;
begin
  SinCos(APolarCoordinates.Phase, LSinVal, LCosVal);
  Result.RealPart := LCosVal * APolarCoordinates.Amplitude;
  Result.ImaginaryPart := LSinVal * APolarCoordinates.Amplitude;
end;

function PolToRect_PLR_PAS_1(const APolarCoordinates: TPolarComplexE): TRegtangularComplexE; overload;
begin
  SinCos(APolarCoordinates.Phase, Result.ImaginaryPart, Result.RealPart);
  Result.RealPart := Result.RealPart * APolarCoordinates.Amplitude;
  Result.ImaginaryPart := Result.ImaginaryPart * APolarCoordinates.Amplitude;
end;

end.
