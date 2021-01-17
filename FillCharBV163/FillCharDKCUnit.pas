unit FillCharDKCUnit;

interface

{$IFDEF WIN32}
procedure FillChar_DKC_Pas_24_a(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_Pas_24_b(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_Pas_24_c(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_Pas_24_d(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_IA32_20_a(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_IA32_20_b(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_IA32_20_c(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_IA32_20_d(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_MMX_11_a(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_MMX_11_b(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_MMX_11_c(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_MMX_11_d(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_MMX_12_a(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_MMX_12_b(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_MMX_12_c(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_MMX_12_d(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE_9_a(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE_9_b(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE_9_c(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE_9_d(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE_14_a(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE_14_b(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE_14_c(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE_14_d(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE2_10_a(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE2_10_b(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE2_10_c(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE2_10_d(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE2_11_a(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE2_11_b(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE2_11_c(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillChar_DKC_SSE2_11_d(var Dest; Count: NativeInt; Value: AnsiChar);
procedure FillCharDKC_SSE2_12_a(var Dest; Count: NativeInt; Value: AnsiChar);
{$ENDIF}

implementation

//Author:            Dennis Kjaer Christensen
//Date:              16/9 2003
//Optimized for:     Blended
//Instructionset(s): IA32
//Size:

{$IFDEF WIN32}

procedure FillChar_DKC_IA32_20_a(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   mov   ch,cl
   jmp  dword ptr [edx*4+@Case1JmpTable]
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseCount31 :
   mov   [eax+29],cx
 @CaseCount29 :
   mov   [eax+27],cx
 @CaseCount27 :
   mov   [eax+25],cx
 @CaseCount25 :
   mov   [eax+23],cx
 @CaseCount23 :
   mov   [eax+21],cx
 @CaseCount21 :
   mov   [eax+19],cx
 @CaseCount19 :
   mov   [eax+17],cx
 @CaseCount17 :
   mov   [eax+15],cx
 @CaseCount15 :
   mov   [eax+13],cx
 @CaseCount13 :
   mov   [eax+11],cx
 @CaseCount11 :
   mov   [eax+9],cx
 @CaseCount9 :
   mov   [eax+7], cx
 @CaseCount7 :
   mov   [eax+5], cx
 @CaseCount5 :
   mov   [eax+3], cx
 @CaseCount3 :
   mov   [eax+1], cx
 @CaseCount1 :
   mov   [eax],   cl
 @CaseCount0 :
   ret
   nop
 @CaseCount30 :
   mov   [eax+28],cx
 @CaseCount28 :
   mov   [eax+26],cx
 @CaseCount26 :
   mov   [eax+24],cx
 @CaseCount24 :
   mov   [eax+22],cx
 @CaseCount22 :
   mov   [eax+20],cx
 @CaseCount20 :
   mov   [eax+18],cx
 @CaseCount18 :
   mov   [eax+16],cx
 @CaseCount16 :
   mov   [eax+14],cx
 @CaseCount14 :
   mov   [eax+12],cx
 @CaseCount12 :
   mov   [eax+10],cx
 @CaseCount10 :
   mov   [eax+8], cx
 @CaseCount8 :
   mov   [eax+6], cx
 @CaseCount6 :
   mov   [eax+4], cx
 @CaseCount4 :
   mov   [eax+2], cx
 @CaseCount2 :
   mov   [eax],   cx
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push  ebx
   push  esi
   push  edi
   //P := PChar(@Dest);
   mov   esi,eax
   //StopP2 := P + Count;
   lea   ebx,[edx+eax]
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //Broadcast value
   mov   ch,cl
   shl   ecx,8
   mov   cl,ch
   shl   ecx,8
   mov   cl,ch
   //I := 0;
   xor   eax,eax
   sub   edx,15
 @Repeat1 :
   mov   [esi+eax],   ecx
   mov   [esi+eax+4], ecx
   mov   [esi+eax+8], ecx
   mov   [esi+eax+12],ecx
   add   eax,16
   cmp   eax,edx
   jl    @Repeat1
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

procedure FillChar_DKC_IA32_20_b(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   mov   ch,cl
   jmp  dword ptr [edx*4+@Case1JmpTable]
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseCount31 :
   mov   [eax+29],cx
 @CaseCount29 :
   mov   [eax+27],cx
 @CaseCount27 :
   mov   [eax+25],cx
 @CaseCount25 :
   mov   [eax+23],cx
 @CaseCount23 :
   mov   [eax+21],cx
 @CaseCount21 :
   mov   [eax+19],cx
 @CaseCount19 :
   mov   [eax+17],cx
 @CaseCount17 :
   mov   [eax+15],cx
 @CaseCount15 :
   mov   [eax+13],cx
 @CaseCount13 :
   mov   [eax+11],cx
 @CaseCount11 :
   mov   [eax+9],cx
 @CaseCount9 :
   mov   [eax+7], cx
 @CaseCount7 :
   mov   [eax+5], cx
 @CaseCount5 :
   mov   [eax+3], cx
 @CaseCount3 :
   mov   [eax+1], cx
 @CaseCount1 :
   mov   [eax],   cl
 @CaseCount0 :
   ret
   nop
 @CaseCount30 :
   mov   [eax+28],cx
 @CaseCount28 :
   mov   [eax+26],cx
 @CaseCount26 :
   mov   [eax+24],cx
 @CaseCount24 :
   mov   [eax+22],cx
 @CaseCount22 :
   mov   [eax+20],cx
 @CaseCount20 :
   mov   [eax+18],cx
 @CaseCount18 :
   mov   [eax+16],cx
 @CaseCount16 :
   mov   [eax+14],cx
 @CaseCount14 :
   mov   [eax+12],cx
 @CaseCount12 :
   mov   [eax+10],cx
 @CaseCount10 :
   mov   [eax+8], cx
 @CaseCount8 :
   mov   [eax+6], cx
 @CaseCount6 :
   mov   [eax+4], cx
 @CaseCount4 :
   mov   [eax+2], cx
 @CaseCount2 :
   mov   [eax],   cx
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push  ebx
   push  esi
   push  edi
   //P := PChar(@Dest);
   mov   esi,eax
   //StopP2 := P + Count;
   lea   ebx,[edx+eax]
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //Broadcast value
   mov   ch,cl
   shl   ecx,8
   mov   cl,ch
   shl   ecx,8
   mov   cl,ch
   //I := 0;
   xor   eax,eax
   sub   edx,15
 @Repeat1 :
   mov   [esi+eax],   ecx
   mov   [esi+eax+4], ecx
   mov   [esi+eax+8], ecx
   mov   [esi+eax+12],ecx
   add   eax,16
   cmp   eax,edx
   jl    @Repeat1
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

procedure FillChar_DKC_IA32_20_c(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   mov   ch,cl
   jmp  dword ptr [edx*4+@Case1JmpTable]
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseCount31 :
   mov   [eax+29],cx
 @CaseCount29 :
   mov   [eax+27],cx
 @CaseCount27 :
   mov   [eax+25],cx
 @CaseCount25 :
   mov   [eax+23],cx
 @CaseCount23 :
   mov   [eax+21],cx
 @CaseCount21 :
   mov   [eax+19],cx
 @CaseCount19 :
   mov   [eax+17],cx
 @CaseCount17 :
   mov   [eax+15],cx
 @CaseCount15 :
   mov   [eax+13],cx
 @CaseCount13 :
   mov   [eax+11],cx
 @CaseCount11 :
   mov   [eax+9],cx
 @CaseCount9 :
   mov   [eax+7], cx
 @CaseCount7 :
   mov   [eax+5], cx
 @CaseCount5 :
   mov   [eax+3], cx
 @CaseCount3 :
   mov   [eax+1], cx
 @CaseCount1 :
   mov   [eax],   cl
 @CaseCount0 :
   ret
   nop
 @CaseCount30 :
   mov   [eax+28],cx
 @CaseCount28 :
   mov   [eax+26],cx
 @CaseCount26 :
   mov   [eax+24],cx
 @CaseCount24 :
   mov   [eax+22],cx
 @CaseCount22 :
   mov   [eax+20],cx
 @CaseCount20 :
   mov   [eax+18],cx
 @CaseCount18 :
   mov   [eax+16],cx
 @CaseCount16 :
   mov   [eax+14],cx
 @CaseCount14 :
   mov   [eax+12],cx
 @CaseCount12 :
   mov   [eax+10],cx
 @CaseCount10 :
   mov   [eax+8], cx
 @CaseCount8 :
   mov   [eax+6], cx
 @CaseCount6 :
   mov   [eax+4], cx
 @CaseCount4 :
   mov   [eax+2], cx
 @CaseCount2 :
   mov   [eax],   cx
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push  ebx
   push  esi
   push  edi
   //P := PChar(@Dest);
   mov   esi,eax
   //StopP2 := P + Count;
   lea   ebx,[edx+eax]
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //Broadcast value
   mov   ch,cl
   shl   ecx,8
   mov   cl,ch
   shl   ecx,8
   mov   cl,ch
   //I := 0;
   xor   eax,eax
   sub   edx,15
 @Repeat1 :
   mov   [esi+eax],   ecx
   mov   [esi+eax+4], ecx
   mov   [esi+eax+8], ecx
   mov   [esi+eax+12],ecx
   add   eax,16
   cmp   eax,edx
   jl    @Repeat1
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

procedure FillChar_DKC_IA32_20_d(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   mov   ch,cl
   jmp  dword ptr [edx*4+@Case1JmpTable]
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseCount31 :
   mov   [eax+29],cx
 @CaseCount29 :
   mov   [eax+27],cx
 @CaseCount27 :
   mov   [eax+25],cx
 @CaseCount25 :
   mov   [eax+23],cx
 @CaseCount23 :
   mov   [eax+21],cx
 @CaseCount21 :
   mov   [eax+19],cx
 @CaseCount19 :
   mov   [eax+17],cx
 @CaseCount17 :
   mov   [eax+15],cx
 @CaseCount15 :
   mov   [eax+13],cx
 @CaseCount13 :
   mov   [eax+11],cx
 @CaseCount11 :
   mov   [eax+9],cx
 @CaseCount9 :
   mov   [eax+7], cx
 @CaseCount7 :
   mov   [eax+5], cx
 @CaseCount5 :
   mov   [eax+3], cx
 @CaseCount3 :
   mov   [eax+1], cx
 @CaseCount1 :
   mov   [eax],   cl
 @CaseCount0 :
   ret
   nop
 @CaseCount30 :
   mov   [eax+28],cx
 @CaseCount28 :
   mov   [eax+26],cx
 @CaseCount26 :
   mov   [eax+24],cx
 @CaseCount24 :
   mov   [eax+22],cx
 @CaseCount22 :
   mov   [eax+20],cx
 @CaseCount20 :
   mov   [eax+18],cx
 @CaseCount18 :
   mov   [eax+16],cx
 @CaseCount16 :
   mov   [eax+14],cx
 @CaseCount14 :
   mov   [eax+12],cx
 @CaseCount12 :
   mov   [eax+10],cx
 @CaseCount10 :
   mov   [eax+8], cx
 @CaseCount8 :
   mov   [eax+6], cx
 @CaseCount6 :
   mov   [eax+4], cx
 @CaseCount4 :
   mov   [eax+2], cx
 @CaseCount2 :
   mov   [eax],   cx
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push  ebx
   push  esi
   push  edi
   //P := PChar(@Dest);
   mov   esi,eax
   //StopP2 := P + Count;
   lea   ebx,[edx+eax]
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //Broadcast value
   mov   ch,cl
   shl   ecx,8
   mov   cl,ch
   shl   ecx,8
   mov   cl,ch
   //I := 0;
   xor   eax,eax
   sub   edx,15
 @Repeat1 :
   mov   [esi+eax],   ecx
   mov   [esi+eax+4], ecx
   mov   [esi+eax+8], ecx
   mov   [esi+eax+12],ecx
   add   eax,16
   cmp   eax,edx
   jl    @Repeat1
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              14/9 2003
//Optimized for:     Pascal Blended
//Instructionset(s): IA32
//Size:

procedure FillChar_DKC_Pas_24_a(var Dest; Count: NativeInt; Value: AnsiChar);
var
 I, FourValues, ICount, MisAlignment : Integer;
 P, StopP2 : PAnsiChar;
 DstI : PIntegerArray;

begin
 if Count <= 0 then
  Exit;
 P := PAnsiChar(@Dest);
 case Count of
  0 :
   Exit;
  1 :
   begin
    P[0] := Value;
   end;
  2 :
   begin
    P[0] := Value;
    P[1] := Value;
   end;
  3 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
   end;
  4 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
   end;
  5 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
   end;
  6 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
   end;
  7 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
   end;
  8 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
   end;
  9 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
   end;
  10 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
   end;
  11 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
   end;
  12 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
   end;
  13 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
   end;
  14 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
   end;
  15 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
   end;
  16 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
   end;
  17 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
   end;
  18 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
   end;
  19 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
   end;
  20 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
   end;
  21 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
   end;
  22 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
   end;
  23 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
   end;
  24 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
   end;
  25 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
   end;
  26 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
   end;
  27 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
   end;
  28 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
   end;
  29 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
   end;
  30 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
    P[29] := Value;
   end;
  31 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
    P[29] := Value;
    P[30] := Value;
   end;
 else
  //Count is 20 or more here
  StopP2 := P + Count;
  ICount := Count div 4;
  //Fill 8 byte per round
  DstI := @Dest;
  MisAlignment := Integer(DstI) mod 4;
  I := 0;
  case MisAlignment of
   1 :
    begin
     P^ := Value;
     Inc(P);
    end;
   2 :
    begin
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
    end;
   3 :
    begin
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
    end;
  end;
  //Fill 8 byte per round
  DstI := PIntegerArray(P);   //DstI now aligned
  FourValues := Integer(Value);
  FourValues := FourValues or FourValues shl 8;
  FourValues := FourValues or FourValues shl 16;
  Dec(ICount,2);
  repeat
   DstI[I] := FourValues;
   Inc(I);
   DstI[I] := FourValues;
   Inc(I);
  until(I >= ICount);
  //Fill the rest if any
  P := P + I*4;
  if P < StopP2 then
   begin
    repeat
     P^ := Value;
     Inc(P);
    until(P >= StopP2)
   end;
 end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/9 2003
//Optimized for:     Pascal Blended
//Instructionset(s): IA32
//Size:

procedure FillChar_DKC_Pas_24_b(var Dest; Count: NativeInt; Value: AnsiChar);
var
 I, FourValues, ICount, MisAlignment : Integer;
 P, StopP2 : PAnsiChar;
 DstI : PIntegerArray;

begin
 if Count <= 0 then
	Exit;
 P := PAnsiChar(@Dest);
 case Count of
  0 :
   Exit;
  1 :
   begin
    P[0] := Value;
   end;
  2 :
   begin
    P[0] := Value;
    P[1] := Value;
   end;
  3 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
   end;
  4 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
   end;
  5 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
   end;
  6 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
   end;
  7 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
   end;
  8 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
   end;
  9 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
   end;
  10 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
   end;
  11 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
   end;
  12 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
   end;
  13 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
   end;
  14 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
   end;
  15 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
   end;
  16 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
   end;
  17 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
   end;
  18 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
   end;
  19 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
   end;
  20 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
   end;
  21 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
   end;
  22 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
   end;
  23 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
   end;
  24 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
   end;
  25 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
   end;
  26 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
   end;
  27 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
   end;
  28 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
   end;
  29 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
   end;
  30 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
    P[29] := Value;
   end;
  31 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
    P[29] := Value;
    P[30] := Value;
   end;
 else
  //Count is 20 or more here
  StopP2 := P + Count;
  ICount := Count div 4;
  //Fill 8 byte per round
  DstI := @Dest;
  MisAlignment := Integer(DstI) mod 4;
  I := 0;
  case MisAlignment of
   1 :
    begin
     P^ := Value;
     Inc(P);
    end;
   2 :
    begin
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
    end;
   3 :
    begin
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
    end;
  end;
  //Fill 8 byte per round
  DstI := PIntegerArray(P);   //DstI now aligned
  FourValues := Integer(Value);
  FourValues := FourValues or FourValues shl 8;
  FourValues := FourValues or FourValues shl 16;
  Dec(ICount,2);
  repeat
   DstI[I] := FourValues;
   Inc(I);
   DstI[I] := FourValues;
   Inc(I);
  until(I >= ICount);
  //Fill the rest if any
  P := P + I*4;
  if P < StopP2 then
   begin
    repeat
     P^ := Value;
     Inc(P);
    until(P >= StopP2)
   end;
 end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/9 2003
//Optimized for:     Pascal Blended
//Instructionset(s): IA32
//Size:

procedure FillChar_DKC_Pas_24_c(var Dest; Count: NativeInt; Value: AnsiChar);
var
 I, FourValues, ICount, MisAlignment : Integer;
 P, StopP2 : PAnsiChar;
 DstI : PIntegerArray;

begin
 if Count <= 0 then
  Exit;
 P := PAnsiChar(@Dest);
 case Count of
  0 :
   Exit;
  1 :
   begin
    P[0] := Value;
   end;
  2 :
   begin
    P[0] := Value;
    P[1] := Value;
   end;
  3 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
   end;
  4 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
   end;
  5 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
   end;
  6 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
   end;
  7 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
   end;
  8 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
   end;
  9 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
   end;
  10 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
   end;
  11 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
   end;
  12 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
   end;
  13 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
   end;
  14 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
   end;
  15 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
   end;
  16 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
   end;
  17 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
   end;
  18 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
   end;
  19 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
   end;
  20 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
   end;
  21 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
   end;
  22 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
   end;
  23 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
   end;
  24 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
   end;
  25 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
   end;
  26 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
   end;
  27 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
   end;
  28 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
   end;
  29 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
   end;
  30 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
    P[29] := Value;
   end;
  31 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
    P[29] := Value;
    P[30] := Value;
   end;
 else
  //Count is 20 or more here
  StopP2 := P + Count;
  ICount := Count div 4;
  //Fill 8 byte per round
  DstI := @Dest;
  MisAlignment := Integer(DstI) mod 4;
  I := 0;
  case MisAlignment of
   1 :
    begin
     P^ := Value;
     Inc(P);
    end;
   2 :
    begin
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
    end;
   3 :
    begin
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
    end;
  end;
  //Fill 8 byte per round
  DstI := PIntegerArray(P);   //DstI now aligned
  FourValues := Integer(Value);
  FourValues := FourValues or FourValues shl 8;
  FourValues := FourValues or FourValues shl 16;
  Dec(ICount,2);
  repeat
   DstI[I] := FourValues;
   Inc(I);
   DstI[I] := FourValues;
   Inc(I);
  until(I >= ICount);
  //Fill the rest if any
  P := P + I*4;
  if P < StopP2 then
   begin
    repeat
     P^ := Value;
     Inc(P);
    until(P >= StopP2)
   end;
 end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/9 2003
//Optimized for:     Pascal Blended
//Instructionset(s): IA32
//Size:

procedure FillChar_DKC_Pas_24_d(var Dest; Count: NativeInt; Value: AnsiChar);
var
 I, FourValues, ICount, MisAlignment : Integer;
 P, StopP2 : PAnsiChar;
 DstI : PIntegerArray;

begin
 if Count <= 0 then
  Exit;
 P := PAnsiChar(@Dest);
 case Count of
  0 :
   Exit;
  1 :
   begin
    P[0] := Value;
   end;
  2 :
   begin
    P[0] := Value;
    P[1] := Value;
   end;
  3 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
   end;
  4 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
   end;
  5 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
   end;
  6 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
   end;
  7 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
   end;
  8 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
   end;
  9 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
   end;
  10 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
   end;
  11 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
   end;
  12 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
   end;
  13 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
   end;
  14 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
   end;
  15 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
   end;
  16 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
   end;
  17 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
   end;
  18 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
   end;
  19 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
   end;
  20 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
   end;
  21 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
   end;
  22 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
   end;
  23 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
   end;
  24 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
   end;
  25 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
   end;
  26 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
   end;
  27 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
   end;
  28 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
   end;
  29 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
   end;
  30 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
    P[29] := Value;
   end;
  31 :
   begin
    P[0] := Value;
    P[1] := Value;
    P[2] := Value;
    P[3] := Value;
    P[4] := Value;
    P[5] := Value;
    P[6] := Value;
    P[7] := Value;
    P[8] := Value;
    P[9] := Value;
    P[10] := Value;
    P[11] := Value;
    P[12] := Value;
    P[13] := Value;
    P[14] := Value;
    P[15] := Value;
    P[16] := Value;
    P[17] := Value;
    P[18] := Value;
    P[19] := Value;
    P[20] := Value;
    P[21] := Value;
    P[22] := Value;
    P[23] := Value;
    P[24] := Value;
    P[25] := Value;
    P[26] := Value;
    P[27] := Value;
    P[28] := Value;
    P[29] := Value;
    P[30] := Value;
   end;
 else
  //Count is 20 or more here
  StopP2 := P + Count;
  ICount := Count div 4;
  //Fill 8 byte per round
  DstI := @Dest;
  MisAlignment := Integer(DstI) mod 4;
  I := 0;
  case MisAlignment of
   1 :
    begin
     P^ := Value;
     Inc(P);
    end;
   2 :
    begin
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
    end;
   3 :
    begin
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
     P^ := Value;
     Inc(P);
    end;
  end;
  //Fill 8 byte per round
  DstI := PIntegerArray(P);   //DstI now aligned
  FourValues := Integer(Value);
  FourValues := FourValues or FourValues shl 8;
  FourValues := FourValues or FourValues shl 16;
  Dec(ICount,2);
  repeat
   DstI[I] := FourValues;
   Inc(I);
   DstI[I] := FourValues;
   Inc(I);
  until(I >= ICount);
  //Fill the rest if any
  P := P + I*4;
  if P < StopP2 then
   begin
    repeat
     P^ := Value;
     Inc(P);
    until(P >= StopP2)
   end;
 end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              13/9 2003
//Optimized for:     Athlon
//Instructionset(s): IA32, MMX
//Size:

procedure FillChar_DKC_MMX_11_a(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   push  esi
   push  edi
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   cmp   edx,40
   jae    @Repeat3
   xor   eax,eax
 @Repeat4 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat4
   jmp   @Exit1
   //Need at least 40 bytes here. Max 8 for alignment and 32 for loop
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //Broadcast value
   mov   ch, cl
   shl   ecx, 8
   mov   cl, ch
   shl   ecx, 8
   mov   cl, ch
   movd  mm0, ecx
   movq  mm1, mm0
   psllq mm1, 32
   por   mm0, mm1
   //I := 0;
   xor   eax,eax
   sub   edx,31
 @Repeat1 :
   movq  [esi+eax],mm0
   movq  [esi+eax+8],mm0
   movq  [esi+eax+16],mm0
   movq  [esi+eax+24],mm0
   add   eax,32
   cmp   eax,edx
   jl    @Repeat1
   emms
   add   edx,31
   //Fill the rest if any
   cmp   eax,edx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32, MMX
//Size:

procedure FillChar_DKC_MMX_12_a(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   push  esi
   push  edi
   //Broadcast value
   mov   ch, cl
   shl   ecx, 8
   mov   cl, ch
   shl   ecx, 8
   mov   cl, ch
   movd  mm0, ecx
   movq  mm1, mm0
   psllq mm1, 32
   por   mm0, mm1
   //Fill the rest
   movq  [eax+edx-8],mm0
   movq  [eax+edx-16],mm0
   movq  [eax+edx-24],mm0
   movq  [eax+edx-32],mm0
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   cmp   edx,40
   jae   @Repeat3
   xor   eax,eax
 @Repeat4 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat4
   jmp   @Exit1
   //Need at least 40 bytes here. Max 8 for alignment and 32 for loop
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //I := 0;
   xor   eax,eax
   sub   edx,31
 @Repeat1 :
   movq  [esi+eax],mm0
   movq  [esi+eax+8],mm0
   movq  [esi+eax+16],mm0
   movq  [esi+eax+24],mm0
   add   eax,32
   cmp   eax,edx
   jl    @Repeat1
 @Exit1 :
   emms
   pop   edi
   pop   esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

procedure Filler1;
asm
 nop
end;


//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32, MMX
//Size:

procedure FillChar_DKC_MMX_12_b(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   push  esi
   push  edi
   //Broadcast value
   mov   ch, cl
   shl   ecx, 8
   mov   cl, ch
   shl   ecx, 8
   mov   cl, ch
   movd  mm0, ecx
   movq  mm1, mm0
   psllq mm1, 32
   por   mm0, mm1
   //Fill the rest
   movq  [eax+edx-8],mm0
   movq  [eax+edx-16],mm0
   movq  [eax+edx-24],mm0
   movq  [eax+edx-32],mm0
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   cmp   edx,40
   jae   @Repeat3
   xor   eax,eax
 @Repeat4 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat4
   jmp   @Exit1
   //Need at least 40 bytes here. Max 8 for alignment and 32 for loop
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //I := 0;
   xor   eax,eax
   sub   edx,31
 @Repeat1 :
   movq  [esi+eax],mm0
   movq  [esi+eax+8],mm0
   movq  [esi+eax+16],mm0
   movq  [esi+eax+24],mm0
   add   eax,32
   cmp   eax,edx
   jl    @Repeat1
 @Exit1 :
   emms
   pop   edi
   pop   esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

procedure Filler2;
asm
 nop
end;


//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32, MMX
//Size:

procedure FillChar_DKC_MMX_12_c(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   push  esi
   push  edi
   //Broadcast value
   mov   ch, cl
   shl   ecx, 8
   mov   cl, ch
   shl   ecx, 8
   mov   cl, ch
   movd  mm0, ecx
   movq  mm1, mm0
   psllq mm1, 32
   por   mm0, mm1
   //Fill the rest
   movq  [eax+edx-8],mm0
   movq  [eax+edx-16],mm0
   movq  [eax+edx-24],mm0
   movq  [eax+edx-32],mm0
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   cmp   edx,40
   jae   @Repeat3
   xor   eax,eax
 @Repeat4 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat4
   jmp   @Exit1
   //Need at least 40 bytes here. Max 8 for alignment and 32 for loop
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //I := 0;
   xor   eax,eax
   sub   edx,31
 @Repeat1 :
   movq  [esi+eax],mm0
   movq  [esi+eax+8],mm0
   movq  [esi+eax+16],mm0
   movq  [esi+eax+24],mm0
   add   eax,32
   cmp   eax,edx
   jl    @Repeat1
 @Exit1 :
   emms
   pop   edi
   pop   esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

procedure Filler3;
asm
 nop
end;


//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32, MMX
//Size:

procedure FillChar_DKC_MMX_12_d(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   push  esi
   push  edi
   //Broadcast value
   mov   ch, cl
   shl   ecx, 8
   mov   cl, ch
   shl   ecx, 8
   mov   cl, ch
   movd  mm0, ecx
   movq  mm1, mm0
   psllq mm1, 32
   por   mm0, mm1
   //Fill the rest
   movq  [eax+edx-8],mm0
   movq  [eax+edx-16],mm0
   movq  [eax+edx-24],mm0
   movq  [eax+edx-32],mm0
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   cmp   edx,40
   jae   @Repeat3
   xor   eax,eax
 @Repeat4 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat4
   jmp   @Exit1
   //Need at least 40 bytes here. Max 8 for alignment and 32 for loop
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //I := 0;
   xor   eax,eax
   sub   edx,31
 @Repeat1 :
   movq  [esi+eax],mm0
   movq  [esi+eax+8],mm0
   movq  [esi+eax+16],mm0
   movq  [esi+eax+24],mm0
   add   eax,32
   cmp   eax,edx
   jl    @Repeat1
 @Exit1 :
   emms
   pop   edi
   pop   esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              13/9 2003
//Optimized for:     Athlon
//Instructionset(s): IA32, MMX
//Size:

procedure FillChar_DKC_MMX_11_b(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   push  esi
   push  edi
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   cmp   edx,40
   jae    @Repeat3
   xor   eax,eax
 @Repeat4 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat4
   jmp   @Exit1
   //Need at least 40 bytes here. Max 8 for alignment and 32 for loop
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //Broadcast value
   mov   ch, cl
   shl   ecx, 8
   mov   cl, ch
   shl   ecx, 8
   mov   cl, ch
   movd  mm0, ecx
   movq  mm1, mm0
   psllq mm1, 32
   por   mm0, mm1
   //I := 0;
   xor   eax,eax
   sub   edx,31
 @Repeat1 :
   movq  [esi+eax],mm0
   movq  [esi+eax+8],mm0
   movq  [esi+eax+16],mm0
   movq  [esi+eax+24],mm0
   add   eax,32
   cmp   eax,edx
   jl    @Repeat1
   emms
   add   edx,31
   //Fill the rest if any
   cmp   eax,edx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              13/9 2003
//Optimized for:     Athlon
//Instructionset(s): IA32, MMX
//Size:

procedure FillChar_DKC_MMX_11_c(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   push  esi
   push  edi
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   cmp   edx,40
   jae    @Repeat3
   xor   eax,eax
 @Repeat4 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat4
   jmp   @Exit1
   //Need at least 40 bytes here. Max 8 for alignment and 32 for loop
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //Broadcast value
   mov   ch, cl
   shl   ecx, 8
   mov   cl, ch
   shl   ecx, 8
   mov   cl, ch
   movd  mm0, ecx
   movq  mm1, mm0
   psllq mm1, 32
   por   mm0, mm1
   //I := 0;
   xor   eax,eax
   sub   edx,31
 @Repeat1 :
   movq  [esi+eax],mm0
   movq  [esi+eax+8],mm0
   movq  [esi+eax+16],mm0
   movq  [esi+eax+24],mm0
   add   eax,32
   cmp   eax,edx
   jl    @Repeat1
   emms
   add   edx,31
   //Fill the rest if any
   cmp   eax,edx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              13/9 2003
//Optimized for:     Athlon
//Instructionset(s): IA32, MMX
//Size:

procedure FillChar_DKC_MMX_11_d(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   push  esi
   push  edi
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   cmp   edx,40
   jae    @Repeat3
   xor   eax,eax
 @Repeat4 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat4
   jmp   @Exit1
   //Need at least 40 bytes here. Max 8 for alignment and 32 for loop
   //8 byte Align
 @Repeat3 :
   mov   [esi],cl
   add   esi,1
   sub   edx,1     //Decrement count
   mov   edi,esi
   and   edi,7
   test  edi,edi
   jnz   @Repeat3
   //Broadcast value
   mov   ch, cl
   shl   ecx, 8
   mov   cl, ch
   shl   ecx, 8
   mov   cl, ch
   movd  mm0, ecx
   movq  mm1, mm0
   psllq mm1, 32
   por   mm0, mm1
   //I := 0;
   xor   eax,eax
   sub   edx,31
 @Repeat1 :
   movq  [esi+eax],mm0
   movq  [esi+eax+8],mm0
   movq  [esi+eax+16],mm0
   movq  [esi+eax+24],mm0
   add   eax,32
   cmp   eax,edx
   jl    @Repeat1
   emms
   add   edx,31
   //Fill the rest if any
   cmp   eax,edx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi+eax],cl
   add   eax,1
   cmp   eax,edx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              16/9 2003
//Optimized for:     Athlon/P3
//Instructionset(s): IA32, MMX, SSE
//Size

procedure FillChar_DKC_SSE_9_a(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push  ebx
   push  esi
   push  edi
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   //StopP2 := P + Count;
   lea   ebx,[edx+eax]
   //8 byte Align
 @Repeat3 :
   mov    [esi],cl
   add    esi,1
   sub    edx,1     //Decrement count
   mov    edi,esi
   and    edi,7
   test   edi,edi
   jnz    @Repeat3
   //Broadcast value
   mov    ch, cl
   movd   mm0, ecx
   pshufw mm0, mm0, 0
   //I := 0;
   xor    eax,eax
   sub    edx,15
   cmp    edx,256000
   ja     @Repeat4
 @Repeat1 :
   movq   [esi+eax],  mm0
   movq   [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat1
   jmp    @Repeat4End
 @Repeat4 :
   movntq [esi+eax],  mm0
   movntq [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat4
 @Repeat4End :
   emms
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              16/9 2003
//Optimized for:     Athlon/P3
//Instructionset(s): IA32, MMX, SSE
//Size

procedure FillChar_DKC_SSE_9_b(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push  ebx
   push  esi
   push  edi
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   //StopP2 := P + Count;
   lea   ebx,[edx+eax]
   //8 byte Align
 @Repeat3 :
   mov    [esi],cl
   add    esi,1
   sub    edx,1     //Decrement count
   mov    edi,esi
   and    edi,7
   test   edi,edi
   jnz    @Repeat3
   //Broadcast value
   mov    ch, cl
   movd   mm0, ecx
   pshufw mm0, mm0, 0
   //I := 0;
   xor    eax,eax
   sub    edx,15
   cmp    edx,256000
   ja     @Repeat4
 @Repeat1 :
   movq   [esi+eax],  mm0
   movq   [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat1
   jmp    @Repeat4End
 @Repeat4 :
   movntq [esi+eax],  mm0
   movntq [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat4
 @Repeat4End :
   emms
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              16/9 2003
//Optimized for:     Athlon/P3
//Instructionset(s): IA32, MMX, SSE
//Size

procedure FillChar_DKC_SSE_9_c(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push  ebx
   push  esi
   push  edi
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   //StopP2 := P + Count;
   lea   ebx,[edx+eax]
   //8 byte Align
 @Repeat3 :
   mov    [esi],cl
   add    esi,1
   sub    edx,1     //Decrement count
   mov    edi,esi
   and    edi,7
   test   edi,edi
   jnz    @Repeat3
   //Broadcast value
   mov    ch, cl
   movd   mm0, ecx
   pshufw mm0, mm0, 0
   //I := 0;
   xor    eax,eax
   sub    edx,15
   cmp    edx,256000
   ja     @Repeat4
 @Repeat1 :
   movq   [esi+eax],  mm0
   movq   [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat1
   jmp    @Repeat4End
 @Repeat4 :
   movntq [esi+eax],  mm0
   movntq [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat4
 @Repeat4End :
   emms
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              16/9 2003
//Optimized for:     Athlon/P3
//Instructionset(s): IA32, MMX, SSE
//Size

procedure FillChar_DKC_SSE_9_d(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push  ebx
   push  esi
   push  edi
   //P := PAnsiChar(@Dest);
   mov   esi,eax
   //StopP2 := P + Count;
   lea   ebx,[edx+eax]
   //8 byte Align
 @Repeat3 :
   mov    [esi],cl
   add    esi,1
   sub    edx,1     //Decrement count
   mov    edi,esi
   and    edi,7
   test   edi,edi
   jnz    @Repeat3
   //Broadcast value
   mov    ch, cl
   movd   mm0, ecx
   pshufw mm0, mm0, 0
   //I := 0;
   xor    eax,eax
   sub    edx,15
   cmp    edx,256000
   ja     @Repeat4
 @Repeat1 :
   movq   [esi+eax],  mm0
   movq   [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat1
   jmp    @Repeat4End
 @Repeat4 :
   movntq [esi+eax],  mm0
   movntq [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat4
 @Repeat4End :
   emms
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/9 2003
//Optimized for:     Athlon/P3 512 kb cache
//Instructionset(s): IA32, MMX, SSE
//Size

procedure FillChar_DKC_SSE_14_a(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push   ebx
   push   esi
   push   edi
   //P := PAnsiChar(@Dest);
   mov    esi,eax
   //StopP2 := P + Count;
   lea    ebx,[edx+eax]
   //Broadcast value
   mov    ch, cl
   movd   mm0, ecx
   pshufw mm0, mm0, 0
   movq   [esi],mm0
   //8 byte Align
   mov    edi,esi
   and    edi,7
   mov    eax,8
   sub    eax,edi
   add    esi,eax
   sub    edx,eax
   //I := 0;
   xor    eax,eax
   sub    edx,15
   cmp    edx,524288
   ja     @Repeat4
 @Repeat1 :
   movq   [esi+eax],  mm0
   movq   [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat1
   jmp    @Repeat4End
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @Repeat4 :
   movntq [esi+eax],  mm0
   movntq [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat4
 @Repeat4End :
   emms
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/9 2003
//Optimized for:     Athlon/P3 512 kb cache
//Instructionset(s): IA32, MMX, SSE
//Size

procedure FillChar_DKC_SSE_14_b(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push   ebx
   push   esi
   push   edi
   //P := PAnsiChar(@Dest);
   mov    esi,eax
   //StopP2 := P + Count;
   lea    ebx,[edx+eax]
   //Broadcast value
   mov    ch, cl
   movd   mm0, ecx
   pshufw mm0, mm0, 0
   movq   [esi],  mm0
   //8 byte Align
   mov    edi,esi
   and    edi,7
   mov    eax,8
   sub    eax,edi
   add    esi,eax
   sub    edx,eax
   //I := 0;
   xor    eax,eax
   sub    edx,15
   cmp    edx,524288
   ja     @Repeat4
 @Repeat1 :
   movq   [esi+eax],  mm0
   movq   [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat1
   jmp    @Repeat4End
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @Repeat4 :
   movntq [esi+eax],  mm0
   movntq [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat4
 @Repeat4End :
   emms
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/9 2003
//Optimized for:     Athlon/P3 512 kb cache
//Instructionset(s): IA32, MMX, SSE
//Size

procedure FillChar_DKC_SSE_14_c(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push   ebx
   push   esi
   push   edi
   //P := PAnsiChar(@Dest);
   mov    esi,eax
   //StopP2 := P + Count;
   lea    ebx,[edx+eax]
   //Broadcast value
   mov    ch, cl
   movd   mm0, ecx
   pshufw mm0, mm0, 0
   movq   [esi],  mm0
   //8 byte Align
   mov    edi,esi
   and    edi,7
   mov    eax,8
   sub    eax,edi
   add    esi,eax
   sub    edx,eax
   //I := 0;
   xor    eax,eax
   sub    edx,15
   cmp    edx,524288
   ja     @Repeat4
 @Repeat1 :
   movq   [esi+eax],  mm0
   movq   [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat1
   jmp    @Repeat4End
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @Repeat4 :
   movntq [esi+eax],  mm0
   movntq [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat4
 @Repeat4End :
   emms
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/9 2003
//Optimized for:     Athlon/P3 512 kb cache
//Instructionset(s): IA32, MMX, SSE
//Size

procedure FillChar_DKC_SSE_14_d(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 24 bytes here. Max 8 for alignment and 16 for loop
   push   ebx
   push   esi
   push   edi
   //P := PAnsiChar(@Dest);
   mov    esi,eax
   //StopP2 := P + Count;
   lea    ebx,[edx+eax]
   //Broadcast value
   mov    ch, cl
   movd   mm0, ecx
   pshufw mm0, mm0, 0
   movq   [esi],  mm0
   //8 byte Align
   mov    edi,esi
   and    edi,7
   mov    eax,8
   sub    eax,edi
   add    esi,eax
   sub    edx,eax
   //I := 0;
   xor    eax,eax
   sub    edx,15
   cmp    edx,524288
   ja     @Repeat4
 @Repeat1 :
   movq   [esi+eax],  mm0
   movq   [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat1
   jmp    @Repeat4End
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
 @Repeat4 :
   movntq [esi+eax],  mm0
   movntq [esi+eax+8],mm0
   add    eax,16
   cmp    eax,edx
   jl     @Repeat4
 @Repeat4End :
   emms
   //Fill the rest if any
   add   esi,eax
   cmp   esi,ebx
   jnb   @Exit1
 @Repeat2 :
   mov   [esi],cl
   add   esi,1
   cmp   esi,ebx
   jb    @Repeat2
 @Exit1 :
   pop   edi
   pop   esi
   pop   ebx
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              23/9 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure FillCharDKC_SSE2_3_a(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   Jmp  @Exit2
 @CaseCount1 :
   mov  [eax],cl
   jmp  @Exit2
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   jmp  @Exit2
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   jmp  @Exit2
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   jmp  @Exit2
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   jmp  @Exit2
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   jmp  @Exit2
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   jmp  @Exit2
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   jmp  @Exit2
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   jmp  @Exit2
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   jmp  @Exit2
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   jmp  @Exit2
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   jmp  @Exit2
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   jmp  @Exit2
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   jmp  @Exit2
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   jmp  @Exit2
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   jmp  @Exit2
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   jmp  @Exit2
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   jmp  @Exit2
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   jmp  @Exit2
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   jmp   @Exit2
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   jmp   @Exit2
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   jmp   @Exit2
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   jmp   @Exit2
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   jmp   @Exit2
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   jmp   @Exit2
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   jmp   @Exit2
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   jmp   @Exit2
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   jmp   @Exit2
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   jmp   @Exit2
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   jmp   @Exit2
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   jmp   @Exit2
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    ebx
   push    esi
   push    edi
   //P := PAnsiChar(@Dest);
   mov     esi,eax
   //StopP2 := P + Count;
   lea     ebx,[edx+eax]
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   movdqu  [esi],xmm0
   //16 byte Align
   mov     edi,esi
   and     edi,$F
   mov     eax,16
   sub     eax,edi
   add     esi,eax
   sub     edx,eax
   //I := 0;
   xor     eax,eax
   sub     edx,15
   cmp     edx,524288
   ja      @Repeat4
 @Repeat1 :
   movdqa  [esi+eax],xmm0
   add     eax,16
   cmp     eax,edx
   jl      @Repeat1
   jmp     @Repeat4End
 @Repeat4 :
   movntdq [esi+eax],xmm0
   add     eax,16
   cmp     eax,edx
   jl      @Repeat4
 @Repeat4End :
   //Fill the rest if any
   add     esi,eax
   cmp     esi,ebx
   jnb     @Exit1
 @Repeat2 :
   mov     [esi],cl
   add     esi,1
   cmp     esi,ebx
   jnb     @Exit1
   mov     [esi],cl
   add     esi,1
   cmp     esi,ebx
   jb      @Repeat2
 @Exit1 :
   pop     edi
   pop     esi
   pop     ebx
 @Exit2 :
   ret
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              23/9 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure FillCharDKC_SSE2_3_b(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   Jmp  @Exit2
 @CaseCount1 :
   mov  [eax],cl
   jmp  @Exit2
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   jmp  @Exit2
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   jmp  @Exit2
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   jmp  @Exit2
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   jmp  @Exit2
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   jmp  @Exit2
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   jmp  @Exit2
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   jmp  @Exit2
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   jmp  @Exit2
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   jmp  @Exit2
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   jmp  @Exit2
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   jmp  @Exit2
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   jmp  @Exit2
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   jmp  @Exit2
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   jmp  @Exit2
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   jmp  @Exit2
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   jmp  @Exit2
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   jmp  @Exit2
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   jmp  @Exit2
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   jmp   @Exit2
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   jmp   @Exit2
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   jmp   @Exit2
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   jmp   @Exit2
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   jmp   @Exit2
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   jmp   @Exit2
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   jmp   @Exit2
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   jmp   @Exit2
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   jmp   @Exit2
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   jmp   @Exit2
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   jmp   @Exit2
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   jmp   @Exit2
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    ebx
   push    esi
   push    edi
   //P := PAnsiChar(@Dest);
   mov     esi,eax
   //StopP2 := P + Count;
   lea     ebx,[edx+eax]
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   movdqu  [esi],xmm0
   //16 byte Align
   mov     edi,esi
   and     edi,$F
   mov     eax,16
   sub     eax,edi
   add     esi,eax
   sub     edx,eax
   //I := 0;
   xor     eax,eax
   sub     edx,15
   cmp     edx,524288
   ja      @Repeat4
 @Repeat1 :
   movdqa  [esi+eax],xmm0
   add     eax,16
   cmp     eax,edx
   jl      @Repeat1
   jmp     @Repeat4End
 @Repeat4 :
   movntdq [esi+eax],xmm0
   add     eax,16
   cmp     eax,edx
   jl      @Repeat4
 @Repeat4End :
   //Fill the rest if any
   add     esi,eax
   cmp     esi,ebx
   jnb     @Exit1
 @Repeat2 :
   mov     [esi],cl
   add     esi,1
   cmp     esi,ebx
   jnb     @Exit1
   mov     [esi],cl
   add     esi,1
   cmp     esi,ebx
   jb      @Repeat2
 @Exit1 :
   pop     edi
   pop     esi
   pop     ebx
 @Exit2 :
   ret
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              23/9 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure FillCharDKC_SSE2_3_c(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   Jmp  @Exit2
 @CaseCount1 :
   mov  [eax],cl
   jmp  @Exit2
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   jmp  @Exit2
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   jmp  @Exit2
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   jmp  @Exit2
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   jmp  @Exit2
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   jmp  @Exit2
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   jmp  @Exit2
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   jmp  @Exit2
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   jmp  @Exit2
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   jmp  @Exit2
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   jmp  @Exit2
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   jmp  @Exit2
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   jmp  @Exit2
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   jmp  @Exit2
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   jmp  @Exit2
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   jmp  @Exit2
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   jmp  @Exit2
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   jmp  @Exit2
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   jmp  @Exit2
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   jmp   @Exit2
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   jmp   @Exit2
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   jmp   @Exit2
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   jmp   @Exit2
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   jmp   @Exit2
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   jmp   @Exit2
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   jmp   @Exit2
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   jmp   @Exit2
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   jmp   @Exit2
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   jmp   @Exit2
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   jmp   @Exit2
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   jmp   @Exit2
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    ebx
   push    esi
   push    edi
   //P := PAnsiChar(@Dest);
   mov     esi,eax
   //StopP2 := P + Count;
   lea     ebx,[edx+eax]
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   movdqu  [esi],xmm0
   //16 byte Align
   mov     edi,esi
   and     edi,$F
   mov     eax,16
   sub     eax,edi
   add     esi,eax
   sub     edx,eax
   //I := 0;
   xor     eax,eax
   sub     edx,15
   cmp     edx,524288
   ja      @Repeat4
 @Repeat1 :
   movdqa  [esi+eax],xmm0
   add     eax,16
   cmp     eax,edx
   jl      @Repeat1
   jmp     @Repeat4End
 @Repeat4 :
   movntdq [esi+eax],xmm0
   add     eax,16
   cmp     eax,edx
   jl      @Repeat4
 @Repeat4End :
   //Fill the rest if any
   add     esi,eax
   cmp     esi,ebx
   jnb     @Exit1
 @Repeat2 :
   mov     [esi],cl
   add     esi,1
   cmp     esi,ebx
   jnb     @Exit1
   mov     [esi],cl
   add     esi,1
   cmp     esi,ebx
   jb      @Repeat2
 @Exit1 :
   pop     edi
   pop     esi
   pop     ebx
 @Exit2 :
   ret
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              23/9 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure FillCharDKC_SSE2_3_d(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   Jmp  @Exit2
 @CaseCount1 :
   mov  [eax],cl
   jmp  @Exit2
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   jmp  @Exit2
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   jmp  @Exit2
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   jmp  @Exit2
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   jmp  @Exit2
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   jmp  @Exit2
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   jmp  @Exit2
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   jmp  @Exit2
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   jmp  @Exit2
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   jmp  @Exit2
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   jmp  @Exit2
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   jmp  @Exit2
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   jmp  @Exit2
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   jmp  @Exit2
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   jmp  @Exit2
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   jmp  @Exit2
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   jmp  @Exit2
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   jmp  @Exit2
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   jmp  @Exit2
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   jmp   @Exit2
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   jmp   @Exit2
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   jmp   @Exit2
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   jmp   @Exit2
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   jmp   @Exit2
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   jmp   @Exit2
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   jmp   @Exit2
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   jmp   @Exit2
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   jmp   @Exit2
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   jmp   @Exit2
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   jmp   @Exit2
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   jmp   @Exit2
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    ebx
   push    esi
   push    edi
   //P := PAnsiChar(@Dest);
   mov     esi,eax
   //StopP2 := P + Count;
   lea     ebx,[edx+eax]
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   movdqu  [esi],xmm0
   //16 byte Align
   mov     edi,esi
   and     edi,$F
   mov     eax,16
   sub     eax,edi
   add     esi,eax
   sub     edx,eax
   //I := 0;
   xor     eax,eax
   sub     edx,15
   cmp     edx,524288
   ja      @Repeat4
 @Repeat1 :
   movdqa  [esi+eax],xmm0
   add     eax,16
   cmp     eax,edx
   jl      @Repeat1
   jmp     @Repeat4End
 @Repeat4 :
   movntdq [esi+eax],xmm0
   add     eax,16
   cmp     eax,edx
   jl      @Repeat4
 @Repeat4End :
   //Fill the rest if any
   add     esi,eax
   cmp     esi,ebx
   jnb     @Exit1
 @Repeat2 :
   mov     [esi],cl
   add     esi,1
   cmp     esi,ebx
   jnb     @Exit1
   mov     [esi],cl
   add     esi,1
   cmp     esi,ebx
   jb      @Repeat2
 @Exit1 :
   pop     edi
   pop     esi
   pop     ebx
 @Exit2 :
   ret
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/12 2003
//Optimized for:     Opteron
//Instructionset(s): IA32, MMX, SSE, SSE2
//Size

procedure FillChar_DKC_SSE2_10_a(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    esi
   push    edi
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   //Fill first 16 non aligned bytes
   movdqu  [eax],xmm0
   //StopP2 := P + Count;
   lea     ecx,[eax+edx]
   //16 byte Align
   mov     edi,eax
   and     edi,$F
   mov     esi,16
   sub     esi,edi
   add     eax,esi
   sub     edx,esi
   //I := 0;
   xor     esi,esi
   sub     edx,15
   cmp     edx,1048576
   ja      @Repeat4
 @Repeat1 :
   movdqa  [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat1
   jmp     @Repeat4End
   nop
   nop
 @Repeat4 :
   movntdq [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat4
 @Repeat4End :
   {movdq2q mm0,xmm0
   movntq  [ecx-16],mm0
   movntq  [ecx-8], mm0
   emms}
   //Fill the rest
   movdqu [ecx-16],xmm0
 @Exit1 :
   pop   edi
   pop   esi
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/12 2003
//Optimized for:     Opteron
//Instructionset(s): IA32, MMX, SSE, SSE2
//Size

procedure FillChar_DKC_SSE2_10_b(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    esi
   push    edi
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   //Fill first 16 non aligned bytes
   movdqu  [eax],xmm0
   //StopP2 := P + Count;
   lea     ecx,[eax+edx]
   //16 byte Align
   mov     edi,eax
   and     edi,$F
   mov     esi,16
   sub     esi,edi
   add     eax,esi
   sub     edx,esi
   //I := 0;
   xor     esi,esi
   sub     edx,15
   cmp     edx,1048576
   ja      @Repeat4
 @Repeat1 :
   movdqa  [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat1
   jmp     @Repeat4End
   nop
   nop
 @Repeat4 :
   movntdq [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat4
 @Repeat4End :
   {movdq2q mm0,xmm0
   movntq  [ecx-16],mm0
   movntq  [ecx-8], mm0
   emms}
   //Fill the rest
   movdqu [ecx-16],xmm0
 @Exit1 :
   pop   edi
   pop   esi
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/12 2003
//Optimized for:     Opteron
//Instructionset(s): IA32, MMX, SSE, SSE2
//Size

procedure FillChar_DKC_SSE2_10_c(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    esi
   push    edi
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   //Fill first 16 non aligned bytes
   movdqu  [eax],xmm0
   //StopP2 := P + Count;
   lea     ecx,[eax+edx]
   //16 byte Align
   mov     edi,eax
   and     edi,$F
   mov     esi,16
   sub     esi,edi
   add     eax,esi
   sub     edx,esi
   //I := 0;
   xor     esi,esi
   sub     edx,15
   cmp     edx,1048576
   ja      @Repeat4
 @Repeat1 :
   movdqa  [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat1
   jmp     @Repeat4End
   nop
   nop
 @Repeat4 :
   movntdq [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat4
 @Repeat4End :
   {movdq2q mm0,xmm0
   movntq  [ecx-16],mm0
   movntq  [ecx-8], mm0
   emms}
   //Fill the rest
   movdqu [ecx-16],xmm0
 @Exit1 :
   pop   edi
   pop   esi
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/12 2003
//Optimized for:     Opteron
//Instructionset(s): IA32, MMX, SSE, SSE2
//Size

procedure FillChar_DKC_SSE2_10_d(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   ret
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   ret
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   ret
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   ret
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   ret
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   ret
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   ret
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   ret
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   ret
   nop
   nop
   nop
   nop
   nop
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    esi
   push    edi
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   //Fill first 16 non aligned bytes
   movdqu  [eax],xmm0
   //StopP2 := P + Count;
   lea     ecx,[eax+edx]
   //16 byte Align
   mov     edi,eax
   and     edi,$F
   mov     esi,16
   sub     esi,edi
   add     eax,esi
   sub     edx,esi
   //I := 0;
   xor     esi,esi
   sub     edx,15
   cmp     edx,1048576
   ja      @Repeat4
 @Repeat1 :
   movdqa  [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat1
   jmp     @Repeat4End
   nop
   nop
 @Repeat4 :
   movntdq [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat4
 @Repeat4End :
   {movdq2q mm0,xmm0
   movntq  [ecx-16],mm0
   movntq  [ecx-8], mm0
   emms}
   //Fill the rest
   movdqu [ecx-16],xmm0
 @Exit1 :
   pop   edi
   pop   esi
 @Exit2 :
   ret
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/12 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure FillChar_DKC_SSE2_11_a(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   Jmp  @Exit2
 @CaseCount1 :
   mov  [eax],cl
   jmp  @Exit2
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   jmp  @Exit2
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   jmp  @Exit2
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   jmp  @Exit2
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   jmp  @Exit2
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   jmp  @Exit2
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   jmp  @Exit2
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   jmp  @Exit2
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   jmp  @Exit2
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   jmp  @Exit2
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   jmp  @Exit2
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   jmp  @Exit2
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   jmp  @Exit2
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   jmp  @Exit2
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   jmp  @Exit2
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   jmp  @Exit2
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   jmp  @Exit2
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   jmp  @Exit2
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   jmp  @Exit2
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   jmp   @Exit2
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   jmp   @Exit2
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   jmp   @Exit2
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   jmp   @Exit2
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   jmp   @Exit2
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   jmp   @Exit2
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   jmp   @Exit2
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   jmp   @Exit2
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   jmp   @Exit2
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   jmp   @Exit2
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   jmp   @Exit2
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   jmp   @Exit2
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    esi
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   movdqu  [eax],xmm0
   //StopP2 := P + Count;
   lea     ecx,[eax+edx]
   //Fill the rest
   movdqu [ecx-16],xmm0
   //16 byte Align
   mov     ecx,eax
   and     ecx,$F
   mov     esi,16
   sub     esi,ecx
   add     eax,esi
   sub     edx,esi
   //I := 0;
   xor     esi,esi
   sub     edx,15
   cmp     edx,524288
   ja      @Repeat4
 @Repeat1 :
   movdqa  [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat1
   jmp     @Exit1
 @Repeat4 :
   movntdq [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat4
 @Exit1 :
   pop     esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/12 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure FillChar_DKC_SSE2_11_b(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   Jmp  @Exit2
 @CaseCount1 :
   mov  [eax],cl
   jmp  @Exit2
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   jmp  @Exit2
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   jmp  @Exit2
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   jmp  @Exit2
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   jmp  @Exit2
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   jmp  @Exit2
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   jmp  @Exit2
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   jmp  @Exit2
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   jmp  @Exit2
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   jmp  @Exit2
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   jmp  @Exit2
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   jmp  @Exit2
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   jmp  @Exit2
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   jmp  @Exit2
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   jmp  @Exit2
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   jmp  @Exit2
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   jmp  @Exit2
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   jmp  @Exit2
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   jmp  @Exit2
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   jmp   @Exit2
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   jmp   @Exit2
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   jmp   @Exit2
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   jmp   @Exit2
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   jmp   @Exit2
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   jmp   @Exit2
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   jmp   @Exit2
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   jmp   @Exit2
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   jmp   @Exit2
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   jmp   @Exit2
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   jmp   @Exit2
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   jmp   @Exit2
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    esi
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   movdqu  [eax],xmm0
   //StopP2 := P + Count;
   lea     ecx,[eax+edx]
   //Fill the rest
   movdqu [ecx-16],xmm0
   //16 byte Align
   mov     ecx,eax
   and     ecx,$F
   mov     esi,16
   sub     esi,ecx
   add     eax,esi
   sub     edx,esi
   //I := 0;
   xor     esi,esi
   sub     edx,15
   cmp     edx,524288
   ja      @Repeat4
 @Repeat1 :
   movdqa  [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat1
   jmp     @Exit1
 @Repeat4 :
   movntdq [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat4
 @Exit1 :
   pop     esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/12 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure FillChar_DKC_SSE2_11_c(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   Jmp  @Exit2
 @CaseCount1 :
   mov  [eax],cl
   jmp  @Exit2
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   jmp  @Exit2
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   jmp  @Exit2
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   jmp  @Exit2
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   jmp  @Exit2
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   jmp  @Exit2
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   jmp  @Exit2
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   jmp  @Exit2
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   jmp  @Exit2
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   jmp  @Exit2
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   jmp  @Exit2
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   jmp  @Exit2
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   jmp  @Exit2
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   jmp  @Exit2
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   jmp  @Exit2
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   jmp  @Exit2
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   jmp  @Exit2
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   jmp  @Exit2
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   jmp  @Exit2
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   jmp   @Exit2
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   jmp   @Exit2
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   jmp   @Exit2
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   jmp   @Exit2
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   jmp   @Exit2
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   jmp   @Exit2
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   jmp   @Exit2
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   jmp   @Exit2
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   jmp   @Exit2
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   jmp   @Exit2
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   jmp   @Exit2
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   jmp   @Exit2
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    esi
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   movdqu  [eax],xmm0
   //StopP2 := P + Count;
   lea     ecx,[eax+edx]
   //Fill the rest
   movdqu [ecx-16],xmm0
   //16 byte Align
   mov     ecx,eax
   and     ecx,$F
   mov     esi,16
   sub     esi,ecx
   add     eax,esi
   sub     edx,esi
   //I := 0;
   xor     esi,esi
   sub     edx,15
   cmp     edx,524288
   ja      @Repeat4
 @Repeat1 :
   movdqa  [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat1
   jmp     @Exit1
 @Repeat4 :
   movntdq [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat4
 @Exit1 :
   pop     esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              22/12 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure FillChar_DKC_SSE2_11_d(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   Jmp  @Exit2
 @CaseCount1 :
   mov  [eax],cl
   jmp  @Exit2
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   jmp  @Exit2
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   jmp  @Exit2
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   jmp  @Exit2
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   jmp  @Exit2
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   jmp  @Exit2
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   jmp  @Exit2
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   jmp  @Exit2
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   jmp  @Exit2
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   jmp  @Exit2
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   jmp  @Exit2
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   jmp  @Exit2
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   jmp  @Exit2
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   jmp  @Exit2
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   jmp  @Exit2
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   jmp  @Exit2
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   jmp  @Exit2
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   jmp  @Exit2
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   jmp  @Exit2
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   jmp   @Exit2
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   jmp   @Exit2
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   jmp   @Exit2
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   jmp   @Exit2
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   jmp   @Exit2
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   jmp   @Exit2
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   jmp   @Exit2
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   jmp   @Exit2
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   jmp   @Exit2
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   jmp   @Exit2
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   jmp   @Exit2
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   jmp   @Exit2
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    esi
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   movdqu  [eax],xmm0
   //StopP2 := P + Count;
   lea     ecx,[eax+edx]
   //Fill the rest
   movdqu [ecx-16],xmm0
   //16 byte Align
   mov     ecx,eax
   and     ecx,$F
   mov     esi,16
   sub     esi,ecx
   add     eax,esi
   sub     edx,esi
   //I := 0;
   xor     esi,esi
   sub     edx,15
   cmp     edx,524288
   ja      @Repeat4
 @Repeat1 :
   movdqa  [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat1
   jmp     @Exit1
 @Repeat4 :
   movntdq [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat4
 @Exit1 :
   pop     esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     P4
//Instructionset(s): IA32, MMX, SSE, SSE2

procedure FillCharDKC_SSE2_12_a(var Dest; Count: NativeInt; Value: AnsiChar);
asm
   test edx,edx
   jle  @Exit2
   //case Count of
   cmp  edx,31
   jnbe @CaseElse
   jmp  dword ptr [edx*4+@Case1JmpTable]
 @CaseCount0 :
   ret
 @CaseCount1 :
   mov  [eax],cl
   ret
 @CaseCount2 :
   mov  ch,cl
   mov  [eax],cx
   ret
 @CaseCount3 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cl
   ret
 @CaseCount4 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   ret
 @CaseCount5 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cl
   ret
 @CaseCount6 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   ret
 @CaseCount7 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cl
   ret
 @CaseCount8 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   ret
 @CaseCount9 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cl
   ret
 @CaseCount10 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   ret
 @CaseCount11 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cl
   ret
 @CaseCount12 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   ret
 @CaseCount13 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cl
   ret
 @CaseCount14 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   ret
 @CaseCount15 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cl
   ret
 @CaseCount16 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   ret
 @CaseCount17 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cl
   ret
 @CaseCount18 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   ret
 @CaseCount19 :
   mov  ch,cl
   mov  [eax],cx
   mov  [eax+2],cx
   mov  [eax+4],cx
   mov  [eax+6],cx
   mov  [eax+8],cx
   mov  [eax+10],cx
   mov  [eax+12],cx
   mov  [eax+14],cx
   mov  [eax+16],cx
   mov  [eax+18],cl
   ret
 @CaseCount20 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   jmp   @Exit2
 @CaseCount21 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cl
   jmp   @Exit2
 @CaseCount22 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   jmp   @Exit2
 @CaseCount23 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cl
   jmp   @Exit2
 @CaseCount24 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   jmp   @Exit2
 @CaseCount25 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cl
   jmp   @Exit2
 @CaseCount26 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   jmp   @Exit2
 @CaseCount27 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cl
   jmp   @Exit2
 @CaseCount28 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   //jmp   @Exit2
   ret
 @CaseCount29 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cl
   //jmp   @Exit2
   ret
 @CaseCount30 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   //jmp   @Exit2
   ret
 @CaseCount31 :
   mov   ch,cl
   mov   [eax],cx
   mov   [eax+2],cx
   mov   [eax+4],cx
   mov   [eax+6],cx
   mov   [eax+8],cx
   mov   [eax+10],cx
   mov   [eax+12],cx
   mov   [eax+14],cx
   mov   [eax+16],cx
   mov   [eax+18],cx
   mov   [eax+20],cx
   mov   [eax+22],cx
   mov   [eax+24],cx
   mov   [eax+26],cx
   mov   [eax+28],cx
   mov   [eax+30],cl
   //jmp   @Exit2
   ret
 @CaseElse :
   //Need at least 32 bytes here. Max 16 for alignment and 16 for loop
   push    esi
   //Broadcast value
   mov     ch, cl
   movd    xmm0, ecx
   pshuflw xmm0, xmm0, 0
   pshufd  xmm0, xmm0, 0
   movdqu  [eax],xmm0
   //Fill the rest
   movdqu  [eax+edx-16],xmm0
   //16 byte Align
   mov     ecx,eax
   and     ecx,$F
   mov     esi,16
   sub     esi,ecx
   add     eax,esi
   sub     edx,esi
   //I := 0;
   xor     esi,esi
   sub     edx,15
   cmp     edx,524288
   ja      @Repeat4
 @Repeat1 :
   movdqa  [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat1
   jmp     @Exit1
 @Repeat4 :
   movntdq [eax+esi],xmm0
   add     esi,16
   cmp     esi,edx
   jl      @Repeat4
 @Exit1 :
   pop     esi
 @Exit2 :
   ret

@Case1JmpTable:
 dd @CaseCount0
 dd @CaseCount1
 dd @CaseCount2
 dd @CaseCount3
 dd @CaseCount4
 dd @CaseCount5
 dd @CaseCount6
 dd @CaseCount7
 dd @CaseCount8
 dd @CaseCount9
 dd @CaseCount10
 dd @CaseCount11
 dd @CaseCount12
 dd @CaseCount13
 dd @CaseCount14
 dd @CaseCount15
 dd @CaseCount16
 dd @CaseCount17
 dd @CaseCount18
 dd @CaseCount19
 dd @CaseCount20
 dd @CaseCount21
 dd @CaseCount22
 dd @CaseCount23
 dd @CaseCount24
 dd @CaseCount25
 dd @CaseCount26
 dd @CaseCount27
 dd @CaseCount28
 dd @CaseCount29
 dd @CaseCount30
 dd @CaseCount31

end;

initialization
 Filler1;
 Filler2;
 Filler3;
{$ENDIF WIN32}


end.
