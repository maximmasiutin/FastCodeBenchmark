unit MinFPDKCUnit;

interface

function MinDKC_Pas(const A, B : Single) : Single; overload;
function MinDKC_Pas(const A, B : Double) : Double; overload;
function MinDKC_Pas(const A, B : Extended) : Extended; overload;
function MinDKC_RTL(const A, B : Single) : Single; overload;
function MinDKC_RTL(const A, B : Double) : Double; overload;
function MinDKC_RTL(const A, B : Extended) : Extended; overload;
function MinDKC_ASM2(const A, B : Single) : Single; overload;
function MinDKC_ASM2(const A, B : Double) : Double; overload;
function MinDKC_ASM2(const A, B : Extended) : Extended; overload;
function MinDKC_SSE2_3(const A, B : Double) : Double; overload;
function MinDKC_SSE_2(const A, B : Single) : Single; overload;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function MinDKC_Pas(const A, B : Single) : Single; overload;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function MinDKC_Pas(const A, B : Double) : Double; overload;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function MinDKC_Pas(const A, B : Extended) : Extended; overload;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function MinDKC_RTL(const A, B : Single) : Single; overload;
asm
 fld   A
 fld   B
 fcom
 fstsw ax
 sahf
 jnb   @Else
 ffree st(1)
 pop   ebp
 ret   8
@Else :
 fxch
 ffree st(1)
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function MinDKC_RTL(const A, B : Double) : Double; overload;
asm
 fld   A
 fld   B
 fcom
 fstsw ax
 sahf
 jnb    @Else
 ffree st(1)
 pop   ebp
 ret   16
@Else :
 fxch
 ffree st(1)
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function MinDKC_RTL(const A, B : Extended) : Extended; overload;
asm
 fld   A
 fld   B
 fcom
 fstsw ax
 sahf
 jnb   @Else
 ffree st(1)
 pop   ebp
 ret   $18
@Else :
 fxch
 ffree st(1)
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function MinDKC_Asm2(const A, B : Single) : Single; overload;
asm
 fld   A
 fld   B
 fcomi st(0), st(1)
 jnb   @Else
 ffree st(1)
 pop   ebp
 ret   8
@Else :
 fxch
 ffree st(1)
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32, IA32 Extensions

function MinDKC_Asm2(const A, B : Double) : Double; overload;
asm
 fld   A
 fld   B
 fcomi st(0),st(1)
 jnb   @Else
 ffree st(1)
 pop   ebp
 ret   16
@Else :
 fxch
 ffree st(1)
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32, IA32 Extensions

function MinDKC_Asm2(const A, B : Extended) : Extended; overload;
asm
 fld   A
 fld   B
 fcomi st(0), st(1)
 jnb   @Else
 ffree st(1)
 pop   ebp
 ret   $18
@Else :
 fxch
 ffree st(1)
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32, SSE2

function MinDKC_SSE2_3(const A, B : Double) : Double; overload;
asm
 sub   esp, 8
 movsd xmm0,A
 movsd xmm1,b
 minsd xmm0,xmm1
 movsd [esp],xmm0
 fld   qword ptr [esp]
 add   esp, 8
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32, SSE

function MinDKC_SSE_2(const A, B : Single) : Single; overload;
asm
 sub   esp,8
 movss xmm0,A
 movss xmm1,b
 minss xmm0,xmm1
 movss [esp],xmm0
 fld   dword ptr [esp]
 add   esp,8
end;

end.
