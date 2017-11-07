unit UpperCaseSHAUnit;

interface

//All these functions removed 28.07.2006 because failing in validation 13
//function UpperCase_Sha_Pas_5_a(const s: string): string;
//function UpperCase_Sha_Pas_5_b(const s: string): string;
//function UpperCase_Sha_Pas_5_c(const s: string): string;
//function UpperCase_Sha_Pas_5_d(const s: string): string;
//function UpperCase_Sha_Pas_6_a(const s: string): string;
//function UpperCase_Sha_Pas_6_b(const s: string): string;
//function UpperCase_Sha_Pas_6_c(const s: string): string;
//function UpperCase_Sha_Pas_6_d(const s: string): string;
//function UpperCase_Sha_IA32_5_a(const s: string): string;
//function UpperCase_Sha_IA32_5_b(const s: string): string;
//function UpperCase_Sha_IA32_5_c(const s: string): string;
//function UpperCase_Sha_IA32_5_d(const s: string): string;
//function UpperCase_Sha_IA32_6_a(const s: string): string;
//function UpperCase_Sha_IA32_6_b(const s: string): string;
//function UpperCase_Sha_IA32_6_c(const s: string): string;
//function UpperCase_Sha_IA32_6_d(const s: string): string;

implementation

//function UpperCase_Sha_IA32_5_a(const s: string): string;
//asm
//       push  ebx
//       push  esi
//       push  edi
//       mov   esi, eax          // s
//       mov   eax, edx
//       test  esi, esi
//       jz    @nil
//       mov   edx, [esi-4]      // Length(s)
//       mov   edi, eax          // @Result
//       test  edx, edx
//       jle   @nil
//       mov   ebx, edx
//       test  edx, 3
//       jz    @LengthOk         // Jump if Length mod 4 = 0
//       or    edx, 3            // Else requre Length mod 4 = 3
//@LengthOk:
//       call  System.@LStrSetLength
//       mov   edi, [edi]        // Result
//       mov   [edi-4], ebx      // Correct Result length
//       add   ebx, -1
//       and   ebx, -4
//       mov   eax, [ebx+esi]
//
//@loop: mov   ecx, eax
//       or    eax, $80808080    // $E1..$FA
//       mov   edx, eax
//       sub   eax, $7B7B7B7B    // $66..$7F
//       xor   edx, ecx          // $80
//       or    eax, $80808080    // $E6..$FF
//       sub   eax, $66666666    // $80..$99
//       and   eax, edx          // $80
//       shr   eax, 2            // $20
//       xor   eax, ecx          // Upper
//       mov   [ebx+edi], eax
//       mov   eax, [ebx+esi-4]
//       sub   ebx, 4
//       jge   @loop
//
//       pop   edi
//       pop   esi
//       pop   ebx
//       ret
//
//@nil:  pop   edi
//       pop   esi
//       pop   ebx
//       jmp    System.@LStrClr   // Result:=''
//       end;
//
//procedure Filler1;
//asm
// nop
//end;
//
//function UpperCase_Sha_IA32_5_b(const s: string): string;
//asm
//       push  ebx
//       push  esi
//       push  edi
//       mov   esi, eax          // s
//       mov   eax, edx
//       test  esi, esi
//       jz    @nil
//       mov   edx, [esi-4]      // Length(s)
//       mov   edi, eax          // @Result
//       test  edx, edx
//       jle   @nil
//       mov   ebx, edx
//       test  edx, 3
//       jz    @LengthOk         // Jump if Length mod 4 = 0
//       or    edx, 3            // Else requre Length mod 4 = 3
//@LengthOk:
//       call  System.@LStrSetLength
//       mov   edi, [edi]        // Result
//       mov   [edi-4], ebx      // Correct Result length
//       add   ebx, -1
//       and   ebx, -4
//       mov   eax, [ebx+esi]
//
//@loop: mov   ecx, eax
//       or    eax, $80808080    // $E1..$FA
//       mov   edx, eax
//       sub   eax, $7B7B7B7B    // $66..$7F
//       xor   edx, ecx          // $80
//       or    eax, $80808080    // $E6..$FF
//       sub   eax, $66666666    // $80..$99
//       and   eax, edx          // $80
//       shr   eax, 2            // $20
//       xor   eax, ecx          // Upper
//       mov   [ebx+edi], eax
//       mov   eax, [ebx+esi-4]
//       sub   ebx, 4
//       jge   @loop
//
//       pop   edi
//       pop   esi
//       pop   ebx
//       ret
//
//@nil:  pop   edi
//       pop   esi
//       pop   ebx
//       jmp    System.@LStrClr   // Result:=''
//       end;
//
//procedure Filler2;
//asm
// nop
//end;
//
//function UpperCase_Sha_IA32_5_c(const s: string): string;
//asm
//       push  ebx
//       push  esi
//       push  edi
//       mov   esi, eax          // s
//       mov   eax, edx
//       test  esi, esi
//       jz    @nil
//       mov   edx, [esi-4]      // Length(s)
//       mov   edi, eax          // @Result
//       test  edx, edx
//       jle   @nil
//       mov   ebx, edx
//       test  edx, 3
//       jz    @LengthOk         // Jump if Length mod 4 = 0
//       or    edx, 3            // Else requre Length mod 4 = 3
//@LengthOk:
//       call  System.@LStrSetLength
//       mov   edi, [edi]        // Result
//       mov   [edi-4], ebx      // Correct Result length
//       add   ebx, -1
//       and   ebx, -4
//       mov   eax, [ebx+esi]
//
//@loop: mov   ecx, eax
//       or    eax, $80808080    // $E1..$FA
//       mov   edx, eax
//       sub   eax, $7B7B7B7B    // $66..$7F
//       xor   edx, ecx          // $80
//       or    eax, $80808080    // $E6..$FF
//       sub   eax, $66666666    // $80..$99
//       and   eax, edx          // $80
//       shr   eax, 2            // $20
//       xor   eax, ecx          // Upper
//       mov   [ebx+edi], eax
//       mov   eax, [ebx+esi-4]
//       sub   ebx, 4
//       jge   @loop
//
//       pop   edi
//       pop   esi
//       pop   ebx
//       ret
//
//@nil:  pop   edi
//       pop   esi
//       pop   ebx
//       jmp    System.@LStrClr   // Result:=''
//       end;
//
//procedure Filler3;
//asm
// nop
//end;
//
//function UpperCase_Sha_IA32_5_d(const s: string): string;
//asm
//       push  ebx
//       push  esi
//       push  edi
//       mov   esi, eax          // s
//       mov   eax, edx
//       test  esi, esi
//       jz    @nil
//       mov   edx, [esi-4]      // Length(s)
//       mov   edi, eax          // @Result
//       test  edx, edx
//       jle   @nil
//       mov   ebx, edx
//       test  edx, 3
//       jz    @LengthOk         // Jump if Length mod 4 = 0
//       or    edx, 3            // Else requre Length mod 4 = 3
//@LengthOk:
//       call  System.@LStrSetLength
//       mov   edi, [edi]        // Result
//       mov   [edi-4], ebx      // Correct Result length
//       add   ebx, -1
//       and   ebx, -4
//       mov   eax, [ebx+esi]
//
//@loop: mov   ecx, eax
//       or    eax, $80808080    // $E1..$FA
//       mov   edx, eax
//       sub   eax, $7B7B7B7B    // $66..$7F
//       xor   edx, ecx          // $80
//       or    eax, $80808080    // $E6..$FF
//       sub   eax, $66666666    // $80..$99
//       and   eax, edx          // $80
//       shr   eax, 2            // $20
//       xor   eax, ecx          // Upper
//       mov   [ebx+edi], eax
//       mov   eax, [ebx+esi-4]
//       sub   ebx, 4
//       jge   @loop
//
//       pop   edi
//       pop   esi
//       pop   ebx
//       ret
//
//@nil:  pop   edi
//       pop   esi
//       pop   ebx
//       jmp    System.@LStrClr   // Result:=''
//       end;
//
//function UpperCase_Sha_IA32_6_a(const s: string): string;
//asm
//       push  ebx
//       push  esi
//       push  edi
//       mov   esi, eax          // s
//       mov   eax, edx
//       test  esi, esi
//       jz    @Nil
//       mov   edx, [esi-4]      // Length(s)
//       mov   edi, eax          // @Result
//       test  edx, edx
//       jle   @Nil
//       mov   ecx, [eax]
//       mov   ebx, edx
//       test  ecx, ecx
//       jz    @Realloc          // Jump if Result not allocated
//       test  edx, 3
//       jnz   @Length3
//       xor   edx, [ecx-4]
//       cmp   edx, 3
//       jbe   @TestRef
//       jmp   @Realloc
//@Length3:
//       or    edx, 2
//       xor   edx, [ecx-4]
//       cmp   edx, 1
//       ja    @Realloc
//@TestRef:
//       cmp   [ecx-8], 1
//       je    @LengthOK         // Jump if Result RefCt=1
//@Realloc:
//       mov   edx, ebx
//       or    edx, 3
//       call  System.@LStrSetLength
//@LengthOK:
//       mov   edi, [edi]        // Result
//       mov   [edi-4], ebx      // Correct Result length
//       mov   byte ptr [ebx+edi], 0
//       add   ebx, -1
//       and   ebx, -4
//       mov   eax, [ebx+esi]
//
//@Loop: mov   ecx, eax
//       or    eax, $80808080    // $E1..$FA
//       mov   edx, eax
//       sub   eax, $7B7B7B7B    // $66..$7F
//       xor   edx, ecx          // $80
//       or    eax, $80808080    // $E6..$FF
//       sub   eax, $66666666    // $80..$99
//       and   eax, edx          // $80
//       shr   eax, 2            // $20
//       xor   eax, ecx          // Upper
//       mov   [ebx+edi], eax
//       mov   eax, [ebx+esi-4]
//       sub   ebx, 4
//       jge   @Loop
//
//       pop   edi
//       pop   esi
//       pop   ebx
//       ret
//
//@Nil:  pop   edi
//       pop   esi
//       pop   ebx
//       jmp    System.@LStrClr   // Result:=''
//       end;
//
//function UpperCase_Sha_IA32_6_b(const s: string): string;
//asm
//       push  ebx
//       push  esi
//       push  edi
//       mov   esi, eax          // s
//       mov   eax, edx
//       test  esi, esi
//       jz    @Nil
//       mov   edx, [esi-4]      // Length(s)
//       mov   edi, eax          // @Result
//       test  edx, edx
//       jle   @Nil
//       mov   ecx, [eax]
//       mov   ebx, edx
//       test  ecx, ecx
//       jz    @Realloc          // Jump if Result not allocated
//       test  edx, 3
//       jnz   @Length3
//       xor   edx, [ecx-4]
//       cmp   edx, 3
//       jbe   @TestRef
//       jmp   @Realloc
//@Length3:
//       or    edx, 2
//       xor   edx, [ecx-4]
//       cmp   edx, 1
//       ja    @Realloc
//@TestRef:
//       cmp   [ecx-8], 1
//       je    @LengthOK         // Jump if Result RefCt=1
//@Realloc:
//       mov   edx, ebx
//       or    edx, 3
//       call  System.@LStrSetLength
//@LengthOK:
//       mov   edi, [edi]        // Result
//       mov   [edi-4], ebx      // Correct Result length
//       mov   byte ptr [ebx+edi], 0
//       add   ebx, -1
//       and   ebx, -4
//       mov   eax, [ebx+esi]
//
//@Loop: mov   ecx, eax
//       or    eax, $80808080    // $E1..$FA
//       mov   edx, eax
//       sub   eax, $7B7B7B7B    // $66..$7F
//       xor   edx, ecx          // $80
//       or    eax, $80808080    // $E6..$FF
//       sub   eax, $66666666    // $80..$99
//       and   eax, edx          // $80
//       shr   eax, 2            // $20
//       xor   eax, ecx          // Upper
//       mov   [ebx+edi], eax
//       mov   eax, [ebx+esi-4]
//       sub   ebx, 4
//       jge   @Loop
//
//       pop   edi
//       pop   esi
//       pop   ebx
//       ret
//
//@Nil:  pop   edi
//       pop   esi
//       pop   ebx
//       jmp    System.@LStrClr   // Result:=''
//       end;
//
//function UpperCase_Sha_IA32_6_c(const s: string): string;
//asm
//       push  ebx
//       push  esi
//       push  edi
//       mov   esi, eax          // s
//       mov   eax, edx
//       test  esi, esi
//       jz    @Nil
//       mov   edx, [esi-4]      // Length(s)
//       mov   edi, eax          // @Result
//       test  edx, edx
//       jle   @Nil
//       mov   ecx, [eax]
//       mov   ebx, edx
//       test  ecx, ecx
//       jz    @Realloc          // Jump if Result not allocated
//       test  edx, 3
//       jnz   @Length3
//       xor   edx, [ecx-4]
//       cmp   edx, 3
//       jbe   @TestRef
//       jmp   @Realloc
//@Length3:
//       or    edx, 2
//       xor   edx, [ecx-4]
//       cmp   edx, 1
//       ja    @Realloc
//@TestRef:
//       cmp   [ecx-8], 1
//       je    @LengthOK         // Jump if Result RefCt=1
//@Realloc:
//       mov   edx, ebx
//       or    edx, 3
//       call  System.@LStrSetLength
//@LengthOK:
//       mov   edi, [edi]        // Result
//       mov   [edi-4], ebx      // Correct Result length
//       mov   byte ptr [ebx+edi], 0
//       add   ebx, -1
//       and   ebx, -4
//       mov   eax, [ebx+esi]
//
//@Loop: mov   ecx, eax
//       or    eax, $80808080    // $E1..$FA
//       mov   edx, eax
//       sub   eax, $7B7B7B7B    // $66..$7F
//       xor   edx, ecx          // $80
//       or    eax, $80808080    // $E6..$FF
//       sub   eax, $66666666    // $80..$99
//       and   eax, edx          // $80
//       shr   eax, 2            // $20
//       xor   eax, ecx          // Upper
//       mov   [ebx+edi], eax
//       mov   eax, [ebx+esi-4]
//       sub   ebx, 4
//       jge   @Loop
//
//       pop   edi
//       pop   esi
//       pop   ebx
//       ret
//
//@Nil:  pop   edi
//       pop   esi
//       pop   ebx
//       jmp    System.@LStrClr   // Result:=''
//       end;
//
//function UpperCase_Sha_IA32_6_d(const s: string): string;
//asm
//       push  ebx
//       push  esi
//       push  edi
//       mov   esi, eax          // s
//       mov   eax, edx
//       test  esi, esi
//       jz    @Nil
//       mov   edx, [esi-4]      // Length(s)
//       mov   edi, eax          // @Result
//       test  edx, edx
//       jle   @Nil
//       mov   ecx, [eax]
//       mov   ebx, edx
//       test  ecx, ecx
//       jz    @Realloc          // Jump if Result not allocated
//       test  edx, 3
//       jnz   @Length3
//       xor   edx, [ecx-4]
//       cmp   edx, 3
//       jbe   @TestRef
//       jmp   @Realloc
//@Length3:
//       or    edx, 2
//       xor   edx, [ecx-4]
//       cmp   edx, 1
//       ja    @Realloc
//@TestRef:
//       cmp   [ecx-8], 1
//       je    @LengthOK         // Jump if Result RefCt=1
//@Realloc:
//       mov   edx, ebx
//       or    edx, 3
//       call  System.@LStrSetLength
//@LengthOK:
//       mov   edi, [edi]        // Result
//       mov   [edi-4], ebx      // Correct Result length
//       mov   byte ptr [ebx+edi], 0
//       add   ebx, -1
//       and   ebx, -4
//       mov   eax, [ebx+esi]
//
//@Loop: mov   ecx, eax
//       or    eax, $80808080    // $E1..$FA
//       mov   edx, eax
//       sub   eax, $7B7B7B7B    // $66..$7F
//       xor   edx, ecx          // $80
//       or    eax, $80808080    // $E6..$FF
//       sub   eax, $66666666    // $80..$99
//       and   eax, edx          // $80
//       shr   eax, 2            // $20
//       xor   eax, ecx          // Upper
//       mov   [ebx+edi], eax
//       mov   eax, [ebx+esi-4]
//       sub   ebx, 4
//       jge   @Loop
//
//       pop   edi
//       pop   esi
//       pop   ebx
//       ret
//
//@Nil:  pop   edi
//       pop   esi
//       pop   ebx
//       jmp    System.@LStrClr   // Result:=''
//       end;
//
//{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
//{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
//function UpperCase_Sha_Pas_5_a(const s: string): string;
//var
//  ch1, ch2, ch3, dist: integer;
//  p, q: pInteger;
//begin;
//  p:=pointer(@pchar(pointer(s))[-4]);
//  if integer(p)=-4 then ch1:=0
//                   else ch1:=p^;
//  if (ch1 and 3)=0 then SetLength(Result,ch1)
//                   else SetLength(Result,ch1 or 3);
//  dist:=(pointer(Result)-pchar(p)) shr 2;
//  if ch1>0 then begin;
//    q:=@pchar(p)[(ch1+3) and -4];
//    pIntegerArray(p)[dist-1]:=ch1;    // Correct Result length
//    ch1:=q^;
//    repeat;
//      ch2:=ch1;
//      ch1:=ch1 or integer($80808080); // $E1..$FA
//      ch3:=ch1;
//      ch1:=ch1 - $7B7B7B7B;           // $66..$7F
//      dec(q);
//      ch1:=ch1 or integer($80808080); // $E6..$FF
//      ch3:=ch3 xor ch2;               // $80
//      ch1:=ch1 - $66666666;           // $80..$99
//      ch3:=ch3 and ch1;               // $80
//      ch1:=q^;
//      ch3:=ch3 shr 2;                 // $20
//      ch3:=ch3 xor ch2;               // Upper
//      pIntegerArray(q)[dist]:=ch3;
//      until cardinal(q)<=cardinal(p);
//    end;
//  end;
//{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
//{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}
//
//{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
//{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
//function UpperCase_Sha_Pas_5_b(const s: string): string;
//var
//  ch1, ch2, ch3, dist: integer;
//  p, q: pInteger;
//begin;
//  p:=pointer(@pchar(pointer(s))[-4]);
//  if integer(p)=-4 then ch1:=0
//                   else ch1:=p^;
//  if (ch1 and 3)=0 then SetLength(Result,ch1)
//                   else SetLength(Result,ch1 or 3);
//  dist:=(pointer(Result)-pchar(p)) shr 2;
//  if ch1>0 then begin;
//    q:=@pchar(p)[(ch1+3) and -4];
//    pIntegerArray(p)[dist-1]:=ch1;    // Correct Result length
//    ch1:=q^;
//    repeat;
//      ch2:=ch1;
//      ch1:=ch1 or integer($80808080); // $E1..$FA
//      ch3:=ch1;
//      ch1:=ch1 - $7B7B7B7B;           // $66..$7F
//      dec(q);
//      ch1:=ch1 or integer($80808080); // $E6..$FF
//      ch3:=ch3 xor ch2;               // $80
//      ch1:=ch1 - $66666666;           // $80..$99
//      ch3:=ch3 and ch1;               // $80
//      ch1:=q^;
//      ch3:=ch3 shr 2;                 // $20
//      ch3:=ch3 xor ch2;               // Upper
//      pIntegerArray(q)[dist]:=ch3;
//      until cardinal(q)<=cardinal(p);
//    end;
//  end;
//{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
//{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}
//
//{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
//{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
//function UpperCase_Sha_Pas_5_c(const s: string): string;
//var
//  ch1, ch2, ch3, dist: integer;
//  p, q: pInteger;
//begin;
//  p:=pointer(@pchar(pointer(s))[-4]);
//  if integer(p)=-4 then ch1:=0
//                   else ch1:=p^;
//  if (ch1 and 3)=0 then SetLength(Result,ch1)
//                   else SetLength(Result,ch1 or 3);
//  dist:=(pointer(Result)-pchar(p)) shr 2;
//  if ch1>0 then begin;
//    q:=@pchar(p)[(ch1+3) and -4];
//    pIntegerArray(p)[dist-1]:=ch1;    // Correct Result length
//    ch1:=q^;
//    repeat;
//      ch2:=ch1;
//      ch1:=ch1 or integer($80808080); // $E1..$FA
//      ch3:=ch1;
//      ch1:=ch1 - $7B7B7B7B;           // $66..$7F
//      dec(q);
//      ch1:=ch1 or integer($80808080); // $E6..$FF
//      ch3:=ch3 xor ch2;               // $80
//      ch1:=ch1 - $66666666;           // $80..$99
//      ch3:=ch3 and ch1;               // $80
//      ch1:=q^;
//      ch3:=ch3 shr 2;                 // $20
//      ch3:=ch3 xor ch2;               // Upper
//      pIntegerArray(q)[dist]:=ch3;
//      until cardinal(q)<=cardinal(p);
//    end;
//  end;
//{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
//{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}
//
//{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
//{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
//function UpperCase_Sha_Pas_5_d(const s: string): string;
//var
//  ch1, ch2, ch3, dist: integer;
//  p, q: pInteger;
//begin;
//  p:=pointer(@pchar(pointer(s))[-4]);
//  if integer(p)=-4 then ch1:=0
//                   else ch1:=p^;
//  if (ch1 and 3)=0 then SetLength(Result,ch1)
//                   else SetLength(Result,ch1 or 3);
//  dist:=(pointer(Result)-pchar(p)) shr 2;
//  if ch1>0 then begin;
//    q:=@pchar(p)[(ch1+3) and -4];
//    pIntegerArray(p)[dist-1]:=ch1;    // Correct Result length
//    ch1:=q^;
//    repeat;
//      ch2:=ch1;
//      ch1:=ch1 or integer($80808080); // $E1..$FA
//      ch3:=ch1;
//      ch1:=ch1 - $7B7B7B7B;           // $66..$7F
//      dec(q);
//      ch1:=ch1 or integer($80808080); // $E6..$FF
//      ch3:=ch3 xor ch2;               // $80
//      ch1:=ch1 - $66666666;           // $80..$99
//      ch3:=ch3 and ch1;               // $80
//      ch1:=q^;
//      ch3:=ch3 shr 2;                 // $20
//      ch3:=ch3 xor ch2;               // Upper
//      pIntegerArray(q)[dist]:=ch3;
//      until cardinal(q)<=cardinal(p);
//    end;
//  end;
//{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
//{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}
//
//{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
//{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
//function UpperCase_Sha_Pas_6_a(const s: string): string;
//var
//  ch1, ch2, ch3, dist: integer;
//  p, q: pInteger;
//label
//  Realloc, LengthOK;
//begin;
//  p:=pointer(@pchar(pointer(s))[-4]);
//  ch1:=0;
//  if integer(p)<>-4 then ch1:=p^;
//  if ch1=0 then Result:=''
//  else begin;
//    q:=pointer(Result);
//    if q=nil then goto Realloc;
//    if ch1 and 3=0
//    then if ch1 xor pInteger(pchar(q)-4)^ > 3
//         then goto Realloc
//         else
//    else if (ch1 or 2) xor pInteger(pchar(q)-4)^ > 1
//         then goto Realloc;
//    if (pInteger(pchar(q)-8)^=1) then goto LengthOK;
//Realloc:
//    SetLength(Result,ch1 or 3);
//    q:=pointer(Result);
//LengthOK:
//    pchar(q)[ch1]:=#0;                // Terminator
//    dec(q); q^:=ch1;                  // Correct Result length
//    dist:=(pointer(Result)-pchar(p)) shr 2;
//    q:=@pchar(p)[(ch1+3) and -4];
//    ch1:=q^;
//    repeat;
//      ch2:=ch1;
//      ch1:=ch1 or integer($80808080); // $E1..$FA
//      ch3:=ch1;
//      ch1:=ch1 - $7B7B7B7B;           // $66..$7F
//      dec(q);
//      ch1:=ch1 or integer($80808080); // $E6..$FF
//      ch3:=ch3 xor ch2;               // $80
//      ch1:=ch1 - $66666666;           // $80..$99
//      ch3:=ch3 and ch1;               // $80
//      ch1:=q^;
//      ch3:=ch3 shr 2;                 // $20
//      ch3:=ch3 xor ch2;               // Upper
//      pIntegerArray(q)[dist]:=ch3;
//      until cardinal(q)<=cardinal(p);
//    end;
//  end;
//{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
//{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}
//
//{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
//{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
//function UpperCase_Sha_Pas_6_b(const s: string): string;
//var
//  ch1, ch2, ch3, dist: integer;
//  p, q: pInteger;
//label
//  Realloc, LengthOK;
//begin;
//  p:=pointer(@pchar(pointer(s))[-4]);
//  ch1:=0;
//  if integer(p)<>-4 then ch1:=p^;
//  if ch1=0 then Result:=''
//  else begin;
//    q:=pointer(Result);
//    if q=nil then goto Realloc;
//    if ch1 and 3=0
//    then if ch1 xor pInteger(pchar(q)-4)^ > 3
//         then goto Realloc
//         else
//    else if (ch1 or 2) xor pInteger(pchar(q)-4)^ > 1
//         then goto Realloc;
//    if (pInteger(pchar(q)-8)^=1) then goto LengthOK;
//Realloc:
//    SetLength(Result,ch1 or 3);
//    q:=pointer(Result);
//LengthOK:
//    pchar(q)[ch1]:=#0;                // Terminator
//    dec(q); q^:=ch1;                  // Correct Result length
//    dist:=(pointer(Result)-pchar(p)) shr 2;
//    q:=@pchar(p)[(ch1+3) and -4];
//    ch1:=q^;
//    repeat;
//      ch2:=ch1;
//      ch1:=ch1 or integer($80808080); // $E1..$FA
//      ch3:=ch1;
//      ch1:=ch1 - $7B7B7B7B;           // $66..$7F
//      dec(q);
//      ch1:=ch1 or integer($80808080); // $E6..$FF
//      ch3:=ch3 xor ch2;               // $80
//      ch1:=ch1 - $66666666;           // $80..$99
//      ch3:=ch3 and ch1;               // $80
//      ch1:=q^;
//      ch3:=ch3 shr 2;                 // $20
//      ch3:=ch3 xor ch2;               // Upper
//      pIntegerArray(q)[dist]:=ch3;
//      until cardinal(q)<=cardinal(p);
//    end;
//  end;
//{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
//{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}
//
//procedure Filler4;
//asm
// nop
//end;
//
//{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
//{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
//function UpperCase_Sha_Pas_6_c(const s: string): string;
//var
//  ch1, ch2, ch3, dist: integer;
//  p, q: pInteger;
//label
//  Realloc, LengthOK;
//begin;
//  p:=pointer(@pchar(pointer(s))[-4]);
//  ch1:=0;
//  if integer(p)<>-4 then ch1:=p^;
//  if ch1=0 then Result:=''
//  else begin;
//    q:=pointer(Result);
//    if q=nil then goto Realloc;
//    if ch1 and 3=0
//    then if ch1 xor pInteger(pchar(q)-4)^ > 3
//         then goto Realloc
//         else
//    else if (ch1 or 2) xor pInteger(pchar(q)-4)^ > 1
//         then goto Realloc;
//    if (pInteger(pchar(q)-8)^=1) then goto LengthOK;
//Realloc:
//    SetLength(Result,ch1 or 3);
//    q:=pointer(Result);
//LengthOK:
//    pchar(q)[ch1]:=#0;                // Terminator
//    dec(q); q^:=ch1;                  // Correct Result length
//    dist:=(pointer(Result)-pchar(p)) shr 2;
//    q:=@pchar(p)[(ch1+3) and -4];
//    ch1:=q^;
//    repeat;
//      ch2:=ch1;
//      ch1:=ch1 or integer($80808080); // $E1..$FA
//      ch3:=ch1;
//      ch1:=ch1 - $7B7B7B7B;           // $66..$7F
//      dec(q);
//      ch1:=ch1 or integer($80808080); // $E6..$FF
//      ch3:=ch3 xor ch2;               // $80
//      ch1:=ch1 - $66666666;           // $80..$99
//      ch3:=ch3 and ch1;               // $80
//      ch1:=q^;
//      ch3:=ch3 shr 2;                 // $20
//      ch3:=ch3 xor ch2;               // Upper
//      pIntegerArray(q)[dist]:=ch3;
//      until cardinal(q)<=cardinal(p);
//    end;
//  end;
//{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
//{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}
//
//{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
//{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}
//function UpperCase_Sha_Pas_6_d(const s: string): string;
//var
//  ch1, ch2, ch3, dist: integer;
//  p, q: pInteger;
//label
//  Realloc, LengthOK;
//begin;
//  p:=pointer(@pchar(pointer(s))[-4]);
//  ch1:=0;
//  if integer(p)<>-4 then ch1:=p^;
//  if ch1=0 then Result:=''
//  else begin;
//    q:=pointer(Result);
//    if q=nil then goto Realloc;
//    if ch1 and 3=0
//    then if ch1 xor pInteger(pchar(q)-4)^ > 3
//         then goto Realloc
//         else
//    else if (ch1 or 2) xor pInteger(pchar(q)-4)^ > 1
//         then goto Realloc;
//    if (pInteger(pchar(q)-8)^=1) then goto LengthOK;
//Realloc:
//    SetLength(Result,ch1 or 3);
//    q:=pointer(Result);
//LengthOK:
//    pchar(q)[ch1]:=#0;                // Terminator
//    dec(q); q^:=ch1;                  // Correct Result length
//    dist:=(pointer(Result)-pchar(p)) shr 2;
//    q:=@pchar(p)[(ch1+3) and -4];
//    ch1:=q^;
//    repeat;
//      ch2:=ch1;
//      ch1:=ch1 or integer($80808080); // $E1..$FA
//      ch3:=ch1;
//      ch1:=ch1 - $7B7B7B7B;           // $66..$7F
//      dec(q);
//      ch1:=ch1 or integer($80808080); // $E6..$FF
//      ch3:=ch3 xor ch2;               // $80
//      ch1:=ch1 - $66666666;           // $80..$99
//      ch3:=ch3 and ch1;               // $80
//      ch1:=q^;
//      ch3:=ch3 shr 2;                 // $20
//      ch3:=ch3 xor ch2;               // Upper
//      pIntegerArray(q)[dist]:=ch3;
//      until cardinal(q)<=cardinal(p);
//    end;
//  end;
//{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
//{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}
//
//initialization
//
//  Filler1;
//  Filler2;
//  Filler3;
//  Filler4;

end.
