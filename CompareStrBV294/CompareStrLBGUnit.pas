unit CompareStrLBGUnit;

interface

function CompareStr_LBG_IA32ext_1_a(const S1, S2: string): Integer;
function CompareStr_LBG_IA32ext_1_b(const S1, S2: string): Integer;
function CompareStr_LBG_IA32ext_1_c(const S1, S2: string): Integer;
function CompareStr_LBG_IA32ext_1_d(const S1, S2: string): Integer;

implementation

//Author           : Lars Bloch Gravengaard
//Instructionset(s): IA32ext
//Remarks          : Based on borland original code : Very small code size


function CompareStr_LBG_IA32ext_1_a(const S1, S2: string): Integer;
asm
      push  esi
      push  edi

      mov   esi,eax
      mov   edi,edx

      test  eax,eax
      je    @1          // S1 length is 0
      mov   eax,[eax-4] // S1 length is in [eax-4]

@1:   test  edx, edx
      je    @2          // S2 length is 0
      mov   edx,[edx-4] // S2 length is in [edx-4]

@2:   mov   ecx,eax
      cmp   ecx,edx
      cmova ecx,edx     // select loop count = Min(S1 length,S2 length)

      cmp   ecx,ecx
      repe  cmpsb

      je    @3
      movzx eax,byte ptr [esi-1]
      movzx edx,byte ptr [edi-1]
@3:   sub   eax,edx

      pop   edi
      pop   esi
end;

procedure Filler1;
asm
 nop
end;

function CompareStr_LBG_IA32ext_1_b(const S1, S2: string): Integer;
asm
      push  esi
      push  edi

      mov   esi,eax
      mov   edi,edx

      test  eax,eax
      je    @1          // S1 length is 0
      mov   eax,[eax-4] // S1 length is in [eax-4]

@1:   test  edx, edx
      je    @2          // S2 length is 0
      mov   edx,[edx-4] // S2 length is in [edx-4]

@2:   mov   ecx,eax
      cmp   ecx,edx
      cmova ecx,edx     // select loop count = Min(S1 length,S2 length)

      cmp   ecx,ecx
      repe  cmpsb

      je    @3
      movzx eax,byte ptr [esi-1]
      movzx edx,byte ptr [edi-1]
@3:   sub   eax,edx

      pop   edi
      pop   esi
end;

procedure Filler2;
asm
 nop
end;

function CompareStr_LBG_IA32ext_1_c(const S1, S2: string): Integer;
asm
      push  esi
      push  edi

      mov   esi,eax
      mov   edi,edx

      test  eax,eax
      je    @1          // S1 length is 0
      mov   eax,[eax-4] // S1 length is in [eax-4]

@1:   test  edx, edx
      je    @2          // S2 length is 0
      mov   edx,[edx-4] // S2 length is in [edx-4]

@2:   mov   ecx,eax
      cmp   ecx,edx
      cmova ecx,edx     // select loop count = Min(S1 length,S2 length)

      cmp   ecx,ecx
      repe  cmpsb

      je    @3
      movzx eax,byte ptr [esi-1]
      movzx edx,byte ptr [edi-1]
@3:   sub   eax,edx

      pop   edi
      pop   esi
end;

procedure Filler3;
asm
 nop
end;

function CompareStr_LBG_IA32ext_1_d(const S1, S2: string): Integer;
asm
      push  esi
      push  edi

      mov   esi,eax
      mov   edi,edx

      test  eax,eax
      je    @1          // S1 length is 0
      mov   eax,[eax-4] // S1 length is in [eax-4]

@1:   test  edx, edx
      je    @2          // S2 length is 0
      mov   edx,[edx-4] // S2 length is in [edx-4]

@2:   mov   ecx,eax
      cmp   ecx,edx
      cmova ecx,edx     // select loop count = Min(S1 length,S2 length)

      cmp   ecx,ecx
      repe  cmpsb

      je    @3
      movzx eax,byte ptr [esi-1]
      movzx edx,byte ptr [edi-1]
@3:   sub   eax,edx

      pop   edi
      pop   esi
end;

initialization

 Filler1;
 Filler2;
 Filler3;

end.