unit Int64MulJOHUnit;

interface

function Int64Mul_JOH_IA32_1(var X, Y : Int64) : Int64;
function Int64Mul_JOH_IA32_2(var X, Y : Int64) : Int64;

implementation

function Int64Mul_JOH_IA32_1(var X, Y : Int64) : Int64;
asm
  push  ebx
  push  edi
  lea   ebx, [eax]
  lea   edi, [edx]
  mov   edx, [ebx+4]
  mov   ecx, [edi+4]
  or    edx, ecx
  mov   edx, [edi]
  mov   eax, [ebx]
  jnz   @@TwoMul
  mul   edx
  pop   edi
  pop   ebx
  ret
@@TwoMul:
  imul  edx, [ebx+4]
  imul  ecx, eax
  add   ecx, edx
  mul   dword ptr [edi]
  add   edx, ecx
  pop   edi
  pop   ebx
end;

function Int64Mul_JOH_IA32_2(var X, Y : Int64) : Int64;
asm  {36 Bytes}
  push  ebx
  push  edi
  lea   ebx, [eax]      //@X
  lea   edi, [edx]      //@Y
  mov   edx, [ebx+4]    //X-Hi
  mov   ecx, [edi+4]    //Y-Hi
  or    edx, ecx        //Both 0?
  mov   eax, [ebx]      //X-Lo
  jz    @@LowMul
  mov   edx, [edi]      //Y-Lo
  imul  ecx, eax        //Y-Hi * X-Lo
  imul  edx, [ebx+4]    //Y-Lo * X-Hi
  add   ecx, edx
@@LowMul:
  mul   dword ptr [edi]
  add   edx, ecx
  pop   edi
  pop   ebx
end; 

end.
