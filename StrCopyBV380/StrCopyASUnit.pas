unit StrCopyASUnit;

interface

function StrCopy_AS_IA32_5_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_AS_IA32_5_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_AS_IA32_5_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_AS_IA32_5_d(Dest: PChar; const Source: PChar): PChar;
function StrCopy_AS_IA32_6_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_AS_IA32_6_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_AS_IA32_6_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_AS_IA32_6_d(Dest: PChar; const Source: PChar): PChar;

implementation

function StrCopy_AS_IA32_5_a(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+2]
  jz     @Move2

  xor     ch, [eax+edx+3]
  mov     [eax+2], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+6]
  jz     @Move4

  xor     ch, [eax+edx+7]
  mov     [eax+6], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+10]
  jz     @Move6

  xor     ch, [eax+edx+11]
  mov     [eax+10], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+14]
  jz     @Move8

  xor     ch, [eax+edx+15]
  mov     [eax+14], cx
  jnz    @Block2

@Endit1:

  pop     eax
  ret

@Move1:

  mov     [eax], cl
  pop     eax
  ret

@Move2:

  mov     [eax+2], cl
  pop     eax
  ret

@Move3:

  mov     [eax+4], cl
  pop     eax
  ret

@Move4:

  mov     [eax+6], cl
  pop     eax
  ret

@Move5:

  mov     [eax+8], cl
  pop     eax
  ret

@Move6:

  mov     [eax+10], cl
  pop     eax
  ret

@Move7:

  mov     [eax+12], cl
  pop     eax
  ret

@Move8:

  mov     [eax+14], cl
  pop     eax
  ret

@block2:

  xor     ecx, ecx
  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+18]
  jz      @Move10

  xor     ch, [eax+edx+19]
  mov     [eax+18], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+22]
  jz       @Move12

  xor     ch, [eax+edx+23]
  mov     [eax+22], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+26]
  jz      @Move14

  xor     ch, [eax+edx+27]
  mov     [eax+26], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+30]
  jz      @Move16

  xor     ch, [eax+edx+31]
  mov     [eax+30], cx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Endit2:

  pop    eax
  ret

@Move9:

  mov    [eax+16], cl
  pop    eax
  ret

@Move10:

  mov    [eax+18], cl
  pop    eax
  ret

@Move11:

  mov    [eax+20], cl
  pop    eax
  ret

@Move12:

  mov    [eax+22], cl
  pop    eax
  ret

@Move13:

  mov    [eax+24], cl
  pop    eax
  ret

@Move14:

  mov    [eax+26], cl
  pop    eax
  ret

@Move15:

  mov    [eax+28], cl
  pop    eax
  ret

@Move16:

  mov    [eax+30], cl
  pop    eax

end;

procedure Filler1;
asm
 nop
end;

function StrCopy_AS_IA32_5_b(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+2]
  jz     @Move2

  xor     ch, [eax+edx+3]
  mov     [eax+2], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+6]
  jz     @Move4

  xor     ch, [eax+edx+7]
  mov     [eax+6], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+10]
  jz     @Move6

  xor     ch, [eax+edx+11]
  mov     [eax+10], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+14]
  jz     @Move8

  xor     ch, [eax+edx+15]
  mov     [eax+14], cx
  jnz    @Block2

@Endit1:

  pop     eax
  ret

@Move1:

  mov     [eax], cl
  pop     eax
  ret

@Move2:

  mov     [eax+2], cl
  pop     eax
  ret

@Move3:

  mov     [eax+4], cl
  pop     eax
  ret

@Move4:

  mov     [eax+6], cl
  pop     eax
  ret

@Move5:

  mov     [eax+8], cl
  pop     eax
  ret

@Move6:

  mov     [eax+10], cl
  pop     eax
  ret

@Move7:

  mov     [eax+12], cl
  pop     eax
  ret

@Move8:

  mov     [eax+14], cl
  pop     eax
  ret

@block2:

  xor     ecx, ecx
  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+18]
  jz      @Move10

  xor     ch, [eax+edx+19]
  mov     [eax+18], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+22]
  jz       @Move12

  xor     ch, [eax+edx+23]
  mov     [eax+22], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+26]
  jz      @Move14

  xor     ch, [eax+edx+27]
  mov     [eax+26], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+30]
  jz      @Move16

  xor     ch, [eax+edx+31]
  mov     [eax+30], cx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Endit2:

  pop    eax
  ret

@Move9:

  mov    [eax+16], cl
  pop    eax
  ret

@Move10:

  mov    [eax+18], cl
  pop    eax
  ret

@Move11:

  mov    [eax+20], cl
  pop    eax
  ret

@Move12:

  mov    [eax+22], cl
  pop    eax
  ret

@Move13:

  mov    [eax+24], cl
  pop    eax
  ret

@Move14:

  mov    [eax+26], cl
  pop    eax
  ret

@Move15:

  mov    [eax+28], cl
  pop    eax
  ret

@Move16:

  mov    [eax+30], cl
  pop    eax

end;

procedure Filler2;
asm
 nop
end;

function StrCopy_AS_IA32_5_c(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+2]
  jz     @Move2

  xor     ch, [eax+edx+3]
  mov     [eax+2], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+6]
  jz     @Move4

  xor     ch, [eax+edx+7]
  mov     [eax+6], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+10]
  jz     @Move6

  xor     ch, [eax+edx+11]
  mov     [eax+10], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+14]
  jz     @Move8

  xor     ch, [eax+edx+15]
  mov     [eax+14], cx
  jnz    @Block2

@Endit1:

  pop     eax
  ret

@Move1:

  mov     [eax], cl
  pop     eax
  ret

@Move2:

  mov     [eax+2], cl
  pop     eax
  ret

@Move3:

  mov     [eax+4], cl
  pop     eax
  ret

@Move4:

  mov     [eax+6], cl
  pop     eax
  ret

@Move5:

  mov     [eax+8], cl
  pop     eax
  ret

@Move6:

  mov     [eax+10], cl
  pop     eax
  ret

@Move7:

  mov     [eax+12], cl
  pop     eax
  ret

@Move8:

  mov     [eax+14], cl
  pop     eax
  ret

@block2:

  xor     ecx, ecx
  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+18]
  jz      @Move10

  xor     ch, [eax+edx+19]
  mov     [eax+18], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+22]
  jz       @Move12

  xor     ch, [eax+edx+23]
  mov     [eax+22], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+26]
  jz      @Move14

  xor     ch, [eax+edx+27]
  mov     [eax+26], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+30]
  jz      @Move16

  xor     ch, [eax+edx+31]
  mov     [eax+30], cx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Endit2:

  pop    eax
  ret

@Move9:

  mov    [eax+16], cl
  pop    eax
  ret

@Move10:

  mov    [eax+18], cl
  pop    eax
  ret

@Move11:

  mov    [eax+20], cl
  pop    eax
  ret

@Move12:

  mov    [eax+22], cl
  pop    eax
  ret

@Move13:

  mov    [eax+24], cl
  pop    eax
  ret

@Move14:

  mov    [eax+26], cl
  pop    eax
  ret

@Move15:

  mov    [eax+28], cl
  pop    eax
  ret

@Move16:

  mov    [eax+30], cl
  pop    eax

end;

procedure Filler3;
asm
 nop
end;

function StrCopy_AS_IA32_5_d(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+2]
  jz     @Move2

  xor     ch, [eax+edx+3]
  mov     [eax+2], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+6]
  jz     @Move4

  xor     ch, [eax+edx+7]
  mov     [eax+6], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+10]
  jz     @Move6

  xor     ch, [eax+edx+11]
  mov     [eax+10], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     ecx, ecx
  xor     cl, [eax+edx+14]
  jz     @Move8

  xor     ch, [eax+edx+15]
  mov     [eax+14], cx
  jnz    @Block2

@Endit1:

  pop     eax
  ret

@Move1:

  mov     [eax], cl
  pop     eax
  ret

@Move2:

  mov     [eax+2], cl
  pop     eax
  ret

@Move3:

  mov     [eax+4], cl
  pop     eax
  ret

@Move4:

  mov     [eax+6], cl
  pop     eax
  ret

@Move5:

  mov     [eax+8], cl
  pop     eax
  ret

@Move6:

  mov     [eax+10], cl
  pop     eax
  ret

@Move7:

  mov     [eax+12], cl
  pop     eax
  ret

@Move8:

  mov     [eax+14], cl
  pop     eax
  ret

@block2:

  xor     ecx, ecx
  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+18]
  jz      @Move10

  xor     ch, [eax+edx+19]
  mov     [eax+18], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+22]
  jz       @Move12

  xor     ch, [eax+edx+23]
  mov     [eax+22], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+26]
  jz      @Move14

  xor     ch, [eax+edx+27]
  mov     [eax+26], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     ecx, ecx
  xor     cl, [eax+edx+30]
  jz      @Move16

  xor     ch, [eax+edx+31]
  mov     [eax+30], cx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Endit2:

  pop    eax
  ret

@Move9:

  mov    [eax+16], cl
  pop    eax
  ret

@Move10:

  mov    [eax+18], cl
  pop    eax
  ret

@Move11:

  mov    [eax+20], cl
  pop    eax
  ret

@Move12:

  mov    [eax+22], cl
  pop    eax
  ret

@Move13:

  mov    [eax+24], cl
  pop    eax
  ret

@Move14:

  mov    [eax+26], cl
  pop    eax
  ret

@Move15:

  mov    [eax+28], cl
  pop    eax
  ret

@Move16:

  mov    [eax+30], cl
  pop    eax

end;

function StrCopy_AS_IA32_6_a(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  push    ebx
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     bl, [eax+edx+2]
  jz     @Move2

  xor     bh, [eax+edx+3]
  mov     [eax+2], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     bl, [eax+edx+6]
  jz     @Move4

  xor     bh, [eax+edx+7]
  mov     [eax+6], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     bl, [eax+edx+10]
  jz     @Move6

  xor     bh, [eax+edx+11]
  mov     [eax+10], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     bl, [eax+edx+14]
  jz     @Move8

  xor     bh, [eax+edx+15]
  mov     [eax+14], bx
  jnz    @Block2

@Endit1:

  pop     ebx
  pop     eax
  ret

@Move1:

  mov     [eax], cl
  jmp    @Endit1

@Move2:

  mov     [eax+2], bl
  jmp    @Endit1

@Move3:

  mov     [eax+4], cl
  jmp    @Endit1

@Move4:

  mov     [eax+6], bl
  jmp    @Endit1

@Move5:

  mov     [eax+8], cl
  jmp    @Endit1

@Move6:

  mov     [eax+10], bl
  jmp    @Endit1

@Move7:

  mov     [eax+12], cl
  jmp    @Endit1

@Move8:

  mov     [eax+14], bl
  jmp    @Endit1

@block2:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     bl, [eax+edx+18]
  jz      @Move10

  xor     bh, [eax+edx+19]
  mov     [eax+18], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     bl, [eax+edx+22]
  jz       @Move12

  xor     bh, [eax+edx+23]
  mov     [eax+22], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     bl, [eax+edx+26]
  jz      @Move14

  xor     bh, [eax+edx+27]
  mov     [eax+26], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     bl, [eax+edx+30]
  jz      @Move16

  xor     bh, [eax+edx+31]
  mov     [eax+30], bx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Move9:

  mov    [eax+16], cl
  jmp    @Endit2

@Move10:

  mov    [eax+18], bl
  jmp    @Endit2

@Move11:

  mov    [eax+20], cl
  jmp    @Endit2

@Move12:

  mov    [eax+22], bl
  jmp    @Endit2

@Move13:

  mov    [eax+24], cl
  jmp    @Endit2

@Move14:

  mov    [eax+26], bl
  jmp    @Endit2

@Move15:

  mov    [eax+28], cl
  jmp    @Endit2

@Move16:

  mov    [eax+30], bl

@Endit2:
  pop    ebx
  pop    eax

end;

procedure Filler4;
asm
 nop
end;

function StrCopy_AS_IA32_6_b(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  push    ebx
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     bl, [eax+edx+2]
  jz     @Move2

  xor     bh, [eax+edx+3]
  mov     [eax+2], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     bl, [eax+edx+6]
  jz     @Move4

  xor     bh, [eax+edx+7]
  mov     [eax+6], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     bl, [eax+edx+10]
  jz     @Move6

  xor     bh, [eax+edx+11]
  mov     [eax+10], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     bl, [eax+edx+14]
  jz     @Move8

  xor     bh, [eax+edx+15]
  mov     [eax+14], bx
  jnz    @Block2

@Endit1:

  pop     ebx
  pop     eax
  ret

@Move1:

  mov     [eax], cl
  jmp    @Endit1

@Move2:

  mov     [eax+2], bl
  jmp    @Endit1

@Move3:

  mov     [eax+4], cl
  jmp    @Endit1

@Move4:

  mov     [eax+6], bl
  jmp    @Endit1

@Move5:

  mov     [eax+8], cl
  jmp    @Endit1

@Move6:

  mov     [eax+10], bl
  jmp    @Endit1

@Move7:

  mov     [eax+12], cl
  jmp    @Endit1

@Move8:

  mov     [eax+14], bl
  jmp    @Endit1

@block2:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     bl, [eax+edx+18]
  jz      @Move10

  xor     bh, [eax+edx+19]
  mov     [eax+18], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     bl, [eax+edx+22]
  jz       @Move12

  xor     bh, [eax+edx+23]
  mov     [eax+22], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     bl, [eax+edx+26]
  jz      @Move14

  xor     bh, [eax+edx+27]
  mov     [eax+26], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     bl, [eax+edx+30]
  jz      @Move16

  xor     bh, [eax+edx+31]
  mov     [eax+30], bx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Move9:

  mov    [eax+16], cl
  jmp    @Endit2

@Move10:

  mov    [eax+18], bl
  jmp    @Endit2

@Move11:

  mov    [eax+20], cl
  jmp    @Endit2

@Move12:

  mov    [eax+22], bl
  jmp    @Endit2

@Move13:

  mov    [eax+24], cl
  jmp    @Endit2

@Move14:

  mov    [eax+26], bl
  jmp    @Endit2

@Move15:

  mov    [eax+28], cl
  jmp    @Endit2

@Move16:

  mov    [eax+30], bl

@Endit2:
  pop    ebx
  pop    eax

end;

procedure Filler5;
asm
 nop
end;

function StrCopy_AS_IA32_6_c(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  push    ebx
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     bl, [eax+edx+2]
  jz     @Move2

  xor     bh, [eax+edx+3]
  mov     [eax+2], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     bl, [eax+edx+6]
  jz     @Move4

  xor     bh, [eax+edx+7]
  mov     [eax+6], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     bl, [eax+edx+10]
  jz     @Move6

  xor     bh, [eax+edx+11]
  mov     [eax+10], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     bl, [eax+edx+14]
  jz     @Move8

  xor     bh, [eax+edx+15]
  mov     [eax+14], bx
  jnz    @Block2

@Endit1:

  pop     ebx
  pop     eax
  ret

@Move1:

  mov     [eax], cl
  jmp    @Endit1

@Move2:

  mov     [eax+2], bl
  jmp    @Endit1

@Move3:

  mov     [eax+4], cl
  jmp    @Endit1

@Move4:

  mov     [eax+6], bl
  jmp    @Endit1

@Move5:

  mov     [eax+8], cl
  jmp    @Endit1

@Move6:

  mov     [eax+10], bl
  jmp    @Endit1

@Move7:

  mov     [eax+12], cl
  jmp    @Endit1

@Move8:

  mov     [eax+14], bl
  jmp    @Endit1

@block2:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     bl, [eax+edx+18]
  jz      @Move10

  xor     bh, [eax+edx+19]
  mov     [eax+18], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     bl, [eax+edx+22]
  jz       @Move12

  xor     bh, [eax+edx+23]
  mov     [eax+22], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     bl, [eax+edx+26]
  jz      @Move14

  xor     bh, [eax+edx+27]
  mov     [eax+26], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     bl, [eax+edx+30]
  jz      @Move16

  xor     bh, [eax+edx+31]
  mov     [eax+30], bx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Move9:

  mov    [eax+16], cl
  jmp    @Endit2

@Move10:

  mov    [eax+18], bl
  jmp    @Endit2

@Move11:

  mov    [eax+20], cl
  jmp    @Endit2

@Move12:

  mov    [eax+22], bl
  jmp    @Endit2

@Move13:

  mov    [eax+24], cl
  jmp    @Endit2

@Move14:

  mov    [eax+26], bl
  jmp    @Endit2

@Move15:

  mov    [eax+28], cl
  jmp    @Endit2

@Move16:

  mov    [eax+30], bl

@Endit2:
  pop    ebx
  pop    eax

end;

procedure Filler6;
asm
 nop
end;

function StrCopy_AS_IA32_6_d(Dest: PChar; const Source: PChar): PChar;
asm

  push    eax
  push    ebx
  sub     edx, eax

@Loopme:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx]
  jz     @Move1

  xor     ch, [eax+edx+1]
  mov     [eax], cx
  jz     @EndIt1

  xor     bl, [eax+edx+2]
  jz     @Move2

  xor     bh, [eax+edx+3]
  mov     [eax+2], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+4]
  jz     @Move3

  xor     ch, [eax+edx+5]
  mov     [eax+4], cx
  jz     @EndIt1

  xor     bl, [eax+edx+6]
  jz     @Move4

  xor     bh, [eax+edx+7]
  mov     [eax+6], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+8]
  jz     @Move5

  xor     ch, [eax+edx+9]
  mov     [eax+8], cx
  jz     @EndIt1

  xor     bl, [eax+edx+10]
  jz     @Move6

  xor     bh, [eax+edx+11]
  mov     [eax+10], bx
  jz     @EndIt1

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+12]
  jz     @Move7

  xor     ch, [eax+edx+13]
  mov     [eax+12], cx
  jz     @EndIt1

  xor     bl, [eax+edx+14]
  jz     @Move8

  xor     bh, [eax+edx+15]
  mov     [eax+14], bx
  jnz    @Block2

@Endit1:

  pop     ebx
  pop     eax
  ret

@Move1:

  mov     [eax], cl
  jmp    @Endit1

@Move2:

  mov     [eax+2], bl
  jmp    @Endit1

@Move3:

  mov     [eax+4], cl
  jmp    @Endit1

@Move4:

  mov     [eax+6], bl
  jmp    @Endit1

@Move5:

  mov     [eax+8], cl
  jmp    @Endit1

@Move6:

  mov     [eax+10], bl
  jmp    @Endit1

@Move7:

  mov     [eax+12], cl
  jmp    @Endit1

@Move8:

  mov     [eax+14], bl
  jmp    @Endit1

@block2:

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+16]
  jz      @Move9

  xor     ch, [eax+edx+17]
  mov     [eax+16], cx
  jz      @EndIt2

  xor     bl, [eax+edx+18]
  jz      @Move10

  xor     bh, [eax+edx+19]
  mov     [eax+18], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+20]
  jz      @Move11

  xor     ch, [eax+edx+21]
  mov     [eax+20], cx
  jz      @EndIt2

  xor     bl, [eax+edx+22]
  jz       @Move12

  xor     bh, [eax+edx+23]
  mov     [eax+22], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+24]
  jz      @Move13

  xor     ch, [eax+edx+25]
  mov     [eax+24], cx
  jz      @EndIt2

  xor     bl, [eax+edx+26]
  jz      @Move14

  xor     bh, [eax+edx+27]
  mov     [eax+26], bx
  jz      @EndIt2

  xor     ecx, ecx
  xor     ebx, ebx

  xor     cl, [eax+edx+28]
  jz      @Move15

  xor     ch, [eax+edx+29]
  mov     [eax+28], cx
  jz      @EndIt2

  xor     bl, [eax+edx+30]
  jz      @Move16

  xor     bh, [eax+edx+31]
  mov     [eax+30], bx
  jz      @EndIt2

  add    eax, 32

  jmp   @Loopme

  nop

@Move9:

  mov    [eax+16], cl
  jmp    @Endit2

@Move10:

  mov    [eax+18], bl
  jmp    @Endit2

@Move11:

  mov    [eax+20], cl
  jmp    @Endit2

@Move12:

  mov    [eax+22], bl
  jmp    @Endit2

@Move13:

  mov    [eax+24], cl
  jmp    @Endit2

@Move14:

  mov    [eax+26], bl
  jmp    @Endit2

@Move15:

  mov    [eax+28], cl
  jmp    @Endit2

@Move16:

  mov    [eax+30], bl

@Endit2:
  pop    ebx
  pop    eax

end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;

end.
