unit FloorUnit;

interface

function FloorExtendedDKC1(const X : Extended) : Int64;
function FloorDoubleDKC1(const X : Double) : Int64;
function FloorSingleDKC1(const X : Single) : Int64;
function FloorExtendedDKCPas1(const X: Extended): Int64;
function FloorDoubleDKCPas1(const X: Double): Int64;
function FloorSingleDKCPas1(const X: Single): Int64;

implementation

uses
 Math;

function FloorExtendedDKC1(const X : Extended) : Int64;
asm
 fnstcw [esp-12].Word         //Get current controlword
 mov    ax, [esp-12]          //into eax
 or     ax, 0000010000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111011111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp-8], ax
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 fldcw  word ptr [esp-12]     //Restore controlword
end;

function FloorDoubleDKC1(const X : Double) : Int64;
asm
 fnstcw [esp-12].Word         //Get current controlword
 mov    ax, [esp-12]          //into eax
 or     ax, 0000010000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111011111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp-8], ax
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 fldcw  word ptr [esp-12]     //Restore controlword
end;

function FloorSingleDKC1(const X : Single) : Int64;
asm
 fnstcw [esp-12].Word         //Get current controlword
 mov    ax, [esp-12]          //into eax
 or     ax, 0000010000000000B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 and    ax, 1111011111111111B //Bit 10-11 is rounding and bit10 = 0 & bit11 = 1 is round down
 mov    [esp-8], ax
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 fldcw  word ptr [esp-12]     //Restore controlword
end;

function FloorExtendedDKCPas1(const X: Extended): Int64;
begin
 Result := Trunc(X);
 if ((X < 0) and (X - Result <> 0)) then
  Dec(Result);
end;

function FloorDoubleDKCPas1(const X: Double): Int64;
begin
 Result := Trunc(X);
 if ((X < 0) and (X - Result <> 0)) then
  Dec(Result);
end;

function FloorSingleDKCPas1(const X: Single): Int64;
begin
 Result := Trunc(X);
 if ((X < 0) and (X - Result <> 0)) then
  Dec(Result);
end;

end.
