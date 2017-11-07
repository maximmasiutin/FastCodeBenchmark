unit Floor32DKCUnit;

interface

function Floor32_DKC_Pas_1(const X : Extended) : Integer; overload;
function Floor32_DKC_Pas_1(const X : Double) : Integer; overload;
function Floor32_DKC_Pas_1(const X : Single) : Integer; overload;
function Floor32_DKC_IA32_1(const X : Extended) : Integer; overload;
function Floor32_DKC_IA32_1(const X : Double) : Integer; overload;
function Floor32_DKC_IA32_1(const X : Single) : Integer; overload;

implementation

uses
 Math;

//Author:            Dennis Kjaer Christensen
//Date:              23/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Floor32_DKC_Pas_1(const X : Extended) : Integer; overload;
begin
 Result := Trunc(X);
 if ((X < 0) and (X - Result <> 0)) then
  Dec(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              23/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Floor32_DKC_Pas_1(const X : Double) : Integer; overload;
begin
 Result := Trunc(X);
 if ((X < 0) and (X - Result <> 0)) then
  Dec(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              23/11 2005
//Instructionset(s): IA32

{$ifopt R-}
  {$define RangeCheckWasOff}
  {$R+}
{$endif}

function Floor32_DKC_Pas_1(const X : Single) : Integer; overload;
begin
 Result := Trunc(X);
 if ((X < 0) and (X - Result <> 0)) then
  Dec(Result);
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              23/11 2005
//Instructionset(s): IA32

function Floor32_DKC_IA32_1(const X : Extended) : Integer; overload;
asm
 sub    esp,8
 fnstcw [esp].Word           //Get current controlword
 mov    ax,[esp]             //into eax
 or     ax,0000010000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax,1111011111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4],ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  dword ptr [esp+4]
 mov    eax,[esp+4]
 fldcw  word ptr [esp]       //Restore controlword
 add    esp,8
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/11 2005
//Instructionset(s): IA32

function Floor32_DKC_IA32_1(const X : Double) : Integer; overload;
asm
 sub    esp,8
 fnstcw [esp].Word           //Get current controlword
 mov    ax,[esp]             //into eax
 or     ax,0000010000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax,1111011111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4],ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  dword ptr [esp+4]
 mov    eax,[esp+4]
 fldcw  word ptr [esp]       //Restore controlword
 add    esp,8
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/11 2005
//Instructionset(s): IA32

function Floor32_DKC_IA32_1(const X : Single) : Integer; overload;
asm
 sub    esp,8
 fnstcw [esp].Word            //Get current controlword
 mov    ax, [esp]             //into eax
 or     ax, 0000010000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111011111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp+4], ax
 fldcw  word ptr [esp+4]
 fld    X
 fistp  dword ptr [esp+4]
 mov    eax, [esp+4]
 fldcw  word ptr [esp]        //Restore controlword
 add    esp,8
end;

end.
