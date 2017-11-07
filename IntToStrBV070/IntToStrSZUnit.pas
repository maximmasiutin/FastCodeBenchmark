unit IntToStrSZUnit;

interface

uses
  FastcodeChallengeIntToStr32Unit,
  FastcodeChallengeUnit;

implementation

uses
  D5Support;

{$O+,R-,Q-}

function IntToStr_SZ_IA32_5_a(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net

const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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
ASM
  push    ebx
  push    edi
  push    esi

  mov     ebx, eax
  mov     edi, edx

  mov     ecx, 10              // Set length to 10

  and     ebx, 080000000h      // If negative value
  jz      @@P1
  inc     ecx                  // include negative sign
  neg     eax                  // absolute value

@@P1:
  cmp     eax, 080000000h      // If it is low(integer)
  je      @@CreateString       // go and create string

  cmp     eax, 1000000000-1  // 10 digits
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100000000-1   // 9 digits ...
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10000000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 1000000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 1000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10-1
  ja      @@CreateString

  dec     ecx               // 1 digit


@@CreateString:
  push    eax
  push    ebx
  push    ecx

  mov     eax, edi    // Result adres to eax
  mov     edx, ecx    // length to edx

  call    system.@LStrSetLength

  pop     ecx
  pop     ebx
  pop     eax

  mov     edi, [edi]

  and     ebx, ebx                // If negative
  jz      @@NonNegative2

  mov     [edi], byte ptr '-'     // Store '-'
  inc     edi
  dec     ecx

@@NonNegative2:
  add     edi, ecx                // Point to the end of string
  sub     edi, 2

@@Start:
  cmp     ecx, 1
  je   @@FinalDigitDirect

@@LOOP1:
   mov    ecx, 051EB851Fh

@@LOOP2:
   mov    ebx, eax        // Div100
   mul    ecx             // -/-
   shr    edx, 5          // -/-

   mov    eax, edx        //  Save result to EAX

   lea    edx, edx*4+edx  // Multiply with 100
   lea    edx, edx*4+edx  // -/-
   shl    edx, 2          // -/-
   sub    ebx, edx        // Find index for Digits2

   movzx  ebx, word ptr [Digits2 + ebx * 2]
   mov    [edi], bx
   sub    edi, 2

   cmp    eax, 9         // if V>9 then continue
   ja     @@LOOP2


@@FINALDIGIT:
   cmp    eax, 0         // If not exist
   jz     @@End          // go to the end

@@FinalDigitDirect:
   add    al, 48         // Save the last one
   mov    [edi + 1], al

@@End:
  pop    esi
  pop    edi
  pop    ebx
end;

function IntToStr_SZ_IA32_5_b(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net

const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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
ASM
  push    ebx
  push    edi
  push    esi

  mov     ebx, eax
  mov     edi, edx

  mov     ecx, 10              // Set length to 10

  and     ebx, 080000000h      // If negative value
  jz      @@P1
  inc     ecx                  // include negative sign
  neg     eax                  // absolute value

@@P1:
  cmp     eax, 080000000h      // If it is low(integer)
  je      @@CreateString       // go and create string

  cmp     eax, 1000000000-1  // 10 digits
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100000000-1   // 9 digits ...
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10000000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 1000000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 1000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10-1
  ja      @@CreateString

  dec     ecx               // 1 digit


@@CreateString:
  push    eax
  push    ebx
  push    ecx

  mov     eax, edi    // Result adres to eax
  mov     edx, ecx    // length to edx

  call    system.@LStrSetLength

  pop     ecx
  pop     ebx
  pop     eax

  mov     edi, [edi]

  and     ebx, ebx                // If negative
  jz      @@NonNegative2

  mov     [edi], byte ptr '-'     // Store '-'
  inc     edi
  dec     ecx

@@NonNegative2:
  add     edi, ecx                // Point to the end of string
  sub     edi, 2

@@Start:
  cmp     ecx, 1
  je   @@FinalDigitDirect

@@LOOP1:
   mov    ecx, 051EB851Fh

@@LOOP2:
   mov    ebx, eax        // Div100
   mul    ecx             // -/-
   shr    edx, 5          // -/-

   mov    eax, edx        //  Save result to EAX

   lea    edx, edx*4+edx  // Multiply with 100
   lea    edx, edx*4+edx  // -/-
   shl    edx, 2          // -/-
   sub    ebx, edx        // Find index for Digits2

   movzx  ebx, word ptr [Digits2 + ebx * 2]
   mov    [edi], bx
   sub    edi, 2

   cmp    eax, 9         // if V>9 then continue
   ja     @@LOOP2


@@FINALDIGIT:
   cmp    eax, 0         // If not exist
   jz     @@End          // go to the end

@@FinalDigitDirect:
   add    al, 48         // Save the last one
   mov    [edi + 1], al

@@End:
  pop    esi
  pop    edi
  pop    ebx
end;

function IntToStr_SZ_IA32_5_c(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net

const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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
ASM
  push    ebx
  push    edi
  push    esi

  mov     ebx, eax
  mov     edi, edx

  mov     ecx, 10              // Set length to 10

  and     ebx, 080000000h      // If negative value
  jz      @@P1
  inc     ecx                  // include negative sign
  neg     eax                  // absolute value

@@P1:
  cmp     eax, 080000000h      // If it is low(integer)
  je      @@CreateString       // go and create string

  cmp     eax, 1000000000-1  // 10 digits
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100000000-1   // 9 digits ...
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10000000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 1000000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 1000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10-1
  ja      @@CreateString

  dec     ecx               // 1 digit


@@CreateString:
  push    eax
  push    ebx
  push    ecx

  mov     eax, edi    // Result adres to eax
  mov     edx, ecx    // length to edx

  call    system.@LStrSetLength

  pop     ecx
  pop     ebx
  pop     eax

  mov     edi, [edi]

  and     ebx, ebx                // If negative
  jz      @@NonNegative2

  mov     [edi], byte ptr '-'     // Store '-'
  inc     edi
  dec     ecx

@@NonNegative2:
  add     edi, ecx                // Point to the end of string
  sub     edi, 2

@@Start:
  cmp     ecx, 1
  je   @@FinalDigitDirect

@@LOOP1:
   mov    ecx, 051EB851Fh

@@LOOP2:
   mov    ebx, eax        // Div100
   mul    ecx             // -/-
   shr    edx, 5          // -/-

   mov    eax, edx        //  Save result to EAX

   lea    edx, edx*4+edx  // Multiply with 100
   lea    edx, edx*4+edx  // -/-
   shl    edx, 2          // -/-
   sub    ebx, edx        // Find index for Digits2

   movzx  ebx, word ptr [Digits2 + ebx * 2]
   mov    [edi], bx
   sub    edi, 2

   cmp    eax, 9         // if V>9 then continue
   ja     @@LOOP2


@@FINALDIGIT:
   cmp    eax, 0         // If not exist
   jz     @@End          // go to the end

@@FinalDigitDirect:
   add    al, 48         // Save the last one
   mov    [edi + 1], al

@@End:
  pop    esi
  pop    edi
  pop    ebx
end;

function IntToStr_SZ_IA32_5_d(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net

const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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
ASM
  push    ebx
  push    edi
  push    esi

  mov     ebx, eax
  mov     edi, edx

  mov     ecx, 10              // Set length to 10

  and     ebx, 080000000h      // If negative value
  jz      @@P1
  inc     ecx                  // include negative sign
  neg     eax                  // absolute value

@@P1:
  cmp     eax, 080000000h      // If it is low(integer)
  je      @@CreateString       // go and create string

  cmp     eax, 1000000000-1  // 10 digits
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100000000-1   // 9 digits ...
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10000000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 1000000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 1000-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 100-1
  ja      @@CreateString

  dec     ecx
  cmp     eax, 10-1
  ja      @@CreateString

  dec     ecx               // 1 digit


@@CreateString:
  push    eax
  push    ebx
  push    ecx

  mov     eax, edi    // Result adres to eax
  mov     edx, ecx    // length to edx

  call    system.@LStrSetLength

  pop     ecx
  pop     ebx
  pop     eax

  mov     edi, [edi]

  and     ebx, ebx                // If negative
  jz      @@NonNegative2

  mov     [edi], byte ptr '-'     // Store '-'
  inc     edi
  dec     ecx

@@NonNegative2:
  add     edi, ecx                // Point to the end of string
  sub     edi, 2

@@Start:
  cmp     ecx, 1
  je   @@FinalDigitDirect

@@LOOP1:
   mov    ecx, 051EB851Fh

@@LOOP2:
   mov    ebx, eax        // Div100
   mul    ecx             // -/-
   shr    edx, 5          // -/-

   mov    eax, edx        //  Save result to EAX

   lea    edx, edx*4+edx  // Multiply with 100
   lea    edx, edx*4+edx  // -/-
   shl    edx, 2          // -/-
   sub    ebx, edx        // Find index for Digits2

   movzx  ebx, word ptr [Digits2 + ebx * 2]
   mov    [edi], bx
   sub    edi, 2

   cmp    eax, 9         // if V>9 then continue
   ja     @@LOOP2


@@FINALDIGIT:
   cmp    eax, 0         // If not exist
   jz     @@End          // go to the end

@@FinalDigitDirect:
   add    al, 48         // Save the last one
   mov    [edi + 1], al

@@End:
  pop    esi
  pop    edi
  pop    ebx
end;

function IntToStr_SZ_PAS_5_a(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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

var
  v,n,c: integer;
  w: PWord;
  Negative: Boolean;
begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  Negative:=Value <0;

  v:=abs(value);

  if v >= 1000000000 then c := 10 else
  if v >= 100000000  then c :=  9 else
  if v >= 10000000   then c :=  8 else
  if v >= 1000000    then c :=  7 else
  if v >= 100000     then c :=  6 else
  if v >= 10000      then c :=  5 else
  if v >= 1000       then c :=  4 else
  if v >= 100        then c :=  3 else
  if v >= 10         then c :=  2 else
  begin
    if Value = 0 then
    begin
      Result := '0';
      Exit;
    end;
    c := 1;
  end;


  if Negative then
  begin
     inc(c);
     SetLength(result,c);
     pchar(pointer(Result))^:= '-';
  end else
    SetLength(result,c);

  pchar(w):= pchar(pointer(Result))+ c-2;

  while v>9 do
  begin
    n:= v div 100;

    w^:=word(Digits2[v-n*100]);
    dec(w);
    v:=n;
  end;

  if v>0 then
    pchar(pchar(w)+1)^:=char(v+48);
end;

function Div100_a(Value:Cardinal):Cardinal;
ASM
  MOV EDX, 051EB851Fh
  MUL EDX
  SHR EDX, 5
  MOV EAX, EDX
end;

function IntToStr_SZ_PAS_3_a(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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

var
  v,n,c: integer;
  //w: PWord;
  Negative: Boolean;
  p: PChar;
begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  Negative:=Value <0;

  v:=abs(value);

  if v >= 1000000000 then c := 10 else
  if v >= 100000000  then c :=  9 else
  if v >= 10000000   then c :=  8 else
  if v >= 1000000    then c :=  7 else
  if v >= 100000     then c :=  6 else
  if v >= 10000      then c :=  5 else
  if v >= 1000       then c :=  4 else
  if v >= 100        then c :=  3 else
  if v >= 10         then c :=  2 else
  begin
    if Value = 0 then
    begin
      Result := '0';
      Exit;
    end;
    c := 1;
  end;

  if Negative then
  begin
     inc(c);
     SetLength(result,c);
     pchar(pointer(Result))^:= '-';
  end else
    SetLength(result,c);

  p:= pchar(pointer(Result))+c;
  dec(p);
  dec(p);

  while (v>9) do
  begin
    n:= integer(div100_a(v));

    pword(p)^:=word(Digits2[v-n*100]);
    dec(p);
    dec(p);

    v:=n;

  end;

  if v>0 then
    pchar(p+1)^:=char(v+48);
end;


function IntToStr_SZ_IA32_4_a(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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
ASM
  push    ebx
  push    edi
  push    esi

  mov     ebx, eax
  mov     edi, edx

  mov     ecx, 10              // Set length to 10

  and     ebx, 080000000h
  jz      @@P1
  inc     cl                   // include negative sign
  neg     eax                  // partial complement

@@P1:

  cmp     eax, 080000000h      // If it is low(integer)
  je      @@CreateString       // go and create string

@@DetectDigits:
@@d10:
   cmp    eax, 1000000000
   jl     @@d9
   jmp    @@d0
@@d9:
   dec    cl
   cmp    eax, 100000000
   jl     @@d8
   jmp    @@d0
@@d8:
   dec    cl
   cmp    eax, 10000000
   jl     @@d7
   jmp    @@d0
@@d7:
   dec    cl
   cmp    eax, 1000000
   jl     @@d6
   jmp    @@d0
@@d6:
   dec    cl
   cmp    eax, 100000
   jl     @@d5
   jmp    @@d0
@@d5:
   dec    cl
   cmp    eax, 10000
   jl     @@d4
   jmp    @@d0
@@d4:
   dec    cl
   cmp    eax, 1000
   jl     @@d3
   jmp    @@d0
@@d3:
   dec    cl
   cmp    eax, 100
   jl     @@d2
   jmp    @@d0
@@d2:
   dec    cl
   cmp    eax, 10
   jl     @@d1
   jmp    @@d0
@@d1:
   dec    cl

@@d0:


@@CreateString:
  push   eax
  push   ebx
  push   ecx

  mov    eax, edi
  mov    edx, ecx

  call  system.@LStrSetLength

  pop   ecx
  pop   ebx
  pop   eax

  mov   edi, [edi]

  and   ebx, ebx
  jz    @@NonNegative2
  mov   [edi], BYTE PTR '-'
  add   edi,ecx
  sub   edi, 2

  dec   ecx
  jmp @@Start

@@NonNegative2:
  add   edi,ecx
  sub   edi, 2

@@Start:
  cmp cl,1
  je @@FINALDIGITDIRECT

@@LOOP1:

@@LOOP2:
   mov    ebx,eax
   mov    edx, 051EB851Fh // Div100
   mul    edx             // -/-
   shr    edx, 5          // -/-

   mov    eax, edx        //  Save result to EAX

   LEA    EDX,EAX*4+EAX  // Multiply with 100
   LEA    EDX,EDX*4+EDX  //
   SHL    EDX, 2         //

   SUB    EBX,EDX        // Find index for Digits2 index

   MOVZX  EBX, WORD PTR [Digits2+EBX*2]
   MOV    [EDI], BX

   DEC    EDI
   DEC    EDI

   CMP    EAX, 9        //if V>9 then do
   JA     @@LOOP2

@@FINALDIGIT:

   cmp    eax, 0      // If exist, store last digit
   JE     @@END

@@FINALDIGITDIRECT:

   ADD    AL, 48      // Or save te last one
   MOV    [EDI+1], AL

@@END:

  pop    esi
  pop    edi
  pop    ebx

end;

function IntToStr_SZ_PAS_5_b(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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

var
  v,n,c: integer;
  w: PWord;
  Negative: Boolean;
begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  Negative:=Value <0;

  v:=abs(value);

  if v >= 1000000000 then c := 10 else
  if v >= 100000000  then c :=  9 else
  if v >= 10000000   then c :=  8 else
  if v >= 1000000    then c :=  7 else
  if v >= 100000     then c :=  6 else
  if v >= 10000      then c :=  5 else
  if v >= 1000       then c :=  4 else
  if v >= 100        then c :=  3 else
  if v >= 10         then c :=  2 else
  begin
    if Value = 0 then
    begin
      Result := '0';
      Exit;
    end;
    c := 1;
  end;


  if Negative then
  begin
     inc(c);
     SetLength(result,c);
     pchar(pointer(Result))^:= '-';
  end else
    SetLength(result,c);

  pchar(w):= pchar(pointer(Result))+ c-2;

  while v>9 do
  begin
    n:= v div 100;

    w^:=word(Digits2[v-n*100]);
    dec(w);
    v:=n;
  end;

  if v>0 then
    pchar(pchar(w)+1)^:=char(v+48);
end;

function Div100_b(Value:Cardinal):Cardinal;
ASM
  MOV EDX, 051EB851Fh
  MUL EDX
  SHR EDX, 5
  MOV EAX, EDX
end;

function IntToStr_SZ_PAS_3_b(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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

var
  v,n,c: integer;
  //w: PWord;
  Negative: Boolean;
  p: PChar;
begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  Negative:=Value <0;

  v:=abs(value);

  if v >= 1000000000 then c := 10 else
  if v >= 100000000  then c :=  9 else
  if v >= 10000000   then c :=  8 else
  if v >= 1000000    then c :=  7 else
  if v >= 100000     then c :=  6 else
  if v >= 10000      then c :=  5 else
  if v >= 1000       then c :=  4 else
  if v >= 100        then c :=  3 else
  if v >= 10         then c :=  2 else
  begin
    if Value = 0 then
    begin
      Result := '0';
      Exit;
    end;
    c := 1;
  end;

  if Negative then
  begin
     inc(c);
     SetLength(result,c);
     pchar(pointer(Result))^:= '-';
  end else
    SetLength(result,c);

  p:= pchar(pointer(Result))+c;
  dec(p);
  dec(p);

  while (v>9) do
  begin
    n:= integer(div100_b(v));

    pword(p)^:=word(Digits2[v-n*100]);
    dec(p);
    dec(p);

    v:=n;

  end;

  if v>0 then
    pchar(p+1)^:=char(v+48);
end;


function IntToStr_SZ_IA32_4_b(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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
ASM
  push    ebx
  push    edi
  push    esi

  mov     ebx, eax
  mov     edi, edx

  mov     ecx, 10              // Set length to 10

  and     ebx, 080000000h
  jz      @@P1     
  inc     cl                   // include negative sign
  neg     eax                  // partial complement

@@P1:

  cmp     eax, 080000000h      // If it is low(integer)
  je      @@CreateString       // go and create string

@@DetectDigits:
@@d10:
   cmp    eax, 1000000000
   jl     @@d9
   jmp    @@d0
@@d9:
   dec    cl
   cmp    eax, 100000000
   jl     @@d8
   jmp    @@d0
@@d8:
   dec    cl
   cmp    eax, 10000000
   jl     @@d7
   jmp    @@d0
@@d7:
   dec    cl
   cmp    eax, 1000000
   jl     @@d6
   jmp    @@d0
@@d6:
   dec    cl
   cmp    eax, 100000
   jl     @@d5
   jmp    @@d0
@@d5:
   dec    cl
   cmp    eax, 10000
   jl     @@d4
   jmp    @@d0
@@d4:
   dec    cl
   cmp    eax, 1000
   jl     @@d3
   jmp    @@d0
@@d3:
   dec    cl
   cmp    eax, 100
   jl     @@d2
   jmp    @@d0
@@d2:
   dec    cl
   cmp    eax, 10
   jl     @@d1
   jmp    @@d0
@@d1:
   dec    cl

@@d0:


@@CreateString:
  push   eax
  push   ebx
  push   ecx

  mov    eax, edi
  mov    edx, ecx

  call  system.@LStrSetLength

  pop   ecx
  pop   ebx
  pop   eax

  mov   edi, [edi]

  and   ebx, ebx
  jz    @@NonNegative2
  mov   [edi], BYTE PTR '-'
  add   edi,ecx
  sub   edi, 2

  dec   ecx
  jmp @@Start

@@NonNegative2:
  add   edi,ecx
  sub   edi, 2

@@Start:
  cmp cl,1
  je @@FINALDIGITDIRECT

@@LOOP1:

@@LOOP2:
   mov    ebx,eax
   mov    edx, 051EB851Fh // Div100
   mul    edx             // -/-
   shr    edx, 5          // -/-

   mov    eax, edx        //  Save result to EAX

   LEA    EDX,EAX*4+EAX  // Multiply with 100
   LEA    EDX,EDX*4+EDX  //
   SHL    EDX, 2         //

   SUB    EBX,EDX        // Find index for Digits2 index

   MOVZX  EBX, WORD PTR [Digits2+EBX*2]
   MOV    [EDI], BX

   DEC    EDI
   DEC    EDI

   CMP    EAX, 9        //if V>9 then do
   JA     @@LOOP2

@@FINALDIGIT:

   cmp    eax, 0      // If exist, store last digit
   JE     @@END

@@FINALDIGITDIRECT:

   ADD    AL, 48      // Or save te last one
   MOV    [EDI+1], AL

@@END:

  pop    esi
  pop    edi
  pop    ebx

end;

function IntToStr_SZ_PAS_5_c(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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

var
  v,n,c: integer;
  w: PWord;
  Negative: Boolean;
begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  Negative:=Value <0;

  v:=abs(value);

  if v >= 1000000000 then c := 10 else
  if v >= 100000000  then c :=  9 else
  if v >= 10000000   then c :=  8 else
  if v >= 1000000    then c :=  7 else
  if v >= 100000     then c :=  6 else
  if v >= 10000      then c :=  5 else
  if v >= 1000       then c :=  4 else
  if v >= 100        then c :=  3 else
  if v >= 10         then c :=  2 else
  begin
    if Value = 0 then
    begin
      Result := '0';
      Exit;
    end;
    c := 1;
  end;


  if Negative then
  begin
     inc(c);
     SetLength(result,c);
     pchar(pointer(Result))^:= '-';
  end else
    SetLength(result,c);

  pchar(w):= pchar(pointer(Result))+ c-2;

  while v>9 do
  begin
    n:= v div 100;

    w^:=word(Digits2[v-n*100]);
    dec(w);
    v:=n;
  end;

  if v>0 then
    pchar(pchar(w)+1)^:=char(v+48);
end;

function Div100_c(Value:Cardinal):Cardinal;
ASM
  MOV EDX, 051EB851Fh
  MUL EDX
  SHR EDX, 5
  MOV EAX, EDX
end;

function IntToStr_SZ_PAS_3_c(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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

var
  v,n,c: integer;
  //w: PWord;
  Negative: Boolean;
  p: PChar;
begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  Negative:=Value <0;

  v:=abs(value);

  if v >= 1000000000 then c := 10 else
  if v >= 100000000  then c :=  9 else
  if v >= 10000000   then c :=  8 else
  if v >= 1000000    then c :=  7 else
  if v >= 100000     then c :=  6 else
  if v >= 10000      then c :=  5 else
  if v >= 1000       then c :=  4 else
  if v >= 100        then c :=  3 else
  if v >= 10         then c :=  2 else
  begin
    if Value = 0 then
    begin
      Result := '0';
      Exit;
    end;
    c := 1;
  end;

  if Negative then
  begin
     inc(c);
     SetLength(result,c);
     pchar(pointer(Result))^:= '-';
  end else
    SetLength(result,c);

  p:= pchar(pointer(Result))+c;
  dec(p);
  dec(p);

  while (v>9) do
  begin
    n:= integer(div100_c(v));

    pword(p)^:=word(Digits2[v-n*100]);
    dec(p);
    dec(p);

    v:=n;

  end;

  if v>0 then
    pchar(p+1)^:=char(v+48);
end;


function IntToStr_SZ_IA32_4_c(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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
ASM
  push    ebx
  push    edi
  push    esi

  mov     ebx, eax
  mov     edi, edx

  mov     ecx, 10              // Set length to 10

  and     ebx, 080000000h
  jz      @@P1     
  inc     cl                   // include negative sign
  neg     eax                  // partial complement

@@P1:

  cmp     eax, 080000000h      // If it is low(integer)
  je      @@CreateString       // go and create string

@@DetectDigits:
@@d10:
   cmp    eax, 1000000000
   jl     @@d9
   jmp    @@d0
@@d9:
   dec    cl
   cmp    eax, 100000000
   jl     @@d8
   jmp    @@d0
@@d8:
   dec    cl
   cmp    eax, 10000000
   jl     @@d7
   jmp    @@d0
@@d7:
   dec    cl
   cmp    eax, 1000000
   jl     @@d6
   jmp    @@d0
@@d6:
   dec    cl
   cmp    eax, 100000
   jl     @@d5
   jmp    @@d0
@@d5:
   dec    cl
   cmp    eax, 10000
   jl     @@d4
   jmp    @@d0
@@d4:
   dec    cl
   cmp    eax, 1000
   jl     @@d3
   jmp    @@d0
@@d3:
   dec    cl
   cmp    eax, 100
   jl     @@d2
   jmp    @@d0
@@d2:
   dec    cl
   cmp    eax, 10
   jl     @@d1
   jmp    @@d0
@@d1:
   dec    cl

@@d0:


@@CreateString:
  push   eax
  push   ebx
  push   ecx

  mov    eax, edi
  mov    edx, ecx

  call  system.@LStrSetLength

  pop   ecx
  pop   ebx
  pop   eax

  mov   edi, [edi]

  and   ebx, ebx
  jz    @@NonNegative2
  mov   [edi], BYTE PTR '-'
  add   edi,ecx
  sub   edi, 2

  dec   ecx
  jmp @@Start

@@NonNegative2:
  add   edi,ecx
  sub   edi, 2

@@Start:
  cmp cl,1
  je @@FINALDIGITDIRECT

@@LOOP1:

@@LOOP2:
   mov    ebx,eax
   mov    edx, 051EB851Fh // Div100
   mul    edx             // -/-
   shr    edx, 5          // -/-

   mov    eax, edx        //  Save result to EAX

   LEA    EDX,EAX*4+EAX  // Multiply with 100
   LEA    EDX,EDX*4+EDX  //
   SHL    EDX, 2         //

   SUB    EBX,EDX        // Find index for Digits2 index

   MOVZX  EBX, WORD PTR [Digits2+EBX*2]
   MOV    [EDI], BX

   DEC    EDI
   DEC    EDI

   CMP    EAX, 9        //if V>9 then do
   JA     @@LOOP2

@@FINALDIGIT:

   cmp    eax, 0      // If exist, store last digit
   JE     @@END

@@FINALDIGITDIRECT:

   ADD    AL, 48      // Or save te last one
   MOV    [EDI+1], AL

@@END:

  pop    esi
  pop    edi
  pop    ebx

end;

function IntToStr_SZ_PAS_5_d(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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

var
  v,n,c: integer;
  w: PWord;
  Negative: Boolean;
begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  Negative:=Value <0;

  v:=abs(value);

  if v >= 1000000000 then c := 10 else
  if v >= 100000000  then c :=  9 else
  if v >= 10000000   then c :=  8 else
  if v >= 1000000    then c :=  7 else
  if v >= 100000     then c :=  6 else
  if v >= 10000      then c :=  5 else
  if v >= 1000       then c :=  4 else
  if v >= 100        then c :=  3 else
  if v >= 10         then c :=  2 else
  begin
    if Value = 0 then
    begin
      Result := '0';
      Exit;
    end;
    c := 1;
  end;


  if Negative then
  begin
     inc(c);
     SetLength(result,c);
     pchar(pointer(Result))^:= '-';
  end else
    SetLength(result,c);

  pchar(w):= pchar(pointer(Result))+ c-2;

  while v>9 do
  begin
    n:= v div 100;

    w^:=word(Digits2[v-n*100]);
    dec(w);
    v:=n;
  end;

  if v>0 then
    pchar(pchar(w)+1)^:=char(v+48);
end;

function Div100_d(Value:Cardinal):Cardinal;
ASM
  MOV EDX, 051EB851Fh
  MUL EDX
  SHR EDX, 5
  MOV EAX, EDX
end;

function IntToStr_SZ_PAS_3_d(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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

var
  v,n,c: integer;
  //w: PWord;
  Negative: Boolean;
  p: PChar;
begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  Negative:=Value <0;

  v:=abs(value);

  if v >= 1000000000 then c := 10 else
  if v >= 100000000  then c :=  9 else
  if v >= 10000000   then c :=  8 else
  if v >= 1000000    then c :=  7 else
  if v >= 100000     then c :=  6 else
  if v >= 10000      then c :=  5 else
  if v >= 1000       then c :=  4 else
  if v >= 100        then c :=  3 else
  if v >= 10         then c :=  2 else
  begin
    if Value = 0 then
    begin
      Result := '0';
      Exit;
    end;
    c := 1;
  end;

  if Negative then
  begin
     inc(c);
     SetLength(result,c);
     pchar(pointer(Result))^:= '-';
  end else
    SetLength(result,c);

  p:= pchar(pointer(Result))+c;
  dec(p);
  dec(p);

  while (v>9) do
  begin
    n:= integer(div100_d(v));

    pword(p)^:=word(Digits2[v-n*100]);
    dec(p);
    dec(p);

    v:=n;

  end;

  if v>0 then
    pchar(p+1)^:=char(v+48);
end;


function IntToStr_SZ_IA32_4_d(Value: Integer): string;
// 'Common sence' solution
// Author: Sasa Zeman
// Web site: www.szutils.net
// E-mail  : public@szutils.net
const
  Digits2 : packed array[0..99] of array[1..2] of Char =
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
ASM
  push    ebx
  push    edi
  push    esi

  mov     ebx, eax
  mov     edi, edx

  mov     ecx, 10              // Set length to 10

  and     ebx, 080000000h
  jz      @@P1     
  inc     cl                   // include negative sign
  neg     eax                  // partial complement

@@P1:

  cmp     eax, 080000000h      // If it is low(integer)
  je      @@CreateString       // go and create string

@@DetectDigits:
@@d10:
   cmp    eax, 1000000000
   jl     @@d9
   jmp    @@d0
@@d9:
   dec    cl
   cmp    eax, 100000000
   jl     @@d8
   jmp    @@d0
@@d8:
   dec    cl
   cmp    eax, 10000000
   jl     @@d7
   jmp    @@d0
@@d7:
   dec    cl
   cmp    eax, 1000000
   jl     @@d6
   jmp    @@d0
@@d6:
   dec    cl
   cmp    eax, 100000
   jl     @@d5
   jmp    @@d0
@@d5:
   dec    cl
   cmp    eax, 10000
   jl     @@d4
   jmp    @@d0
@@d4:
   dec    cl
   cmp    eax, 1000
   jl     @@d3
   jmp    @@d0
@@d3:
   dec    cl
   cmp    eax, 100
   jl     @@d2
   jmp    @@d0
@@d2:
   dec    cl
   cmp    eax, 10
   jl     @@d1
   jmp    @@d0
@@d1:
   dec    cl

@@d0:


@@CreateString:
  push   eax
  push   ebx
  push   ecx

  mov    eax, edi
  mov    edx, ecx

  call  system.@LStrSetLength

  pop   ecx
  pop   ebx
  pop   eax

  mov   edi, [edi]

  and   ebx, ebx
  jz    @@NonNegative2
  mov   [edi], BYTE PTR '-'
  add   edi,ecx
  sub   edi, 2

  dec   ecx
  jmp @@Start

@@NonNegative2:
  add   edi,ecx
  sub   edi, 2

@@Start:
  cmp cl,1
  je @@FINALDIGITDIRECT

@@LOOP1:

@@LOOP2:
   mov    ebx,eax
   mov    edx, 051EB851Fh // Div100
   mul    edx             // -/-
   shr    edx, 5          // -/-

   mov    eax, edx        //  Save result to EAX

   LEA    EDX,EAX*4+EAX  // Multiply with 100
   LEA    EDX,EDX*4+EDX  //
   SHL    EDX, 2         //

   SUB    EBX,EDX        // Find index for Digits2 index

   MOVZX  EBX, WORD PTR [Digits2+EBX*2]
   MOV    [EDI], BX

   DEC    EDI
   DEC    EDI

   CMP    EAX, 9        //if V>9 then do
   JA     @@LOOP2

@@FINALDIGIT:

   cmp    eax, 0      // If exist, store last digit
   JE     @@END

@@FINALDIGITDIRECT:

   ADD    AL, 48      // Or save te last one
   MOV    [EDI+1], AL

@@END:

  pop    esi
  pop    edi
  pop    ebx

end;

initialization
begin
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_PAS_5_a', '', @IntToStr_SZ_PAS_5_a, fccPas, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_PAS_3_a', '', @IntToStr_SZ_PAS_3_a, fccPas, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_IA32_4_a', '', @IntToStr_SZ_IA32_4_a, fccIA32, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_PAS_5_b', '', @IntToStr_SZ_PAS_5_b, fccPas, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_PAS_3_b', '', @IntToStr_SZ_PAS_3_b, fccPas, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_IA32_4_b', '', @IntToStr_SZ_IA32_4_b, fccIA32, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_PAS_5_c', '', @IntToStr_SZ_PAS_5_c, fccPas, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_PAS_3_c', '', @IntToStr_SZ_PAS_3_c, fccPas, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_IA32_4_c', '', @IntToStr_SZ_IA32_4_c, fccIA32, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_PAS_5_d', '', @IntToStr_SZ_PAS_5_d, fccPas, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_PAS_3_d', '', @IntToStr_SZ_PAS_3_d, fccIA32, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_IA32_4_d', '', @IntToStr_SZ_IA32_4_d, fccIA32, fcaSZ));

  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_IA32_5_a', '', @IntToStr_SZ_IA32_5_a, fccIA32, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_IA32_5_b', '', @IntToStr_SZ_IA32_5_b, fccIA32, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_IA32_5_c', '', @IntToStr_SZ_IA32_5_c, fccIA32, fcaSZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_SZ_IA32_5_d', '', @IntToStr_SZ_IA32_5_d, fccIA32, fcaSZ));
end;

end.


