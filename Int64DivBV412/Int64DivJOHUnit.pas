unit Int64DivJOHUnit;

interface

function Int64Div_JOH_IA32_1_a(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_1_b(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_1_c(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_1_d(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_2_a(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_2_b(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_2_c(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_2_d(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_3_a(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_3_b(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_3_c(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_3_d(var X, Y : Int64) : Int64;
function Int64Div_JOH_PAS(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_4_a(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_4_b(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_4_c(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_4_d(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_5_a(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_5_b(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_5_c(var X, Y : Int64) : Int64;
function Int64Div_JOH_IA32_5_d(var X, Y : Int64) : Int64;

implementation

function Int64Div_JOH_IA32_1_a(var X, Y : Int64) : Int64;
asm
  push    ebx
  push    esi
  push    edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]      //ECX:EBX = Y
  mov     edx, [eax+4]
  mov     eax, [eax]        //EDX:EAX = X

  mov     esi, edx
  mov     edi, ecx

  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi          // EDX:EAX := abs(X)

  sar     edi, 31
  xor     esi, edi          // 0 if X and Y have same sign
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi          // ECX:EBX := abs(Y)

  jnz     @@BigDivisor      // divisor > 32^32-1
  cmp     edx, ebx          // only one division needed ? (ecx = 0)
  jb      @@OneDiv          // yes, one division sufficient
  mov     ecx, eax          // save dividend-lo in ecx
  mov     eax, edx          // get dividend-hi
  xor     edx, edx          // zero extend it into edx:eax
  div     ebx               // quotient-hi in eax
  xchg    eax, ecx          // ecx = quotient-hi, eax =dividend-lo
@@OneDiv:
  div     ebx               // eax = quotient-lo
  mov     edx, ecx          // edx = quotient-hi(quotient in edx:eax)
  jmp     @SetSign
@@BigDivisor:
  cmp     edx, ecx
  jae     @BigDiv
@Zero:
  xor     eax, eax
  xor     edx, edx
  jmp     @Done
@BigDiv:
  sub     esp, 12           // Create three local variables.
  mov     [esp  ], eax      // dividend_lo
  mov     [esp+4], ebx      // divisor_lo
  mov     [esp+8], edx      // dividend_hi
  mov     edi, ecx          //  edi:ebx and ecx:esi
  shr     edx, 1            // shift both
  rcr     eax, 1            //  divisor and
  ror     edi, 1            //   and dividend
  rcr     ebx, 1            //    right by 1 bit
  bsr     ecx, ecx          // ecx = number of remaining shifts
  shrd    ebx, edi, cl      // scale down divisor and
  shrd    eax, edx, cl      //   dividend such that divisor
  shr     edx, cl           //    less than 2^32 (i.e. fits in ebx)
  rol     edi, 1            // restore original divisor (edi:esi)
  div     ebx               // compute quotient
  mov     ebx, [esp]        // dividend_lo
  mov     ecx, eax          // save quotient
  imul    edi, eax          // quotient * divisor hi-word (low only)
  mul     DWORD PTR [esp+4] // quotient * divisor low word
  add     edx, edi          // edx:eax = quotient * divisor
  sub     ebx, eax          // dividend-lo - (quot.*divisor)-lo
  mov     eax, ecx          // get quotient
  mov     ecx, [esp+8]      // dividend_hi
  sbb     ecx, edx          // subtract divisor * quot. from dividend
  sbb     eax, 0            // Adjust quotient if remainder is negative.
  xor     edx, edx          // clear hi-word of quot (eax<=FFFFFFFFh)
  add     esp, 12           // Remove local variables.
@SetSign:
  xor     eax, esi          // If (quotient < 0),
  xor     edx, esi          //   compute 1's complement of result.
  sub     eax, esi          // If (quotient < 0),
  sbb     edx, esi          //   compute 2's complement of result.
@Done:
  pop     edi
  pop     esi
  pop     ebx
end;

function Int64Div_JOH_IA32_1_b(var X, Y : Int64) : Int64;
asm
  push    ebx
  push    esi
  push    edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]      //ECX:EBX = Y
  mov     edx, [eax+4]
  mov     eax, [eax]        //EDX:EAX = X

  mov     esi, edx
  mov     edi, ecx

  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi          // EDX:EAX := abs(X)

  sar     edi, 31
  xor     esi, edi          // 0 if X and Y have same sign
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi          // ECX:EBX := abs(Y)

  jnz     @@BigDivisor      // divisor > 32^32-1
  cmp     edx, ebx          // only one division needed ? (ecx = 0)
  jb      @@OneDiv          // yes, one division sufficient
  mov     ecx, eax          // save dividend-lo in ecx
  mov     eax, edx          // get dividend-hi
  xor     edx, edx          // zero extend it into edx:eax
  div     ebx               // quotient-hi in eax
  xchg    eax, ecx          // ecx = quotient-hi, eax =dividend-lo
@@OneDiv:
  div     ebx               // eax = quotient-lo
  mov     edx, ecx          // edx = quotient-hi(quotient in edx:eax)
  jmp     @SetSign
@@BigDivisor:
  cmp     edx, ecx
  jae     @BigDiv
@Zero:
  xor     eax, eax
  xor     edx, edx
  jmp     @Done
@BigDiv:
  sub     esp, 12           // Create three local variables.
  mov     [esp  ], eax      // dividend_lo
  mov     [esp+4], ebx      // divisor_lo
  mov     [esp+8], edx      // dividend_hi
  mov     edi, ecx          //  edi:ebx and ecx:esi
  shr     edx, 1            // shift both
  rcr     eax, 1            //  divisor and
  ror     edi, 1            //   and dividend
  rcr     ebx, 1            //    right by 1 bit
  bsr     ecx, ecx          // ecx = number of remaining shifts
  shrd    ebx, edi, cl      // scale down divisor and
  shrd    eax, edx, cl      //   dividend such that divisor
  shr     edx, cl           //    less than 2^32 (i.e. fits in ebx)
  rol     edi, 1            // restore original divisor (edi:esi)
  div     ebx               // compute quotient
  mov     ebx, [esp]        // dividend_lo
  mov     ecx, eax          // save quotient
  imul    edi, eax          // quotient * divisor hi-word (low only)
  mul     DWORD PTR [esp+4] // quotient * divisor low word
  add     edx, edi          // edx:eax = quotient * divisor
  sub     ebx, eax          // dividend-lo - (quot.*divisor)-lo
  mov     eax, ecx          // get quotient
  mov     ecx, [esp+8]      // dividend_hi
  sbb     ecx, edx          // subtract divisor * quot. from dividend
  sbb     eax, 0            // Adjust quotient if remainder is negative.
  xor     edx, edx          // clear hi-word of quot (eax<=FFFFFFFFh)
  add     esp, 12           // Remove local variables.
@SetSign:
  xor     eax, esi          // If (quotient < 0),
  xor     edx, esi          //   compute 1's complement of result.
  sub     eax, esi          // If (quotient < 0),
  sbb     edx, esi          //   compute 2's complement of result.
@Done:
  pop     edi
  pop     esi
  pop     ebx
end;

function Int64Div_JOH_IA32_1_c(var X, Y : Int64) : Int64;
asm
  push    ebx
  push    esi
  push    edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]      //ECX:EBX = Y
  mov     edx, [eax+4]
  mov     eax, [eax]        //EDX:EAX = X

  mov     esi, edx
  mov     edi, ecx

  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi          // EDX:EAX := abs(X)

  sar     edi, 31
  xor     esi, edi          // 0 if X and Y have same sign
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi          // ECX:EBX := abs(Y)

  jnz     @@BigDivisor      // divisor > 32^32-1
  cmp     edx, ebx          // only one division needed ? (ecx = 0)
  jb      @@OneDiv          // yes, one division sufficient
  mov     ecx, eax          // save dividend-lo in ecx
  mov     eax, edx          // get dividend-hi
  xor     edx, edx          // zero extend it into edx:eax
  div     ebx               // quotient-hi in eax
  xchg    eax, ecx          // ecx = quotient-hi, eax =dividend-lo
@@OneDiv:
  div     ebx               // eax = quotient-lo
  mov     edx, ecx          // edx = quotient-hi(quotient in edx:eax)
  jmp     @SetSign
@@BigDivisor:
  cmp     edx, ecx
  jae     @BigDiv
@Zero:
  xor     eax, eax
  xor     edx, edx
  jmp     @Done
@BigDiv:
  sub     esp, 12           // Create three local variables.
  mov     [esp  ], eax      // dividend_lo
  mov     [esp+4], ebx      // divisor_lo
  mov     [esp+8], edx      // dividend_hi
  mov     edi, ecx          //  edi:ebx and ecx:esi
  shr     edx, 1            // shift both
  rcr     eax, 1            //  divisor and
  ror     edi, 1            //   and dividend
  rcr     ebx, 1            //    right by 1 bit
  bsr     ecx, ecx          // ecx = number of remaining shifts
  shrd    ebx, edi, cl      // scale down divisor and
  shrd    eax, edx, cl      //   dividend such that divisor
  shr     edx, cl           //    less than 2^32 (i.e. fits in ebx)
  rol     edi, 1            // restore original divisor (edi:esi)
  div     ebx               // compute quotient
  mov     ebx, [esp]        // dividend_lo
  mov     ecx, eax          // save quotient
  imul    edi, eax          // quotient * divisor hi-word (low only)
  mul     DWORD PTR [esp+4] // quotient * divisor low word
  add     edx, edi          // edx:eax = quotient * divisor
  sub     ebx, eax          // dividend-lo - (quot.*divisor)-lo
  mov     eax, ecx          // get quotient
  mov     ecx, [esp+8]      // dividend_hi
  sbb     ecx, edx          // subtract divisor * quot. from dividend
  sbb     eax, 0            // Adjust quotient if remainder is negative.
  xor     edx, edx          // clear hi-word of quot (eax<=FFFFFFFFh)
  add     esp, 12           // Remove local variables.
@SetSign:
  xor     eax, esi          // If (quotient < 0),
  xor     edx, esi          //   compute 1's complement of result.
  sub     eax, esi          // If (quotient < 0),
  sbb     edx, esi          //   compute 2's complement of result.
@Done:
  pop     edi
  pop     esi
  pop     ebx
end;

function Int64Div_JOH_IA32_1_d(var X, Y : Int64) : Int64;
asm
  push    ebx
  push    esi
  push    edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]      //ECX:EBX = Y
  mov     edx, [eax+4]
  mov     eax, [eax]        //EDX:EAX = X

  mov     esi, edx
  mov     edi, ecx

  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi          // EDX:EAX := abs(X)

  sar     edi, 31
  xor     esi, edi          // 0 if X and Y have same sign
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi          // ECX:EBX := abs(Y)

  jnz     @@BigDivisor      // divisor > 32^32-1
  cmp     edx, ebx          // only one division needed ? (ecx = 0)
  jb      @@OneDiv          // yes, one division sufficient
  mov     ecx, eax          // save dividend-lo in ecx
  mov     eax, edx          // get dividend-hi
  xor     edx, edx          // zero extend it into edx:eax
  div     ebx               // quotient-hi in eax
  xchg    eax, ecx          // ecx = quotient-hi, eax =dividend-lo
@@OneDiv:
  div     ebx               // eax = quotient-lo
  mov     edx, ecx          // edx = quotient-hi(quotient in edx:eax)
  jmp     @SetSign
@@BigDivisor:
  cmp     edx, ecx
  jae     @BigDiv
@Zero:
  xor     eax, eax
  xor     edx, edx
  jmp     @Done
@BigDiv:
  sub     esp, 12           // Create three local variables.
  mov     [esp  ], eax      // dividend_lo
  mov     [esp+4], ebx      // divisor_lo
  mov     [esp+8], edx      // dividend_hi
  mov     edi, ecx          //  edi:ebx and ecx:esi
  shr     edx, 1            // shift both
  rcr     eax, 1            //  divisor and
  ror     edi, 1            //   and dividend
  rcr     ebx, 1            //    right by 1 bit
  bsr     ecx, ecx          // ecx = number of remaining shifts
  shrd    ebx, edi, cl      // scale down divisor and
  shrd    eax, edx, cl      //   dividend such that divisor
  shr     edx, cl           //    less than 2^32 (i.e. fits in ebx)
  rol     edi, 1            // restore original divisor (edi:esi)
  div     ebx               // compute quotient
  mov     ebx, [esp]        // dividend_lo
  mov     ecx, eax          // save quotient
  imul    edi, eax          // quotient * divisor hi-word (low only)
  mul     DWORD PTR [esp+4] // quotient * divisor low word
  add     edx, edi          // edx:eax = quotient * divisor
  sub     ebx, eax          // dividend-lo - (quot.*divisor)-lo
  mov     eax, ecx          // get quotient
  mov     ecx, [esp+8]      // dividend_hi
  sbb     ecx, edx          // subtract divisor * quot. from dividend
  sbb     eax, 0            // Adjust quotient if remainder is negative.
  xor     edx, edx          // clear hi-word of quot (eax<=FFFFFFFFh)
  add     esp, 12           // Remove local variables.
@SetSign:
  xor     eax, esi          // If (quotient < 0),
  xor     edx, esi          //   compute 1's complement of result.
  sub     eax, esi          // If (quotient < 0),
  sbb     edx, esi          //   compute 2's complement of result.
@Done:
  pop     edi
  pop     esi
  pop     ebx
end;

function Int64Div_JOH_IA32_2_a(var X, Y : Int64) : Int64;
asm
  sub    esp, 12           {Allocate Stack Frame}
  fild   qword ptr [eax]   {Load X}
  fild   qword ptr [edx]   {Load Y}
  fnstcw [esp]             {Save Existing Control Word}
  movzx  eax, [esp]        {Load Control Word into EAX}
  or     eax, $00000F00    {Set Extended Precision Truncate}
  mov    [esp+4], eax      {Save New Control Word}
  fldcw  [esp+4]           {Set New Control Word}
  fdivp
  fistp  qword ptr [esp+4] {Save Result within Stack Space}
  fldcw  [esp]             {Restore Original Control Word}
  mov    eax, [esp+4]      {Set Result}
  mov    edx, [esp+8]
  add    esp, 12
end;

procedure Filler1;
asm
 nop
end;


function Int64Div_JOH_IA32_2_b(var X, Y : Int64) : Int64;
asm
  sub    esp, 12           {Allocate Stack Frame}
  fild   qword ptr [eax]   {Load X}
  fild   qword ptr [edx]   {Load Y}
  fnstcw [esp]             {Save Existing Control Word}
  movzx  eax, [esp]        {Load Control Word into EAX}
  or     eax, $00000F00    {Set Extended Precision Truncate}
  mov    [esp+4], eax      {Save New Control Word}
  fldcw  [esp+4]           {Set New Control Word}
  fdivp
  fistp  qword ptr [esp+4] {Save Result within Stack Space}
  fldcw  [esp]             {Restore Original Control Word}
  mov    eax, [esp+4]      {Set Result}
  mov    edx, [esp+8]
  add    esp, 12
end;

procedure Filler2;
asm
 nop
end;

function Int64Div_JOH_IA32_2_c(var X, Y : Int64) : Int64;
asm
  sub    esp, 12           {Allocate Stack Frame}
  fild   qword ptr [eax]   {Load X}
  fild   qword ptr [edx]   {Load Y}
  fnstcw [esp]             {Save Existing Control Word}
  movzx  eax, [esp]        {Load Control Word into EAX}
  or     eax, $00000F00    {Set Extended Precision Truncate}
  mov    [esp+4], eax      {Save New Control Word}
  fldcw  [esp+4]           {Set New Control Word}
  fdivp
  fistp  qword ptr [esp+4] {Save Result within Stack Space}
  fldcw  [esp]             {Restore Original Control Word}
  mov    eax, [esp+4]      {Set Result}
  mov    edx, [esp+8]
  add    esp, 12
end;

procedure Filler3;
asm
 nop
end;


function Int64Div_JOH_IA32_2_d(var X, Y : Int64) : Int64;
asm
  sub    esp, 12           {Allocate Stack Frame}
  fild   qword ptr [eax]   {Load X}
  fild   qword ptr [edx]   {Load Y}
  fnstcw [esp]             {Save Existing Control Word}
  movzx  eax, [esp]        {Load Control Word into EAX}
  or     eax, $00000F00    {Set Extended Precision Truncate}
  mov    [esp+4], eax      {Save New Control Word}
  fldcw  [esp+4]           {Set New Control Word}
  fdivp
  fistp  qword ptr [esp+4] {Save Result within Stack Space}
  fldcw  [esp]             {Restore Original Control Word}
  mov    eax, [esp+4]      {Set Result}
  mov    edx, [esp+8]
  add    esp, 12
end;

function Int64Div_JOH_PAS(var X, Y : Int64) : Int64;
type
  iRec = packed record
    Lo, Hi : LongWord;
  end;
var
  I, J : LongWord;
begin
  I := iRec(X).Hi and $80000000; {if X >= 0 then I := 0}
  J := iRec(Y).Hi and $80000000; {if Y >= 0 then J := 0}
  if I xor J = 0 then
    begin {Same Sign}
      if I = 0 then
        begin {Both Positive}
          if X >= Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {Both Negative}
          if X <= Y then
            Result := X div Y
          else
            Result := 0
        end;
    end
  else
    begin {Different Sign}
      if I = 0 then
        begin {X = +ve, Y = -ve}
          if X >= -Y then
            Result := X div Y
          else
            Result := 0
        end
      else
        begin {X = -ve, Y = +ve}
          if X <= -Y then
            Result := X div Y
          else
            Result := 0
        end;
    end;
end;

function Int64Div_JOH_IA32_3_a(var X, Y : Int64) : Int64;
asm
  fild    qword ptr [eax]   {Load X}
  fild    qword ptr [edx]   {Load Y}
  fld     st(1)
  fabs
  fld     st(1)
  fabs
  fucomip st, st(1)
  fstp    st(0)
  jbe     @DoDiv
  fstp    st(0)            {|X| < |Y|}
  fstp    st(0)
  xor     eax, eax
  xor     edx, edx
  ret
@DoDiv:
  sub     esp, 12           {Allocate Stack Frame}
  fnstcw  [esp]             {Save Existing Control Word}
  movzx   eax, [esp]        {Load Control Word into EAX}
  or      eax, $00000F00    {Set Extended Precision Truncate}
  mov     [esp+4], eax      {Save New Control Word}
  fldcw   [esp+4]           {Set New Control Word}
  fdivp
  fistp   qword ptr [esp+4] {Save Result within Stack Space}
  fldcw   [esp]             {Restore Original Control Word}
  mov     eax, [esp+4]      {Set Result}
  mov     edx, [esp+8]
  add     esp, 12
end;

function Int64Div_JOH_IA32_3_b(var X, Y : Int64) : Int64;
asm
  fild    qword ptr [eax]   {Load X}
  fild    qword ptr [edx]   {Load Y}
  fld     st(1)
  fabs
  fld     st(1)
  fabs
  fucomip st, st(1)
  fstp    st(0)
  jbe     @DoDiv
  fstp    st(0)            {|X| < |Y|}
  fstp    st(0)
  xor     eax, eax
  xor     edx, edx
  ret
@DoDiv:
  sub     esp, 12           {Allocate Stack Frame}
  fnstcw  [esp]             {Save Existing Control Word}
  movzx   eax, [esp]        {Load Control Word into EAX}
  or      eax, $00000F00    {Set Extended Precision Truncate}
  mov     [esp+4], eax      {Save New Control Word}
  fldcw   [esp+4]           {Set New Control Word}
  fdivp
  fistp   qword ptr [esp+4] {Save Result within Stack Space}
  fldcw   [esp]             {Restore Original Control Word}
  mov     eax, [esp+4]      {Set Result}
  mov     edx, [esp+8]
  add     esp, 12
end;

procedure Filler7;
asm
 nop
end;

function Int64Div_JOH_IA32_3_c(var X, Y : Int64) : Int64;
asm
  fild    qword ptr [eax]   {Load X}
  fild    qword ptr [edx]   {Load Y}
  fld     st(1)
  fabs
  fld     st(1)
  fabs
  fucomip st, st(1)
  fstp    st(0)
  jbe     @DoDiv
  fstp    st(0)            {|X| < |Y|}
  fstp    st(0)
  xor     eax, eax
  xor     edx, edx
  ret
@DoDiv:
  sub     esp, 12           {Allocate Stack Frame}
  fnstcw  [esp]             {Save Existing Control Word}
  movzx   eax, [esp]        {Load Control Word into EAX}
  or      eax, $00000F00    {Set Extended Precision Truncate}
  mov     [esp+4], eax      {Save New Control Word}
  fldcw   [esp+4]           {Set New Control Word}
  fdivp
  fistp   qword ptr [esp+4] {Save Result within Stack Space}
  fldcw   [esp]             {Restore Original Control Word}
  mov     eax, [esp+4]      {Set Result}
  mov     edx, [esp+8]
  add     esp, 12
end;

function Int64Div_JOH_IA32_3_d(var X, Y : Int64) : Int64;
asm
  fild    qword ptr [eax]   {Load X}
  fild    qword ptr [edx]   {Load Y}
  fld     st(1)
  fabs
  fld     st(1)
  fabs
  fucomip st, st(1)
  fstp    st(0)
  jbe     @DoDiv
  fstp    st(0)            {|X| < |Y|}
  fstp    st(0)
  xor     eax, eax
  xor     edx, edx
  ret
@DoDiv:
  sub     esp, 12           {Allocate Stack Frame}
  fnstcw  [esp]             {Save Existing Control Word}
  movzx   eax, [esp]        {Load Control Word into EAX}
  or      eax, $00000F00    {Set Extended Precision Truncate}
  mov     [esp+4], eax      {Save New Control Word}
  fldcw   [esp+4]           {Set New Control Word}
  fdivp
  fistp   qword ptr [esp+4] {Save Result within Stack Space}
  fldcw   [esp]             {Restore Original Control Word}
  mov     eax, [esp+4]      {Set Result}
  mov     edx, [esp+8]
  add     esp, 12
end;



//Fastcode wrapper around proposed highlander __lldiv replacement
function Int64Div_JOH_IA32_4_a(var X, Y : Int64) : Int64;
asm
  sub     esp, 24            {allocate local storage}
  mov     [esp], ebx         {save used registers}
  mov     [esp+4], esi
  mov     [esp+8], edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]       {ecx:ebx = Y (Divisor)}
  mov     edx, [eax+4]
  mov     eax, [eax]         {edx:eax = X (Dividend)}
  mov     esi, edx
  mov     edi, ecx
  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi           {edx:eax = abs(X)}
  sar     edi, 31
  xor     esi, edi           {esi = 0 if X and Y have same sign, else -1}
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi           {ecx:ebx = abs(Y)}
  jnz     @@BigDivisor       {jump if divisor >= 232}
  cmp     edx, ebx           {dividend-hi < divisor-hi?}
  jb      @@OneDiv           {yes, only one division needed}
  mov     ecx, eax           {ecx = dividend-lo}
  mov     eax, edx           {eax = dividend-hi}
  xor     edx, edx           {zero extend it into edx:eax}
  div     ebx                {eax = quotient-hi}
  xchg    eax, ecx           {eax = dividend-lo, ecx = quotient-hi}
@@OneDiv:
  div     ebx                {eax = quotient-lo}
  mov     edx, ecx           {edx = quotient-hi}
  jmp     @SetSign           {quotient in edx:eax}
@@BigDivisor:
  cmp     edx, ecx           {dividend-hi >= divisor-hi?}
  jae     @@BigDiv           {yes, big division needed}
  xor     eax, eax           {no, result = 0}
  xor     edx, edx
  jmp     @Done
@@BigDiv:
  mov     [esp+12], eax      {save dividend-lo}
  mov     [esp+16], ebx      {save divisor-lo}
  mov     [esp+20], edx      {save dividend-hi}
  mov     edi, ecx           {with divisor (ecx:ebx) and dividend (edx:eax)}
  shr     edx, 1             { shift both}
  rcr     eax, 1             {  dividend and}
  ror     edi, 1             {   divisor}
  rcr     ebx, 1             {    right by 1 bit}
  bsr     ecx, ecx           {get number of remaining shifts}
  shrd    ebx, edi, cl       {scale down divisor and}
  shrd    eax, edx, cl       {  dividend such that divisor}
  shr     edx, cl            {   is less than 232}
  rol     edi, 1             {restore original divisor-hi}
  div     ebx                {compute quotient}
  mov     ebx, [esp+12]      {dividend-lo}
  mov     ecx, eax           {save quotient}
  imul    edi, eax           {quotient * divisor hi}
  mul     dword ptr [esp+16] {quotient * divisor-lo}
  add     edx, edi           {edx:eax = quotient * divisor}
  sub     ebx, eax           {dividend-lo - (quotient*divisor-lo)}
  mov     eax, ecx           {get quotient}
  mov     ecx, [esp+20]      {dividend-hi}
  sbb     ecx, edx           {dividend - divisor * quotient}
  sbb     eax, 0             {Adjust quotient if remainder is negative}
  xor     edx, edx           {clear hi-word of quotient}
@SetSign:
  xor     eax, esi           {if quotient < 0}
  xor     edx, esi           { compute 1's complement of result}
  sub     eax, esi           {if quotient < 0}
  sbb     edx, esi           { compute 2's complement of result}
@Done:
  mov     ebx, [esp]         {restore used registers}
  mov     esi, [esp+4]
  mov     edi, [esp+8]
  add     esp, 24            {release local storage}
end;

procedure Filler4;
asm
 nop
end;


//Fastcode wrapper around proposed highlander __lldiv replacement
function Int64Div_JOH_IA32_4_b(var X, Y : Int64) : Int64;
asm
  sub     esp, 24            {allocate local storage}
  mov     [esp], ebx         {save used registers}
  mov     [esp+4], esi
  mov     [esp+8], edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]       {ecx:ebx = Y (Divisor)}
  mov     edx, [eax+4]
  mov     eax, [eax]         {edx:eax = X (Dividend)}
  mov     esi, edx
  mov     edi, ecx
  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi           {edx:eax = abs(X)}
  sar     edi, 31
  xor     esi, edi           {esi = 0 if X and Y have same sign, else -1}
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi           {ecx:ebx = abs(Y)}
  jnz     @@BigDivisor       {jump if divisor >= 232}
  cmp     edx, ebx           {dividend-hi < divisor-hi?}
  jb      @@OneDiv           {yes, only one division needed}
  mov     ecx, eax           {ecx = dividend-lo}
  mov     eax, edx           {eax = dividend-hi}
  xor     edx, edx           {zero extend it into edx:eax}
  div     ebx                {eax = quotient-hi}
  xchg    eax, ecx           {eax = dividend-lo, ecx = quotient-hi}
@@OneDiv:
  div     ebx                {eax = quotient-lo}
  mov     edx, ecx           {edx = quotient-hi}
  jmp     @SetSign           {quotient in edx:eax}
@@BigDivisor:
  cmp     edx, ecx           {dividend-hi >= divisor-hi?}
  jae     @@BigDiv           {yes, big division needed}
  xor     eax, eax           {no, result = 0}
  xor     edx, edx
  jmp     @Done
@@BigDiv:
  mov     [esp+12], eax      {save dividend-lo}
  mov     [esp+16], ebx      {save divisor-lo}
  mov     [esp+20], edx      {save dividend-hi}
  mov     edi, ecx           {with divisor (ecx:ebx) and dividend (edx:eax)}
  shr     edx, 1             { shift both}
  rcr     eax, 1             {  dividend and}
  ror     edi, 1             {   divisor}
  rcr     ebx, 1             {    right by 1 bit}
  bsr     ecx, ecx           {get number of remaining shifts}
  shrd    ebx, edi, cl       {scale down divisor and}
  shrd    eax, edx, cl       {  dividend such that divisor}
  shr     edx, cl            {   is less than 232}
  rol     edi, 1             {restore original divisor-hi}
  div     ebx                {compute quotient}
  mov     ebx, [esp+12]      {dividend-lo}
  mov     ecx, eax           {save quotient}
  imul    edi, eax           {quotient * divisor hi}
  mul     dword ptr [esp+16] {quotient * divisor-lo}
  add     edx, edi           {edx:eax = quotient * divisor}
  sub     ebx, eax           {dividend-lo - (quotient*divisor-lo)}
  mov     eax, ecx           {get quotient}
  mov     ecx, [esp+20]      {dividend-hi}
  sbb     ecx, edx           {dividend - divisor * quotient}
  sbb     eax, 0             {Adjust quotient if remainder is negative}
  xor     edx, edx           {clear hi-word of quotient}
@SetSign:
  xor     eax, esi           {if quotient < 0}
  xor     edx, esi           { compute 1's complement of result}
  sub     eax, esi           {if quotient < 0}
  sbb     edx, esi           { compute 2's complement of result}
@Done:
  mov     ebx, [esp]         {restore used registers}
  mov     esi, [esp+4]
  mov     edi, [esp+8]
  add     esp, 24            {release local storage}
end;

procedure Filler5;
asm
 nop
end;


//Fastcode wrapper around proposed highlander __lldiv replacement
function Int64Div_JOH_IA32_4_c(var X, Y : Int64) : Int64;
asm
  sub     esp, 24            {allocate local storage}
  mov     [esp], ebx         {save used registers}
  mov     [esp+4], esi
  mov     [esp+8], edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]       {ecx:ebx = Y (Divisor)}
  mov     edx, [eax+4]
  mov     eax, [eax]         {edx:eax = X (Dividend)}
  mov     esi, edx
  mov     edi, ecx
  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi           {edx:eax = abs(X)}
  sar     edi, 31
  xor     esi, edi           {esi = 0 if X and Y have same sign, else -1}
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi           {ecx:ebx = abs(Y)}
  jnz     @@BigDivisor       {jump if divisor >= 232}
  cmp     edx, ebx           {dividend-hi < divisor-hi?}
  jb      @@OneDiv           {yes, only one division needed}
  mov     ecx, eax           {ecx = dividend-lo}
  mov     eax, edx           {eax = dividend-hi}
  xor     edx, edx           {zero extend it into edx:eax}
  div     ebx                {eax = quotient-hi}
  xchg    eax, ecx           {eax = dividend-lo, ecx = quotient-hi}
@@OneDiv:
  div     ebx                {eax = quotient-lo}
  mov     edx, ecx           {edx = quotient-hi}
  jmp     @SetSign           {quotient in edx:eax}
@@BigDivisor:
  cmp     edx, ecx           {dividend-hi >= divisor-hi?}
  jae     @@BigDiv           {yes, big division needed}
  xor     eax, eax           {no, result = 0}
  xor     edx, edx
  jmp     @Done
@@BigDiv:
  mov     [esp+12], eax      {save dividend-lo}
  mov     [esp+16], ebx      {save divisor-lo}
  mov     [esp+20], edx      {save dividend-hi}
  mov     edi, ecx           {with divisor (ecx:ebx) and dividend (edx:eax)}
  shr     edx, 1             { shift both}
  rcr     eax, 1             {  dividend and}
  ror     edi, 1             {   divisor}
  rcr     ebx, 1             {    right by 1 bit}
  bsr     ecx, ecx           {get number of remaining shifts}
  shrd    ebx, edi, cl       {scale down divisor and}
  shrd    eax, edx, cl       {  dividend such that divisor}
  shr     edx, cl            {   is less than 232}
  rol     edi, 1             {restore original divisor-hi}
  div     ebx                {compute quotient}
  mov     ebx, [esp+12]      {dividend-lo}
  mov     ecx, eax           {save quotient}
  imul    edi, eax           {quotient * divisor hi}
  mul     dword ptr [esp+16] {quotient * divisor-lo}
  add     edx, edi           {edx:eax = quotient * divisor}
  sub     ebx, eax           {dividend-lo - (quotient*divisor-lo)}
  mov     eax, ecx           {get quotient}
  mov     ecx, [esp+20]      {dividend-hi}
  sbb     ecx, edx           {dividend - divisor * quotient}
  sbb     eax, 0             {Adjust quotient if remainder is negative}
  xor     edx, edx           {clear hi-word of quotient}
@SetSign:
  xor     eax, esi           {if quotient < 0}
  xor     edx, esi           { compute 1's complement of result}
  sub     eax, esi           {if quotient < 0}
  sbb     edx, esi           { compute 2's complement of result}
@Done:
  mov     ebx, [esp]         {restore used registers}
  mov     esi, [esp+4]
  mov     edi, [esp+8]
  add     esp, 24            {release local storage}
end;

procedure Filler6;
asm
 nop
end;


//Fastcode wrapper around proposed highlander __lldiv replacement
function Int64Div_JOH_IA32_4_d(var X, Y : Int64) : Int64;
asm
  sub     esp, 24            {allocate local storage}
  mov     [esp], ebx         {save used registers}
  mov     [esp+4], esi
  mov     [esp+8], edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]       {ecx:ebx = Y (Divisor)}
  mov     edx, [eax+4]
  mov     eax, [eax]         {edx:eax = X (Dividend)}
  mov     esi, edx
  mov     edi, ecx
  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi           {edx:eax = abs(X)}
  sar     edi, 31
  xor     esi, edi           {esi = 0 if X and Y have same sign, else -1}
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi           {ecx:ebx = abs(Y)}
  jnz     @@BigDivisor       {jump if divisor >= 232}
  cmp     edx, ebx           {dividend-hi < divisor-hi?}
  jb      @@OneDiv           {yes, only one division needed}
  mov     ecx, eax           {ecx = dividend-lo}
  mov     eax, edx           {eax = dividend-hi}
  xor     edx, edx           {zero extend it into edx:eax}
  div     ebx                {eax = quotient-hi}
  xchg    eax, ecx           {eax = dividend-lo, ecx = quotient-hi}
@@OneDiv:
  div     ebx                {eax = quotient-lo}
  mov     edx, ecx           {edx = quotient-hi}
  jmp     @SetSign           {quotient in edx:eax}
@@BigDivisor:
  cmp     edx, ecx           {dividend-hi >= divisor-hi?}
  jae     @@BigDiv           {yes, big division needed}
  xor     eax, eax           {no, result = 0}
  xor     edx, edx
  jmp     @Done
@@BigDiv:
  mov     [esp+12], eax      {save dividend-lo}
  mov     [esp+16], ebx      {save divisor-lo}
  mov     [esp+20], edx      {save dividend-hi}
  mov     edi, ecx           {with divisor (ecx:ebx) and dividend (edx:eax)}
  shr     edx, 1             { shift both}
  rcr     eax, 1             {  dividend and}
  ror     edi, 1             {   divisor}
  rcr     ebx, 1             {    right by 1 bit}
  bsr     ecx, ecx           {get number of remaining shifts}
  shrd    ebx, edi, cl       {scale down divisor and}
  shrd    eax, edx, cl       {  dividend such that divisor}
  shr     edx, cl            {   is less than 232}
  rol     edi, 1             {restore original divisor-hi}
  div     ebx                {compute quotient}
  mov     ebx, [esp+12]      {dividend-lo}
  mov     ecx, eax           {save quotient}
  imul    edi, eax           {quotient * divisor hi}
  mul     dword ptr [esp+16] {quotient * divisor-lo}
  add     edx, edi           {edx:eax = quotient * divisor}
  sub     ebx, eax           {dividend-lo - (quotient*divisor-lo)}
  mov     eax, ecx           {get quotient}
  mov     ecx, [esp+20]      {dividend-hi}
  sbb     ecx, edx           {dividend - divisor * quotient}
  sbb     eax, 0             {Adjust quotient if remainder is negative}
  xor     edx, edx           {clear hi-word of quotient}
@SetSign:
  xor     eax, esi           {if quotient < 0}
  xor     edx, esi           { compute 1's complement of result}
  sub     eax, esi           {if quotient < 0}
  sbb     edx, esi           { compute 2's complement of result}
@Done:
  mov     ebx, [esp]         {restore used registers}
  mov     esi, [esp+4]
  mov     edi, [esp+8]
  add     esp, 24            {release local storage}
end;


function Int64Div_JOH_IA32_5_a(var X, Y : Int64) : Int64;
asm {Size = 135 Bytes}
  push    ebx
  push    esi
  push    edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]      //ECX:EBX = Y
  mov     edx, [eax+4]
  mov     eax, [eax]        //EDX:EAX = X
  mov     esi, edx
  mov     edi, ecx
  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi          // EDX:EAX := abs(X)
  sar     edi, 31
  xor     esi, edi          // 0 if X and Y have same sign
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi          // ECX:EBX := abs(Y)
  jnz     @@BigDivisor      // divisor > 3232-1
  cmp     edx, ebx          // only one division needed ? (ecx = 0)
  jb      @@OneDiv          // yes, one division sufficient
  mov     ecx, eax          // save dividend-lo in ecx
  mov     eax, edx          // get dividend-hi
  xor     edx, edx          // zero extend it into edx:eax
  div     ebx               // quotient-hi in eax
  xchg    eax, ecx          // ecx = quotient-hi, eax =dividend-lo
@@OneDiv:
  div     ebx               // eax = quotient-lo
  mov     edx, ecx          // edx = quotient-hi(quotient in edx:eax)
  jmp     @SetSign
@@BigDivisor:
  cmp     edx, ecx
  jae     @BigDiv
@Zero:
  xor     eax, eax
  xor     edx, edx
  jmp     @Done
@BigDiv:
  push    edx
  push    eax
  push    ebx
  mov     edi, ecx
  shr     edx, 1            // shift both
  rcr     eax, 1            //  divisor and
  ror     edi, 1            //   and dividend
  rcr     ebx, 1            //    right by 1 bit
  bsr     ecx, ecx          // ecx = number of remaining shifts
  shrd    ebx, edi, cl      // scale down divisor and
  shrd    eax, edx, cl      //   dividend such that divisor
  shr     edx, cl           //    less than 232 (i.e. fits in ebx)
  rol     edi, 1            // restore original divisor (edi:esi)
  div     ebx               // compute quotient
  mov     ecx, eax          // save quotient
  imul    edi, eax          // quotient * divisor hi-word (low only)
  pop     ebx
  mul     ebx
  pop     ebx
  add     edx, edi          // edx:eax = quotient * divisor
  sub     ebx, eax          // dividend-lo - (quot.*divisor)-lo
  mov     eax, ecx          // get quotient
  pop     ecx
  sbb     ecx, edx          // subtract divisor * quot. from dividend
  sbb     eax, 0            // Adjust quotient if remainder is negative.
  xor     edx, edx          // clear hi-word of quot (eax<=FFFFFFFFh)
@SetSign:
  xor     eax, esi          // If (quotient < 0),
  xor     edx, esi          //   compute 1's complement of result.
  sub     eax, esi          // If (quotient < 0),
  sbb     edx, esi          //   compute 2's complement of result.
@Done:
  pop     edi
  pop     esi
  pop     ebx
end;


function Int64Div_JOH_IA32_5_b(var X, Y : Int64) : Int64;
asm {Size = 135 Bytes}
  push    ebx
  push    esi
  push    edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]      //ECX:EBX = Y
  mov     edx, [eax+4]
  mov     eax, [eax]        //EDX:EAX = X
  mov     esi, edx
  mov     edi, ecx
  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi          // EDX:EAX := abs(X)
  sar     edi, 31
  xor     esi, edi          // 0 if X and Y have same sign
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi          // ECX:EBX := abs(Y)
  jnz     @@BigDivisor      // divisor > 3232-1
  cmp     edx, ebx          // only one division needed ? (ecx = 0)
  jb      @@OneDiv          // yes, one division sufficient
  mov     ecx, eax          // save dividend-lo in ecx
  mov     eax, edx          // get dividend-hi
  xor     edx, edx          // zero extend it into edx:eax
  div     ebx               // quotient-hi in eax
  xchg    eax, ecx          // ecx = quotient-hi, eax =dividend-lo
@@OneDiv:
  div     ebx               // eax = quotient-lo
  mov     edx, ecx          // edx = quotient-hi(quotient in edx:eax)
  jmp     @SetSign
@@BigDivisor:
  cmp     edx, ecx
  jae     @BigDiv
@Zero:
  xor     eax, eax
  xor     edx, edx
  jmp     @Done
@BigDiv:
  push    edx
  push    eax
  push    ebx
  mov     edi, ecx
  shr     edx, 1            // shift both
  rcr     eax, 1            //  divisor and
  ror     edi, 1            //   and dividend
  rcr     ebx, 1            //    right by 1 bit
  bsr     ecx, ecx          // ecx = number of remaining shifts
  shrd    ebx, edi, cl      // scale down divisor and
  shrd    eax, edx, cl      //   dividend such that divisor
  shr     edx, cl           //    less than 232 (i.e. fits in ebx)
  rol     edi, 1            // restore original divisor (edi:esi)
  div     ebx               // compute quotient
  mov     ecx, eax          // save quotient
  imul    edi, eax          // quotient * divisor hi-word (low only)
  pop     ebx
  mul     ebx
  pop     ebx
  add     edx, edi          // edx:eax = quotient * divisor
  sub     ebx, eax          // dividend-lo - (quot.*divisor)-lo
  mov     eax, ecx          // get quotient
  pop     ecx
  sbb     ecx, edx          // subtract divisor * quot. from dividend
  sbb     eax, 0            // Adjust quotient if remainder is negative.
  xor     edx, edx          // clear hi-word of quot (eax<=FFFFFFFFh)
@SetSign:
  xor     eax, esi          // If (quotient < 0),
  xor     edx, esi          //   compute 1's complement of result.
  sub     eax, esi          // If (quotient < 0),
  sbb     edx, esi          //   compute 2's complement of result.
@Done:
  pop     edi
  pop     esi
  pop     ebx
end;

procedure Filler8;
asm
 nop
end;

function Int64Div_JOH_IA32_5_c(var X, Y : Int64) : Int64;
asm {Size = 135 Bytes}
  push    ebx
  push    esi
  push    edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]      //ECX:EBX = Y
  mov     edx, [eax+4]
  mov     eax, [eax]        //EDX:EAX = X
  mov     esi, edx
  mov     edi, ecx
  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi          // EDX:EAX := abs(X)
  sar     edi, 31
  xor     esi, edi          // 0 if X and Y have same sign
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi          // ECX:EBX := abs(Y)
  jnz     @@BigDivisor      // divisor > 3232-1
  cmp     edx, ebx          // only one division needed ? (ecx = 0)
  jb      @@OneDiv          // yes, one division sufficient
  mov     ecx, eax          // save dividend-lo in ecx
  mov     eax, edx          // get dividend-hi
  xor     edx, edx          // zero extend it into edx:eax
  div     ebx               // quotient-hi in eax
  xchg    eax, ecx          // ecx = quotient-hi, eax =dividend-lo
@@OneDiv:
  div     ebx               // eax = quotient-lo
  mov     edx, ecx          // edx = quotient-hi(quotient in edx:eax)
  jmp     @SetSign
@@BigDivisor:
  cmp     edx, ecx
  jae     @BigDiv
@Zero:
  xor     eax, eax
  xor     edx, edx
  jmp     @Done
@BigDiv:
  push    edx
  push    eax
  push    ebx
  mov     edi, ecx
  shr     edx, 1            // shift both
  rcr     eax, 1            //  divisor and
  ror     edi, 1            //   and dividend
  rcr     ebx, 1            //    right by 1 bit
  bsr     ecx, ecx          // ecx = number of remaining shifts
  shrd    ebx, edi, cl      // scale down divisor and
  shrd    eax, edx, cl      //   dividend such that divisor
  shr     edx, cl           //    less than 232 (i.e. fits in ebx)
  rol     edi, 1            // restore original divisor (edi:esi)
  div     ebx               // compute quotient
  mov     ecx, eax          // save quotient
  imul    edi, eax          // quotient * divisor hi-word (low only)
  pop     ebx
  mul     ebx
  pop     ebx
  add     edx, edi          // edx:eax = quotient * divisor
  sub     ebx, eax          // dividend-lo - (quot.*divisor)-lo
  mov     eax, ecx          // get quotient
  pop     ecx
  sbb     ecx, edx          // subtract divisor * quot. from dividend
  sbb     eax, 0            // Adjust quotient if remainder is negative.
  xor     edx, edx          // clear hi-word of quot (eax<=FFFFFFFFh)
@SetSign:
  xor     eax, esi          // If (quotient < 0),
  xor     edx, esi          //   compute 1's complement of result.
  sub     eax, esi          // If (quotient < 0),
  sbb     edx, esi          //   compute 2's complement of result.
@Done:
  pop     edi
  pop     esi
  pop     ebx
end;


function Int64Div_JOH_IA32_5_d(var X, Y : Int64) : Int64;
asm {Size = 135 Bytes}
  push    ebx
  push    esi
  push    edi
  mov     ebx, [edx]
  mov     ecx, [edx+4]      //ECX:EBX = Y
  mov     edx, [eax+4]
  mov     eax, [eax]        //EDX:EAX = X
  mov     esi, edx
  mov     edi, ecx
  sar     esi, 31
  xor     eax, esi
  xor     edx, esi
  sub     eax, esi
  sbb     edx, esi          // EDX:EAX := abs(X)
  sar     edi, 31
  xor     esi, edi          // 0 if X and Y have same sign
  xor     ebx, edi
  xor     ecx, edi
  sub     ebx, edi
  sbb     ecx, edi          // ECX:EBX := abs(Y)
  jnz     @@BigDivisor      // divisor > 3232-1
  cmp     edx, ebx          // only one division needed ? (ecx = 0)
  jb      @@OneDiv          // yes, one division sufficient
  mov     ecx, eax          // save dividend-lo in ecx
  mov     eax, edx          // get dividend-hi
  xor     edx, edx          // zero extend it into edx:eax
  div     ebx               // quotient-hi in eax
  xchg    eax, ecx          // ecx = quotient-hi, eax =dividend-lo
@@OneDiv:
  div     ebx               // eax = quotient-lo
  mov     edx, ecx          // edx = quotient-hi(quotient in edx:eax)
  jmp     @SetSign
@@BigDivisor:
  cmp     edx, ecx
  jae     @BigDiv
@Zero:
  xor     eax, eax
  xor     edx, edx
  jmp     @Done
@BigDiv:
  push    edx
  push    eax
  push    ebx
  mov     edi, ecx
  shr     edx, 1            // shift both
  rcr     eax, 1            //  divisor and
  ror     edi, 1            //   and dividend
  rcr     ebx, 1            //    right by 1 bit
  bsr     ecx, ecx          // ecx = number of remaining shifts
  shrd    ebx, edi, cl      // scale down divisor and
  shrd    eax, edx, cl      //   dividend such that divisor
  shr     edx, cl           //    less than 232 (i.e. fits in ebx)
  rol     edi, 1            // restore original divisor (edi:esi)
  div     ebx               // compute quotient
  mov     ecx, eax          // save quotient
  imul    edi, eax          // quotient * divisor hi-word (low only)
  pop     ebx
  mul     ebx
  pop     ebx
  add     edx, edi          // edx:eax = quotient * divisor
  sub     ebx, eax          // dividend-lo - (quot.*divisor)-lo
  mov     eax, ecx          // get quotient
  pop     ecx
  sbb     ecx, edx          // subtract divisor * quot. from dividend
  sbb     eax, 0            // Adjust quotient if remainder is negative.
  xor     edx, edx          // clear hi-word of quot (eax<=FFFFFFFFh)
@SetSign:
  xor     eax, esi          // If (quotient < 0),
  xor     edx, esi          //   compute 1's complement of result.
  sub     eax, esi          // If (quotient < 0),
  sbb     edx, esi          //   compute 2's complement of result.
@Done:
  pop     edi
  pop     esi
  pop     ebx
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;
 Filler7;
 Filler8;


end.
