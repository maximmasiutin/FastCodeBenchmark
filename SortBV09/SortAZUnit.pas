unit SortAZUnit;

interface

{$INCLUDE Defines.inc}

uses
  Classes, FastCodeChallengeUnit, FastcodeChallengeSortUnit;

procedure Sort_AZ_IA32_2(List: PPointerList; Count: Integer; Compare: TListSortCompare);

implementation

procedure Sort_AZ_IA32_2(List: PPointerList; Count: Integer; Compare: TListSortCompare);
asm
  push  ebx
  push  ebp
  push  esi
  push  edi
  push  ecx

  mov   ebx,   eax
  cmp   edx,   3
  jle   @SmallList

@RecurseTail:
  push  edx
  lea   edi,   [edx - 1]
  shr   edx,   1
  xor   esi,   esi
  mov   ebp,   [ebx + edx * 4]

  jmp   @Compare1NoInc

@Compare1:
  add   esi,   1
@Compare1NoInc:
  mov   eax,   [ebx + esi * 4]
  mov   edx,   ebp
  call  dword ptr [esp + 4]
  cmp   eax,   0
  jl    @Compare1

  jmp   @Compare2NoDec
@Compare2:
  sub   edi,   1
@Compare2NoDec:
  mov   eax,   [ebx + edi * 4]
  mov   edx,   ebp
  call  dword ptr [esp + 4]
  cmp   eax,   0
  jg    @Compare2

  cmp   esi,   edi
  jg    @DoneLoop

  mov   eax,   [ebx + esi * 4]
  mov   edx,   [ebx + edi * 4]
  mov   [ebx + edi * 4], eax
  mov   [ebx + esi * 4], edx
  add   esi,   1
  sub   edi,   1
  cmp   esi,   edi
  jle   @Compare1NoInc

@DoneLoop:  
  cmp   edi,   0
  jle   @RecurseSkip
  mov   eax,   ebx
  lea   edx,   [edi + 1]
  mov   ecx,   [esp + 4]
  call  Sort_AZ_IA32_2

@RecurseSkip:
  pop   edx
  lea   ebx,   [ebx + esi * 4]
  sub   edx,   esi

  cmp   edx,   3
  jg    @RecurseTail

@SmallList:
  cmp   edx,   2
  jl    @Exit
  jg    @Sort3

@Sort2:
  mov   esi,   [ebx]
  mov   edi,   [ebx + 4]
  mov   eax,   esi
  mov   edx,   edi
  call  dword ptr [esp]
  cmp   eax,   0
  jle   @Exit
  mov   [ebx], edi
  mov   [ebx + 4], esi
  jmp   @Exit

@Sort3:
  mov   esi,   [ebx]
  mov   ebp,   [ebx + 8]
  mov   edi,   [ebx + 4]

  mov   eax,   esi
  mov   edx,   ebp
  call  dword ptr [esp]
  push  eax

  mov   eax,   esi
  mov   edx,   edi
  call  dword ptr [esp + 4]
  pop   edx

  cmp   eax,   0
  jl    @Sort3_L
  je    @Sort3_E

@Sort3_G:
  cmp   edx,   0
  jg    @Sort3_GG

@Sort3_BAC:
  mov   [ebx], edi
  mov   [ebx + 4], esi
  jmp   @Exit

@Sort3_LL:
  mov   eax,   edi
  mov   edx,   ebp
  call  dword ptr [esp]
  cmp   eax,   0
  jle   @Exit

@Sort3_ACB:
  mov   [ebx + 4], ebp
  mov   [ebx + 8], edi
  jmp   @Exit

@Sort3_L:
  cmp   edx,   0
  jl    @Sort3_LL

@Sort3_CAB:
  mov   [ebx], ebp
  mov   [ebx + 4], esi
  mov   [ebx + 8], edi
  jmp   @Exit

@Sort3_GG:
  mov   eax,   edi
  mov   edx,   ebp
  call  dword ptr [esp]
  cmp   eax,   0
  jl    @Sort3_BCA

@Sort3_CBA:
  mov   [ebx], ebp
  mov   [ebx + 8], esi
  jmp   @Exit

@Sort3_BCA:
  mov   [ebx], edi
  mov   [ebx + 4], ebp
  mov   [ebx + 8], esi
  jmp   @Exit

@Sort3_E:
  cmp   edx,   0
  jg    @Sort3_CBA

@Exit:
  add   esp,   4
  pop   edi
  pop   esi
  pop   ebp
  pop   ebx
end;

initialization
begin
  ChallengeSort.RegisterFunction(FunctionData('Sort_AZ_IA32_2', 'QuickSort, middle element (like RTL)', @Sort_AZ_IA32_2, fccIA32, fcaAZ));
end;

end.
