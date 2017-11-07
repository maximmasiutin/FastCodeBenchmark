unit PolToRectFOUnit;

interface

uses
 ComplexDataTypesUnit;

function PolToReg_FO_IA32_1(const X : TPolarComplexE) :
TRegtangularComplexE; overload;
function PolToReg_FO_IA32_1(const X : TPolarComplexD) :
TRegtangularComplexD; overload;
function PolToReg_FO_IA32_1(const X : TPolarComplexS) :
TRegtangularComplexS; overload;

implementation

function PolToReg_FO_IA32_1(const X : TPolarComplexE) :
TRegtangularComplexE; overload;
asm
   FLD      [eax.TPolarComplexE.Phase]
   FSINCOS
   FLD      [eax.TPolarComplexE.Amplitude]
   FNSTSW   AX
   SAHF
   JP       @@outOfRange
   FMUL     ST(2), ST(0)
   FMULP    ST(1), ST(0)
   FSTP     [edx.TRegtangularComplexE.RealPart]
   FSTP     [edx.TRegtangularComplexE.ImaginaryPart]
   WAIT
   RET
@@outOfRange:
   FSTP    ST(0)
   FSTP    ST(0)
   MOV     ECX, 7
   XCHG    EDX, EDI
   XOR     EAX, EAX
   REP     STOSD
   XCHG    EDI, EDX
end;

function PolToReg_FO_IA32_1(const X : TPolarComplexD) :
TRegtangularComplexD; overload;
asm
   FLD      [eax.TPolarComplexD.Phase]
   FSINCOS
   FLD      [eax.TPolarComplexD.Amplitude]
   FNSTSW   AX
   SAHF
   JP       @@outOfRange
   FMUL     ST(2), ST(0)
   FMULP    ST(1), ST(0)
   FSTP     [edx.TRegtangularComplexD.RealPart]
   FSTP     [edx.TRegtangularComplexD.ImaginaryPart]
   WAIT
   RET
@@outOfRange:
   FSTP    ST(0)
   FSTP    ST(0)
   MOV     ECX, 4
   XCHG    EDX, EDI
   XOR     EAX, EAX
   REP     STOSD
   XCHG    EDI, EDX
end;

function PolToReg_FO_IA32_1(const X : TPolarComplexS) :
TRegtangularComplexS; overload;
asm
   FLD      [eax.TPolarComplexS.Phase]
   FSINCOS
   FLD      [eax.TPolarComplexS.Amplitude]
   FNSTSW   AX
   SAHF
   JP       @@outOfRange
   FMUL     ST(2), ST(0)
   FMULP    ST(1), ST(0)
   FSTP     [edx.TRegtangularComplexS.RealPart]
   FSTP     [edx.TRegtangularComplexS.ImaginaryPart]
   WAIT
   RET
@@outOfRange:
   FSTP    ST(0)
   FSTP    ST(0)
   MOV     DWORD ptr [edx.TRegtangularComplexS.RealPart], 0
   MOV     DWORD ptr [edx.TRegtangularComplexS.ImaginaryPart], 0
end;

end.
