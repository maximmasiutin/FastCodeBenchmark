unit Int64DivAMDUnit;

interface

function Int64Div_AMD_IA32_1_a(var X, Y : Int64) : Int64;
function Int64Div_AMD_IA32_1_b(var X, Y : Int64) : Int64;
function Int64Div_AMD_IA32_1_c(var X, Y : Int64) : Int64;
function Int64Div_AMD_IA32_1_d(var X, Y : Int64) : Int64;

implementation

function Int64Div_AMD_IA32_1_a(var X, Y : Int64) : Int64;
asm
 push ebx // Save EBX as per calling convention.
 push esi // Save ESI as per calling convention.
 push edi // Save EDI as per calling convention.
 mov ecx, [edx+4]   // divisor_hi
 mov ebx, [edx] // divisor_lo
 mov edx, [eax+4]   // dividend_hi
 mov eax, [eax] // dividend_lo
 mov esi, ecx // divisor_hi
 xor esi, edx // divisor_hi ^ dividend_hi
 sar esi, 31 // (quotient < 0) ? -1 : 0
 mov edi, edx // dividend_hi
 sar edi, 31 // (dividend < 0) ? -1 : 0
 xor eax, edi // If (dividend < 0),
 xor edx, edi // compute 1's complement of dividend.
 sub eax, edi // If (dividend < 0),
 sbb edx, edi // compute 2's complement of dividend.
 mov edi, ecx // divisor_hi
 sar edi, 31 // (divisor < 0) ? -1 : 0
 xor ebx, edi // If (divisor < 0),
 xor ecx, edi // compute 1's complement of divisor.
 sub ebx, edi // If (divisor < 0),
 sbb ecx, edi // compute 2's complement of divisor.
 jnz @big_divisor // divisor > 2^32 - 1
 cmp edx, ebx // Only one division needed (ECX = 0)?
 jae @two_divs // Need two divisions.
 div ebx // EAX = quotient_lo
 mov edx, ecx // EDX = quotient_hi = 0 (quotient in EDX:EAX)
 xor eax, esi // If (quotient < 0),
 xor edx, esi // compute 1's complement of result.
 sub eax, esi // If (quotient < 0),
 sbb edx, esi // compute 2's complement of result.
 pop edi // Restore EDI as per calling convention.
 pop esi // Restore ESI as per calling convention.
 pop ebx // Restore EBX as per calling convention.
 ret // Done, return to caller.
@two_divs:
 mov ecx, eax // Save dividend_lo in ECX.
 mov eax, edx // Get dividend_hi.
 xor edx, edx // Zero-extend it into EDX:EAX.
 div ebx // quotient_hi in EAX
 xchg eax, ecx // ECX = quotient_hi, EAX = dividend_lo
 div ebx // EAX = quotient_lo
 mov edx, ecx // EDX = quotient_hi (quotient in EDX:EAX)
 jmp @make_sign // Make quotient signed.
@big_divisor:
 sub esp, 12 // Create three local variables.
 mov [esp], eax // dividend_lo
 mov [esp+4], ebx // divisor_lo
 mov [esp+8], edx // dividend_hi
 mov edi, ecx // Save divisor_hi.
 shr edx, 1 // Shift both
 rcr eax, 1 // divisor and
 ror edi, 1 // and dividend
 rcr ebx, 1 // right by 1 bit.
 bsr ecx, ecx // ECX = number of remaining shifts
 shrd ebx, edi, cl // Scale down divisor and
 shrd eax, edx, cl // dividend such that divisor is
 shr edx, cl // less than 2^32 (that is, fits in EBX).
 rol edi, 1 // Restore original divisor_hi.
 div ebx // Compute quotient.
 mov ebx, [esp] // dividend_lo
 mov ecx, eax // Save quotient.
 imul edi, eax // quotient * divisor high word (low only)
 mul DWORD PTR [esp+4] // quotient * divisor low word
 add edx, edi // EDX:EAX = quotient * divisor
 sub ebx, eax // dividend_lo - (quot.*divisor)_lo
 mov eax, ecx // Get quotient.
 mov ecx, [esp+8] // dividend_hi
 sbb ecx, edx // Subtract (divisor * quot.) from dividend
 sbb eax, 0 // Adjust quotient if remainder is negative.
 xor edx, edx // Clear high word of quotient.
 add esp, 12 // Remove local variables.
@make_sign:
 xor eax, esi // If (quotient < 0),
 xor edx, esi // compute 1's complement of result.
 sub eax, esi // If (quotient < 0),
 sbb edx, esi // compute 2's complement of result.
 pop edi // Restore EDI as per calling convention.
 pop esi // Restore ESI as per calling convention.
 pop ebx // Restore EBX as per calling convention.
end;


function Int64Div_AMD_IA32_1_b(var X, Y : Int64) : Int64;
asm
 push ebx // Save EBX as per calling convention.
 push esi // Save ESI as per calling convention.
 push edi // Save EDI as per calling convention.
 mov ecx, [edx+4]   // divisor_hi
 mov ebx, [edx] // divisor_lo
 mov edx, [eax+4]   // dividend_hi
 mov eax, [eax] // dividend_lo
 mov esi, ecx // divisor_hi
 xor esi, edx // divisor_hi ^ dividend_hi
 sar esi, 31 // (quotient < 0) ? -1 : 0
 mov edi, edx // dividend_hi
 sar edi, 31 // (dividend < 0) ? -1 : 0
 xor eax, edi // If (dividend < 0),
 xor edx, edi // compute 1's complement of dividend.
 sub eax, edi // If (dividend < 0),
 sbb edx, edi // compute 2's complement of dividend.
 mov edi, ecx // divisor_hi
 sar edi, 31 // (divisor < 0) ? -1 : 0
 xor ebx, edi // If (divisor < 0),
 xor ecx, edi // compute 1's complement of divisor.
 sub ebx, edi // If (divisor < 0),
 sbb ecx, edi // compute 2's complement of divisor.
 jnz @big_divisor // divisor > 2^32 - 1
 cmp edx, ebx // Only one division needed (ECX = 0)?
 jae @two_divs // Need two divisions.
 div ebx // EAX = quotient_lo
 mov edx, ecx // EDX = quotient_hi = 0 (quotient in EDX:EAX)
 xor eax, esi // If (quotient < 0),
 xor edx, esi // compute 1's complement of result.
 sub eax, esi // If (quotient < 0),
 sbb edx, esi // compute 2's complement of result.
 pop edi // Restore EDI as per calling convention.
 pop esi // Restore ESI as per calling convention.
 pop ebx // Restore EBX as per calling convention.
 ret // Done, return to caller.
@two_divs:
 mov ecx, eax // Save dividend_lo in ECX.
 mov eax, edx // Get dividend_hi.
 xor edx, edx // Zero-extend it into EDX:EAX.
 div ebx // quotient_hi in EAX
 xchg eax, ecx // ECX = quotient_hi, EAX = dividend_lo
 div ebx // EAX = quotient_lo
 mov edx, ecx // EDX = quotient_hi (quotient in EDX:EAX)
 jmp @make_sign // Make quotient signed.
@big_divisor:
 sub esp, 12 // Create three local variables.
 mov [esp], eax // dividend_lo
 mov [esp+4], ebx // divisor_lo
 mov [esp+8], edx // dividend_hi
 mov edi, ecx // Save divisor_hi.
 shr edx, 1 // Shift both
 rcr eax, 1 // divisor and
 ror edi, 1 // and dividend
 rcr ebx, 1 // right by 1 bit.
 bsr ecx, ecx // ECX = number of remaining shifts
 shrd ebx, edi, cl // Scale down divisor and
 shrd eax, edx, cl // dividend such that divisor is
 shr edx, cl // less than 2^32 (that is, fits in EBX).
 rol edi, 1 // Restore original divisor_hi.
 div ebx // Compute quotient.
 mov ebx, [esp] // dividend_lo
 mov ecx, eax // Save quotient.
 imul edi, eax // quotient * divisor high word (low only)
 mul DWORD PTR [esp+4] // quotient * divisor low word
 add edx, edi // EDX:EAX = quotient * divisor
 sub ebx, eax // dividend_lo - (quot.*divisor)_lo
 mov eax, ecx // Get quotient.
 mov ecx, [esp+8] // dividend_hi
 sbb ecx, edx // Subtract (divisor * quot.) from dividend
 sbb eax, 0 // Adjust quotient if remainder is negative.
 xor edx, edx // Clear high word of quotient.
 add esp, 12 // Remove local variables.
@make_sign:
 xor eax, esi // If (quotient < 0),
 xor edx, esi // compute 1's complement of result.
 sub eax, esi // If (quotient < 0),
 sbb edx, esi // compute 2's complement of result.
 pop edi // Restore EDI as per calling convention.
 pop esi // Restore ESI as per calling convention.
 pop ebx // Restore EBX as per calling convention.
end;

procedure Filler1;
asm
 nop
end;


function Int64Div_AMD_IA32_1_c(var X, Y : Int64) : Int64;
asm
 push ebx // Save EBX as per calling convention.
 push esi // Save ESI as per calling convention.
 push edi // Save EDI as per calling convention.
 mov ecx, [edx+4]   // divisor_hi
 mov ebx, [edx] // divisor_lo
 mov edx, [eax+4]   // dividend_hi
 mov eax, [eax] // dividend_lo
 mov esi, ecx // divisor_hi
 xor esi, edx // divisor_hi ^ dividend_hi
 sar esi, 31 // (quotient < 0) ? -1 : 0
 mov edi, edx // dividend_hi
 sar edi, 31 // (dividend < 0) ? -1 : 0
 xor eax, edi // If (dividend < 0),
 xor edx, edi // compute 1's complement of dividend.
 sub eax, edi // If (dividend < 0),
 sbb edx, edi // compute 2's complement of dividend.
 mov edi, ecx // divisor_hi
 sar edi, 31 // (divisor < 0) ? -1 : 0
 xor ebx, edi // If (divisor < 0),
 xor ecx, edi // compute 1's complement of divisor.
 sub ebx, edi // If (divisor < 0),
 sbb ecx, edi // compute 2's complement of divisor.
 jnz @big_divisor // divisor > 2^32 - 1
 cmp edx, ebx // Only one division needed (ECX = 0)?
 jae @two_divs // Need two divisions.
 div ebx // EAX = quotient_lo
 mov edx, ecx // EDX = quotient_hi = 0 (quotient in EDX:EAX)
 xor eax, esi // If (quotient < 0),
 xor edx, esi // compute 1's complement of result.
 sub eax, esi // If (quotient < 0),
 sbb edx, esi // compute 2's complement of result.
 pop edi // Restore EDI as per calling convention.
 pop esi // Restore ESI as per calling convention.
 pop ebx // Restore EBX as per calling convention.
 ret // Done, return to caller.
@two_divs:
 mov ecx, eax // Save dividend_lo in ECX.
 mov eax, edx // Get dividend_hi.
 xor edx, edx // Zero-extend it into EDX:EAX.
 div ebx // quotient_hi in EAX
 xchg eax, ecx // ECX = quotient_hi, EAX = dividend_lo
 div ebx // EAX = quotient_lo
 mov edx, ecx // EDX = quotient_hi (quotient in EDX:EAX)
 jmp @make_sign // Make quotient signed.
@big_divisor:
 sub esp, 12 // Create three local variables.
 mov [esp], eax // dividend_lo
 mov [esp+4], ebx // divisor_lo
 mov [esp+8], edx // dividend_hi
 mov edi, ecx // Save divisor_hi.
 shr edx, 1 // Shift both
 rcr eax, 1 // divisor and
 ror edi, 1 // and dividend
 rcr ebx, 1 // right by 1 bit.
 bsr ecx, ecx // ECX = number of remaining shifts
 shrd ebx, edi, cl // Scale down divisor and
 shrd eax, edx, cl // dividend such that divisor is
 shr edx, cl // less than 2^32 (that is, fits in EBX).
 rol edi, 1 // Restore original divisor_hi.
 div ebx // Compute quotient.
 mov ebx, [esp] // dividend_lo
 mov ecx, eax // Save quotient.
 imul edi, eax // quotient * divisor high word (low only)
 mul DWORD PTR [esp+4] // quotient * divisor low word
 add edx, edi // EDX:EAX = quotient * divisor
 sub ebx, eax // dividend_lo - (quot.*divisor)_lo
 mov eax, ecx // Get quotient.
 mov ecx, [esp+8] // dividend_hi
 sbb ecx, edx // Subtract (divisor * quot.) from dividend
 sbb eax, 0 // Adjust quotient if remainder is negative.
 xor edx, edx // Clear high word of quotient.
 add esp, 12 // Remove local variables.
@make_sign:
 xor eax, esi // If (quotient < 0),
 xor edx, esi // compute 1's complement of result.
 sub eax, esi // If (quotient < 0),
 sbb edx, esi // compute 2's complement of result.
 pop edi // Restore EDI as per calling convention.
 pop esi // Restore ESI as per calling convention.
 pop ebx // Restore EBX as per calling convention.
end;


function Int64Div_AMD_IA32_1_d(var X, Y : Int64) : Int64;
asm
 push ebx // Save EBX as per calling convention.
 push esi // Save ESI as per calling convention.
 push edi // Save EDI as per calling convention.
 mov ecx, [edx+4]   // divisor_hi
 mov ebx, [edx] // divisor_lo
 mov edx, [eax+4]   // dividend_hi
 mov eax, [eax] // dividend_lo
 mov esi, ecx // divisor_hi
 xor esi, edx // divisor_hi ^ dividend_hi
 sar esi, 31 // (quotient < 0) ? -1 : 0
 mov edi, edx // dividend_hi
 sar edi, 31 // (dividend < 0) ? -1 : 0
 xor eax, edi // If (dividend < 0),
 xor edx, edi // compute 1's complement of dividend.
 sub eax, edi // If (dividend < 0),
 sbb edx, edi // compute 2's complement of dividend.
 mov edi, ecx // divisor_hi
 sar edi, 31 // (divisor < 0) ? -1 : 0
 xor ebx, edi // If (divisor < 0),
 xor ecx, edi // compute 1's complement of divisor.
 sub ebx, edi // If (divisor < 0),
 sbb ecx, edi // compute 2's complement of divisor.
 jnz @big_divisor // divisor > 2^32 - 1
 cmp edx, ebx // Only one division needed (ECX = 0)?
 jae @two_divs // Need two divisions.
 div ebx // EAX = quotient_lo
 mov edx, ecx // EDX = quotient_hi = 0 (quotient in EDX:EAX)
 xor eax, esi // If (quotient < 0),
 xor edx, esi // compute 1's complement of result.
 sub eax, esi // If (quotient < 0),
 sbb edx, esi // compute 2's complement of result.
 pop edi // Restore EDI as per calling convention.
 pop esi // Restore ESI as per calling convention.
 pop ebx // Restore EBX as per calling convention.
 ret // Done, return to caller.
@two_divs:
 mov ecx, eax // Save dividend_lo in ECX.
 mov eax, edx // Get dividend_hi.
 xor edx, edx // Zero-extend it into EDX:EAX.
 div ebx // quotient_hi in EAX
 xchg eax, ecx // ECX = quotient_hi, EAX = dividend_lo
 div ebx // EAX = quotient_lo
 mov edx, ecx // EDX = quotient_hi (quotient in EDX:EAX)
 jmp @make_sign // Make quotient signed.
@big_divisor:
 sub esp, 12 // Create three local variables.
 mov [esp], eax // dividend_lo
 mov [esp+4], ebx // divisor_lo
 mov [esp+8], edx // dividend_hi
 mov edi, ecx // Save divisor_hi.
 shr edx, 1 // Shift both
 rcr eax, 1 // divisor and
 ror edi, 1 // and dividend
 rcr ebx, 1 // right by 1 bit.
 bsr ecx, ecx // ECX = number of remaining shifts
 shrd ebx, edi, cl // Scale down divisor and
 shrd eax, edx, cl // dividend such that divisor is
 shr edx, cl // less than 2^32 (that is, fits in EBX).
 rol edi, 1 // Restore original divisor_hi.
 div ebx // Compute quotient.
 mov ebx, [esp] // dividend_lo
 mov ecx, eax // Save quotient.
 imul edi, eax // quotient * divisor high word (low only)
 mul DWORD PTR [esp+4] // quotient * divisor low word
 add edx, edi // EDX:EAX = quotient * divisor
 sub ebx, eax // dividend_lo - (quot.*divisor)_lo
 mov eax, ecx // Get quotient.
 mov ecx, [esp+8] // dividend_hi
 sbb ecx, edx // Subtract (divisor * quot.) from dividend
 sbb eax, 0 // Adjust quotient if remainder is negative.
 xor edx, edx // Clear high word of quotient.
 add esp, 12 // Remove local variables.
@make_sign:
 xor eax, esi // If (quotient < 0),
 xor edx, esi // compute 1's complement of result.
 sub eax, esi // If (quotient < 0),
 sbb edx, esi // compute 2's complement of result.
 pop edi // Restore EDI as per calling convention.
 pop esi // Restore ESI as per calling convention.
 pop ebx // Restore EBX as per calling convention.
end;

initialization

 Filler1;

end.
