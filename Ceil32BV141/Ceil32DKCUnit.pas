unit Ceil32DKCUnit;

interface

function Ceil32_DKC_Pas_1(const X: Extended): Integer; overload;
function Ceil32_DKC_Pas_3(const X: Extended): Integer; overload;
function Ceil32_DKC_Pas_4(const X: Extended): Integer; overload;
function Ceil32_DKC_Pas_5(const X: Extended): Integer; overload;
function Ceil32_DKC_IA32_1(const X : Extended) : Integer; overload;
//function Ceil32_DKC_SSE3_1(const X : Extended) : Integer; overload;

function Ceil32_DKC_Pas_1(const X: Double): Integer; overload;
function Ceil32_DKC_Pas_3(const X: Double): Integer; overload;
function Ceil32_DKC_Pas_4(const X: Double): Integer; overload;
function Ceil32_DKC_Pas_5(const X: Double): Integer; overload;
function Ceil32_DKC_IA32_1(const X : Double) : Integer; overload;
function Ceil32_DKC_SSE2_1(const X: Double): Integer; overload;
function Ceil32_DKC_SSE2_2(const X: Double): Integer; overload;
function Ceil32_DKC_SSE2_3(const X: Double): Integer; overload;
function Ceil32_DKC_SSE2_4(const X: Double): Integer; overload;
function Ceil32_DKC_SSE2_5(const X: Double): Integer; overload;
//function Ceil32_DKC_SSE3_1(const X : Double) : Integer; overload;

function Ceil32_DKC_Pas_1(const X: Single): Integer; overload;
function Ceil32_DKC_Pas_3(const X: Single): Integer; overload;
function Ceil32_DKC_Pas_4(const X: Single): Integer; overload;
function Ceil32_DKC_Pas_5(const X: Single): Integer; overload;
function Ceil32_DKC_IA32_1(const X : Single) : Integer; overload;
function Ceil32_DKC_IA32_2(const X : Single) : Integer; overload;
function Ceil32_DKC_IA32_3(const X : Single) : Integer; overload;
function Ceil32_DKC_IA32_4(const X : Single) : Integer; overload;
function Ceil32_DKC_SSE_1(const X : Single) : Integer; overload;
//function Ceil32_DKC_SSE3_1(const X : Single) : Integer; overload;

implementation

uses
 SysUtils, Math, SysConst;

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_1(const X: Extended): Integer; overload;
begin
 Result := Trunc(X);
 if Frac(X) > 0 then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_1(const X: Double): Integer; overload;
begin
 Result := Trunc(X);
 if Frac(X) > 0 then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_1(const X: Single): Integer; overload;
begin
 Result := Trunc(X);
 if Frac(X) > 0 then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

function EvenDKC(I : Integer) : Boolean;
begin
 if I mod 2 = 0 then
  Result := True
 else
  Result := False;
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

function Ceil32_DKC_Pas_2(const X: Extended): Integer; overload;
begin
 Result := Round(X);
 if ((X > 0) and (Frac(X) = 0.5) and (EvenDKC(Trunc(X)))) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) = 0.5) and (EvenDKC(Trunc(X)))) then
  Dec(Result);
 if ((X > 0) and (Frac(X) > 0) and (Frac(X) < 0.5)) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) >= 0.5) and (Abs(Frac(X)) < 1)) then
  Inc(Result);
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

function Ceil32_DKC_Pas_2(const X: Double): Integer; overload;
begin
 Result := Round(X);
 if ((X > 0) and (Frac(X) = 0.5) and (EvenDKC(Trunc(X)))) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) = 0.5) and (EvenDKC(Trunc(X)))) then
  Dec(Result);
 if ((X > 0) and (Frac(X) > 0) and (Frac(X) < 0.5)) then
  Inc(Result)
 else if ((X < 0) and (Abs(Frac(X)) >= 0.5) and (Abs(Frac(X)) < 1)) then
  Inc(Result);
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

function Ceil32_DKC_Pas_2(const X: Single): Integer; overload;
begin
 Result := Round(X);
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

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_3(const X: Extended): Integer; overload;
begin
 Result := Trunc(X);
 if ((X > 0) and (HasFracDKC(X))) then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_3(const X: Double): Integer; overload;
begin
 Result := Trunc(X);
 if ((X > 0) and (HasFracDKC(X))) then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_3(const X: Single): Integer; overload;
begin
 Result := Trunc(X);
 if ((X > 0) and (HasFracDKC(X))) then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_4(const X: Extended): Integer; overload;
begin
 Result := Trunc(X);
 if ((X > 0) and (X - Result <> 0)) then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_4(const X: Double): Integer; overload;
begin
 Result := Trunc(X);
 if ((X > 0) and (X - Result <> 0)) then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_4(const X: Single): Integer; overload;
begin
 Result := Trunc(X);
 if ((X > 0) and (X - Result <> 0)) then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_5(const X: Extended): Integer; overload;
begin
 Result := Trunc(X);
 if ((X - Result <> 0) and (X > 0)) then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_5(const X: Double): Integer; overload;
begin
 Result := Trunc(X);
 if ((X - Result <> 0) and (X > 0)) then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Ceil32_DKC_Pas_5(const X: Single): Integer; overload;
begin
 Result := Trunc(X);
 if ((X - Result <> 0) and (X > 0)) then
  Inc(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2005
//Instructionset(s): IA32

function Ceil32_DKC_IA32_1(const X : Extended) : Integer; overload;
asm
 sub    esp,8
 fnstcw [esp].Word         //Get current controlword
 mov    ax,[esp]          //into eax
 or     ax,0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax,1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4],ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  dword ptr [esp+4]
 mov    eax,[esp+4]
 fldcw  word ptr [esp]     //Restore controlword
 add    esp,8
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32

function Ceil32_DKC_IA32_1(const X : Double) : Integer; overload;
asm
 sub    esp,8
 fnstcw [esp].Word         //Get current controlword
 mov    ax, [esp]          //into eax
 or     ax, 0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  dword ptr [esp+4]
 mov    eax, [esp+4]
 fldcw  word ptr [esp]     //Restore controlword
 add    esp,8
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32

function Ceil32_DKC_IA32_1(const X : Single) : Integer; overload;
asm
 sub    esp,8
 fnstcw [esp].Word         //Get current controlword
 mov    ax,[esp]          //into eax
 or     ax,0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax,1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4],ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  dword ptr [esp+4]
 mov    eax,[esp+4]
 fldcw  word ptr [esp]     //Restore controlword
 add    esp,8
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32

function Ceil32_DKC_IA32_2(const X : Single) : Integer; overload;
asm
 sub    esp,8
 fnstcw [esp].Word           //Get current controlword
 mov    ax,[esp]             //into eax
 or     ax,0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax,1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4],ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  Result
 fldcw  word ptr [esp]       //Restore controlword
 add    esp,8
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32

function Ceil32_DKC_IA32_3(const X : Single) : Integer; overload;
var
 W1, W2 : Word;
asm
 fnstcw W1.Word           //Get current controlword
 mov    ax,W1             //into eax
 or     ax,0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax,1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    W2,ax
 fldcw  W2
 fld    X
 fistp  Result
 fldcw  W1       //Restore controlword
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32

function Ceil32_DKC_IA32_4(const X : Single) : Integer; overload;
var
 W1, W2 : Word;
asm
 fnstcw W1.Word           //Get current controlword
 mov    ax,W1             //into eax
 or     ax,0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax,1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    W2,ax
 fldcw  W2
 fld    X
 sub    esp,4
 fistp  dword ptr [esp]
 mov    eax,[esp]
 add    esp,4
 fldcw  W1       //Restore controlword
end;

//Author:            Dennis Kjaer Christensen
//Date:              17/11 2005
//Instructionset(s): IA32, IA32 Extensions, SSE

function Ceil32_DKC_SSE_1(const X : Single) : Integer; overload;
asm
 sub       esp,12
 fldz
 fld       X
 fcomi     st(0),st(1)
 ffree     st(1)
 jbe       @NegativeX
@PositiveX :
 fnstcw    [esp+8].Word         //Get current controlword
 mov       ax,[esp+8]          //into eax
 or        ax,0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and       ax,1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov       [esp+4],ax
 fldcw     word ptr [esp+4]
 fistp     dword ptr [esp]
 mov       eax,[esp]
 fldcw     word ptr [esp+8]     //Restore controlword
 jmp       @Exit
@NegativeX :
 //bit 7-12 masks exceptions. We want xxxx exceptions
 //bit 7 must be cleared = 0
 stmxcsr   [esp+4]
 mov       ecx,[esp+4]
 and       ecx,1111111101111111b
 mov       [esp],ecx
 ldmxcsr   [esp]
 ffree     st(0)
 movss     xmm0,X
 cvttss2si eax,xmm0
 ldmxcsr   [esp+4]
@Exit :
 add       esp,12
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32, SSE2

function Trunc32_DKC_SSE2_1(const X : Double) : Integer;
asm
 cvttsd2si eax,X
end;

function Ceil32_DKC_SSE2_1(const X: Double): Integer; overload;
begin
 if (X < -MaxInt-1) or (X > MaxInt) then
  raise ERangeError.CreateRes(@SRangeError);
 Result := Trunc32_DKC_SSE2_1(X);
 if Frac(X) > 0 then
  Inc(Result);
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32, SSE2

function Trunc32_DKC_SSE2_2(var X : Double) : Integer;
asm
 cvttsd2si eax, [eax]
end;

function Ceil32_DKC_SSE2_2(const X: Double): Integer; overload;
var
 X1 : Double;
begin
 if (X < -MaxInt-1) or (X > MaxInt) then
  raise ERangeError.CreateRes(@SRangeError);
 X1 := X;
 Result := Trunc32_DKC_SSE2_2(X1);
 if Frac(X) > 0 then
  Inc(Result);
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32, SSE2

function Frac32_DKC_SSE2_1(var X : Double) : Double;
asm
 sub       esp,8
 movsd     xmm0,[eax]
 cvttsd2si eax, [eax]
 cvtsi2sd  xmm1,eax
 subsd     xmm0,xmm1
 movsd     [esp],xmm0
 fld       qword ptr [esp]
 add       esp,8
end;

function Ceil32_DKC_SSE2_3(const X: Double): Integer; overload;
var
 X1 : Double;

begin
 if (X < -MaxInt-1) or (X > MaxInt) then
  raise ERangeError.CreateRes(@SRangeError);
 X1 := X;
 Result := Trunc32_DKC_SSE2_2(X1);
 if Frac32_DKC_SSE2_1(X1) > 0 then
  Inc(Result);
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32, SSE2

function Trunc32_DKC_SSE2_3(const X : Double) : Integer;
asm
 cvttsd2si eax,X
end;

function Frac32_DKC_SSE2_2(const X : Double) : Double;
asm
 sub       esp,8
 movsd     xmm0,X
 cvttsd2si eax,xmm0
 cvtsi2sd  xmm1,eax
 subsd     xmm0,xmm1
 movsd     [esp],xmm0
 fld       qword ptr [esp]
 add       esp,8
end;

function Ceil32_DKC_SSE2_4(const X: Double): Integer; overload;
begin
 if (X < -MaxInt-1) or (X > MaxInt) then
  raise ERangeError.CreateRes(@SRangeError);
 Result := Trunc32_DKC_SSE2_3(X);
 if Frac32_DKC_SSE2_2(X) > 0 then
  Inc(Result);
end;

//Author:            Dennis Kjaer Christensen
//Date:              16/11 2005
//Instructionset(s): IA32, IA32 exten, SSE2

function Ceil32_DKC_SSE2_5(const X: Double): Integer; overload;
asm
 sub       esp,8
 //bit 7-12 masks exceptions. We want xxxx exceptions
 //bit 7 must be cleared = 0
 stmxcsr   [esp+4]
 mov       ecx,[esp+4]
 and       ecx,1111111101111111b
 mov       [esp],ecx
 ldmxcsr   [esp]
 //Result := Trunc32_DKC_SSE2_3(X);
 cvttsd2si eax,X
 ldmxcsr   [esp+4]
 //if Frac32_DKC_SSE2_2(X) > 0 then
 movsd     xmm0,X
 cvttsd2si eax,xmm0
 cvtsi2sd  xmm1,eax
 subsd     xmm0,xmm1
 movsd     [esp],xmm0
 fld       qword ptr [esp]
 add       esp,8
 //if Frac32_DKC_SSE2_2(X) > 0
 fldz
 fcomi     st(0),st(1)
 ffree     st(1)
 ffree     st(0)
 jae       @Exit
 //Inc(Result);
 inc eax
@Exit :
end;
{
//Author:            Dennis Kjaer Christensen
//Date:              13/11 2005
//Instructionset(s): IA32, IA32 Extensions, SSE3

function Ceil32_DKC_SSE3_1(const X : Extended) : Integer; overload;
asm
 sub    esp,12
 fldz
 fld    X
 fcomi  st(0),st(1)
 ffree  st(1)
 jbe    @NegativeX
@PositiveX :
 fnstcw [esp+8].Word         //Get current controlword
 mov    ax,[esp+8]           //into eax
 or     ax,0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax,1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4],ax
 fldcw  word ptr [esp+4]
 fistp  dword ptr [esp]
 mov    eax,[esp]
 fldcw  word ptr [esp+8]     //Restore controlword
 jmp    @Exit
@NegativeX :
 //fisttp dword ptr [esp]
 db     $DB,$0C,$24
 mov    eax,[esp]
@Exit :
 add    esp,12
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32, IA32 Extensions, SSE3

function Ceil32_DKC_SSE3_1(const X : Double) : Integer; overload;
asm
 sub    esp,12
 fldz
 fld    X
 fcomi  st(0),st(1)
 ffree  st(1)
 jbe    @NegativeX
@PositiveX :
 fnstcw [esp].Word         //Get current controlword
 mov    ax, [esp]          //into eax
 or     ax, 0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fistp  dword ptr [esp+4]
 mov    eax, [esp+4]
 fldcw  word ptr [esp]     //Restore controlword
 jmp    @Exit
@NegativeX :
 //fisttp dword ptr [esp]
 db     $DB,$0C,$24
 mov    eax,[esp]
@Exit :
 add    esp,12
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2005
//Instructionset(s): IA32, IA32 Extensions, SSE3

function Ceil32_DKC_SSE3_1(const X : Single) : Integer; overload;
asm
 sub    esp,12
 fldz
 fld    X
 fcomi  st(0),st(1)
 ffree  st(1)
 jbe    @NegativeX
@PositiveX :
 fnstcw [esp].Word         //Get current controlword
 mov    ax,[esp]          //into eax
 or     ax,0000100000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax,1111101111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4],ax
 fldcw  word ptr [esp+4]
 fistp  dword ptr [esp+4]
 mov    eax,[esp+4]
 fldcw  word ptr [esp]     //Restore controlword
 jmp    @Exit
@NegativeX :
 //fisttp dword ptr [esp]
 db     $DB,$0C,$24
 mov    eax,[esp]
@Exit :
 add    esp,12
end;
}
end.
