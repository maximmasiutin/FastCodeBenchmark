unit Int64MulAMDUnit;

interface

function Int64Mul_AMD_IA32_1(var X, Y : Int64) : Int64;

implementation

function Int64Mul_AMD_IA32_1(var X, Y : Int64) : Int64;
asm
 push ebx
 push edi
 lea  ebx,[X]
 lea  edi,[Y]
 mov  edx,[edi+4]       // multiplicand_hi
 mov  ecx,[ebx+4]       // multiplier_hi
 or   edx,ecx           // one operand >= 2^32?
 mov  edx,[ebx]         // multiplier_lo
 mov  eax,[edi]         // multiplicand_lo
 jnz  @TwoMul           // yes, need two multiplies
 mul  edx               // multiplicand_lo * multiplier_lo
 pop  edi
 pop  ebx
 ret                    // done, return to caller
@TwoMul:
 imul edx,[edi+4]       // p3_lo = multiplier_lo*multiplicand_hi
 imul ecx,[edi]         // p2_lo = multiplier_hi*multiplicand_lo
 add  ecx,edx           // p2_lo + p3_lo
 mul  dword ptr [ebx]   // p1=multiplicand_lo*multiplier_lo
 add  edx,ecx           // p1+p2_lo+p3_lo = result in edx:eax
 pop  edi
 pop  ebx
 ret                    // done, return to caller
end;

end.
