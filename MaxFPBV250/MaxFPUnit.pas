unit MaxFPUnit;

interface

function MaxDKCPas(const A, B : Single) : Single; overload;
function MaxDKCPas(const A, B : Double) : Double; overload;
function MaxDKCPas(const A, B : Extended) : Extended; overload;
function MaxDKCASM1(const A, B : Single) : Single; overload;
function MaxDKCASM1(const A, B : Double) : Double; overload;
function MaxDKCASM1(const A, B : Extended) : Extended; overload;
function MaxDKCASM2(const A, B : Single) : Single; overload;
function MaxDKCASM2(const A, B : Double) : Double; overload;
function MaxDKCASM2(const A, B : Extended) : Extended; overload;
function MaxDKCASM3(const A, B : Single) : Single; overload;
function MaxDKCASM3(const A, B : Double) : Double; overload;
function MaxDKCASM3(const A, B : Extended) : Extended; overload;
function MaxDKCSSE(const A, B : Single) : Single; overload;
function MaxDKCSSE2_1(const A, B : Double) : Double; overload;
function MaxDKCSSE2_2(const A, B : Double) : Double; overload;
function MaxJOH_RTL(const A, B : Single) : Single; overload;
function MaxJOH_RTL(const A, B : Double) : Double; overload;
function MaxJOH_RTL(const A, B : Extended) : Extended; overload;
function MaxJOH(const A, B : Single) : Single; overload;
function MaxJOH(const A, B : Double) : Double; overload;
function MaxJOH(const A, B : Extended) : Extended; overload;

implementation

function MaxDKCPas(const A, B : Single) : Single; overload;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

function MaxDKCPas(const A, B : Double) : Double; overload;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

function MaxDKCPas(const A, B : Extended) : Extended; overload;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

function MaxDKCASM1(const A, B : Single) : Single; overload;
asm
 //if A >= B then
 fld   A
 fld   B
 fcom
 fstsw ax
 sahf
 jb    @Else
 //Result := A
 ffree st(1)
 pop   ebp
 ret   8
 //else
 //Result := B;
@Else :
 fxch
 ffree st(1)
end;

function MaxDKCASM1(const A, B : Double) : Double; overload;
asm
 //if A >= B then
 fld   A
 fld   B
 fcom
 fstsw ax
 sahf
 jb    @Else
 //Result := A
 ffree st(1)
 pop   ebp
 ret   16
 //else
 //Result := B;
@Else :
 fxch
 ffree st(1)
end;

function MaxDKCASM2(const A, B : Single) : Single; overload;
asm
 //if A >= B then
 fld   A
 fld   B
 fcomi st(0), st(1)
 jb    @Else
 //Result := A
 ffree st(1)
 pop   ebp
 ret   8
 //else
 //Result := B;
@Else :
 fxch
 ffree st(1)
end;

function MaxDKCASM2(const A, B : Double) : Double; overload;
asm
 //if A >= B then
 fld   A
 fld   B
 fcomi st(0),st(1)
 jb    @Else
 //Result := A
 ffree st(1)
 pop   ebp
 ret   16
 //else
 //Result := B;
@Else :
 fxch
 ffree st(1)
end;

function MaxDKCASM1(const A, B : Extended) : Extended; overload;
asm
 //if A >= B then
 fld   A
 fld   B
 fcom
 fstsw ax
 sahf
 jb    @Else
 //Result := A
 ffree st(1)
 pop   ebp
 ret   $18
 //else
 //Result := B;
@Else :
 fxch
 ffree st(1)
end;

function MaxDKCASM2(const A, B : Extended) : Extended; overload;
asm
 //if A >= B then
 fld   A
 fld   B
 fcomi st(0), st(1)
 jb    @Else
 //Result := A
 ffree st(1)
 pop   ebp
 ret   $18
 //else
 //Result := B;
@Else :
 fxch
 ffree st(1)
end;

function MaxDKCASM3(const A, B : Single) : Single; overload;
asm
   fld     A
   fld     B
   fcomi   st(0), st(1)
   fcmovb  st(0), st(1)
   ffree   st(1)
end;

function MaxDKCSSE(const A, B : Single) : Single; overload;
asm
 movss xmm0,A
 movss xmm1,b
 maxss xmm0,xmm1
 movss [esp-8],xmm0
 fld   dword ptr [esp-8]
end;

function MaxDKCASM3(const A, B : Double) : Double; overload;
asm
   fld     A
   fld     B
   fcomi   st(0), st(1)
   fcmovb  st(0), st(1)
   ffree   st(1)
end;

function MaxDKCSSE2_1(const A, B : Double) : Double; overload;
asm
 movsd xmm0,A
 movsd xmm1,b
 maxsd xmm0,xmm1
 movsd [esp-8],xmm0
 fld   qword ptr [esp-8]
end;

function MaxDKCSSE2_2(const A, B : Double) : Double; overload;
asm
 movsd xmm0,A
 movsd xmm1,b
 maxsd xmm0,xmm1
 mov   ecx,esp
 and   ecx,-8
 movsd [ecx-16],xmm0
 fld   qword ptr [ecx-16]
end;

function MaxDKCASM3(const A, B : Extended) : Extended; overload;
asm
   fld     A
   fld     B
   fcomi   st(0), st(1)
   fcmovb  st(0), st(1)
   ffree   st(1)
end;

function MaxJOH_RTL(const A, B : Single) : Single; overload;
asm
  fld    B
  fcomp  A
  fstsw  ax
  and    eax, $100
  shr    eax, 6 {eax = 0 or 4}
  fld    dword ptr [ebp+eax+8]
end;

function MaxJOH_RTL(const A, B : Double) : Double; overload;
asm
  fld   A
  fld   B
  fcom
  fstsw ax
  sahf
  jnc   @done
  fxch
@done:
  ffree st(1)
end;

function MaxJOH_RTL(const A, B : Extended) : Extended; overload;
asm
  fld   A
  fld   B
  fcom
  fstsw ax
  sahf
  jnc   @done
  fxch
@done:
  ffree st(1)
end;

function MaxJOH(const A, B : Single) : Single; overload;
asm
  fld     A
  fld     B
  fcomi   st(0), st(1)
  fcmovb  st(0), st(1)
  ffree   st(1)
end;

function MaxJOH(const A, B : Double) : Double; overload;
asm
  fld     A
  fld     B
  fcomi   st(0), st(1)
  fcmovb  st(0), st(1)
  ffree   st(1)
end;

function MaxJOH(const A, B : Extended) : Extended; overload;
asm
  fld     A
  fld     B
  fcomi   st(0), st(1)
  fcmovb  st(0), st(1)
  ffree   st(1)
end;

end.
