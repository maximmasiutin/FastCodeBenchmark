unit PolToRectDKCUnit;

interface

uses
 ComplexDataTypesUnit;

function PolToRectDKCPas1(const X : TPolarComplexE) : TRegtangularComplexE; overload;
function PolToRectDKCPas1(const X : TPolarComplexD) : TRegtangularComplexD; overload;
function PolToRectDKCPas1(const X : TPolarComplexS) : TRegtangularComplexS; overload;
function PolToRectDKCIA32_1(const X : TPolarComplexE) : TRegtangularComplexE; overload;
function PolToRectDKCIA32_1(const X : TPolarComplexD) : TRegtangularComplexD; overload;
function PolToRectDKCIA32_1(const X : TPolarComplexS) : TRegtangularComplexS; overload;
function PolToRectDKCIA32_2(const X : TPolarComplexE) : TRegtangularComplexE; overload;
function PolToRectDKCIA32_2(const X : TPolarComplexD) : TRegtangularComplexD; overload;
function PolToRectDKCIA32_2(const X : TPolarComplexS) : TRegtangularComplexS; overload;

implementation

uses
 Math;

function PolToRectDKCPas1(const X : TPolarComplexE) : TRegtangularComplexE; overload;
begin
 Result.RealPart := Cos(X.Phase) * X.Amplitude;
 Result.ImaginaryPart := Sin(X.Phase) * X.Amplitude;
end;

function PolToRectDKCPas1(const X : TPolarComplexD) : TRegtangularComplexD; overload;
begin
 Result.RealPart := Cos(X.Phase) * X.Amplitude;
 Result.ImaginaryPart := Sin(X.Phase) * X.Amplitude;
end;

function PolToRectDKCPas1(const X : TPolarComplexS) : TRegtangularComplexS; overload;
begin
 Result.RealPart := Cos(X.Phase) * X.Amplitude;
 Result.ImaginaryPart := Sin(X.Phase) * X.Amplitude;
end;

function SinDKC(const Theta: Extended) : Extended; overload;
asm
        FLD     Theta
        FSIN
        FWAIT
end;

function CosDKC(const Theta: Extended) : Extended; overload;
asm
        FLD     Theta
        FCOS
        FWAIT
end;

function SinDKC(const Theta: Double) : Double; overload;
asm
        FLD     Theta
        FSIN
        FWAIT
end;

function CosDKC(const Theta: Double) : Double; overload;
asm
        FLD     Theta
        FCOS
        FWAIT
end;

function SinDKC(const Theta: Single) : Single; overload;
asm
        FLD     Theta
        FSIN
        FWAIT
end;

function CosDKC(const Theta: Single) : Single; overload;
asm
        FLD     Theta
        FCOS
        FWAIT
end;

procedure SinCosDKC(const Theta: Extended; var Sin, Cos: Extended); overload;
asm
        FLD     Theta
        FSINCOS
        FSTP    tbyte ptr [edx]    // Cos
        FSTP    tbyte ptr [eax]    // Sin
        FWAIT
end;

procedure SinCosDKC(const Theta: Double; var Sin, Cos: Double); overload;
asm
        FLD     Theta
        FSINCOS
        FSTP    qword ptr [edx]    // Cos
        FSTP    qword ptr [eax]    // Sin
        FWAIT
end;

procedure SinCosDKC(const Theta: Single; var Sin, Cos: Single); overload;
asm
        FLD     Theta
        FSINCOS
        FSTP    dword ptr [edx]    // Cos
        FSTP    dword ptr [eax]    // Sin
        FWAIT
end;

{

//Not pascal functions because they call homemade BASM functions.

function PolToRectDKCPas2(const X : TPolarComplexE) : TRegtangularComplexE; overload;
var
 SinX, CosX : Extended;

begin
 SinCosDKC(X.Phase, SinX, CosX);
 Result.RealPart := CosX * X.Amplitude;
 Result.ImaginaryPart := SinX * X.Amplitude;
end;

function PolToRectDKCPas2(const X : TPolarComplexD) : TRegtangularComplexD; overload;
var
 SinX, CosX : Double;

begin
 SinCosDKC(X.Phase, SinX, CosX);
 Result.RealPart := CosX * X.Amplitude;
 Result.ImaginaryPart := SinX * X.Amplitude;
end;

function PolToRectDKCPas2(const X : TPolarComplexS) : TRegtangularComplexS; overload;
var
 SinX, CosX : Single;

begin
 SinCosDKC(X.Phase, SinX, CosX);
 Result.RealPart := CosX * X.Amplitude;
 Result.ImaginaryPart := SinX * X.Amplitude;
end;
}
function PolToRectDKCIA32_1(const X : TPolarComplexE) : TRegtangularComplexE; overload;
begin
 Result.RealPart := CosDKC(X.Phase) * X.Amplitude;
 Result.ImaginaryPart := SinDKC(X.Phase) * X.Amplitude;
end;

function PolToRectDKCIA32_1(const X : TPolarComplexD) : TRegtangularComplexD; overload;
begin
 Result.RealPart := CosDKC(X.Phase) * X.Amplitude;
 Result.ImaginaryPart := SinDKC(X.Phase) * X.Amplitude;
end;

function PolToRectDKCIA32_1(const X : TPolarComplexS) : TRegtangularComplexS; overload;
begin
 Result.RealPart := CosDKC(X.Phase) * X.Amplitude;
 Result.ImaginaryPart := SinDKC(X.Phase) * X.Amplitude;
end;

function PolToRectDKCIA32_2(const X : TPolarComplexE) : TRegtangularComplexE; overload;
asm
 //SinCosDKC(X.Phase, SinX, CosX);
 fld     tbyte ptr [eax+$10]
 fsincos
 fld     tbyte ptr [eax]
 //Result.RealPart := CosX * X.Amplitude;
 fmul    st(1), st(0)
 //Result.ImaginaryPart := SinX * X.Amplitude;
 fmulp   st(2), st(0)
 fstp    tbyte ptr [edx]
 fstp    tbyte ptr [edx+$10]
 wait
end;

function PolToRectDKCIA32_2(const X : TPolarComplexD) : TRegtangularComplexD; overload;
asm
 //SinCosDKC(X.Phase, SinX, CosX);
 fld     qword ptr [eax+8]
 fsincos
 fld     qword ptr [eax]
 //Result.RealPart := CosX * X.Amplitude;
 fmul    st(1), st(0)
 //Result.ImaginaryPart := SinX * X.Amplitude;
 fmulp   st(2), st(0)
 fstp    qword ptr [edx]
 fstp    qword ptr [edx+8]
 wait
end;

function PolToRectDKCIA32_2(const X : TPolarComplexS) : TRegtangularComplexS; overload;
asm
 //SinCosDKC(X.Phase, SinX, CosX);
 fld     dword ptr [eax+4]
 fsincos
 fld     dword ptr [eax]
 //Result.RealPart := CosX * X.Amplitude;
 fmul    st(1), st(0)
 //Result.ImaginaryPart := SinX * X.Amplitude;
 fmulp   st(2), st(0)
 fstp    dword ptr [edx]
 fstp    dword ptr [edx+4]
 wait
end;

end.
