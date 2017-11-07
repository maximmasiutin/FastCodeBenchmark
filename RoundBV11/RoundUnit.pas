unit RoundUnit;

interface

function RoundExtendedDKC1(const X : Extended) : Int64;
function RoundExtendedDKC2(const X : Extended) : Int64;
function RoundExtendedDKC3(const X : Extended) : Int64;
function RoundExtendedDKC4(const X : Extended) : Int64;
function RoundDoubleDKC1(const X : Double) : Int64;
function RoundDoubleDKC2(const X : Double) : Int64;
function RoundDoubleDKC3(const X : Double) : Int64;
function RoundSingleDKC1(const X : Single) : Int64;
function RoundSingleDKC2(const X : Single) : Int64;
function RoundSingleDKC3(const X : Single) : Int64;
function RoundExtendedJOH(const X : Extended) : Int64;
function RoundDoubleJOH(const X : Double) : Int64;
function RoundSingleJOH(const X : Single) : Int64;

implementation

uses
 Math;
 
function RoundExtendedDKC1(const X : Extended) : Int64;
var
 FPURoundingMode : TFPURoundingMode;

begin
 FPURoundingMode := GetRoundMode;
 SetRoundMode(rmNearest);
 Result := Round(X);
 SetRoundMode(FPURoundingMode);
end;

function RoundExtendedDKC2(const X : Extended) : Int64;
asm
 fld   X
 fistp qword ptr [esp-8]
 mov   eax, [esp-8]
 mov   edx, [esp-4]
end;

function RoundExtendedDKC3(const X : Extended) : Int64;
asm
 //call Get8087CW
 push   0
 fnstcw [esp].Word
 pop    eax
 mov    ecx, eax
 //CtlWord2 := (CtlWord1 and $F3FF) or (Ord(rmNearest) shl 10);
 and    ax, $f3ff
 or     ax, $00
 mov    [esp-8], ax
 //call Set8087CW
 fnclex  // don't raise pending exceptions enabled by the new flags
 fldcw  word ptr [esp-8]
 //call RoundExtendedDKC2
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 //call Set8087CW
 mov    [esp-8], cx
 fnclex  // don't raise pending exceptions enabled by the new flags
 fldcw  word ptr [esp-8]
end;

function RoundExtendedDKC4(const X : Extended) : Int64;
asm
 //Compiler adds redundant push ebp + mov ebp,esp
 fld   tbyte ptr [esp+8]
 fistp qword ptr [esp-8]
 mov   eax, [esp-8]
 mov   edx, [esp-4]
 //Compiler adds redundant pop ebp 
end;

function RoundDoubleDKC1(const X : Double) : Int64;
var
 FPURoundingMode : TFPURoundingMode;

begin
 FPURoundingMode := GetRoundMode;
 SetRoundMode(rmNearest);
 Result := Round(X);
 SetRoundMode(FPURoundingMode);
end;

function RoundDoubleDKC2(const X : Double) : Int64;
asm
 fld   X
 fistp qword ptr [esp-8]
 mov   eax, [esp-8]
 mov   edx, [esp-4]
end;

function RoundDoubleDKC3(const X : Double) : Int64;
asm
 //call Get8087CW
 push   0
 fnstcw [esp].Word
 pop    eax
 mov    ecx, eax
 //CtlWord2 := (CtlWord1 and $F3FF) or (Ord(rmNearest) shl 10);
 and    ax, $f3ff
 or     ax, $00
 mov    [esp-8], ax
 //call Set8087CW
 fnclex  // don't raise pending exceptions enabled by the new flags
 fldcw  word ptr [esp-8]
 //call RoundExtendedDKC2
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 //call Set8087CW
 mov    [esp-8], cx
 fnclex  // don't raise pending exceptions enabled by the new flags
 fldcw  word ptr [esp-8]
end;

function RoundSingleDKC1(const X : Single) : Int64;
var
 FPURoundingMode : TFPURoundingMode;

begin
 FPURoundingMode := GetRoundMode;
 SetRoundMode(rmNearest);
 Result := Round(X);
 SetRoundMode(FPURoundingMode);
end;

function RoundSingleDKC2(const X : Single) : Int64;
asm
 fld   X
 fistp qword ptr [esp-8]
 mov   eax, [esp-8]
 mov   edx, [esp-4]
end;

function RoundSingleDKC3(const X : Single) : Int64;
asm
 //call Get8087CW
 push   0
 fnstcw [esp].Word
 pop    eax
 mov    ecx, eax
 //CtlWord2 := (CtlWord1 and $F3FF) or (Ord(rmNearest) shl 10);
 and    ax, $f3ff
 or     ax, $00
 mov    [esp-8], ax
 //call Set8087CW
 fnclex  // don't raise pending exceptions enabled by the new flags
 fldcw  word ptr [esp-8]
 //call RoundExtendedDKC2
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 //call Set8087CW
 mov    [esp-8], cx
 fnclex  // don't raise pending exceptions enabled by the new flags
 fldcw  word ptr [esp-8]
end;

function RoundExtendedJOH(const X : Extended) : Int64;
asm
 lea   eax, [ebp+8]
 fld   tbyte ptr [eax]
 fistp qword ptr [eax-16]
 mov   edx, [eax-12]
 mov   eax, [eax-16]
end;

function RoundDoubleJOH(const X : Double) : Int64;
asm
 lea   eax, [ebp+8]
 fld   qword ptr [eax]
 fistp qword ptr [eax-16]
 mov   edx, [eax-12]
 mov   eax, [eax-16]
end;

function RoundSingleJOH(const X : Single) : Int64;
asm
 lea   eax, [ebp+8]
 fld   dword ptr [eax]
 fistp qword ptr [eax-16]
 mov   edx, [eax-12]
 mov   eax, [eax-16]
end;

end.
