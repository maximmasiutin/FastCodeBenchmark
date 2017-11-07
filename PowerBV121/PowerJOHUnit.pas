unit PowerJOHUnit;

interface

function Power_JOH_IA32_1(const Base, Exponent: Single  ): Single  ; overload;
function Power_JOH_IA32_1(const Base, Exponent: Double  ): Double  ; overload;
function Power_JOH_IA32_1(const Base, Exponent: Extended): Extended; overload;

implementation

function Power_JOH_IA32_1(const Base, Exponent: Single): Single; overload;
const
  Max : Double = MaxInt;
var
  IntExp : Integer;
asm
  fld     Exponent
  fld     st             {copy to st(1)}
  fabs                   {abs(exp)}
  fld     Max
  fcompp                 {leave exp in st(0)}
  fstsw   ax
  sahf
  jb      @@RealPower    {exp > MaxInt}
  fld     st             {exp in st(0) and st(1)}
  frndint                {round(exp)}
  fcomp                  {compare exp and round(exp)}
  fstsw   ax
  sahf
  jne     @@RealPower
  fistp   IntExp
  mov     eax, IntExp    {eax=Integer(Exponent)}
  mov     ecx, eax
  cdq
  fld1                   {Result=1}
  xor     eax, edx
  sub     eax, edx       {abs(exp)}
  jz      @@Exit
  fld     Base
  jmp     @@Entry
@@Loop:
  fmul    st, st         {Base * Base}
@@Entry:
  shr     eax, 1
  jnc     @@Loop
  fmul    st(1), st      {Result * X}
  jnz     @@Loop
  fstp    st
  cmp     ecx, 0
  jge     @@Exit
  fld1
  fdivrp                 {1/Result}
  jmp     @@Exit
@@RealPower:
  fld     Base
  ftst
  fstsw   ax
  sahf
  jz      @@Done
  fldln2
  fxch
  fyl2x
  fxch
  fmulp   st(1), st
  fldl2e
  fmulp   st(1), st
  fld     st(0)
  frndint
  fsub    st(1), st
  fxch    st(1)
  f2xm1
  fld1
  faddp   st(1), st
  fscale
@@Done:
  fstp    st(1)
@@Exit:
end;

function Power_JOH_IA32_1(const Base, Exponent: Double): Double; overload;
const
  Max  : Double = MaxInt;
var
  IntExp : Integer;
asm
  fld     Exponent
  fld     st             {copy to st(1)}
  fabs                   {abs(exp)}
  fld     Max
  fcompp                 {leave exp in st(0)}
  fstsw   ax
  sahf
  jb      @@RealPower    {exp > MaxInt}
  fld     st             {exp in st(0) and st(1)}
  frndint                {round(exp)}
  fcomp                  {compare exp and round(exp)}
  fstsw   ax
  sahf
  jne     @@RealPower
  fistp   IntExp
  mov     eax, IntExp    {eax=Trunc(Exponent)}
  mov     ecx, eax
  cdq
  fld1                   {Result=1}
  xor     eax, edx
  sub     eax, edx       {abs(exp)}
  jz      @@Exit
  fld     Base
  jmp     @@Entry
@@Loop:
  fmul    st, st         {Base * Base}
@@Entry:
  shr     eax, 1
  jnc     @@Loop
  fmul    st(1), st      {Result * X}
  jnz     @@Loop
  fstp    st
  cmp     ecx, 0
  jge     @@Exit
  fld1
  fdivrp                 {1/Result}
  jmp     @@Exit
@@RealPower:
  fld     Base
  ftst
  fstsw   ax
  sahf
  jz      @@Done
  fldln2
  fxch
  fyl2x
  fxch
  fmulp   st(1), st
  fldl2e
  fmulp   st(1), st
  fld     st(0)
  frndint
  fsub    st(1), st
  fxch    st(1)
  f2xm1
  fld1
  faddp   st(1), st
  fscale
@@Done:
  fstp    st(1)
@@Exit:
end;

function Power_JOH_IA32_1(const Base, Exponent: Extended): Extended;
const
  Max  : Double = MaxInt;
var
  IntExp : Integer;
asm
  fld     Exponent
  fld     st             {copy to st(1)}
  fabs                   {abs(exp)}
  fld     Max
  fcompp                 {leave exp in st(0)}
  fstsw   ax
  sahf
  jb      @@RealPower    {exp > MaxInt}
  fld     st             {exp in st(0) and st(1)}
  frndint                {round(exp)}
  fcomp                  {compare exp and round(exp)}
  fstsw   ax
  sahf
  jne     @@RealPower
  fistp   IntExp
  mov     eax, IntExp    {eax=Trunc(Exponent)}
  mov     ecx, eax
  cdq
  fld1                   {Result=1}
  xor     eax, edx
  sub     eax, edx       {abs(exp)}
  jz      @@Exit
  fld     Base
  jmp     @@Entry
@@Loop:
  fmul    st, st         {Base * Base}
@@Entry:
  shr     eax, 1
  jnc     @@Loop
  fmul    st(1), st      {Result * X}
  jnz     @@Loop
  fstp    st
  cmp     ecx, 0
  jge     @@Exit
  fld1
  fdivrp                 {1/Result}
  jmp     @@Exit
@@RealPower:
  fld     Base
  ftst
  fstsw   ax
  sahf
  jz      @@Done
  fldln2
  fxch
  fyl2x
  fxch
  fmulp   st(1), st
  fldl2e
  fmulp   st(1), st
  fld     st(0)
  frndint
  fsub    st(1), st
  fxch    st(1)
  f2xm1
  fld1
  faddp   st(1), st
  fscale
@@Done:
  fstp    st(1)
@@Exit:
end;

end.

