//Used sources by John O'Harrow
unit IntToStrShaUnit;

interface

{$INCLUDE Defines.inc}

uses
  FastcodeChallengeIntToStrUnit,
  FastcodeChallengeIntToStr64Unit,
  FastcodeChallengeUnit;

implementation

(*

uses
  Windows, SysUtils;

const
  TwoDigitLookup : packed array[0..99] of array[1..2] of Char =
    ('00','01','02','03','04','05','06','07','08','09',
     '10','11','12','13','14','15','16','17','18','19',
     '20','21','22','23','24','25','26','27','28','29',
     '30','31','32','33','34','35','36','37','38','39',
     '40','41','42','43','44','45','46','47','48','49',
     '50','51','52','53','54','55','56','57','58','59',
     '60','61','62','63','64','65','66','67','68','69',
     '70','71','72','73','74','75','76','77','78','79',
     '80','81','82','83','84','85','86','87','88','89',
     '90','91','92','93','94','95','96','97','98','99');

function IntToStr_Sha_IA32_1(Value: Integer): string;
asm
  push  ebp
  push  ebx
  push  edi
  push  esi

  mov   ebx, eax               //Value
  xor   ebp, ebp
  sar   ebx, 31                //ebx = -1 for Value < 0, else ebx = 0
  mov   edi, edx               //Result address
  xor   esi, esi
  xor   eax, ebx
  sub   eax, ebx               //eax = Abs(Value)
  mov   ecx, eax

  //Calculate number of digits within Result
  //and format Value to 2.8 (or 7.25 binary).
  cmp   eax, 10000
  jae   @@5orMoreDigits
  cmp   ecx, 100
  jae   @@3or4Digits
  add   esi, 2
  shl   eax, 25
  mov   edx, eax
  cmp   ecx, 10
  jmp   @@SetLength
@@3or4Digits:
  add   esi, 4
  mov   edx, $51EB851F         //1e-2
  mul   edx
  shl   edx, 20                //32-7-5
  shr   eax, 12                //7+5
  lea   edx, [edx+eax+1]
  cmp   ecx, 1000
  jmp   @@SetLength
@@5orMoreDigits:
  cmp   ecx, 1000000
  jae   @@7orMoreDigits
  add   esi, 6
  mov   edx, $68DB8BAD         //1e-4
  mul   edx
  shl   edx, 13                //32-7-12
  shr   eax, 19                //7+12
  lea   edx, [edx+eax+1]
  cmp   ecx, 100000
  jmp   @@SetLength
@@7orMoreDigits:
  cmp   ecx, 100000000
  jae   @@9orMoreDigits
  add   esi, 8
  mov   edx, $431BDE83         //1e-6
  mul   edx
  shl   edx, 7                 //32-7-18
  shr   eax, 25                //7+18
  lea   edx, [edx+eax+1]
  cmp   ecx, 10000000
  jmp   @@SetLength
@@9orMoreDigits:
  add   esi, 10
  mov   edx, $55E63B89         //1e-8
  mul   edx
  //Save in ebp 5 carry bits of fraction multiplied by 25
  shr   eax, 5
  lea   eax, [4*eax+eax]
  lea   ebp, [4*eax+eax+$0FFFFFFF]
  shr   ebp, 27                //carry bits + 1
  cmp   ecx, 1000000000
@@SetLength:
  sbb   esi, ebx               //Digits including Sign
  mov   eax, edx
  mov   ecx, [edi]             //Result
  mov   edx, esi
  or    edx, 3                 //Round-up for DWORD allocation resolution
  test  ecx, ecx
  je    @@Alloc                //Null Result => allocate
  cmp   dword ptr [ecx-8], 1
  mov   ecx, [ecx-4]           //Length(Result)
  jne   @@Alloc                //Reference count <> 1 => allocate
  or    ecx, 3                 //Round-Up for DWORD Allocation Resolution
  cmp   ecx, edx
  je    @@SizeOk               //Same size required => skip allocation
@@Alloc:
  push  eax                    //Abs(Value)
  mov   eax, edi
  call  system.@LStrSetLength  //Allocate Result
  pop   eax                    //Abs(Value)
@@SizeOk:
  mov   edi, [edi]             //Result
  lea   edx, [esi+ebx]         //Digits excluding Sign
  mov   ecx, edx
  mov   [edi-4], esi           //Set Result length
  mov   byte ptr [edi], '-'    //Write sign
  mov   byte ptr [edi+esi], 0  //Write zero terminator
  sub   edi, ebx               //Value < 0 => shift destination rigth
  lea   esi, [edi-1]           //Address of byte to save
  and   edx, 1                 //Odd(Digits)
  movzx ebx, [edi-1]           //Save byte which may be corrupted
  sub   edi, edx               //Odd(digits) => shift destination left

  //Digits 1-2
  mov   edx, eax               //Value in format 2.8 (7.25)
  shr   eax, 25                //Get the first two digits
  and   edx, $01FFFFFF         //Filter fraction
  lea   edx, [edx*4+edx]
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  mov   [edi], ax 
  lea   eax, [edx*4+edx]       //Format to 2.6 (9.23)
  add   ecx, -2
  jle   @@Done

  //Digits 3-4
  add   eax, ebp               //Add carry bits
  mov   edx, eax
  shr   eax, 23                //Get the next two digits
  and   edx, $007FFFFF         //Filter fraction
  lea   edx, [edx*4+edx]
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  mov   [edi+2], ax
  lea   eax, [edx*4+edx]       //Format to 2.4 (11.21)
  add   ecx, -2
  jle   @@Done

  //Digits 5-6
  mov   edx, eax
  shr   eax, 21                //Get the next two digits
  and   edx, $001FFFFF         //Filter fraction
  lea   edx, [edx*4+edx]
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  mov   [edi+4], ax
  lea   eax, [edx*4+edx]       //Format to 2.2 (13.19)
  add   ecx, -2
  jle   @@Done

  //Digits 7-8
  mov   edx, eax
  shr   eax, 19                //Get the next two digits
  and   edx, $0007FFFF         //Filter fraction
  lea   edx, [edx*4+edx]
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  mov   [edi+6], ax
  lea   eax, [edx*4+edx]       //Format to 2.0 (15.17)
  add   ecx, -2
  jle   @@Done

  //Digits 9-10
  shr   eax, 17                //Get the next two digits
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  mov   [edi+8], ax

@@Done:
  mov   [esi], bl              //Restore saved byte

  pop   esi
  pop   edi
  pop   ebx
  pop   ebp
end;

function IntToStr_Sha_IA32_2(Value: cardinal): string;
asm
  push  ebp
  push  edi
  push  esi

  xor   ebp, ebp               //Carry bits
  mov   edi, edx               //Result address
  xor   esi, esi               //Number of digits
  mov   ecx, eax               //Value

  //Calculate number of digits within Result
  //and format Value to 2.8 (or 7.25 binary).
  cmp   eax, 10000
  jae   @@5orMoreDigits
  cmp   ecx, 100
  jae   @@3or4Digits
  add   esi, 2
  shl   eax, 25
  mov   edx, eax
  cmp   ecx, 10
  jmp   @@SetLength
@@3or4Digits:
  add   esi, 4
  mov   edx, $51EB851F         //1e-2
  mul   edx
  shl   edx, 20                //32-7-5
  shr   eax, 12                //7+5
  lea   edx, [edx+eax+1]
  cmp   ecx, 1000
  jmp   @@SetLength
@@5orMoreDigits:
  cmp   ecx, 1000000
  jae   @@7orMoreDigits
  add   esi, 6
  mov   edx, $68DB8BAD         //1e-4
  mul   edx
  shl   edx, 13                //32-7-12
  shr   eax, 19                //7+12
  lea   edx, [edx+eax+1]
  cmp   ecx, 100000
  jmp   @@SetLength
@@7orMoreDigits:
  cmp   ecx, 100000000
  jae   @@9orMoreDigits
  add   esi, 8
  mov   edx, $431BDE83         //1e-6
  mul   edx
  shl   edx, 7                 //32-7-18
  shr   eax, 25                //7+18
  lea   edx, [edx+eax+1]
  cmp   ecx, 10000000
  jmp   @@SetLength
@@9orMoreDigits:
  add   esi, 10
  mov   edx, $55E63B89         //1e-8
  mul   edx
  //Save in ebp 5 carry bits of fraction multiplied by 25
  shr   eax, 5
  lea   eax, [4*eax+eax]
  lea   ebp, [4*eax+eax+$0FFFFFFF]
  shr   ebp, 27                //carry bits + 1
  cmp   ecx, 1000000000
@@SetLength:
  sbb   esi, 0                 //Number of digits
  mov   eax, edx
  mov   ecx, [edi]             //Result
  mov   edx, esi
  or    edx, 3                 //Round-up for DWORD allocation resolution
  test  ecx, ecx
  je    @@Alloc                //Null Result => allocate
  cmp   dword ptr [ecx-8], 1
  mov   ecx, [ecx-4]           //Length(Result)
  jne   @@Alloc                //Reference count <> 1 => allocate
  or    ecx, 3                 //Round-Up for DWORD Allocation Resolution
  cmp   ecx, edx
  je    @@SizeOk               //Same size required => skip allocation
@@Alloc:
  push  eax                    //Abs(Value)
  mov   eax, edi
  call  system.@LStrSetLength  //Allocate Result
  pop   eax                    //Abs(Value)
@@SizeOk:
  mov   edi, [edi]             //Result
  mov   edx, esi               //Digits
  mov   [edi-4], esi           //Set Result length
  mov   byte ptr [edi+esi], 0  //Write zero terminator
  and   edx, 1                 //Odd(Digits)
  sub   edi, edx               //Odd(digits) => shift destination left

  //Digits 1-2
  mov   edx, eax               //Value in format 2.8 (7.25)
  shr   eax, 25                //Get the first two digits
  and   edx, $01FFFFFF         //Filter fraction
  lea   edx, [edx*4+edx]
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  test  edi, 1
  jz    @@Write2               //Even address => write two digits
  mov   [edi+1], ah            //Odd address => write one digit
  jmp   @@After1
@@Write2:
  mov   [edi], ax
@@After1:
  lea   eax, [edx*4+edx]       //Format to 2.6 (9.23)
  add   esi, -2
  jle   @@Done

  //Digits 3-4
  add   eax, ebp               //Add carry bits
  mov   edx, eax
  shr   eax, 23                //Get the next two digits
  and   edx, $007FFFFF         //Filter fraction
  lea   edx, [edx*4+edx]
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  mov   [edi+2], ax
  lea   eax, [edx*4+edx]       //Format to 2.4 (11.21)
  add   esi, -2
  jle   @@Done

  //Digits 5-6
  mov   edx, eax
  shr   eax, 21                //Get the next two digits
  and   edx, $001FFFFF         //Filter fraction
  lea   edx, [edx*4+edx]
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  mov   [edi+4], ax
  lea   eax, [edx*4+edx]       //Format to 2.2 (13.19)
  add   esi, -2
  jle   @@Done

  //Digits 7-8
  mov   edx, eax
  shr   eax, 19                //Get the next two digits
  and   edx, $0007FFFF         //Filter fraction
  lea   edx, [edx*4+edx]
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  mov   [edi+6], ax
  lea   eax, [edx*4+edx]       //Format to 2.0 (15.17)
  add   esi, -2
  jle   @@Done

  //Digits 9-10
  shr   eax, 17                //Get the next two digits
  movzx eax, word ptr [TwoDigitLookup+eax*2]
  mov   [edi+8], ax

@@Done:
  pop   esi
  pop   edi
  pop   ebp
end;

*)

initialization
begin
//  JOH claims this function writes past the null terminator
//  ChallengeIntToStr.RegisterFunction(FunctionData(
//    'IntToStr_Sha_IA32_1', '', @IntToStr_Sha_IA32_1, fccIA32, fcaSha));

//  Cardinal function (obviously) fails validation and is therefore not included in the challenge (for now?)
//  ChallengeIntToStr.RegisterFunction(FunctionData(
//    'IntToStr_Sha_IA32_2', @IntToStr_Sha_IA32_2, fccIA32, fcaSha));
end;

end.

