unit TruncUnit;

interface

function TruncExtended_RTL_IA32_1(const X : Extended) : Int64;
function TruncExtended_DKC_IA32_1(const X : Extended) : Int64;
function TruncExtended_DKC_IA32_2(const X : Extended) : Int64;
function TruncDouble_DKC_IA32_1(const X : Double) : Int64;
function TruncDouble_DKC_IA32_2(const X : Double) : Int64;
function TruncSingle_DKC_PAS_1(const X : Single) : Int64;
function TruncSingle_DKC_IA32_2(const X : Single) : Int64;
function TruncSingle_DKC_IA32_3(const X : Single) : Int64;
function TruncExtended_DKC_SSE3_1(const X : Extended) : Int64;
function TruncDouble_DKC_SSE3_1(const X : Double) : Int64;
function TruncSingle_DKC_SSE3_1(const X : Single) : Int64;

implementation

uses
 Math;

//Author:            Dennis Kjaer Christensen
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
 
function TruncExtended_RTL_IA32_1(const X : Extended) : Int64;
asm
       { ->    FST(0)   Extended argument       }
       { <-    EDX:EAX  Result                  }

        SUB     ESP,12
        FNSTCW  [ESP].Word          // save
        FNSTCW  [ESP+2].Word        // scratch
        FWAIT
        OR      [ESP+2].Word, $0F00  // trunc toward zero, full precision
        FLDCW   [ESP+2].Word
        FLD     X                    //Added by Dennis
        FISTP   qword ptr [ESP+4]
        FWAIT
        FLDCW   [ESP].Word
        POP     ECX
        POP     EAX
        POP     EDX
end;

//Author:            Dennis Kjaer Christensen
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32

function TruncExtended_DKC_IA32_1(const X : Extended) : Int64;
var
 FPURoundingMode : TFPURoundingMode;

begin
 FPURoundingMode := GetRoundMode;
 SetRoundMode(rmTruncate);
 Result := Round(X);
 SetRoundMode(FPURoundingMode);
end;

//Author:            Dennis Kjaer Christensen
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32

function TruncExtended_DKC_IA32_2(const X : Extended) : Int64;
asm
 fnstcw [esp-12].Word         //Get current controlword
 mov    ax, [esp-12]          //into eax
 or     ax, 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 mov    [esp-8], ax
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 fldcw  word ptr [esp-12]     //Restore controlword
end;

//Author:            Dennis Kjaer Christensen
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32

function TruncDouble_DKC_IA32_1(const X : Double) : Int64;
var
 FPURoundingMode : TFPURoundingMode;

begin
 FPURoundingMode := GetRoundMode;
 SetRoundMode(rmTruncate);
 Result := Trunc(X);
 SetRoundMode(FPURoundingMode);
end;

//Author:            Dennis Kjaer Christensen
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32

function TruncDouble_DKC_IA32_2(const X : Double) : Int64;
asm
 fnstcw [esp-12].Word         //Get current controlword
 mov    ax, [esp-12]          //into eax
 or     ax, 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 mov    [esp-8], ax
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 fldcw  word ptr [esp-12]     //Restore controlword
end;

//Author:            Dennis Kjaer Christensen
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32

function TruncSingle_DKC_PAS_1(const X : Single) : Int64;
var
 FPURoundingMode : TFPURoundingMode;

begin
 FPURoundingMode := GetRoundMode;
 SetRoundMode(rmTruncate);
 Result := Trunc(X);
 SetRoundMode(FPURoundingMode);
end;

//Author:            Dennis Kjaer Christensen
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32

function TruncSingle_DKC_IA32_2(const X : Single) : Int64;
asm
 fnstcw [esp-12].Word         //Get current controlword
 mov    ax, [esp-12]          //into eax
 or     ax, 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 mov    [esp-8], ax
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 fldcw  word ptr [esp-12]     //Restore controlword
end;

//Author:            Dennis Kjaer Christensen
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32

function TruncSingle_DKC_IA32_3(const X : Single) : Int64;
asm
 fnstcw [esp-12].Word              //Get current controlword
 fnstcw [esp-8].Word               //Get current controlword
 or     [esp-8], 0000110000000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
 fldcw  word ptr [esp-8]
 fld    X
 fistp  qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
 fldcw  word ptr [esp-12]          //Restore controlword
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/2 2004
//Optimized for:     Prescott
//Instructionset(s): IA32, SSE3

function TruncExtended_DKC_SSE3_1(const X : Extended) : Int64;
asm
 fld X
 db $DD, $4C, $24, $F8 // fisttp qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/2 2004
//Optimized for:     Prescott
//Instructionset(s): IA32, SSE3

function TruncDouble_DKC_SSE3_1(const X : Double) : Int64;
asm
 fld X
 db $DD, $4C, $24, $F8 // fisttp qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/2 2004
//Optimized for:     Prescott
//Instructionset(s): IA32, SSE3

function TruncSingle_DKC_SSE3_1(const X : Single) : Int64;
asm
 fld X
 db $DD, $4C, $24, $F8 // fisttp qword ptr [esp-8]
 mov    eax, [esp-8]
 mov    edx, [esp-4]
end;

end.
