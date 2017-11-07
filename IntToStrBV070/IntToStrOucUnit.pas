unit IntToStrOucUnit;

interface

{$INCLUDE Defines.inc}

uses
  FastcodeChallengeIntToStr32Unit,
  FastcodeChallengeIntToStr64Unit,
  FastcodeChallengeUnit,
  SysUtils;

implementation

function IntToStr_OUC_IA32_2_a(Value: Integer): string;
const
   DigitsTable: array [0..159] of array [0..1] of Char =
     ( '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '0A', '0B', '0C', '0D', '0E', '0F',
       '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '1A', '1B', '1C', '1D', '1E', '1F',
       '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '2A', '2B', '2C', '2D', '2E', '2F',
       '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '3A', '3B', '3C', '3D', '3E', '3F',
       '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '4A', '4B', '4C', '4D', '4E', '4F',
       '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '5A', '5B', '5C', '5D', '5E', '5F',
       '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '6A', '6B', '6C', '6D', '6E', '6F',
       '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '7A', '7B', '7C', '7D', '7E', '7F',
       '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '8A', '8B', '8C', '8D', '8E', '8F',
       '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '9A', '9B', '9C', '9D', '9E', '9F' );
var
   BCDChars: array [0..9] of Byte;
   TempInt: Integer;
   Sign: Cardinal;
   NbChars: Integer;
asm
   // EAX = Value
   // EDX = Address to string
   PUSH     EDI
   PUSH     EBX

   TEST     EAX,      EAX
   MOV      Cardinal PTR [Sign],   0
   MOV      TempInt,  EAX
   MOV      EDI,      EDX
   SETS     Byte PTR [Sign]
   JZ       @@Zero
   FILD     TempInt
   FBSTP    [BCDChars]
   FWAIT
   MOV      ECX,      Cardinal PTR [BCDChars+4]
   TEST     ECX, $FF
   MOV      EBX,      [EDI]
   JNZ      @@MoreThan8Digits
   BSR      EAX,      Cardinal PTR [BCDChars]
   SHR      EAX,      2
   MOV      EDX,      [Sign]
   MOV      [NbChars], EAX
   LEA      EDX,      [EDX+EAX+1]
   TEST     EBX,      EBX
   JZ       @@Alloc1
   CMP      Cardinal PTR [EBX-8],  1
   JNE      @@Alloc1
   CMP      [EBX-4],  EDX
   JE       @@SizeOk1
@@Alloc1:
   MOV      EAX,      EDI
   CALL     System.@LStrSetLength
@@SizeOk1:
   MOV      EDI,      [EDI]
   TEST     Cardinal PTR [Sign],   1
   MOV      EAX,      [NBChars]
   JZ       @@Positive1
   MOV      Byte PTR [EDI], '-'
   LEA      EDI,      [EDI+1]
@@Positive1:
   XOR      EDX,      EDX
   SHR      EAX,      1
   JC       @@TwoDigits
   MOV      DL,       Byte PTR [BCDChars + EAX]
   OR       DL,       '0'
   TEST     EAX,      EAX
   MOV      Byte PTR [EDI], DL
   JZ       @@End
   DEC      EAX
   LEA      EDI,      [EDI+1]
@@TwoDigits:
   MOV      DL,       Byte PTR [BCDChars + EAX]
   MOV      CX,       Word PTR [DigitsTable + EDX*2]
   MOV      Word PTR [EDI], CX
   LEA      EDI,      [EDI+2]
   DEC      EAX
   JS       @@End
   JMP      @@TwoDigits
@@MoreThan8Digits:
   XOR      EAX,      EAX
   TEST     ECX,      $F0
   MOV      EDX,      [Sign]
   SETNZ    AL
   LEA      EDX,      [EDX+EAX+9]
   TEST     EBX,      EBX
   MOV      [NbChars], ECX
   JZ       @@Alloc2
   CMP      Cardinal PTR [EBX-8],  1
   JNE      @@Alloc2
   CMP      [EBX-4],  EDX
   JE       @@SizeOk2
@@Alloc2:
   MOV      EAX,      EDI
   CALL     System.@LStrSetLength
@@SizeOk2:
   MOV      EDI,      [EDI]
   TEST     Cardinal PTR [Sign],   1
   MOV      ECX,      [NbChars]
   JZ       @@Positive2
   MOV      Byte PTR [EDI], '-'
   LEA      EDI,      [EDI+1]
@@Positive2:
   XOR      EDX,      EDX
   TEST     ECX,      $F0
   MOV      EAX,      4
   JNZ      @@TwoDigits
   OR       CL,       '0'
   DEC      EAX
   MOV      Byte PTR [EDI], CL
   LEA      EDI,      [EDI+1]
   JMP      @@TwoDigits
@@Zero:
   MOV      EAX,      EDX
   MOV      EDX,      1
   CALL     System.@LStrSetLength
   MOV      EDI,      [EDI]
   MOV      Byte PTR  [EDI], '0'

@@End:
   POP      EBX
   POP      EDI
end;

function IntToStr_OUC_IA32_2_b(Value: Integer): string;
const
   DigitsTable: array [0..159] of array [0..1] of Char =
     ( '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '0A', '0B', '0C', '0D', '0E', '0F',
       '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '1A', '1B', '1C', '1D', '1E', '1F',
       '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '2A', '2B', '2C', '2D', '2E', '2F',
       '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '3A', '3B', '3C', '3D', '3E', '3F',
       '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '4A', '4B', '4C', '4D', '4E', '4F',
       '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '5A', '5B', '5C', '5D', '5E', '5F',
       '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '6A', '6B', '6C', '6D', '6E', '6F',
       '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '7A', '7B', '7C', '7D', '7E', '7F',
       '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '8A', '8B', '8C', '8D', '8E', '8F',
       '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '9A', '9B', '9C', '9D', '9E', '9F' );
var
   BCDChars: array [0..9] of Byte;
   TempInt: Integer;
   Sign: Cardinal;
   NbChars: Integer;
asm
   // EAX = Value
   // EDX = Address to string
   PUSH     EDI
   PUSH     EBX

   TEST     EAX,      EAX
   MOV      Cardinal PTR [Sign],   0
   MOV      TempInt,  EAX
   MOV      EDI,      EDX
   SETS     Byte PTR [Sign]
   JZ       @@Zero
   FILD     TempInt
   FBSTP    [BCDChars]
   FWAIT
   MOV      ECX,      Cardinal PTR [BCDChars+4]
   TEST     ECX, $FF
   MOV      EBX,      [EDI]
   JNZ      @@MoreThan8Digits
   BSR      EAX,      Cardinal PTR [BCDChars]
   SHR      EAX,      2
   MOV      EDX,      [Sign]
   MOV      [NbChars], EAX
   LEA      EDX,      [EDX+EAX+1]
   TEST     EBX,      EBX
   JZ       @@Alloc1
   CMP      Cardinal PTR [EBX-8],  1
   JNE      @@Alloc1
   CMP      [EBX-4],  EDX
   JE       @@SizeOk1
@@Alloc1:
   MOV      EAX,      EDI
   CALL     System.@LStrSetLength
@@SizeOk1:
   MOV      EDI,      [EDI]
   TEST     Cardinal PTR [Sign],   1
   MOV      EAX,      [NBChars]
   JZ       @@Positive1
   MOV      Byte PTR [EDI], '-'
   LEA      EDI,      [EDI+1]
@@Positive1:
   XOR      EDX,      EDX
   SHR      EAX,      1
   JC       @@TwoDigits
   MOV      DL,       Byte PTR [BCDChars + EAX]
   OR       DL,       '0'
   TEST     EAX,      EAX
   MOV      Byte PTR [EDI], DL
   JZ       @@End
   DEC      EAX
   LEA      EDI,      [EDI+1]
@@TwoDigits:
   MOV      DL,       Byte PTR [BCDChars + EAX]
   MOV      CX,       Word PTR [DigitsTable + EDX*2]
   MOV      Word PTR [EDI], CX
   LEA      EDI,      [EDI+2]
   DEC      EAX
   JS       @@End
   JMP      @@TwoDigits
@@MoreThan8Digits:
   XOR      EAX,      EAX
   TEST     ECX,      $F0
   MOV      EDX,      [Sign]
   SETNZ    AL
   LEA      EDX,      [EDX+EAX+9]
   TEST     EBX,      EBX
   MOV      [NbChars], ECX
   JZ       @@Alloc2
   CMP      Cardinal PTR [EBX-8],  1
   JNE      @@Alloc2
   CMP      [EBX-4],  EDX
   JE       @@SizeOk2
@@Alloc2:
   MOV      EAX,      EDI
   CALL     System.@LStrSetLength
@@SizeOk2:
   MOV      EDI,      [EDI]
   TEST     Cardinal PTR [Sign],   1
   MOV      ECX,      [NbChars]
   JZ       @@Positive2
   MOV      Byte PTR [EDI], '-'
   LEA      EDI,      [EDI+1]
@@Positive2:
   XOR      EDX,      EDX
   TEST     ECX,      $F0
   MOV      EAX,      4
   JNZ      @@TwoDigits
   OR       CL,       '0'
   DEC      EAX
   MOV      Byte PTR [EDI], CL
   LEA      EDI,      [EDI+1]
   JMP      @@TwoDigits
@@Zero:
   MOV      EAX,      EDX
   MOV      EDX,      1
   CALL     System.@LStrSetLength
   MOV      EDI,      [EDI]
   MOV      Byte PTR  [EDI], '0'

@@End:
   POP      EBX
   POP      EDI
end;

function IntToStr_OUC_IA32_2_c(Value: Integer): string;
const
   DigitsTable: array [0..159] of array [0..1] of Char =
     ( '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '0A', '0B', '0C', '0D', '0E', '0F',
       '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '1A', '1B', '1C', '1D', '1E', '1F',
       '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '2A', '2B', '2C', '2D', '2E', '2F',
       '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '3A', '3B', '3C', '3D', '3E', '3F',
       '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '4A', '4B', '4C', '4D', '4E', '4F',
       '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '5A', '5B', '5C', '5D', '5E', '5F',
       '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '6A', '6B', '6C', '6D', '6E', '6F',
       '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '7A', '7B', '7C', '7D', '7E', '7F',
       '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '8A', '8B', '8C', '8D', '8E', '8F',
       '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '9A', '9B', '9C', '9D', '9E', '9F' );
var
   BCDChars: array [0..9] of Byte;
   TempInt: Integer;
   Sign: Cardinal;
   NbChars: Integer;
asm
   // EAX = Value
   // EDX = Address to string
   PUSH     EDI
   PUSH     EBX

   TEST     EAX,      EAX
   MOV      Cardinal PTR [Sign],   0
   MOV      TempInt,  EAX
   MOV      EDI,      EDX
   SETS     Byte PTR [Sign]
   JZ       @@Zero
   FILD     TempInt
   FBSTP    [BCDChars]
   FWAIT
   MOV      ECX,      Cardinal PTR [BCDChars+4]
   TEST     ECX, $FF
   MOV      EBX,      [EDI]
   JNZ      @@MoreThan8Digits
   BSR      EAX,      Cardinal PTR [BCDChars]
   SHR      EAX,      2
   MOV      EDX,      [Sign]
   MOV      [NbChars], EAX
   LEA      EDX,      [EDX+EAX+1]
   TEST     EBX,      EBX
   JZ       @@Alloc1
   CMP      Cardinal PTR [EBX-8],  1
   JNE      @@Alloc1
   CMP      [EBX-4],  EDX
   JE       @@SizeOk1
@@Alloc1:
   MOV      EAX,      EDI
   CALL     System.@LStrSetLength
@@SizeOk1:
   MOV      EDI,      [EDI]
   TEST     Cardinal PTR [Sign],   1
   MOV      EAX,      [NBChars]
   JZ       @@Positive1
   MOV      Byte PTR [EDI], '-'
   LEA      EDI,      [EDI+1]
@@Positive1:
   XOR      EDX,      EDX
   SHR      EAX,      1
   JC       @@TwoDigits
   MOV      DL,       Byte PTR [BCDChars + EAX]
   OR       DL,       '0'
   TEST     EAX,      EAX
   MOV      Byte PTR [EDI], DL
   JZ       @@End
   DEC      EAX
   LEA      EDI,      [EDI+1]
@@TwoDigits:
   MOV      DL,       Byte PTR [BCDChars + EAX]
   MOV      CX,       Word PTR [DigitsTable + EDX*2]
   MOV      Word PTR [EDI], CX
   LEA      EDI,      [EDI+2]
   DEC      EAX
   JS       @@End
   JMP      @@TwoDigits
@@MoreThan8Digits:
   XOR      EAX,      EAX
   TEST     ECX,      $F0
   MOV      EDX,      [Sign]
   SETNZ    AL
   LEA      EDX,      [EDX+EAX+9]
   TEST     EBX,      EBX
   MOV      [NbChars], ECX
   JZ       @@Alloc2
   CMP      Cardinal PTR [EBX-8],  1
   JNE      @@Alloc2
   CMP      [EBX-4],  EDX
   JE       @@SizeOk2
@@Alloc2:
   MOV      EAX,      EDI
   CALL     System.@LStrSetLength
@@SizeOk2:
   MOV      EDI,      [EDI]
   TEST     Cardinal PTR [Sign],   1
   MOV      ECX,      [NbChars]
   JZ       @@Positive2
   MOV      Byte PTR [EDI], '-'
   LEA      EDI,      [EDI+1]
@@Positive2:
   XOR      EDX,      EDX
   TEST     ECX,      $F0
   MOV      EAX,      4
   JNZ      @@TwoDigits
   OR       CL,       '0'
   DEC      EAX
   MOV      Byte PTR [EDI], CL
   LEA      EDI,      [EDI+1]
   JMP      @@TwoDigits
@@Zero:
   MOV      EAX,      EDX
   MOV      EDX,      1
   CALL     System.@LStrSetLength
   MOV      EDI,      [EDI]
   MOV      Byte PTR  [EDI], '0'

@@End:
   POP      EBX
   POP      EDI
end;

function IntToStr_OUC_IA32_2_d(Value: Integer): string;
const
   DigitsTable: array [0..159] of array [0..1] of Char =
     ( '00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '0A', '0B', '0C', '0D', '0E', '0F',
       '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '1A', '1B', '1C', '1D', '1E', '1F',
       '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '2A', '2B', '2C', '2D', '2E', '2F',
       '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '3A', '3B', '3C', '3D', '3E', '3F',
       '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '4A', '4B', '4C', '4D', '4E', '4F',
       '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '5A', '5B', '5C', '5D', '5E', '5F',
       '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '6A', '6B', '6C', '6D', '6E', '6F',
       '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '7A', '7B', '7C', '7D', '7E', '7F',
       '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '8A', '8B', '8C', '8D', '8E', '8F',
       '90', '91', '92', '93', '94', '95', '96', '97', '98', '99', '9A', '9B', '9C', '9D', '9E', '9F' );
var
   BCDChars: array [0..9] of Byte;
   TempInt: Integer;
   Sign: Cardinal;
   NbChars: Integer;
asm
   // EAX = Value
   // EDX = Address to string
   PUSH     EDI
   PUSH     EBX

   TEST     EAX,      EAX
   MOV      Cardinal PTR [Sign],   0
   MOV      TempInt,  EAX
   MOV      EDI,      EDX
   SETS     Byte PTR [Sign]
   JZ       @@Zero
   FILD     TempInt
   FBSTP    [BCDChars]
   FWAIT
   MOV      ECX,      Cardinal PTR [BCDChars+4]
   TEST     ECX, $FF
   MOV      EBX,      [EDI]
   JNZ      @@MoreThan8Digits
   BSR      EAX,      Cardinal PTR [BCDChars]
   SHR      EAX,      2
   MOV      EDX,      [Sign]
   MOV      [NbChars], EAX
   LEA      EDX,      [EDX+EAX+1]
   TEST     EBX,      EBX
   JZ       @@Alloc1
   CMP      Cardinal PTR [EBX-8],  1
   JNE      @@Alloc1
   CMP      [EBX-4],  EDX
   JE       @@SizeOk1
@@Alloc1:
   MOV      EAX,      EDI
   CALL     System.@LStrSetLength
@@SizeOk1:
   MOV      EDI,      [EDI]
   TEST     Cardinal PTR [Sign],   1
   MOV      EAX,      [NBChars]
   JZ       @@Positive1
   MOV      Byte PTR [EDI], '-'
   LEA      EDI,      [EDI+1]
@@Positive1:
   XOR      EDX,      EDX
   SHR      EAX,      1
   JC       @@TwoDigits
   MOV      DL,       Byte PTR [BCDChars + EAX]
   OR       DL,       '0'
   TEST     EAX,      EAX
   MOV      Byte PTR [EDI], DL
   JZ       @@End
   DEC      EAX
   LEA      EDI,      [EDI+1]
@@TwoDigits:
   MOV      DL,       Byte PTR [BCDChars + EAX]
   MOV      CX,       Word PTR [DigitsTable + EDX*2]
   MOV      Word PTR [EDI], CX
   LEA      EDI,      [EDI+2]
   DEC      EAX
   JS       @@End
   JMP      @@TwoDigits
@@MoreThan8Digits:
   XOR      EAX,      EAX
   TEST     ECX,      $F0
   MOV      EDX,      [Sign]
   SETNZ    AL
   LEA      EDX,      [EDX+EAX+9]
   TEST     EBX,      EBX
   MOV      [NbChars], ECX
   JZ       @@Alloc2
   CMP      Cardinal PTR [EBX-8],  1
   JNE      @@Alloc2
   CMP      [EBX-4],  EDX
   JE       @@SizeOk2
@@Alloc2:
   MOV      EAX,      EDI
   CALL     System.@LStrSetLength
@@SizeOk2:
   MOV      EDI,      [EDI]
   TEST     Cardinal PTR [Sign],   1
   MOV      ECX,      [NbChars]
   JZ       @@Positive2
   MOV      Byte PTR [EDI], '-'
   LEA      EDI,      [EDI+1]
@@Positive2:
   XOR      EDX,      EDX
   TEST     ECX,      $F0
   MOV      EAX,      4
   JNZ      @@TwoDigits
   OR       CL,       '0'
   DEC      EAX
   MOV      Byte PTR [EDI], CL
   LEA      EDI,      [EDI+1]
   JMP      @@TwoDigits
@@Zero:
   MOV      EAX,      EDX
   MOV      EDX,      1
   CALL     System.@LStrSetLength
   MOV      EDI,      [EDI]
   MOV      Byte PTR  [EDI], '0'

@@End:
   POP      EBX
   POP      EDI
end;

initialization
begin
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_OUC_IA32_2_a', 'BCD unpacking, 2 at a time', @IntToStr_OUC_IA32_2_a, fccIA32, fcaOuc));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_OUC_IA32_2_b', 'BCD unpacking, 2 at a time', @IntToStr_OUC_IA32_2_b, fccIA32, fcaOuc));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_OUC_IA32_2_c', 'BCD unpacking, 2 at a time', @IntToStr_OUC_IA32_2_c, fccIA32, fcaOuc));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_OUC_IA32_2_d', 'BCD unpacking, 2 at a time', @IntToStr_OUC_IA32_2_d, fccIA32, fcaOuc));
end;

end.
