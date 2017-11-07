unit Int64MulDKCUnit;

interface

function Int64MulDKCIA32_1(var X, Y : Int64) : Int64;
function Int64Mul_DKC_IA32_2(var X, Y : Int64) : Int64;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              17/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Int64MulDKCIA32_1(var X, Y : Int64) : Int64;
asm
    push ebx
    push edi
    lea  ebx,[X]
    lea  ecx,[Y]
    //Param1 : [ebx+4]:[ebx]  (hi:lo)
    //Param2 : [ecx+4]:[ecx]  (hi:lo)
    mov  eax, [ebx+4]           //eax = hi1
    mul  dword ptr [ecx]        //edx:eax = hi1*lo2
    mov  edi, eax               //edi = lo(hi1*lo2)
    mov  eax, [ecx+4]           //eax = hi2
    mul  dword ptr [ebx]        //edx:eax = hi2*lo1
    add  edi, eax               //edi = lo(hi1*lo2) + lo(hi2*lo1)
    mov  eax, [ecx]             //eax = lo2
    mul  dword ptr [ebx]        //edx:eax = lo2*lo1   edx is eventual carry
    add  edx, edi               //edx = hi(lo2*lo1) + lo(hi1*lo2) + lo(hi2*lo1)  //if overflow then
    pop  edi                    //eax = lo(lo2*lo1)
    pop  ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              17/10 2003
//Instructionset(s): IA32

function Int64Mul_DKC_IA32_2(var X, Y : Int64) : Int64;
asm
    push ebx
    push esi
    lea  ebx,[X]
    lea  ecx,[Y]
    //Param1 : [ebx+4]:[ebx]    (hi1:lo1)
    //Param2 : [ecx+4]:[ecx]    (hi2:lo2)
    mov  esi,[ebx]              //esi = lo1
    mov  eax,[ebx+4]
    mul  dword ptr [ecx]        //edx:eax = hi1*lo2
    mov  ebx,eax                //ebx = lo(hi1*lo2)
    mov  eax,[ecx+4]            //eax = hi2
    mul  esi                    //edx:eax = hi2*lo1
    add  ebx, eax               //ebx = lo(hi1*lo2) + lo(hi2*lo1)
    mov  eax,[ecx]              //eax = lo2
    mul  esi                    //edx:eax = lo2*lo1   edx is eventual carry
    add  edx,ebx                //edx = hi(lo2*lo1) + lo(hi1*lo2) + lo(hi2*lo1)  //if overflow then
    pop  esi                    //eax = lo(lo2*lo1)
    pop  ebx
end;

end.
