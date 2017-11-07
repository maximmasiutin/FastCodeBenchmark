unit Int64DivDKCUnit;

interface

//function Int64Div_DKC_Pas_1(var X, Y : Int64) : Int64;
function Int64Div_DKC_IA32_2_a(var X, Y : Int64) : Int64;
function Int64Div_DKC_IA32_2_b(var X, Y : Int64) : Int64;
function Int64Div_DKC_IA32_2_c(var X, Y : Int64) : Int64;
function Int64Div_DKC_IA32_2_d(var X, Y : Int64) : Int64;
function Int64Div_DKC_IA32ext_2_a(var X, Y : Int64) : Int64;
function Int64Div_DKC_IA32ext_2_b(var X, Y : Int64) : Int64;
function Int64Div_DKC_IA32ext_2_c(var X, Y : Int64) : Int64;
function Int64Div_DKC_IA32ext_2_d(var X, Y : Int64) : Int64;

implementation

function Int64Div_DKC_Pas_1(var X, Y : Int64) : Int64;
begin
 if Abs(X) >= Abs(Y) then
  Result := X div Y
 else
  Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/10 2004
//Instructionset(s): IA32

function Int64Div_DKC_IA32_2_a(var X, Y : Int64) : Int64;
asm
   fild   qword ptr [X]
   fld    st(0)
   fabs
   fild   qword ptr [Y]
   fld    st(0)
   fabs
   fcom   st(2)
   fstsw ax
   sahf
   jbe    @DoDiv
   ffree  st(3)
   ffree  st(2)
   ffree  st(1)
   ffree  st(0)
   xor    eax,eax
   xor    edx,edx
   jmp    @Exit
 @DoDiv :
   sub    esp,12
   fxch   st(3)
   ffree  st(3)
   ffree  st(2)
   fnstcw [esp].Word         //Get current controlword
   mov    cx, [esp]          //into ecx
   or     cx, 0000111100000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
   mov    [esp+4], cx           //Bit 8-9 is rounding and bit8 = 1 & bit9 = 1 is Extended
   fldcw  word ptr [esp+4]
   fdivrp
   fistp  qword ptr [esp+4]     //Possibly a line split if stackpointer is unaligned
   wait
   fldcw  word ptr [esp]     //Restore controlword
   mov    eax, [esp+4]
   mov    edx, [esp+8]
   add    esp,12
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/10 2004
//Instructionset(s): IA32

function Int64Div_DKC_IA32_2_b(var X, Y : Int64) : Int64;
asm
   fild   qword ptr [X]
   fld    st(0)
   fabs
   fild   qword ptr [Y]
   fld    st(0)
   fabs
   fcom   st(2)
   fstsw ax
   sahf
   jbe    @DoDiv
   ffree  st(3)
   ffree  st(2)
   ffree  st(1)
   ffree  st(0)
   xor    eax,eax
   xor    edx,edx
   jmp    @Exit
 @DoDiv :
   sub    esp,12
   fxch   st(3)
   ffree  st(3)
   ffree  st(2)
   fnstcw [esp].Word         //Get current controlword
   mov    cx, [esp]          //into ecx
   or     cx, 0000111100000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
   mov    [esp+4], cx           //Bit 8-9 is rounding and bit8 = 1 & bit9 = 1 is Extended
   fldcw  word ptr [esp+4]
   fdivrp
   fistp  qword ptr [esp+4]     //Possibly a line split if stackpointer is unaligned
   wait
   fldcw  word ptr [esp]     //Restore controlword
   mov    eax, [esp+4]
   mov    edx, [esp+8]
   add    esp,12
 @Exit :
end;


procedure Filler1;
asm
 nop
end;


//Author:            Dennis Kjaer Christensen
//Date:              5/10 2004
//Instructionset(s): IA32

function Int64Div_DKC_IA32_2_c(var X, Y : Int64) : Int64;
asm
   fild   qword ptr [X]
   fld    st(0)
   fabs
   fild   qword ptr [Y]
   fld    st(0)
   fabs
   fcom   st(2)
   fstsw ax
   sahf
   jbe    @DoDiv
   ffree  st(3)
   ffree  st(2)
   ffree  st(1)
   ffree  st(0)
   xor    eax,eax
   xor    edx,edx
   jmp    @Exit
 @DoDiv :
   sub    esp,12
   fxch   st(3)
   ffree  st(3)
   ffree  st(2)
   fnstcw [esp].Word         //Get current controlword
   mov    cx, [esp]          //into ecx
   or     cx, 0000111100000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
   mov    [esp+4], cx           //Bit 8-9 is rounding and bit8 = 1 & bit9 = 1 is Extended
   fldcw  word ptr [esp+4]
   fdivrp
   fistp  qword ptr [esp+4]     //Possibly a line split if stackpointer is unaligned
   wait
   fldcw  word ptr [esp]     //Restore controlword
   mov    eax, [esp+4]
   mov    edx, [esp+8]
   add    esp,12
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/10 2004
//Instructionset(s): IA32

function Int64Div_DKC_IA32_2_d(var X, Y : Int64) : Int64;
asm
   fild   qword ptr [X]
   fld    st(0)
   fabs
   fild   qword ptr [Y]
   fld    st(0)
   fabs
   fcom   st(2)
   fstsw ax
   sahf
   jbe    @DoDiv
   ffree  st(3)
   ffree  st(2)
   ffree  st(1)
   ffree  st(0)
   xor    eax,eax
   xor    edx,edx
   jmp    @Exit
 @DoDiv :
   sub    esp,12
   fxch   st(3)
   ffree  st(3)
   ffree  st(2)
   fnstcw [esp].Word         //Get current controlword
   mov    cx, [esp]          //into ecx
   or     cx, 0000111100000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
   mov    [esp+4], cx           //Bit 8-9 is rounding and bit8 = 1 & bit9 = 1 is Extended
   fldcw  word ptr [esp+4]
   fdivrp
   fistp  qword ptr [esp+4]     //Possibly a line split if stackpointer is unaligned
   wait
   fldcw  word ptr [esp]     //Restore controlword
   mov    eax, [esp+4]
   mov    edx, [esp+8]
   add    esp,12
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/10 2004
//Instructionset(s): IA32, IA32ext (fcomi)

function Int64Div_DKC_IA32ext_2_a(var X, Y : Int64) : Int64;
asm
   fild   qword ptr [X]
   fld    st(0)
   fabs
   fild   qword ptr [Y]
   fld    st(0)
   fabs
   fcomip st(0), st(2)
   jbe    @DoDiv
   ffree  st(2)
   ffree  st(1)
   ffree  st(0)
   xor    eax,eax
   xor    edx,edx
   jmp    @Exit
 @DoDiv :
   sub    esp,12
   fstp   st(1)
   fnstcw [esp].Word         //Get current controlword
   mov    cx, [esp]          //into ecx
   or     cx, 0000111100000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
   mov    [esp+4], cx           //Bit 8-9 is rounding and bit8 = 1 & bit9 = 1 is Extended
   fldcw  word ptr [esp+4]
   fdivp
   fistp  qword ptr [esp+4]     //Possibly a line split if stackpointer is unaligned
   wait
   fldcw  word ptr [esp]     //Restore controlword
   mov    eax, [esp+4]
   mov    edx, [esp+8]
   add    esp,12
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/10 2004
//Instructionset(s): IA32, IA32ext (fcomi)

function Int64Div_DKC_IA32ext_2_b(var X, Y : Int64) : Int64;
asm
   fild   qword ptr [X]
   fld    st(0)
   fabs
   fild   qword ptr [Y]
   fld    st(0)
   fabs
   fcomip st(0), st(2)
   jbe    @DoDiv
   ffree  st(2)
   ffree  st(1)
   ffree  st(0)
   xor    eax,eax
   xor    edx,edx
   jmp    @Exit
 @DoDiv :
   sub    esp,12
   fstp   st(1)
   fnstcw [esp].Word         //Get current controlword
   mov    cx, [esp]          //into ecx
   or     cx, 0000111100000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
   mov    [esp+4], cx           //Bit 8-9 is rounding and bit8 = 1 & bit9 = 1 is Extended
   fldcw  word ptr [esp+4]
   fdivp
   fistp  qword ptr [esp+4]     //Possibly a line split if stackpointer is unaligned
   wait
   fldcw  word ptr [esp]     //Restore controlword
   mov    eax, [esp+4]
   mov    edx, [esp+8]
   add    esp,12
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/10 2004
//Instructionset(s): IA32, IA32ext (fcomi)

function Int64Div_DKC_IA32ext_2_c(var X, Y : Int64) : Int64;
asm
   fild   qword ptr [X]
   fld    st(0)
   fabs
   fild   qword ptr [Y]
   fld    st(0)
   fabs
   fcomip st(0), st(2)
   jbe    @DoDiv
   ffree  st(2)
   ffree  st(1)
   ffree  st(0)
   xor    eax,eax
   xor    edx,edx
   jmp    @Exit
 @DoDiv :
   sub    esp,12
   fstp   st(1)
   fnstcw [esp].Word         //Get current controlword
   mov    cx, [esp]          //into ecx
   or     cx, 0000111100000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
   mov    [esp+4], cx           //Bit 8-9 is rounding and bit8 = 1 & bit9 = 1 is Extended
   fldcw  word ptr [esp+4]
   fdivp
   fistp  qword ptr [esp+4]     //Possibly a line split if stackpointer is unaligned
   wait
   fldcw  word ptr [esp]     //Restore controlword
   mov    eax, [esp+4]
   mov    edx, [esp+8]
   add    esp,12
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/10 2004
//Instructionset(s): IA32, IA32ext (fcomi)

function Int64Div_DKC_IA32ext_2_d(var X, Y : Int64) : Int64;
asm
   fild   qword ptr [X]
   fld    st(0)
   fabs
   fild   qword ptr [Y]
   fld    st(0)
   fabs
   fcomip st(0), st(2)
   jbe    @DoDiv
   ffree  st(2)
   ffree  st(1)
   ffree  st(0)
   xor    eax,eax
   xor    edx,edx
   jmp    @Exit
 @DoDiv :
   sub    esp,12
   fstp   st(1)
   fnstcw [esp].Word         //Get current controlword
   mov    cx, [esp]          //into ecx
   or     cx, 0000111100000000B //Bit 10-11 is rounding and bit10 = 1 & bit11 = 1 is truncation
   mov    [esp+4], cx           //Bit 8-9 is rounding and bit8 = 1 & bit9 = 1 is Extended
   fldcw  word ptr [esp+4]
   fdivp
   fistp  qword ptr [esp+4]     //Possibly a line split if stackpointer is unaligned
   wait
   fldcw  word ptr [esp]     //Restore controlword
   mov    eax, [esp+4]
   mov    edx, [esp+8]
   add    esp,12
 @Exit :
end;

initialization

 Filler1;

end.
