unit CeilDKCUnit;

interface

function Ceil64ExtendedDKC2(const X : Extended) : Int64;
function Ceil64ExtendedDKCSSE3(const X : Extended) : Int64;
function Ceil64ExtendedDKCPas1(const X: Extended): Int64;
function Ceil64ExtendedDKCPas3(const X: Extended): Int64;
function Ceil64ExtendedDKCPas4(const X: Extended): Int64;
function Ceil64ExtendedDKCPas5(const X: Extended): Int64;

function Ceil64DoubleDKC2(const X : Double) : Int64;
function Ceil64DoubleDKCSSE3(const X : Double) : Int64;
function Ceil64DoubleDKCPas1(const X: Double): Int64;
function Ceil64DoubleDKCPas3(const X: Double): Int64;
function Ceil64DoubleDKCPas4(const X: Double): Int64;
function Ceil64DoubleDKCPas5(const X: Double): Int64;

function Ceil64SingleDKC2(const X : Single) : Int64;
function Ceil64SingleDKCSSE3(const X : Single) : Int64;
function Ceil64SingleDKCPas1(const X: Single): Int64;
function Ceil64SingleDKCPas3(const X: Single): Int64;
function Ceil64SingleDKCPas4(const X: Single): Int64;
function Ceil64SingleDKCPas5(const X: Single): Int64;

implementation

uses
 Math;

//Author:            Dennis Kjaer Christensen
//Date:              2/3 2004
//Optimized for:
//Instructionset(s): IA32

function Ceil64ExtendedDKC2(const X : Extended) : Int64;
asm
 sub    esp, 12
 fnstcw [esp].Word         //Get current controlword
 mov    ax, [esp]          //into eax
 or     ax, 0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  qword ptr [esp+4]
 mov    eax, [esp+4]
 mov    edx, [esp+8]
 fldcw  word ptr [esp]     //Restore controlword
 add    esp, 12
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/3 2004
//Optimized for:
//Instructionset(s): IA32, IA32 Extensions, SSE3

function Ceil64ExtendedDKCSSE3(const X : Extended) : Int64;
asm
 sub    esp, 16
 fldz
 fld    X
 fcomi  st(0), st(1)
 ffree  st(1)
 jbe    @NegativeX
@PositiveX :
 fnstcw [esp+12].Word         //Get current controlword
 mov    ax, [esp+12]          //into eax
 or     ax, 0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fistp  qword ptr [esp]
 mov    eax, [esp]
 mov    edx, [esp+4]
 fldcw  word ptr [esp+12]     //Restore controlword
 jmp    @Exit
@NegativeX :
 db     $DD, $0C, $24 // fisttp qword ptr [esp]
 mov    eax, [esp]
 mov    edx, [esp+4]
@Exit :
 add    esp, 16
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/3 2004
//Optimized for:
//Instructionset(s): IA32, IA32 Extensions, SSE3

function Ceil64DoubleDKCSSE3(const X : Double) : Int64;
asm
 sub    esp, 16
 fldz
 fld    X
 fcomi  st(0), st(1)
 ffree  st(1)
 jbe    @NegativeX
@PositiveX :
 fnstcw [esp+12].Word         //Get current controlword
 mov    ax, [esp+12]          //into eax
 or     ax, 0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fistp  qword ptr [esp]
 mov    eax, [esp]
 mov    edx, [esp+4]
 fldcw  word ptr [esp+12]     //Restore controlword
 jmp    @Exit
@NegativeX :
 db     $DD, $0C, $24 // fisttp qword ptr [esp]
 mov    eax, [esp]
 mov    edx, [esp+4]
@Exit :
 add    esp, 16
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/3 2004
//Optimized for:
//Instructionset(s): IA32, IA32 Extensions, SSE3

function Ceil64SingleDKCSSE3(const X : Single) : Int64;
asm
 sub    esp, 16
 fldz
 fld    X
 fcomi  st(0), st(1)
 ffree  st(1)
 jbe    @NegativeX
@PositiveX :
 fnstcw [esp+12].Word         //Get current controlword
 mov    ax, [esp+12]          //into eax
 or     ax, 0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fistp  qword ptr [esp]
 mov    eax, [esp]
 mov    edx, [esp+4]
 fldcw  word ptr [esp+12]     //Restore controlword
 jmp    @Exit
@NegativeX :
 db     $DD, $0C, $24 // fisttp qword ptr [esp]
 mov    eax, [esp]
 mov    edx, [esp+4]
@Exit :
 add    esp, 16
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/3 2004
//Optimized for:
//Instructionset(s): IA32

function Ceil64DoubleDKC2(const X : Double) : Int64;
asm
 sub    esp, 12
 fnstcw [esp].Word         //Get current controlword
 mov    ax, [esp]          //into eax
 or     ax, 0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  qword ptr [esp+4]
 mov    eax, [esp+4]
 mov    edx, [esp+8]
 fldcw  word ptr [esp]     //Restore controlword
 add    esp, 12
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/3 2004
//Optimized for:
//Instructionset(s): IA32

function Ceil64SingleDKC2(const X : Single) : Int64;
asm
 sub    esp, 12
 fnstcw [esp].Word         //Get current controlword
 mov    ax, [esp]          //into eax
 or     ax, 0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  qword ptr [esp+4]
 mov    eax, [esp+4]
 mov    edx, [esp+8]
 fldcw  word ptr [esp]     //Restore controlword
 add    esp, 12
end;

function Ceil64ExtendedDKCPas1(const X: Extended): Int64;
begin
 Result := Trunc(X);
 if Frac(X) > 0 then
  Inc(Result);
end;

function Ceil64DoubleDKCPas1(const X: Double): Int64;
begin
 Result := Trunc(X);
 if Frac(X) > 0 then
  Inc(Result);
end;

function Ceil64SingleDKCPas1(const X: Single): Int64;
begin
 Result := Trunc(X);
 if Frac(X) > 0 then
  Inc(Result);
end;

function EvenDKC(I : Int64) : Boolean;
begin
 if I mod 2 = 0 then
  Result := True
 else
  Result := False;
end;

function Ceil64ExtendedDKCPas2(const X: Extended): Int64;
begin
 Result := Round(X);//Incorrectly rounding 872.5 to 872   = Bankers rounding not mathematicians rounding
 //Compensate for bankers rounding
 if ((X > 0) and (Frac(X) = 0.5) and (EvenDKC(Trunc(X)))) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) = 0.5) and (EvenDKC(Trunc(X)))) then
  Dec(Result);
 if ((X > 0) and (Frac(X) > 0) and (Frac(X) < 0.5)) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) >= 0.5) and (Abs(Frac(X)) < 1)) then
  Inc(Result);
end;

function Ceil64DoubleDKCPas2(const X: Double): Int64;
begin
 Result := Round(X);//Incorrectly rounding 872.5 to 872   = Bankers rounding not mathematicians rounding
 //Compensate for bankers rounding
 if ((X > 0) and (Frac(X) = 0.5) and (EvenDKC(Trunc(X)))) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) = 0.5) and (EvenDKC(Trunc(X)))) then
  Dec(Result);
 if ((X > 0) and (Frac(X) > 0) and (Frac(X) < 0.5)) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) >= 0.5) and (Abs(Frac(X)) < 1)) then
  Inc(Result);
end;

function Ceil64SingleDKCPas2(const X: Single): Int64;
begin
 Result := Round(X);//Incorrectly rounding 872.5 to 872   = Bankers rounding not mathematicians rounding
 //Compensate for bankers rounding
 if ((X > 0) and (Frac(X) = 0.5) and (EvenDKC(Trunc(X)))) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) = 0.5) and (EvenDKC(Trunc(X)))) then
  Dec(Result);
 if ((X > 0) and (Frac(X) > 0) and (Frac(X) < 0.5)) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) >= 0.5) and (Abs(Frac(X)) < 1)) then
  Inc(Result);
end;

function HasFracDKC(const X: Extended) : Boolean;
var
 Y : Extended;

begin
 Y := Round(X);
 if Y <> X then
  Result := True
 else
  Result := False;
end;

function Ceil64ExtendedDKCPas3(const X: Extended): Int64;
begin
 Result := Trunc(X);
 if ((X > 0) and (HasFracDKC(X))) then
  Inc(Result);
end;

function Ceil64DoubleDKCPas3(const X: Double): Int64;
begin
 Result := Trunc(X);
 if ((X > 0) and (HasFracDKC(X))) then
  Inc(Result);
end;

function Ceil64SingleDKCPas3(const X: Single): Int64;
begin
 Result := Trunc(X);
 if ((X > 0) and (HasFracDKC(X))) then
  Inc(Result);
end;

function Ceil64ExtendedDKCPas4(const X: Extended): Int64;
begin
 Result := Trunc(X);
 if ((X > 0) and (X - Result <> 0)) then
  Inc(Result);
end;

function Ceil64DoubleDKCPas4(const X: Double): Int64;
begin
 Result := Trunc(X);
 if ((X > 0) and (X - Result <> 0)) then
  Inc(Result);
end;

function Ceil64SingleDKCPas4(const X: Single): Int64;
begin
 Result := Trunc(X);
 if ((X > 0) and (X - Result <> 0)) then
  Inc(Result);
end;

function Ceil64ExtendedDKCPas5(const X: Extended): Int64;
begin
 Result := Trunc(X);
 if ((X - Result <> 0) and (X > 0)) then
  Inc(Result);
end;

function Ceil64DoubleDKCPas5(const X: Double): Int64;
begin
 Result := Trunc(X);
 if ((X - Result <> 0) and (X > 0)) then
  Inc(Result);
end;

function Ceil64SingleDKCPas5(const X: Single): Int64;
begin
 Result := Trunc(X);
 if ((X - Result <> 0) and (X > 0)) then
  Inc(Result);
end;

end.
