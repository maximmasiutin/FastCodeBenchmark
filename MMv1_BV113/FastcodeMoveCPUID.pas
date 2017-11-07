unit FastcodeMoveCPUID;

(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Fastcode
 *
 * The Initial Developer of the Original Code is Fastcode
 *
 * Portions created by the Initial Developer are Copyright (C) 2002-2004
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s): John O'Harrow,Dennis Christensen
 *
 * ***** END LICENSE BLOCK ***** *)

//Version : 9.0
//Only plain function calls supported
//Last update 6/8 2006

interface

type
 TFastMove = procedure (const Source; var Dest; Count : Integer);

procedure MoveFastcodeP4P(const Source; var Dest; Count : Integer);
procedure MoveFastcodeP4N(const Source; var Dest; Count : Integer);
procedure MoveFastcodePMD(const Source; var Dest; Count : Integer);
procedure MoveFastcodePMB(const Source; var Dest; Count : Integer);
procedure MoveFastcodeAMD64(const Source; var Dest; Count : Integer);
procedure MoveFastcodeXP(const Source; var Dest; Count : Integer);
procedure MoveFastcodeBlended(const Source; var Dest; Count : Integer);
procedure MoveFastcodeRTL(const Source; var Dest; Count : Integer);
procedure MoveFastcodePascal(const Source; var Dest; Count : Integer);

var
 FastMove : TFastMove;

implementation

uses
  FastcodeCPUID;

var
  PrefetchLimit : Integer; {Used with SSE Moves}

const
  SMALLMOVESIZE = 36;

{-------------------------------------------------------------------------}
{Perform Forward Move of 0..36 Bytes}
{On Entry, ECX = Count, EAX = Source+Count, EDX = Dest+Count.  Destroys ECX}
procedure SmallForwardMove_9;
asm
  jmp     dword ptr [@@FwdJumpTable+ecx*4]
  nop {Align Jump Table}
@@FwdJumpTable:
  dd      @@Done {Removes need to test for zero size move}
  dd      @@Fwd01, @@Fwd02, @@Fwd03, @@Fwd04, @@Fwd05, @@Fwd06, @@Fwd07, @@Fwd08
  dd      @@Fwd09, @@Fwd10, @@Fwd11, @@Fwd12, @@Fwd13, @@Fwd14, @@Fwd15, @@Fwd16
  dd      @@Fwd17, @@Fwd18, @@Fwd19, @@Fwd20, @@Fwd21, @@Fwd22, @@Fwd23, @@Fwd24
  dd      @@Fwd25, @@Fwd26, @@Fwd27, @@Fwd28, @@Fwd29, @@Fwd30, @@Fwd31, @@Fwd32
  dd      @@Fwd33, @@Fwd34, @@Fwd35, @@Fwd36
@@Fwd36:
  mov     ecx, [eax-36]
  mov     [edx-36], ecx
@@Fwd32:
  mov     ecx, [eax-32]
  mov     [edx-32], ecx
@@Fwd28:
  mov     ecx, [eax-28]
  mov     [edx-28], ecx
@@Fwd24:
  mov     ecx, [eax-24]
  mov     [edx-24], ecx
@@Fwd20:
  mov     ecx, [eax-20]
  mov     [edx-20], ecx
@@Fwd16:
  mov     ecx, [eax-16]
  mov     [edx-16], ecx
@@Fwd12:
  mov     ecx, [eax-12]
  mov     [edx-12], ecx
@@Fwd08:
  mov     ecx, [eax-8]
  mov     [edx-8], ecx
@@Fwd04:
  mov     ecx, [eax-4]
  mov     [edx-4], ecx
  ret
  nop
@@Fwd35:
  mov     ecx, [eax-35]
  mov     [edx-35], ecx
@@Fwd31:
  mov     ecx, [eax-31]
  mov     [edx-31], ecx
@@Fwd27:
  mov     ecx, [eax-27]
  mov     [edx-27], ecx
@@Fwd23:
  mov     ecx, [eax-23]
  mov     [edx-23], ecx
@@Fwd19:
  mov     ecx, [eax-19]
  mov     [edx-19], ecx
@@Fwd15:
  mov     ecx, [eax-15]
  mov     [edx-15], ecx
@@Fwd11:
  mov     ecx, [eax-11]
  mov     [edx-11], ecx
@@Fwd07:
  mov     ecx, [eax-7]
  mov     [edx-7], ecx
  mov     ecx, [eax-4]
  mov     [edx-4], ecx
  ret
  nop
@@Fwd03:
  movzx   ecx, word ptr [eax-3]
  mov     [edx-3], cx
  movzx   ecx, byte ptr [eax-1]
  mov     [edx-1], cl
  ret
@@Fwd34:
  mov     ecx, [eax-34]
  mov     [edx-34], ecx
@@Fwd30:
  mov     ecx, [eax-30]
  mov     [edx-30], ecx
@@Fwd26:
  mov     ecx, [eax-26]
  mov     [edx-26], ecx
@@Fwd22:
  mov     ecx, [eax-22]
  mov     [edx-22], ecx
@@Fwd18:
  mov     ecx, [eax-18]
  mov     [edx-18], ecx
@@Fwd14:
  mov     ecx, [eax-14]
  mov     [edx-14], ecx
@@Fwd10:
  mov     ecx, [eax-10]
  mov     [edx-10], ecx
@@Fwd06:
  mov     ecx, [eax-6]
  mov     [edx-6], ecx
@@Fwd02:
  movzx   ecx, word ptr [eax-2]
  mov     [edx-2], cx
  ret
  nop
  nop
  nop
@@Fwd33:
  mov     ecx, [eax-33]
  mov     [edx-33], ecx
@@Fwd29:
  mov     ecx, [eax-29]
  mov     [edx-29], ecx
@@Fwd25:
  mov     ecx, [eax-25]
  mov     [edx-25], ecx
@@Fwd21:
  mov     ecx, [eax-21]
  mov     [edx-21], ecx
@@Fwd17:
  mov     ecx, [eax-17]
  mov     [edx-17], ecx
@@Fwd13:
  mov     ecx, [eax-13]
  mov     [edx-13], ecx
@@Fwd09:
  mov     ecx, [eax-9]
  mov     [edx-9], ecx
@@Fwd05:
  mov     ecx, [eax-5]
  mov     [edx-5], ecx
@@Fwd01:
  movzx   ecx, byte ptr [eax-1]
  mov     [edx-1], cl
  ret
@@Done:
end; {SmallForwardMove}

{-------------------------------------------------------------------------}
{Perform Backward Move of 0..36 Bytes}
{On Entry, ECX = Count, EAX = Source, EDX = Dest.  Destroys ECX}
procedure SmallBackwardMove_9;
asm
  jmp     dword ptr [@@BwdJumpTable+ecx*4]
  nop {Align Jump Table}
@@BwdJumpTable:
  dd      @@Done {Removes need to test for zero size move}
  dd      @@Bwd01, @@Bwd02, @@Bwd03, @@Bwd04, @@Bwd05, @@Bwd06, @@Bwd07, @@Bwd08
  dd      @@Bwd09, @@Bwd10, @@Bwd11, @@Bwd12, @@Bwd13, @@Bwd14, @@Bwd15, @@Bwd16
  dd      @@Bwd17, @@Bwd18, @@Bwd19, @@Bwd20, @@Bwd21, @@Bwd22, @@Bwd23, @@Bwd24
  dd      @@Bwd25, @@Bwd26, @@Bwd27, @@Bwd28, @@Bwd29, @@Bwd30, @@Bwd31, @@Bwd32
  dd      @@Bwd33, @@Bwd34, @@Bwd35, @@Bwd36
@@Bwd36:
  mov     ecx, [eax+32]
  mov     [edx+32], ecx
@@Bwd32:
  mov     ecx, [eax+28]
  mov     [edx+28], ecx
@@Bwd28:
  mov     ecx, [eax+24]
  mov     [edx+24], ecx
@@Bwd24:
  mov     ecx, [eax+20]
  mov     [edx+20], ecx
@@Bwd20:
  mov     ecx, [eax+16]
  mov     [edx+16], ecx
@@Bwd16:
  mov     ecx, [eax+12]
  mov     [edx+12], ecx
@@Bwd12:
  mov     ecx, [eax+8]
  mov     [edx+8], ecx
@@Bwd08:
  mov     ecx, [eax+4]
  mov     [edx+4], ecx
@@Bwd04:
  mov     ecx, [eax]
  mov     [edx], ecx
  ret
  nop
  nop
  nop
@@Bwd35:
  mov     ecx, [eax+31]
  mov     [edx+31], ecx
@@Bwd31:
  mov     ecx, [eax+27]
  mov     [edx+27], ecx
@@Bwd27:
  mov     ecx, [eax+23]
  mov     [edx+23], ecx
@@Bwd23:
  mov     ecx, [eax+19]
  mov     [edx+19], ecx
@@Bwd19:
  mov     ecx, [eax+15]
  mov     [edx+15], ecx
@@Bwd15:
  mov     ecx, [eax+11]
  mov     [edx+11], ecx
@@Bwd11:
  mov     ecx, [eax+7]
  mov     [edx+7], ecx
@@Bwd07:
  mov     ecx, [eax+3]
  mov     [edx+3], ecx
  mov     ecx, [eax]
  mov     [edx], ecx
  ret
  nop
  nop
  nop
@@Bwd03:
  movzx   ecx, word ptr [eax+1]
  mov     [edx+1], cx
  movzx   ecx, byte ptr [eax]
  mov     [edx], cl
  ret
  nop
  nop
@@Bwd34:
  mov     ecx, [eax+30]
  mov     [edx+30], ecx
@@Bwd30:
  mov     ecx, [eax+26]
  mov     [edx+26], ecx
@@Bwd26:
  mov     ecx, [eax+22]
  mov     [edx+22], ecx
@@Bwd22:
  mov     ecx, [eax+18]
  mov     [edx+18], ecx
@@Bwd18:
  mov     ecx, [eax+14]
  mov     [edx+14], ecx
@@Bwd14:
  mov     ecx, [eax+10]
  mov     [edx+10], ecx
@@Bwd10:
  mov     ecx, [eax+6]
  mov     [edx+6], ecx
@@Bwd06:
  mov     ecx, [eax+2]
  mov     [edx+2], ecx
@@Bwd02:
  movzx   ecx, word ptr [eax]
  mov     [edx], cx
  ret
  nop
@@Bwd33:
  mov     ecx, [eax+29]
  mov     [edx+29], ecx
@@Bwd29:
  mov     ecx, [eax+25]
  mov     [edx+25], ecx
@@Bwd25:
  mov     ecx, [eax+21]
  mov     [edx+21], ecx
@@Bwd21:
  mov     ecx, [eax+17]
  mov     [edx+17], ecx
@@Bwd17:
  mov     ecx, [eax+13]
  mov     [edx+13], ecx
@@Bwd13:
  mov     ecx, [eax+9]
  mov     [edx+9], ecx
@@Bwd09:
  mov     ecx, [eax+5]
  mov     [edx+5], ecx
@@Bwd05:
  mov     ecx, [eax+1]
  mov     [edx+1], ecx
@@Bwd01:
  movzx   ecx, byte ptr[eax]
  mov     [edx], cl
  ret
  nop
  nop
@@Done:
end; {SmallBackwardMove}

{-------------------------------------------------------------------------}
procedure AlignedSSE3Move; {Same as SSE2 Version}
asm
@@Loop:
  movdqa  xmm0, [eax+8*ecx]
  movdqa  xmm1, [eax+8*ecx+16]
  movdqa  xmm2, [eax+8*ecx+32]
  movdqa  xmm3, [eax+8*ecx+48]
  movdqa  [edx+8*ecx], xmm0
  movdqa  [edx+8*ecx+16], xmm1
  movdqa  [edx+8*ecx+32], xmm2
  movdqa  [edx+8*ecx+48], xmm3
  movdqa  xmm4, [eax+8*ecx+64]
  movdqa  xmm5, [eax+8*ecx+80]
  movdqa  xmm6, [eax+8*ecx+96]
  movdqa  xmm7, [eax+8*ecx+112]
  movdqa  [edx+8*ecx+64], xmm4
  movdqa  [edx+8*ecx+80], xmm5
  movdqa  [edx+8*ecx+96], xmm6
  movdqa  [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
end;

{-------------------------------------------------------------------------}
procedure UnalignedSSE3Move;
asm
@@Loop:
{$IFDEF VER170}
  lddqu   xmm0, [eax+8*ecx]
  lddqu   xmm1, [eax+8*ecx+16]
  lddqu   xmm2, [eax+8*ecx+32]
  lddqu   xmm3, [eax+8*ecx+48]
{$ELSE}
  DB      $F2,$0F,$F0,$04,$C8
  DB      $F2,$0F,$F0,$4C,$C8,$10
  DB      $F2,$0F,$F0,$54,$C8,$20
  DB      $F2,$0F,$F0,$5C,$C8,$30
{$ENDIF}
  movdqa  [edx+8*ecx], xmm0
  movdqa  [edx+8*ecx+16], xmm1
  movdqa  [edx+8*ecx+32], xmm2
  movdqa  [edx+8*ecx+48], xmm3
{$IFDEF VER170}
  lddqu   xmm4, [eax+8*ecx+64]
  lddqu   xmm5, [eax+8*ecx+80]
  lddqu   xmm6, [eax+8*ecx+96]
  lddqu   xmm7, [eax+8*ecx+112]
{$ELSE}
  DB      $F2,$0F,$F0,$64,$C8,$40
  DB      $F2,$0F,$F0,$6C,$C8,$50
  DB      $F2,$0F,$F0,$74,$C8,$60
  DB      $F2,$0F,$F0,$7C,$C8,$70
{$ENDIF}
  movdqa  [edx+8*ecx+64], xmm4
  movdqa  [edx+8*ecx+80], xmm5
  movdqa  [edx+8*ecx+96], xmm6
  movdqa  [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
end;

{-------------------------------------------------------------------------}
procedure LargeAlignedSSE3Move; {Same as SSE2 Version}
const
  Prefetch = 512;
asm
@@Loop:
  prefetchnta [eax+8*ecx+Prefetch]
  prefetchnta [eax+8*ecx+Prefetch+64]
  movdqa  xmm0, [eax+8*ecx]
  movdqa  xmm1, [eax+8*ecx+16]
  movdqa  xmm2, [eax+8*ecx+32]
  movdqa  xmm3, [eax+8*ecx+48]
  movntdq [edx+8*ecx], xmm0
  movntdq [edx+8*ecx+16], xmm1
  movntdq [edx+8*ecx+32], xmm2
  movntdq [edx+8*ecx+48], xmm3
  movdqa  xmm4, [eax+8*ecx+64]
  movdqa  xmm5, [eax+8*ecx+80]
  movdqa  xmm6, [eax+8*ecx+96]
  movdqa  xmm7, [eax+8*ecx+112]
  movntdq [edx+8*ecx+64], xmm4
  movntdq [edx+8*ecx+80], xmm5
  movntdq [edx+8*ecx+96], xmm6
  movntdq [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
  sfence
end;

{-------------------------------------------------------------------------}
procedure LargeUnalignedSSE3Move;
const
  Prefetch = 512;
asm
@@Loop:
  prefetchnta [eax+8*ecx+Prefetch]
  prefetchnta [eax+8*ecx+Prefetch+64]
{$IFDEF VER170}
  lddqu   xmm0, [eax+8*ecx]
  lddqu   xmm1, [eax+8*ecx+16]
  lddqu   xmm2, [eax+8*ecx+32]
  lddqu   xmm3, [eax+8*ecx+48]
{$ELSE}
  DB      $F2,$0F,$F0,$04,$C8
  DB      $F2,$0F,$F0,$4C,$C8,$10
  DB      $F2,$0F,$F0,$54,$C8,$20
  DB      $F2,$0F,$F0,$5C,$C8,$30
{$ENDIF}
  movntdq [edx+8*ecx], xmm0
  movntdq [edx+8*ecx+16], xmm1
  movntdq [edx+8*ecx+32], xmm2
  movntdq [edx+8*ecx+48], xmm3
{$IFDEF VER170}
  lddqu   xmm4, [eax+8*ecx+64]
  lddqu   xmm5, [eax+8*ecx+80]
  lddqu   xmm6, [eax+8*ecx+96]
  lddqu   xmm7, [eax+8*ecx+112]
{$ELSE}
  DB      $F2,$0F,$F0,$64,$C8,$40
  DB      $F2,$0F,$F0,$6C,$C8,$50
  DB      $F2,$0F,$F0,$74,$C8,$60
  DB      $F2,$0F,$F0,$7C,$C8,$70
{$ENDIF}
  movntdq [edx+8*ecx+64], xmm4
  movntdq [edx+8*ecx+80], xmm5
  movntdq [edx+8*ecx+96], xmm6
  movntdq [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
  sfence
end;



{-------------------------------------------------------------------------}
{Dest MUST be 16-Byes Aligned, Count MUST be multiple of 16 }
procedure AlignedFwdMoveSSE3_9(const Source; var Dest; Count: Integer);
asm
  push    ebx
  mov     ebx, ecx
  and     ecx, -128             {No of Bytes to Block Move (Multiple of 128)}
  add     eax, ecx              {End of Source Blocks}
  add     edx, ecx              {End of Dest Blocks}
  shr     ecx, 3                {No of QWORD's to Block Move}
  neg     ecx
  cmp     ecx, PrefetchLimit    {Count > Limit - Use Prefetch}
  jl      @@Large
  test    eax, 15               {Check if Both Source/Dest are Aligned}
  jnz     @@SmallUnaligned
  call    AlignedSSE3Move       {Both Source and Dest 16-Byte Aligned}
  jmp     @Remainder
@@SmallUnaligned:               {Source Not 16-Byte Aligned}
  call    UnalignedSSE3Move
  jmp     @Remainder
@@Large:
  test    eax, 15               {Check if Both Source/Dest Aligned}
  jnz     @@LargeUnaligned
  call    LargeAlignedSSE3Move  {Both Source and Dest 16-Byte Aligned}
  jmp     @Remainder
@@LargeUnaligned:               {Source Not 16-Byte Aligned}
  call    LargeUnalignedSSE3Move
@Remainder:
  and     ebx, $7F              {Remainder (0..112 - Multiple of 16)}
  jz      @@Done
  add     eax, ebx
  add     edx, ebx
  neg     ebx
@@RemainderLoop:
{$IFDEF VER170}
  lddqu   xmm0, [eax+ebx]
{$ELSE}
  DB      $F2,$0F,$F0,$04,$03
{$ENDIF}
  movdqa  [edx+ebx], xmm0
  add     ebx, 16
  jnz     @@RemainderLoop
@@Done:
  pop     ebx
end; {AlignedFwdMoveSSE3}


{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX > EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Forwards_SSE3_9;
const
  LARGESIZE = 2048;
asm
  cmp     ecx, LARGESIZE
  jge     @FwdLargeMove
  cmp     ecx, SMALLMOVESIZE+32
{$IFDEF VER170}
  lddqu   xmm0, [eax]
{$ELSE}
  DB      $F2,$0F,$F0,$00
{$ENDIF}
  jg      @FwdMoveSSE3
{$IFDEF VER170}
  lddqu   xmm1, [eax+16]
{$ELSE}
  DB      $F2,$0F,$F0,$48,$10
{$ENDIF}
  movdqu  [edx], xmm0
  movdqu  [edx+16], xmm1
  add     eax, ecx
  add     edx, ecx
  sub     ecx, 32
  jmp     SmallForwardMove_9
  nop
  nop
  nop
@FwdMoveSSE3:
  push    ebx
  mov     ebx, edx
  {Align Writes}
  add     eax, ecx
  add     ecx, edx
  add     edx, 15
  and     edx, -16
  sub     ecx, edx
  add     edx, ecx
  {Now Aligned}
  sub     ecx, 32
  neg     ecx
@FwdLoopSSE3:
{$IFDEF VER170}
  lddqu   xmm1, [eax+ecx-32]
  lddqu   xmm2, [eax+ecx-16]
{$ELSE}
  DB      $F2,$0F,$F0,$4C,$01,$E0
  DB      $F2,$0F,$F0,$54,$01,$F0
{$ENDIF}
  movdqa  [edx+ecx-32], xmm1
  movdqa  [edx+ecx-16], xmm2
  add     ecx, 32
  jle     @FwdLoopSSE3
  movdqu  [ebx], xmm0 {First 16 Bytes}
  neg     ecx
  add     ecx, 32
  pop     ebx
  jmp     SmallForwardMove_9
@FwdLargeMove:
  push    ebx
  mov     ebx, ecx
  test    edx, 15
  jz      @FwdLargeAligned
  {16 byte Align Destination}
  mov     ecx, edx
  add     ecx, 15
  and     ecx, -16
  sub     ecx, edx
  add     eax, ecx
  add     edx, ecx
  sub     ebx, ecx
  {Destination now 16 Byte Aligned}
  call    SmallForwardMove_9
  mov     ecx, ebx
@FwdLargeAligned:
  and     ecx, -16
  sub     ebx, ecx {EBX = Remainder}
  push    edx
  push    eax
  push    ecx
  call    AlignedFwdMoveSSE3_9
  pop     ecx
  pop     eax
  pop     edx
  add     ecx, ebx
  add     eax, ecx
  add     edx, ecx
  mov     ecx, ebx
  pop     ebx
  jmp     SmallForwardMove_9
end; {Forwards_SSE3}

{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX < EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Backwards_SSE3_9;
asm
  cmp     ecx, SMALLMOVESIZE+32
  jg      @BwdMoveSSE3
  sub     ecx, 32
{$IFDEF VER170}
  lddqu   xmm1, [eax+ecx]
  lddqu   xmm2, [eax+ecx+16]
{$ELSE}
  DB      $F2,$0F,$F0,$0C,$01
  DB      $F2,$0F,$F0,$54,$01,$10
{$ENDIF}
  movdqu  [edx+ecx], xmm1
  movdqu  [edx+ecx+16], xmm2
  jmp     SmallBackwardMove_9
  nop
@BwdMoveSSE3:
  push    ebx
{$IFDEF VER170}
  lddqu   xmm0, [eax+ecx-16] {Last 16 Bytes}
{$ELSE}
  DB      $F2,$0F,$F0,$44,$01,$F0
{$ENDIF}
  {Align Writes}
  lea     ebx, [edx+ecx]
  and     ebx, 15
  sub     ecx, ebx
  add     ebx, ecx
  {Now Aligned}
  sub     ecx, 32
@BwdLoop:
{$IFDEF VER170}
  lddqu   xmm1, [eax+ecx]
  lddqu   xmm2, [eax+ecx+16]
{$ELSE}
  DB      $F2,$0F,$F0,$0C,$01
  DB      $F2,$0F,$F0,$54,$01,$10
{$ENDIF}
  movdqa  [edx+ecx], xmm1
  movdqa  [edx+ecx+16], xmm2
  sub     ecx, 32
  jge     @BwdLoop
  movdqu  [edx+ebx-16], xmm0  {Last 16 Bytes}
  add     ecx, 32
  pop     ebx
  jmp     SmallBackwardMove_9
end; {Backwards_SSE3}

//Author:            John O'Harrow
//Date:              
//Optimized for:     Intel P4 Prescott
//Instructionset(s): SSE3
//Original name:     MoveJOH_SSE3_9


procedure MoveFastcodeP4P(const Source; var Dest; Count : Integer);
asm
  cmp     ecx, SMALLMOVESIZE
  ja      @Large {Count > SMALLMOVESIZE or Count < 0}
  cmp     eax, edx
  jbe     @SmallCheck
  add     eax, ecx
  add     edx, ecx
  jmp     SmallForwardMove_9
@SmallCheck:
  jne     SmallBackwardMove_9
  ret {For Compatibility with Delphi's move for Source = Dest}
@Large:
  jng     @Done {For Compatibility with Delphi's move for Count < 0}
  cmp     eax, edx
  ja      Forwards_SSE3_9
  je      @Done {For Compatibility with Delphi's move for Source = Dest}
  sub     edx, ecx
  cmp     eax, edx
  lea     edx, [edx+ecx]
  jna     Forwards_SSE3_9
  jmp     Backwards_SSE3_9 {Source/Dest Overlap}
@Done:
end;


{-------------------------------------------------------------------------}
{Perform Forward Move of 0..36 Bytes}
{On Entry, ECX = Count, EAX = Source+Count, EDX = Dest+Count.  Destroys ECX}
procedure SmallForwardMove_5;
asm
  jmp     dword ptr [@@FwdJumpTable+ecx*4]
  nop {Align Jump Table}
@@FwdJumpTable:
  dd      @@Done {Removes need to test for zero size move}
  dd      @@Fwd01, @@Fwd02, @@Fwd03, @@Fwd04, @@Fwd05, @@Fwd06, @@Fwd07, @@Fwd08
  dd      @@Fwd09, @@Fwd10, @@Fwd11, @@Fwd12, @@Fwd13, @@Fwd14, @@Fwd15, @@Fwd16
  dd      @@Fwd17, @@Fwd18, @@Fwd19, @@Fwd20, @@Fwd21, @@Fwd22, @@Fwd23, @@Fwd24
  dd      @@Fwd25, @@Fwd26, @@Fwd27, @@Fwd28, @@Fwd29, @@Fwd30, @@Fwd31, @@Fwd32
  dd      @@Fwd33, @@Fwd34, @@Fwd35, @@Fwd36
@@Fwd36:
  mov     ecx, [eax-36]
  mov     [edx-36], ecx
@@Fwd32:
  mov     ecx, [eax-32]
  mov     [edx-32], ecx
@@Fwd28:
  mov     ecx, [eax-28]
  mov     [edx-28], ecx
@@Fwd24:
  mov     ecx, [eax-24]
  mov     [edx-24], ecx
@@Fwd20:
  mov     ecx, [eax-20]
  mov     [edx-20], ecx
@@Fwd16:
  mov     ecx, [eax-16]
  mov     [edx-16], ecx
@@Fwd12:
  mov     ecx, [eax-12]
  mov     [edx-12], ecx
@@Fwd08:
  mov     ecx, [eax-8]
  mov     [edx-8], ecx
@@Fwd04:
  mov     ecx, [eax-4]
  mov     [edx-4], ecx
  ret
  nop
@@Fwd35:
  mov     ecx, [eax-35]
  mov     [edx-35], ecx
@@Fwd31:
  mov     ecx, [eax-31]
  mov     [edx-31], ecx
@@Fwd27:
  mov     ecx, [eax-27]
  mov     [edx-27], ecx
@@Fwd23:
  mov     ecx, [eax-23]
  mov     [edx-23], ecx
@@Fwd19:
  mov     ecx, [eax-19]
  mov     [edx-19], ecx
@@Fwd15:
  mov     ecx, [eax-15]
  mov     [edx-15], ecx
@@Fwd11:
  mov     ecx, [eax-11]
  mov     [edx-11], ecx
@@Fwd07:
  mov     ecx, [eax-7]
  mov     [edx-7], ecx
  mov     ecx, [eax-4] 
  mov     [edx-4], ecx
  ret
  nop
@@Fwd03:
  movzx   ecx,  word ptr [eax-3]
  mov     [edx-3], cx
  movzx   ecx,  byte ptr [eax-1]
  mov     [edx-1], cl
  ret
@@Fwd34:
  mov     ecx, [eax-34]
  mov     [edx-34], ecx
@@Fwd30:
  mov     ecx, [eax-30]
  mov     [edx-30], ecx
@@Fwd26:
  mov     ecx, [eax-26]
  mov     [edx-26], ecx
@@Fwd22:
  mov     ecx, [eax-22]
  mov     [edx-22], ecx
@@Fwd18:
  mov     ecx, [eax-18]
  mov     [edx-18], ecx
@@Fwd14:
  mov     ecx, [eax-14]
  mov     [edx-14], ecx
@@Fwd10:
  mov     ecx, [eax-10]
  mov     [edx-10], ecx
@@Fwd06:
  mov     ecx, [eax-6]
  mov     [edx-6], ecx
@@Fwd02:
  movzx   ecx,  word ptr [eax-2]
  mov     [edx-2], cx
  ret
  nop
  nop
  nop
@@Fwd33:
  mov     ecx, [eax-33]
  mov     [edx-33], ecx
@@Fwd29:
  mov     ecx, [eax-29]
  mov     [edx-29], ecx
@@Fwd25:
  mov     ecx, [eax-25]
  mov     [edx-25], ecx
@@Fwd21:
  mov     ecx, [eax-21]
  mov     [edx-21], ecx
@@Fwd17:
  mov     ecx, [eax-17]
  mov     [edx-17], ecx
@@Fwd13:
  mov     ecx, [eax-13]
  mov     [edx-13], ecx
@@Fwd09:
  mov     ecx, [eax-9]
  mov     [edx-9], ecx
@@Fwd05:
  mov     ecx, [eax-5]
  mov     [edx-5], ecx
@@Fwd01:
  movzx   ecx,  byte ptr [eax-1]
  mov     [edx-1], cl
  ret
@@Done:
end; {SmallForwardMove}

{-------------------------------------------------------------------------}
{Perform Backward Move of 0..36 Bytes}
{On Entry, ECX = Count, EAX = Source, EDX = Dest.  Destroys ECX}
procedure SmallBackwardMove_5;
asm
  jmp     dword ptr [@@BwdJumpTable+ecx*4]
  nop {Align Jump Table}
@@BwdJumpTable:
  dd      @@Done {Removes need to test for zero size move}
  dd      @@Bwd01, @@Bwd02, @@Bwd03, @@Bwd04, @@Bwd05, @@Bwd06, @@Bwd07, @@Bwd08
  dd      @@Bwd09, @@Bwd10, @@Bwd11, @@Bwd12, @@Bwd13, @@Bwd14, @@Bwd15, @@Bwd16
  dd      @@Bwd17, @@Bwd18, @@Bwd19, @@Bwd20, @@Bwd21, @@Bwd22, @@Bwd23, @@Bwd24
  dd      @@Bwd25, @@Bwd26, @@Bwd27, @@Bwd28, @@Bwd29, @@Bwd30, @@Bwd31, @@Bwd32
  dd      @@Bwd33, @@Bwd34, @@Bwd35, @@Bwd36
@@Bwd36:
  mov     ecx, [eax+32]
  mov     [edx+32], ecx
@@Bwd32:
  mov     ecx, [eax+28]
  mov     [edx+28], ecx
@@Bwd28:
  mov     ecx, [eax+24]
  mov     [edx+24], ecx
@@Bwd24:
  mov     ecx, [eax+20]
  mov     [edx+20], ecx
@@Bwd20:
  mov     ecx, [eax+16]
  mov     [edx+16], ecx
@@Bwd16:
  mov     ecx, [eax+12]
  mov     [edx+12], ecx
@@Bwd12:
  mov     ecx, [eax+8]
  mov     [edx+8], ecx
@@Bwd08:
  mov     ecx, [eax+4]
  mov     [edx+4], ecx
@@Bwd04:
  mov     ecx, [eax]
  mov     [edx], ecx
  ret
  nop
  nop
  nop
@@Bwd35:
  mov     ecx, [eax+31]
  mov     [edx+31], ecx
@@Bwd31:
  mov     ecx, [eax+27]
  mov     [edx+27], ecx
@@Bwd27:
  mov     ecx, [eax+23]
  mov     [edx+23], ecx
@@Bwd23:
  mov     ecx, [eax+19]
  mov     [edx+19], ecx
@@Bwd19:
  mov     ecx, [eax+15]
  mov     [edx+15], ecx
@@Bwd15:
  mov     ecx, [eax+11]
  mov     [edx+11], ecx
@@Bwd11:
  mov     ecx, [eax+7]
  mov     [edx+7], ecx
@@Bwd07:
  mov     ecx, [eax+3]
  mov     [edx+3], ecx
  mov     ecx, [eax]
  mov     [edx], ecx
  ret
  nop
  nop
  nop
@@Bwd03:
  movzx   ecx,  word ptr [eax+1]
  mov     [edx+1], cx
  movzx   ecx,  byte ptr [eax]
  mov     [edx], cl
  ret
  nop
  nop
@@Bwd34:
  mov     ecx, [eax+30]
  mov     [edx+30], ecx
@@Bwd30:
  mov     ecx, [eax+26]
  mov     [edx+26], ecx
@@Bwd26:
  mov     ecx, [eax+22]
  mov     [edx+22], ecx
@@Bwd22:
  mov     ecx, [eax+18]
  mov     [edx+18], ecx
@@Bwd18:
  mov     ecx, [eax+14]
  mov     [edx+14], ecx
@@Bwd14:
  mov     ecx, [eax+10]
  mov     [edx+10], ecx
@@Bwd10:
  mov     ecx, [eax+6]
  mov     [edx+6], ecx
@@Bwd06:
  mov     ecx, [eax+2]
  mov     [edx+2], ecx
@@Bwd02:
  movzx   ecx,  word ptr [eax]
  mov     [edx], cx
  ret
  nop
@@Bwd33:
  mov     ecx, [eax+29]
  mov     [edx+29], ecx
@@Bwd29:
  mov     ecx, [eax+25]
  mov     [edx+25], ecx
@@Bwd25:
  mov     ecx, [eax+21]
  mov     [edx+21], ecx
@@Bwd21:
  mov     ecx, [eax+17]
  mov     [edx+17], ecx
@@Bwd17:
  mov     ecx, [eax+13]
  mov     [edx+13], ecx
@@Bwd13:
  mov     ecx, [eax+9]
  mov     [edx+9], ecx
@@Bwd09:
  mov     ecx, [eax+5]
  mov     [edx+5], ecx
@@Bwd05:
  mov     ecx, [eax+1]
  mov     [edx+1], ecx
@@Bwd01:
  movzx   ecx,  byte ptr[eax]
  mov     [edx], cl
  ret
  nop
  nop
@@Done:
end; {SmallBackwardMove}

{-------------------------------------------------------------------------}
{Dest MUST be 16-Byes Aligned, Count MUST be multiple of 16 }
procedure AlignedFwdMoveSSE_5(const Source; var Dest; Count: Integer);
const
  Prefetch = 512;
asm
  push    esi
  mov     esi, eax             {ESI = Source}
  mov     eax, ecx             {EAX = Count}
  and     eax, -128            {EAX = No of Bytes to Block Move}
  add     esi, eax
  add     edx, eax
  shr     eax, 3               {EAX = No of QWORD's to Block Move}
  neg     eax
  cmp     eax,  PrefetchLimit  {Count > Limit - Use Prefetch}
  jl      @Large
@Small: {Count<=256K}
  test    esi, 15              {Check if Both Source/Dest Aligned}
  jnz     @SmallUnaligned
@SmallAligned:                {Both Source and Dest 16-Byte Aligned}
@SmallAlignedLoop:
  movaps  xmm0, [esi+8*eax]
  movaps  xmm1, [esi+8*eax+16]
  movaps  xmm2, [esi+8*eax+32]
  movaps  xmm3, [esi+8*eax+48]
  movaps  [edx+8*eax], xmm0
  movaps  [edx+8*eax+16], xmm1
  movaps  [edx+8*eax+32], xmm2
  movaps  [edx+8*eax+48], xmm3
  movaps  xmm4, [esi+8*eax+64]
  movaps  xmm5, [esi+8*eax+80]
  movaps  xmm6, [esi+8*eax+96]
  movaps  xmm7, [esi+8*eax+112]
  movaps  [edx+8*eax+64], xmm4
  movaps  [edx+8*eax+80], xmm5
  movaps  [edx+8*eax+96], xmm6
  movaps  [edx+8*eax+112], xmm7
  add     eax, 16
  js      @SmallAlignedLoop
  jmp     @Remainder
@SmallUnaligned:              {Source Not 16-Byte Aligned}
@SmallUnalignedLoop:
  movups  xmm0, [esi+8*eax]
  movups  xmm1, [esi+8*eax+16]
  movups  xmm2, [esi+8*eax+32]
  movups  xmm3, [esi+8*eax+48]
  movaps  [edx+8*eax], xmm0
  movaps  [edx+8*eax+16], xmm1
  movaps  [edx+8*eax+32], xmm2
  movaps  [edx+8*eax+48], xmm3
  movups  xmm4, [esi+8*eax+64]
  movups  xmm5, [esi+8*eax+80]
  movups  xmm6, [esi+8*eax+96]
  movups  xmm7, [esi+8*eax+112]
  movaps  [edx+8*eax+64], xmm4
  movaps  [edx+8*eax+80], xmm5
  movaps  [edx+8*eax+96], xmm6
  movaps  [edx+8*eax+112], xmm7
  add     eax, 16
  js      @SmallUnalignedLoop
  jmp     @Remainder
@Large:
  test    esi, 15              {Check if Both Source/Dest Aligned}
  jnz     @LargeUnaligned
@LargeAligned:                {Both Source and Dest 16-Byte Aligned}
@LargeAlignedLoop:
  prefetchnta  [esi+8*eax+Prefetch]
  prefetchnta  [esi+8*eax+Prefetch+64]
  movaps  xmm0, [esi+8*eax]
  movaps  xmm1, [esi+8*eax+16]
  movaps  xmm2, [esi+8*eax+32]
  movaps  xmm3, [esi+8*eax+48]
  movntps [edx+8*eax], xmm0
  movntps [edx+8*eax+16], xmm1
  movntps [edx+8*eax+32], xmm2
  movntps [edx+8*eax+48], xmm3
  movaps  xmm4, [esi+8*eax+64]
  movaps  xmm5, [esi+8*eax+80]
  movaps  xmm6, [esi+8*eax+96]
  movaps  xmm7, [esi+8*eax+112]
  movntps [edx+8*eax+64], xmm4
  movntps [edx+8*eax+80], xmm5
  movntps [edx+8*eax+96], xmm6
  movntps [edx+8*eax+112], xmm7
  add     eax, 16
  js      @LargeAlignedLoop
  sfence
  jmp     @Remainder
@LargeUnaligned:              {Source Not 16-Byte Aligned}
@LargeUnalignedLoop:
  prefetchnta  [esi+8*eax+Prefetch]
  prefetchnta  [esi+8*eax+Prefetch+64]
  movups  xmm0, [esi+8*eax]
  movups  xmm1, [esi+8*eax+16]
  movups  xmm2, [esi+8*eax+32]
  movups  xmm3, [esi+8*eax+48]
  movntps [edx+8*eax], xmm0
  movntps [edx+8*eax+16], xmm1
  movntps [edx+8*eax+32], xmm2
  movntps [edx+8*eax+48], xmm3
  movups  xmm4, [esi+8*eax+64]
  movups  xmm5, [esi+8*eax+80]
  movups  xmm6, [esi+8*eax+96]
  movups  xmm7, [esi+8*eax+112]
  movntps [edx+8*eax+64], xmm4
  movntps [edx+8*eax+80], xmm5
  movntps [edx+8*eax+96], xmm6
  movntps [edx+8*eax+112], xmm7
  add     eax, 16
  js      @LargeUnalignedLoop
  sfence
@Remainder:
  and     ecx, $7F {ECX = Remainder (0..112 - Multiple of 16)}
  jz      @Done
  add     esi, ecx
  add     edx, ecx
  neg     ecx
@RemainderLoop:
  movups  xmm0, [esi+ecx]
  movaps  [edx+ecx], xmm0
  add     ecx, 16
  jnz     @RemainderLoop
@Done:
  pop     esi
end; {AlignedFwdMoveSSE}


{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX > EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Forwards_SSE_5;
const
  LARGESIZE = 2048;
asm
  cmp     ecx, LARGESIZE
  jge     @FwdLargeMove
  cmp     ecx, SMALLMOVESIZE+32
  movups  xmm0, [eax]
  jg      @FwdMoveSSE
  movups  xmm1, [eax+16]
  movups  [edx], xmm0
  movups  [edx+16], xmm1
  add     eax, ecx
  add     edx, ecx
  sub     ecx, 32
  jmp     SmallForwardMove_5
@FwdMoveSSE:
  push    ebx
  mov     ebx, edx
  {Align Writes}
  add     eax, ecx
  add     ecx, edx
  add     edx, 15
  and     edx, -16
  sub     ecx, edx
  add     edx, ecx
  {Now Aligned}
  sub     ecx, 32
  neg     ecx
@FwdLoopSSE:
  movups  xmm1, [eax+ecx-32]
  movups  xmm2, [eax+ecx-16]
  movaps  [edx+ecx-32], xmm1
  movaps  [edx+ecx-16], xmm2
  add     ecx, 32
  jle     @FwdLoopSSE
  movups  [ebx], xmm0 {First 16 Bytes}
  neg     ecx
  add     ecx, 32
  pop     ebx
  jmp     SmallForwardMove_5
@FwdLargeMove:
  push    ebx
  mov     ebx, ecx
  test    edx, 15
  jz      @FwdLargeAligned
  {16 byte Align Destination}
  mov     ecx, edx
  add     ecx, 15
  and     ecx, -16
  sub     ecx, edx
  add     eax, ecx
  add     edx, ecx
  sub     ebx, ecx
  {Destination now 16 Byte Aligned}
  call    SmallForwardMove_5
  mov     ecx, ebx
@FwdLargeAligned:
  and     ecx, -16
  sub     ebx, ecx {EBX = Remainder}
  push    edx
  push    eax
  push    ecx
  call    AlignedFwdMoveSSE_5
  pop     ecx
  pop     eax
  pop     edx
  add     ecx, ebx
  add     eax, ecx
  add     edx, ecx
  mov     ecx, ebx
  pop     ebx
  jmp     SmallForwardMove_5
end; {Forwards_SSE}

{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX < EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Backwards_SSE_5;
asm
  cmp     ecx, SMALLMOVESIZE+32
  jg      @BwdMoveSSE
  sub     ecx, 32
  movups  xmm1, [eax+ecx]
  movups  xmm2, [eax+ecx+16]
  movups  [edx+ecx], xmm1
  movups  [edx+ecx+16], xmm2
  jmp     SmallBackwardMove_5
@BwdMoveSSE:
  push    ebx
  movups  xmm0, [eax+ecx-16] {Last 16 Bytes}
  {Align Writes}
  lea     ebx, [edx+ecx]
  and     ebx, 15
  sub     ecx, ebx
  add     ebx, ecx
  {Now Aligned}
  sub     ecx, 32
@BwdLoop:
  movups  xmm1, [eax+ecx]
  movups  xmm2, [eax+ecx+16]
  movaps  [edx+ecx], xmm1
  movaps  [edx+ecx+16], xmm2
  sub     ecx, 32
  jge     @BwdLoop
  movups  [edx+ebx-16], xmm0  {Last 16 Bytes}
  add     ecx, 32
  pop     ebx
  jmp     SmallBackwardMove_5
end; {Backwards_SSE}


//Author:            John O'Harrow
//Date:
//Optimized for:     Intel P4 Northwood
//Instructionset(s): SSE
//Original name:     MoveJOH_SSE_5

procedure MoveFastcodeP4N(const Source; var Dest; Count : Integer);
asm
  cmp     ecx, SMALLMOVESIZE
  ja      @Large {Count > SMALLMOVESIZE or Count < 0}
  cmp     eax, edx
  jbe     @SmallCheck
  add     eax, ecx
  add     edx, ecx
  jmp     SmallForwardMove_5
@SmallCheck:
  jne     SmallBackwardMove_5
  ret {For Compatibility with Delphi's move for Source = Dest}
@Large:
  jng     @Done {For Compatibility with Delphi's move for Count < 0}
  cmp     eax, edx
  ja      Forwards_SSE_5
  je      @Done {For Compatibility with Delphi's move for Source = Dest}
  sub     edx, ecx
  cmp     eax, edx
  lea     edx, [edx+ecx]
  ja      Backwards_SSE_5 {Source/Dest Overlap}
  jmp     Forwards_SSE_5
@Done:
end; {MoveJOH_SSE}


//Author:            Dennis Kjaer Christensen
//Date:              10/6 2004
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32, MMX, SSE
//Original name:     MoveDKCSSE_1

procedure MoveFastcodePMD(const Source; var Dest; Count : Integer);
asm
     //Exit if Count is negative
     test    ecx, ecx
     js      @Exit
     //Detect the need for rewerse move in overlapped case
     cmp     eax, edx                   // if (DestAddress > SourceAddress) then
     jnb     @ForwardMove
     push    ebx
     mov     ebx, edx
     sub     ebx, eax                   // (DestAddress - SourceAddress)
     cmp     ebx, edx                   // if ((DestAddress - SourceAddress) < Count) then
     pop     ebx
     jb      @RewMove
@ForwardMove:
     cmp     ecx, 55
     jnbe    @ForwardCaseElse
     jmp     dword ptr [ecx*4+@Case1JmpTable]
@ForwardCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
@ForwardCaseCount0:
     ret
@ForwardCaseCount2:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     ret
@ForwardCaseCount3:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax+2]
     mov     [edx+2], cl
     ret
@ForwardCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@ForwardCaseCount5:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     ret
@ForwardCaseCount6:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     ret
@ForwardCaseCount7:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+6]
     mov     [edx+6], cl
     ret
@ForwardCaseCount8:
     movq    mm0, [eax]
     movq    [edx], mm0
     emms
     ret
@ForwardCaseCount9:
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     emms
     ret
@ForwardCaseCount10 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     emms
     ret
@ForwardCaseCount11 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+10]
     mov     [edx+10], cl
     emms
     ret
@ForwardCaseCount12:
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     emms
     ret
@ForwardCaseCount13 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     emms
     ret
@ForwardCaseCount14 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     emms
     ret
@ForwardCaseCount15 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+14]
     mov     [edx+14], cl
     emms
     ret
@ForwardCaseCount16 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     emms
     ret
@ForwardCaseCount17 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     emms
     ret
@ForwardCaseCount18 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     emms
     ret
@ForwardCaseCount19 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+18]
     mov     [edx+18], cl
     emms
     ret
@ForwardCaseCount20 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     emms
     ret
@ForwardCaseCount21 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     emms
     ret
@ForwardCaseCount22 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     emms
     ret
@ForwardCaseCount23 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+22]
     mov     [edx+22], cl
     emms
     ret
@ForwardCaseCount24 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     emms
     ret
@ForwardCaseCount25 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     emms
     ret
@ForwardCaseCount26 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     emms
     ret
@ForwardCaseCount27 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+26]
     mov     [edx+26], cl
     emms
     ret
@ForwardCaseCount28 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     emms
     ret
@ForwardCaseCount29 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     emms
     ret
@ForwardCaseCount30 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     emms
     ret
@ForwardCaseCount31 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+30]
     mov     [edx+30], cl
     emms
     ret
@ForwardCaseCount32 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     emms
     ret
@ForwardCaseCount33 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     emms
     ret
@ForwardCaseCount34 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     emms
     ret
@ForwardCaseCount35 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+34]
     mov     [edx+34], cl
     emms
     ret
@ForwardCaseCount36 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     emms
     ret
@ForwardCaseCount37 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     emms
     ret
@ForwardCaseCount38 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     emms
     ret
@ForwardCaseCount39 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+38]
     mov     [edx+38], cl
     emms
     ret
@ForwardCaseCount40 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     emms
     ret
@ForwardCaseCount41 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     emms
     ret
@ForwardCaseCount42 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     emms
     ret
@ForwardCaseCount43 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+42]
     mov     [edx+42], cl
     emms
     ret
@ForwardCaseCount44 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     emms
     ret
@ForwardCaseCount45 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     emms
     ret
@ForwardCaseCount46 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     emms
     ret
@ForwardCaseCount47 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+46]
     mov     [edx+46], cl
     emms
     ret
@ForwardCaseCount48 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     emms
     ret
@ForwardCaseCount49 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     emms
     ret
@ForwardCaseCount50 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     emms
     ret
@ForwardCaseCount51 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     emms
     ret
@ForwardCaseCount52 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     emms
     ret
@ForwardCaseCount53 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     emms
     ret
@ForwardCaseCount54 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     emms
     ret
@ForwardCaseCount55 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl,[eax+54]
     mov     [edx+54],cl
     emms
     ret
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @ForwardCaseElse:
     cmp     ecx, 800
     jnle    @Else9
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     mov     edi, ecx
     shr     edi, 5
     shl     edi, 5
     xor     ebx, ebx
 @L11:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    mm2, [eax+ebx+16]
     movq    mm3, [eax+ebx+24]
     movq    [edx+ebx], mm0
     movq    [edx+ebx+8], mm1
     movq    [edx+ebx+16], mm2
     movq    [edx+ebx+24], mm3
     add     ebx, 32
     cmp     ebx, edi
     jb      @L11
     emms
     add     eax, edi
     add     edx, edi
     sub     ecx, edi  //Remaining moves
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
     nop
     nop
     nop
     nop
     nop
 @Else9:
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     //Align destination
     xor     edi, edi                // ByteNo1 := 0;
 @L111:
     mov     bl, [eax+edi]           // DstB[ByteNo1] := SrcB[ByteNo1];
     mov     [edx+edi], bl
     add     edi, 1                  // Inc(ByteNo1);
     mov     ebx, edx                // edx is destination pointer
     add     ebx, edi
     and     ebx, $0f
     test    ebx, ebx
     jnz     @L111                   // until((SrcAddress2 mod 16) = 0);
     add     eax, edi                // SrcB is aligned now - "SrcI := SrcI + ByteNo1;" Not valid Pascal
     add     edx, edi                // DstB is aligned now - "DstI := DstI + ByteNo1;" Not valid Pascal
     sub     ecx, edi                // Count := Count - ByteNo1;
     mov     esi, ecx
 @L222:
     //SourceAddress2 := Cardinal(@SrcB[0]);
     //if (SourceAddress2 mod 16 = 0) then
     mov     ebx, eax
     and     ebx, $0f
     jnz     @ElseIf1
     //Both source and destination are 16 byte aligned
     cmp     ecx, 240000            // if Count < 1M then
     jnl     @Else2
     shr     ecx,4
     shl     ecx,4
     xor     ebx, ebx
 @L1111:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L1111
     jmp     @Fedtmule
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
 @Else2:
     shr     ecx, 7                  // NoOfIntLoops  := Count div 16;    16, 32, 48, 64, 80, 96, 112, 128
     shl     ecx, 7                  // NoOfIntMoves := NoOfIntLoops * 4;  4,  8, 12, 16, 20, 24,  28,  32
     xor     ebx, ebx
 @L10:
     movaps  xmm0, [eax+ebx]
     movaps  xmm1, [eax+ebx+16]
     movaps  xmm2, [eax+ebx+32]
     movaps  xmm3, [eax+ebx+48]
     movaps  xmm4, [eax+ebx+64]
     movaps  xmm5, [eax+ebx+80]
     movaps  xmm6, [eax+ebx+96]
     movaps  xmm7, [eax+ebx+112]
     movntps [edx+ebx],     xmm0
     movntps [edx+ebx+16],  xmm1
     movntps [edx+ebx+32],  xmm2
     movntps [edx+ebx+48],  xmm3
     movntps [edx+ebx+64],  xmm4
     movntps [edx+ebx+80],  xmm5
     movntps [edx+ebx+96],  xmm6
     movntps [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @L10
 @L20:
     jmp     @Fedtmule
     nop
     nop
     nop
     nop
     nop
     //else if (SourceAddress2 mod 8 = 0) then
 @ElseIf1:
     //Source is at least 8 byte aligned and destination is at least 16 byte aligned
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @Else1
     //Destination 16 byte aligned, Source unaligned
     shr     ecx, 4               // NoOfIntLoops  := Count div 16;
     shl     ecx, 4               // NoOfIntMoves := NoOfIntLoops * 4;
     xor     ebx, ebx
 @L100:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L100
 @L200:
     jmp     @Fedtmule
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
 @Else1:
     //Destination 16 byte aligned. Source unaligned
     shr     ecx, 4
     shl     ecx, 4
     xor     ebx, ebx
 @L1000:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L1000
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @Fedtmule:
     // Small moves after big 16 byte destination aligned moves
     add     eax, ecx
     add     edx, ecx
     sub     esi, ecx  //Remaining moves
     mov     ecx, esi
     cmp     ecx, 55
     ja      @L1239
     pop     esi
     pop     edi
     pop     ebx
     emms
     jmp     dword ptr [ecx*4+@Case1JmpTable]
     nop
     nop
     nop
     nop
     nop
 @L1239:
     add     ecx, eax
 @L123:
     mov     bl, [eax]          // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx], bl
     inc     eax
     inc     edx
     cmp     eax, ecx
     jb      @L123                  // until(ByteNo >= EndOfByteMoves);
     pop     esi
     pop     edi
     pop     ebx
     emms
     ret
 @RewMove:
     cmp     ecx,64
     jnbe    @Case1Else
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @RewerseCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
 @RewerseCaseCount0:
     ret
 @RewerseCaseCount2:
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax]
     mov     [edx], cl
     ret
 @RewerseCaseCount3:
     mov     cl, [eax+2]
     mov     [edx+2], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax]
     mov     [edx], cl
     ret
 @RewerseCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount5:
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount6:
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount7:
     mov     cl, [eax+6]
     mov     [edx+6], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount8:
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount9:
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount10:
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount11:
     mov     cl, [eax+10]
     mov     [edx+10], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount12 :
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount13 :
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@RewerseCaseCount14 :
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@RewerseCaseCount15 :
     mov     cl, [eax+14]
     mov     [edx+14], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@RewerseCaseCount16 :
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount17 :
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount18 :
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount19 :
     mov     cl, [eax+18]
     mov     [edx+18], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount20 :
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount21 :
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount22 :
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount23 :
     mov     cl, [eax+22]
     mov     [edx+22], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount24 :
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount25 :
     mov     cl, [eax+24]
     mov     [edx+24], cl
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount26 :
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+24]
     mov     [edx+24], cl
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount27 :
     mov     cl, [eax+26]
     mov     [edx+26], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+24]
     mov     [edx+24], cl
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount28 :
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount29 :
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount30 :
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount31 :
     mov     cl, [eax+30]
     mov     [edx+30], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount32 :
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount33 :
     mov     cl, [eax+32]
     mov     [edx+32], cl
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount34 :
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+32]
     mov     [edx+32], cl
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount35 :
     mov     cl, [eax+34]
     mov     [edx+34], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+32]
     mov     [edx+32], cl
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount36 :
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount37 :
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8], mm2
     movq    [edx], mm3
     emms
     ret
@RewerseCaseCount38 :
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount39 :
     mov     cl, [eax+38]
     mov     [edx+38], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount40 :
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount41 :
     mov     cl, [eax+40]
     mov     [edx+40], cl
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount42 :
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+40]
     mov     [edx+40], cl
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount43 :
     mov     cl, [eax+42]
     mov     [edx+42], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+40]
     mov     [edx+40], cl
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount44 :
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount45 :
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount46 :
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount47 :
     mov     cl, [eax+46]
     mov     [edx+46], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount48 :
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount49 :
     mov     cl, [eax+48]
     mov     [edx+48], cl
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount50 :
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+48]
     mov     [edx+48], cl
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount51 :
     mov     cl, [eax+50]
     mov     [edx+50], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+48]
     mov     [edx+48], cl
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount52 :
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount53 :
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount54 :
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount55 :
     mov     cl, [eax+54]
     mov     [edx+54], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount56 :
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount57 :
     mov     cl, [eax+56]
     mov     [edx+56], cl
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount58 :
     mov     cl, [eax+57]
     mov     [edx+57], cl
     mov     cl, [eax+56]
     mov     [edx+56], cl
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount59 :
     mov     cl, [eax+58]
     mov     [edx+58], cl
     mov     cl, [eax+57]
     mov     [edx+57], cl
     mov     cl, [eax+56]
     mov     [edx+56], cl
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount60 :
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount61 :
     mov     cl, [eax+60]
     mov     [edx+60], cl
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount62 :
     mov     cl, [eax+61]
     mov     [edx+61], cl
     mov     cl, [eax+60]
     mov     [edx+60], cl
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount63 :
     mov     cl, [eax+62]
     mov     [edx+62], cl
     mov     cl, [eax+61]
     mov     [edx+61], cl
     mov     cl, [eax+60]
     mov     [edx+60], cl
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount64 :
     movq    mm0, [eax+56]
     movq    mm1, [eax+48]
     movq    mm2, [eax+40]
     movq    mm3, [eax+32]
     movq    mm4, [eax+24]
     movq    mm5, [eax+16]
     movq    mm6, [eax+8]
     movq    mm7, [eax]
     movq    [edx+56], mm0
     movq    [edx+48], mm1
     movq    [edx+40], mm2
     movq    [edx+32], mm3
     movq    [edx+24], mm4
     movq    [edx+16], mm5
     movq    [edx+8],  mm6
     movq    [edx],    mm7
     emms
     ret
     nop
     nop
     nop
 @Case1Else:
     push    ebx
     push    edi
 @L15:
     sub     ecx, 1
     mov     bl, [eax+ecx]
     mov     [edx+ecx], bl
     mov     edi, edx               // ecx is destination pointer
     add     edi, ecx
     and     edi, $07
     test    edi, edi
     jnz     @L15                    // until((SrcAddress2 mod 16) = 0);
     sub     ecx, 16
     mov     ebx, ecx
 @L67:
     movq    mm0, [eax+ecx+8]
     movq    [edx+ecx+8], mm0
     movq    mm1, [eax+ecx]
     movq    [edx+ecx], mm1
     sub     ecx, 16
     jns     @L67
     emms
     add     ecx,16
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @Exit:
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

@Case1JmpTable:
 dd @ForwardCaseCount0
 dd @ForwardCaseCount1
 dd @ForwardCaseCount2
 dd @ForwardCaseCount3
 dd @ForwardCaseCount4
 dd @ForwardCaseCount5
 dd @ForwardCaseCount6
 dd @ForwardCaseCount7
 dd @ForwardCaseCount8
 dd @ForwardCaseCount9
 dd @ForwardCaseCount10
 dd @ForwardCaseCount11
 dd @ForwardCaseCount12
 dd @ForwardCaseCount13
 dd @ForwardCaseCount14
 dd @ForwardCaseCount15
 dd @ForwardCaseCount16
 dd @ForwardCaseCount17
 dd @ForwardCaseCount18
 dd @ForwardCaseCount19
 dd @ForwardCaseCount20
 dd @ForwardCaseCount21
 dd @ForwardCaseCount22
 dd @ForwardCaseCount23
 dd @ForwardCaseCount24
 dd @ForwardCaseCount25
 dd @ForwardCaseCount26
 dd @ForwardCaseCount27
 dd @ForwardCaseCount28
 dd @ForwardCaseCount29
 dd @ForwardCaseCount30
 dd @ForwardCaseCount31
 dd @ForwardCaseCount32
 dd @ForwardCaseCount33
 dd @ForwardCaseCount34
 dd @ForwardCaseCount35
 dd @ForwardCaseCount36
 dd @ForwardCaseCount37
 dd @ForwardCaseCount38
 dd @ForwardCaseCount39
 dd @ForwardCaseCount40
 dd @ForwardCaseCount41
 dd @ForwardCaseCount42
 dd @ForwardCaseCount43
 dd @ForwardCaseCount44
 dd @ForwardCaseCount45
 dd @ForwardCaseCount46
 dd @ForwardCaseCount47
 dd @ForwardCaseCount48
 dd @ForwardCaseCount49
 dd @ForwardCaseCount50
 dd @ForwardCaseCount51
 dd @ForwardCaseCount52
 dd @ForwardCaseCount53
 dd @ForwardCaseCount54
 dd @ForwardCaseCount55

@Case2JmpTable:
 dd @RewerseCaseCount0
 dd @RewerseCaseCount1
 dd @RewerseCaseCount2
 dd @RewerseCaseCount3
 dd @RewerseCaseCount4
 dd @RewerseCaseCount5
 dd @RewerseCaseCount6
 dd @RewerseCaseCount7
 dd @RewerseCaseCount8
 dd @RewerseCaseCount9
 dd @RewerseCaseCount10
 dd @RewerseCaseCount11
 dd @RewerseCaseCount12
 dd @RewerseCaseCount13
 dd @RewerseCaseCount14
 dd @RewerseCaseCount15
 dd @RewerseCaseCount16
 dd @RewerseCaseCount17
 dd @RewerseCaseCount18
 dd @RewerseCaseCount19
 dd @RewerseCaseCount20
 dd @RewerseCaseCount21
 dd @RewerseCaseCount22
 dd @RewerseCaseCount23
 dd @RewerseCaseCount24
 dd @RewerseCaseCount25
 dd @RewerseCaseCount26
 dd @RewerseCaseCount27
 dd @RewerseCaseCount28
 dd @RewerseCaseCount29
 dd @RewerseCaseCount30
 dd @RewerseCaseCount31
 dd @RewerseCaseCount32
 dd @RewerseCaseCount33
 dd @RewerseCaseCount34
 dd @RewerseCaseCount35
 dd @RewerseCaseCount36
 dd @RewerseCaseCount37
 dd @RewerseCaseCount38
 dd @RewerseCaseCount39
 dd @RewerseCaseCount40
 dd @RewerseCaseCount41
 dd @RewerseCaseCount42
 dd @RewerseCaseCount43
 dd @RewerseCaseCount44
 dd @RewerseCaseCount45
 dd @RewerseCaseCount46
 dd @RewerseCaseCount47
 dd @RewerseCaseCount48
 dd @RewerseCaseCount49
 dd @RewerseCaseCount50
 dd @RewerseCaseCount51
 dd @RewerseCaseCount52
 dd @RewerseCaseCount53
 dd @RewerseCaseCount54
 dd @RewerseCaseCount55
 dd @RewerseCaseCount56
 dd @RewerseCaseCount57
 dd @RewerseCaseCount58
 dd @RewerseCaseCount59
 dd @RewerseCaseCount60
 dd @RewerseCaseCount61
 dd @RewerseCaseCount62
 dd @RewerseCaseCount63
 dd @RewerseCaseCount64
end;

{-------------------------------------------------------------------------}
{Perform Forward Move of 0..36 Bytes}
{On Entry, ECX = Count, EAX = Source+Count, EDX = Dest+Count.  Destroys ECX}
procedure SmallForwardMove_8;
asm
  jmp     dword ptr [@@FwdJumpTable+ecx*4]
  nop {Align Jump Table}
@@FwdJumpTable:
  dd      @@Done {Removes need to test for zero size move}
  dd      @@Fwd01, @@Fwd02, @@Fwd03, @@Fwd04, @@Fwd05, @@Fwd06, @@Fwd07, @@Fwd08
  dd      @@Fwd09, @@Fwd10, @@Fwd11, @@Fwd12, @@Fwd13, @@Fwd14, @@Fwd15, @@Fwd16
  dd      @@Fwd17, @@Fwd18, @@Fwd19, @@Fwd20, @@Fwd21, @@Fwd22, @@Fwd23, @@Fwd24
  dd      @@Fwd25, @@Fwd26, @@Fwd27, @@Fwd28, @@Fwd29, @@Fwd30, @@Fwd31, @@Fwd32
  dd      @@Fwd33, @@Fwd34, @@Fwd35, @@Fwd36
@@Fwd36:
  mov     ecx, [eax-36]
  mov     [edx-36], ecx
@@Fwd32:
  mov     ecx, [eax-32]
  mov     [edx-32], ecx
@@Fwd28:
  mov     ecx, [eax-28]
  mov     [edx-28], ecx
@@Fwd24:
  mov     ecx, [eax-24]
  mov     [edx-24], ecx
@@Fwd20:
  mov     ecx, [eax-20]
  mov     [edx-20], ecx
@@Fwd16:
  mov     ecx, [eax-16]
  mov     [edx-16], ecx
@@Fwd12:
  mov     ecx, [eax-12]
  mov     [edx-12], ecx
@@Fwd08:
  mov     ecx, [eax-8]
  mov     [edx-8], ecx
@@Fwd04:
  mov     ecx, [eax-4]
  mov     [edx-4], ecx
  ret
  nop
@@Fwd35:
  mov     ecx, [eax-35]
  mov     [edx-35], ecx
@@Fwd31:
  mov     ecx, [eax-31]
  mov     [edx-31], ecx
@@Fwd27:
  mov     ecx, [eax-27]
  mov     [edx-27], ecx
@@Fwd23:
  mov     ecx, [eax-23]
  mov     [edx-23], ecx
@@Fwd19:
  mov     ecx, [eax-19]
  mov     [edx-19], ecx
@@Fwd15:
  mov     ecx, [eax-15]
  mov     [edx-15], ecx
@@Fwd11:
  mov     ecx, [eax-11]
  mov     [edx-11], ecx
@@Fwd07:
  mov     ecx, [eax-7]
  mov     [edx-7], ecx
  mov     ecx, [eax-4]
  mov     [edx-4], ecx
  ret
  nop
@@Fwd03:
  movzx   ecx, word ptr [eax-3]
  mov     [edx-3], cx
  movzx   ecx, byte ptr [eax-1]
  mov     [edx-1], cl
  ret
@@Fwd34:
  mov     ecx, [eax-34]
  mov     [edx-34], ecx
@@Fwd30:
  mov     ecx, [eax-30]
  mov     [edx-30], ecx
@@Fwd26:
  mov     ecx, [eax-26]
  mov     [edx-26], ecx
@@Fwd22:
  mov     ecx, [eax-22]
  mov     [edx-22], ecx
@@Fwd18:
  mov     ecx, [eax-18]
  mov     [edx-18], ecx
@@Fwd14:
  mov     ecx, [eax-14]
  mov     [edx-14], ecx
@@Fwd10:
  mov     ecx, [eax-10]
  mov     [edx-10], ecx
@@Fwd06:
  mov     ecx, [eax-6]
  mov     [edx-6], ecx
@@Fwd02:
  movzx   ecx, word ptr [eax-2]
  mov     [edx-2], cx
  ret
  nop
  nop
  nop
@@Fwd33:
  mov     ecx, [eax-33]
  mov     [edx-33], ecx
@@Fwd29:
  mov     ecx, [eax-29]
  mov     [edx-29], ecx
@@Fwd25:
  mov     ecx, [eax-25]
  mov     [edx-25], ecx
@@Fwd21:
  mov     ecx, [eax-21]
  mov     [edx-21], ecx
@@Fwd17:
  mov     ecx, [eax-17]
  mov     [edx-17], ecx
@@Fwd13:
  mov     ecx, [eax-13]
  mov     [edx-13], ecx
@@Fwd09:
  mov     ecx, [eax-9]
  mov     [edx-9], ecx
@@Fwd05:
  mov     ecx, [eax-5]
  mov     [edx-5], ecx
@@Fwd01:
  movzx   ecx, byte ptr [eax-1]
  mov     [edx-1], cl
  ret
@@Done:
end; {SmallForwardMove}

{-------------------------------------------------------------------------}
{Perform Backward Move of 0..36 Bytes}
{On Entry, ECX = Count, EAX = Source, EDX = Dest.  Destroys ECX}
procedure SmallBackwardMove_8;
asm
  jmp     dword ptr [@@BwdJumpTable+ecx*4]
  nop {Align Jump Table}
@@BwdJumpTable:
  dd      @@Done {Removes need to test for zero size move}
  dd      @@Bwd01, @@Bwd02, @@Bwd03, @@Bwd04, @@Bwd05, @@Bwd06, @@Bwd07, @@Bwd08
  dd      @@Bwd09, @@Bwd10, @@Bwd11, @@Bwd12, @@Bwd13, @@Bwd14, @@Bwd15, @@Bwd16
  dd      @@Bwd17, @@Bwd18, @@Bwd19, @@Bwd20, @@Bwd21, @@Bwd22, @@Bwd23, @@Bwd24
  dd      @@Bwd25, @@Bwd26, @@Bwd27, @@Bwd28, @@Bwd29, @@Bwd30, @@Bwd31, @@Bwd32
  dd      @@Bwd33, @@Bwd34, @@Bwd35, @@Bwd36
@@Bwd36:
  mov     ecx, [eax+32]
  mov     [edx+32], ecx
@@Bwd32:
  mov     ecx, [eax+28]
  mov     [edx+28], ecx
@@Bwd28:
  mov     ecx, [eax+24]
  mov     [edx+24], ecx
@@Bwd24:
  mov     ecx, [eax+20]
  mov     [edx+20], ecx
@@Bwd20:
  mov     ecx, [eax+16]
  mov     [edx+16], ecx
@@Bwd16:
  mov     ecx, [eax+12]
  mov     [edx+12], ecx
@@Bwd12:
  mov     ecx, [eax+8]
  mov     [edx+8], ecx
@@Bwd08:
  mov     ecx, [eax+4]
  mov     [edx+4], ecx
@@Bwd04:
  mov     ecx, [eax]
  mov     [edx], ecx
  ret
  nop
  nop
  nop
@@Bwd35:
  mov     ecx, [eax+31]
  mov     [edx+31], ecx
@@Bwd31:
  mov     ecx, [eax+27]
  mov     [edx+27], ecx
@@Bwd27:
  mov     ecx, [eax+23]
  mov     [edx+23], ecx
@@Bwd23:
  mov     ecx, [eax+19]
  mov     [edx+19], ecx
@@Bwd19:
  mov     ecx, [eax+15]
  mov     [edx+15], ecx
@@Bwd15:
  mov     ecx, [eax+11]
  mov     [edx+11], ecx
@@Bwd11:
  mov     ecx, [eax+7]
  mov     [edx+7], ecx
@@Bwd07:
  mov     ecx, [eax+3]
  mov     [edx+3], ecx
  mov     ecx, [eax]
  mov     [edx], ecx
  ret
  nop
  nop
  nop
@@Bwd03:
  movzx   ecx, word ptr [eax+1]
  mov     [edx+1], cx
  movzx   ecx, byte ptr [eax]
  mov     [edx], cl
  ret
  nop
  nop
@@Bwd34:
  mov     ecx, [eax+30]
  mov     [edx+30], ecx
@@Bwd30:
  mov     ecx, [eax+26]
  mov     [edx+26], ecx
@@Bwd26:
  mov     ecx, [eax+22]
  mov     [edx+22], ecx
@@Bwd22:
  mov     ecx, [eax+18]
  mov     [edx+18], ecx
@@Bwd18:
  mov     ecx, [eax+14]
  mov     [edx+14], ecx
@@Bwd14:
  mov     ecx, [eax+10]
  mov     [edx+10], ecx
@@Bwd10:
  mov     ecx, [eax+6]
  mov     [edx+6], ecx
@@Bwd06:
  mov     ecx, [eax+2]
  mov     [edx+2], ecx
@@Bwd02:
  movzx   ecx, word ptr [eax]
  mov     [edx], cx
  ret
  nop
@@Bwd33:
  mov     ecx, [eax+29]
  mov     [edx+29], ecx
@@Bwd29:
  mov     ecx, [eax+25]
  mov     [edx+25], ecx
@@Bwd25:
  mov     ecx, [eax+21]
  mov     [edx+21], ecx
@@Bwd21:
  mov     ecx, [eax+17]
  mov     [edx+17], ecx
@@Bwd17:
  mov     ecx, [eax+13]
  mov     [edx+13], ecx
@@Bwd13:
  mov     ecx, [eax+9]
  mov     [edx+9], ecx
@@Bwd09:
  mov     ecx, [eax+5]
  mov     [edx+5], ecx
@@Bwd05:
  mov     ecx, [eax+1]
  mov     [edx+1], ecx
@@Bwd01:
  movzx   ecx, byte ptr[eax]
  mov     [edx], cl
  ret
  nop
  nop
@@Done:
end; {SmallBackwardMove}

{-------------------------------------------------------------------------}
procedure AlignedSSEMove;
asm
@@Loop:
  movaps  xmm0, [eax+8*ecx]
  movaps  xmm1, [eax+8*ecx+16]
  movaps  xmm2, [eax+8*ecx+32]
  movaps  xmm3, [eax+8*ecx+48]
  movaps  [edx+8*ecx], xmm0
  movaps  [edx+8*ecx+16], xmm1
  movaps  [edx+8*ecx+32], xmm2
  movaps  [edx+8*ecx+48], xmm3
  movaps  xmm4, [eax+8*ecx+64]
  movaps  xmm5, [eax+8*ecx+80]
  movaps  xmm6, [eax+8*ecx+96]
  movaps  xmm7, [eax+8*ecx+112]
  movaps  [edx+8*ecx+64], xmm4
  movaps  [edx+8*ecx+80], xmm5
  movaps  [edx+8*ecx+96], xmm6
  movaps  [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
end;


{-------------------------------------------------------------------------}
procedure UnalignedSSEMove;
asm
@@Loop:
  movups  xmm0, [eax+8*ecx]
  movups  xmm1, [eax+8*ecx+16]
  movups  xmm2, [eax+8*ecx+32]
  movups  xmm3, [eax+8*ecx+48]
  movaps  [edx+8*ecx], xmm0
  movaps  [edx+8*ecx+16], xmm1
  movaps  [edx+8*ecx+32], xmm2
  movaps  [edx+8*ecx+48], xmm3
  movups  xmm4, [eax+8*ecx+64]
  movups  xmm5, [eax+8*ecx+80]
  movups  xmm6, [eax+8*ecx+96]
  movups  xmm7, [eax+8*ecx+112]
  movaps  [edx+8*ecx+64], xmm4
  movaps  [edx+8*ecx+80], xmm5
  movaps  [edx+8*ecx+96], xmm6
  movaps  [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
end;

{-------------------------------------------------------------------------}
procedure LargeAlignedSSEMove;
const
  Prefetch = 512;
asm
@@Loop:
  prefetchnta [eax+8*ecx+Prefetch]
  prefetchnta [eax+8*ecx+Prefetch+64]
  movaps  xmm0, [eax+8*ecx]
  movaps  xmm1, [eax+8*ecx+16]
  movaps  xmm2, [eax+8*ecx+32]
  movaps  xmm3, [eax+8*ecx+48]
  movntps [edx+8*ecx], xmm0
  movntps [edx+8*ecx+16], xmm1
  movntps [edx+8*ecx+32], xmm2
  movntps [edx+8*ecx+48], xmm3
  movaps  xmm4, [eax+8*ecx+64]
  movaps  xmm5, [eax+8*ecx+80]
  movaps  xmm6, [eax+8*ecx+96]
  movaps  xmm7, [eax+8*ecx+112]
  movntps [edx+8*ecx+64], xmm4
  movntps [edx+8*ecx+80], xmm5
  movntps [edx+8*ecx+96], xmm6
  movntps [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
  sfence
end;

{-------------------------------------------------------------------------}
procedure LargeUnalignedSSEMove;
const
  Prefetch = 512;
asm
@@Loop:
  prefetchnta [eax+8*ecx+Prefetch]
  prefetchnta [eax+8*ecx+Prefetch+64]
  movups  xmm0, [eax+8*ecx]
  movups  xmm1, [eax+8*ecx+16]
  movups  xmm2, [eax+8*ecx+32]
  movups  xmm3, [eax+8*ecx+48]
  movntps [edx+8*ecx], xmm0
  movntps [edx+8*ecx+16], xmm1
  movntps [edx+8*ecx+32], xmm2
  movntps [edx+8*ecx+48], xmm3
  movups  xmm4, [eax+8*ecx+64]
  movups  xmm5, [eax+8*ecx+80]
  movups  xmm6, [eax+8*ecx+96]
  movups  xmm7, [eax+8*ecx+112]
  movntps [edx+8*ecx+64], xmm4
  movntps [edx+8*ecx+80], xmm5
  movntps [edx+8*ecx+96], xmm6
  movntps [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
  sfence
end;


{-------------------------------------------------------------------------}
{Dest MUST be 16-Byes Aligned, Count MUST be multiple of 16 }
procedure AlignedFwdMoveSSE_8(const Source; var Dest; Count: Integer);
asm
  push    ebx
  mov     ebx, ecx
  and     ecx, -128             {No of Bytes to Block Move (Multiple of 128)}
  add     eax, ecx              {End of Source Blocks}
  add     edx, ecx              {End of Dest Blocks}
  shr     ecx, 3                {No of QWORD's to Block Move}
  neg     ecx
  cmp     ecx, PrefetchLimit    {Count > Limit - Use Prefetch}
  jl      @@Large
  test    eax, 15               {Check if Both Source/Dest are Aligned}
  jnz     @@SmallUnaligned
  call    AlignedSSEMove        {Both Source and Dest 16-Byte Aligned}
  jmp     @Remainder
@@SmallUnaligned:               {Source Not 16-Byte Aligned}
  call    UnalignedSSEMove
  jmp     @Remainder
@@Large:
  test    eax, 15               {Check if Both Source/Dest Aligned}
  jnz     @@LargeUnaligned
  call    LargeAlignedSSEMove   {Both Source and Dest 16-Byte Aligned}
  jmp     @Remainder
@@LargeUnaligned:               {Source Not 16-Byte Aligned}
  call    LargeUnalignedSSEMove
@Remainder:
  and     ebx, $7F              {Remainder (0..112 - Multiple of 16)}
  jz      @@Done
  add     eax, ebx
  add     edx, ebx
  neg     ebx
@@RemainderLoop:
  movups  xmm0, [eax+ebx]
  movaps  [edx+ebx], xmm0
  add     ebx, 16
  jnz     @@RemainderLoop
@@Done:
  pop     ebx
end; {AlignedFwdMoveSSE}


{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX > EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Forwards_SSE_8;
const
  LARGESIZE = 2048;
asm
  cmp     ecx, LARGESIZE
  jge     @FwdLargeMove
  cmp     ecx, SMALLMOVESIZE+32
  movups  xmm0, [eax]
  jg      @FwdMoveSSE
  movups  xmm1, [eax+16]
  movups  [edx], xmm0
  movups  [edx+16], xmm1
  add     eax, ecx
  add     edx, ecx
  sub     ecx, 32
  jmp     SmallForwardMove_8
@FwdMoveSSE:
  push    ebx
  mov     ebx, edx
  {Align Writes}
  add     eax, ecx
  add     ecx, edx
  add     edx, 15                   
  and     edx, -16
  sub     ecx, edx
  add     edx, ecx
  {Now Aligned}
  sub     ecx, 32
  neg     ecx
@FwdLoopSSE:
  movups  xmm1, [eax+ecx-32]
  movups  xmm2, [eax+ecx-16]
  movaps  [edx+ecx-32], xmm1
  movaps  [edx+ecx-16], xmm2
  add     ecx, 32
  jle     @FwdLoopSSE
  movups  [ebx], xmm0 {First 16 Bytes}
  neg     ecx
  add     ecx, 32
  pop     ebx
  jmp     SmallForwardMove_8
@FwdLargeMove:
  push    ebx
  mov     ebx, ecx
  test    edx, 15
  jz      @FwdLargeAligned
  {16 byte Align Destination}
  mov     ecx, edx
  add     ecx, 15
  and     ecx, -16
  sub     ecx, edx
  add     eax, ecx
  add     edx, ecx
  sub     ebx, ecx
  {Destination now 16 Byte Aligned}
  call    SmallForwardMove_8
  mov     ecx, ebx
@FwdLargeAligned:
  and     ecx, -16
  sub     ebx, ecx {EBX = Remainder}
  push    edx
  push    eax
  push    ecx
  call    AlignedFwdMoveSSE_8
  pop     ecx
  pop     eax
  pop     edx
  add     ecx, ebx
  add     eax, ecx
  add     edx, ecx
  mov     ecx, ebx
  pop     ebx
  jmp     SmallForwardMove_8
end; {Forwards_SSE}

{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX < EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Backwards_SSE_8;
asm
  cmp     ecx, SMALLMOVESIZE+32
  jg      @BwdMoveSSE
  sub     ecx, 32
  movups  xmm1, [eax+ecx]
  movups  xmm2, [eax+ecx+16]
  movups  [edx+ecx], xmm1
  movups  [edx+ecx+16], xmm2
  jmp     SmallBackwardMove_8
  nop
  nop
@BwdMoveSSE:
  push    ebx                            
  movups  xmm0, [eax+ecx-16] {Last 16 Bytes}
  {Align Writes}
  lea     ebx, [edx+ecx]
  and     ebx, 15
  sub     ecx, ebx
  add     ebx, ecx
  {Now Aligned}
  sub     ecx, 32
@BwdLoop:
  movups  xmm1, [eax+ecx]
  movups  xmm2, [eax+ecx+16]
  movaps  [edx+ecx], xmm1
  movaps  [edx+ecx+16], xmm2
  sub     ecx, 32
  jge     @BwdLoop
  movups  [edx+ebx-16], xmm0  {Last 16 Bytes}
  add     ecx, 32
  pop     ebx
  jmp     SmallBackwardMove_8
end; {Backwards_SSE}



//Author:            John O'Harrow
//Date:
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): SSE
//Original name:     MoveJOH_SSE_8

procedure MoveFastcodePMB(const Source; var Dest; Count : Integer);
asm
  cmp     ecx, SMALLMOVESIZE
  ja      @Large {Count > SMALLMOVESIZE or Count < 0}
  cmp     eax, edx
  jbe     @SmallCheck
  add     eax, ecx
  add     edx, ecx
  jmp     SmallForwardMove_8
@SmallCheck:
  jne     SmallBackwardMove_8
  ret {For Compatibility with Delphi's move for Source = Dest}
@Large:
  jng     @Done {For Compatibility with Delphi's move for Count < 0}
  cmp     eax, edx
  ja      Forwards_SSE_8
  je      @Done {For Compatibility with Delphi's move for Source = Dest}
  sub     edx, ecx
  cmp     eax, edx
  lea     edx, [edx+ecx]
  jna     Forwards_SSE_8
  jmp     Backwards_SSE_8 {Source/Dest Overlap}
@Done:
end; {MoveJOH_SSE}

{-------------------------------------------------------------------------}
procedure AlignedSSE2Move;
asm
@@Loop:
  movdqa  xmm0, [eax+8*ecx]
  movdqa  xmm1, [eax+8*ecx+16]
  movdqa  xmm2, [eax+8*ecx+32]
  movdqa  xmm3, [eax+8*ecx+48]
  movdqa  [edx+8*ecx], xmm0
  movdqa  [edx+8*ecx+16], xmm1
  movdqa  [edx+8*ecx+32], xmm2
  movdqa  [edx+8*ecx+48], xmm3
  movdqa  xmm4, [eax+8*ecx+64]
  movdqa  xmm5, [eax+8*ecx+80]
  movdqa  xmm6, [eax+8*ecx+96]
  movdqa  xmm7, [eax+8*ecx+112]
  movdqa  [edx+8*ecx+64], xmm4
  movdqa  [edx+8*ecx+80], xmm5
  movdqa  [edx+8*ecx+96], xmm6
  movdqa  [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
end;


{-------------------------------------------------------------------------}
procedure UnalignedSSE2Move;
asm
@@Loop:
  movdqu  xmm0, [eax+8*ecx]
  movdqu  xmm1, [eax+8*ecx+16]
  movdqu  xmm2, [eax+8*ecx+32]
  movdqu  xmm3, [eax+8*ecx+48]
  movdqa  [edx+8*ecx], xmm0
  movdqa  [edx+8*ecx+16], xmm1
  movdqa  [edx+8*ecx+32], xmm2
  movdqa  [edx+8*ecx+48], xmm3
  movdqu  xmm4, [eax+8*ecx+64]
  movdqu  xmm5, [eax+8*ecx+80]
  movdqu  xmm6, [eax+8*ecx+96]
  movdqu  xmm7, [eax+8*ecx+112]
  movdqa  [edx+8*ecx+64], xmm4
  movdqa  [edx+8*ecx+80], xmm5
  movdqa  [edx+8*ecx+96], xmm6
  movdqa  [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
end;

{-------------------------------------------------------------------------}
procedure LargeAlignedSSE2Move;
const
  Prefetch = 512;
asm
@@Loop:
  prefetchnta [eax+8*ecx+Prefetch]
  prefetchnta [eax+8*ecx+Prefetch+64]
  movdqa  xmm0, [eax+8*ecx]
  movdqa  xmm1, [eax+8*ecx+16]
  movdqa  xmm2, [eax+8*ecx+32]
  movdqa  xmm3, [eax+8*ecx+48]
  movntdq [edx+8*ecx], xmm0
  movntdq [edx+8*ecx+16], xmm1
  movntdq [edx+8*ecx+32], xmm2
  movntdq [edx+8*ecx+48], xmm3
  movdqa  xmm4, [eax+8*ecx+64]
  movdqa  xmm5, [eax+8*ecx+80]
  movdqa  xmm6, [eax+8*ecx+96]
  movdqa  xmm7, [eax+8*ecx+112]
  movntdq [edx+8*ecx+64], xmm4
  movntdq [edx+8*ecx+80], xmm5
  movntdq [edx+8*ecx+96], xmm6
  movntdq [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
  sfence
end;

{-------------------------------------------------------------------------}
procedure LargeUnalignedSSE2Move;
const
  Prefetch = 512;
asm
@@Loop:
  prefetchnta [eax+8*ecx+Prefetch]
  prefetchnta [eax+8*ecx+Prefetch+64]
  movdqu  xmm0, [eax+8*ecx]
  movdqu  xmm1, [eax+8*ecx+16]
  movdqu  xmm2, [eax+8*ecx+32]
  movdqu  xmm3, [eax+8*ecx+48]
  movntdq [edx+8*ecx], xmm0
  movntdq [edx+8*ecx+16], xmm1
  movntdq [edx+8*ecx+32], xmm2
  movntdq [edx+8*ecx+48], xmm3
  movdqu  xmm4, [eax+8*ecx+64]
  movdqu  xmm5, [eax+8*ecx+80]
  movdqu  xmm6, [eax+8*ecx+96]
  movdqu  xmm7, [eax+8*ecx+112]
  movntdq [edx+8*ecx+64], xmm4
  movntdq [edx+8*ecx+80], xmm5
  movntdq [edx+8*ecx+96], xmm6
  movntdq [edx+8*ecx+112], xmm7
  add     ecx, 16
  js      @@Loop
  sfence
end;


{-------------------------------------------------------------------------}
{Dest MUST be 16-Byes Aligned, Count MUST be multiple of 16 }
procedure AlignedFwdMoveSSE2_9(const Source; var Dest; Count: Integer);
asm
  push    ebx
  mov     ebx, ecx
  and     ecx, -128             {No of Bytes to Block Move (Multiple of 128)}
  add     eax, ecx              {End of Source Blocks}
  add     edx, ecx              {End of Dest Blocks}
  shr     ecx, 3                {No of QWORD's to Block Move}
  neg     ecx
  cmp     ecx, PrefetchLimit    {Count > Limit - Use Prefetch}
  jl      @@Large
  test    eax, 15               {Check if Both Source/Dest are Aligned}
  jnz     @@SmallUnaligned
  call    AlignedSSE2Move       {Both Source and Dest 16-Byte Aligned}
  jmp     @Remainder
@@SmallUnaligned:               {Source Not 16-Byte Aligned}
  call    UnalignedSSE2Move
  jmp     @Remainder
@@Large:
  test    eax, 15               {Check if Both Source/Dest Aligned}
  jnz     @@LargeUnaligned
  call    LargeAlignedSSE2Move  {Both Source and Dest 16-Byte Aligned}
  jmp     @Remainder
@@LargeUnaligned:               {Source Not 16-Byte Aligned}
  call    LargeUnalignedSSE2Move
@Remainder:
  and     ebx, $7F              {Remainder (0..112 - Multiple of 16)}
  jz      @@Done
  add     eax, ebx
  add     edx, ebx
  neg     ebx
@@RemainderLoop:
  movdqu  xmm0, [eax+ebx]
  movdqa  [edx+ebx], xmm0
  add     ebx, 16
  jnz     @@RemainderLoop
@@Done:
  pop     ebx
end; {AlignedFwdMoveSSE2}

{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX > EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Forwards_SSE2_9;
const
  LARGESIZE = 2048;
asm
  cmp     ecx, LARGESIZE
  jge     @FwdLargeMove
  cmp     ecx, SMALLMOVESIZE+32
  movdqu  xmm0, [eax]
  jg      @FwdMoveSSE2
  movdqu  xmm1, [eax+16]
  movdqu  [edx], xmm0
  movdqu  [edx+16], xmm1
  add     eax, ecx
  add     edx, ecx
  sub     ecx, 32
  jmp     SmallForwardMove_9
  nop
  nop
  nop
@FwdMoveSSE2:
  push    ebx
  mov     ebx, edx
  {Align Writes}
  add     eax, ecx
  add     ecx, edx
  add     edx, 15
  and     edx, -16
  sub     ecx, edx
  add     edx, ecx
  {Now Aligned}
  sub     ecx, 32
  neg     ecx
@FwdLoopSSE2:
  movdqu  xmm1, [eax+ecx-32]
  movdqu  xmm2, [eax+ecx-16]
  movdqa  [edx+ecx-32], xmm1
  movdqa  [edx+ecx-16], xmm2
  add     ecx, 32
  jle     @FwdLoopSSE2
  movdqu  [ebx], xmm0 {First 16 Bytes}
  neg     ecx
  add     ecx, 32
  pop     ebx
  jmp     SmallForwardMove_9
@FwdLargeMove:
  push    ebx
  mov     ebx, ecx
  test    edx, 15
  jz      @FwdLargeAligned
  {16 byte Align Destination}
  mov     ecx, edx
  add     ecx, 15
  and     ecx, -16
  sub     ecx, edx
  add     eax, ecx
  add     edx, ecx
  sub     ebx, ecx
  {Destination now 16 Byte Aligned}
  call    SmallForwardMove_9
  mov     ecx, ebx
@FwdLargeAligned:
  and     ecx, -16
  sub     ebx, ecx {EBX = Remainder}
  push    edx
  push    eax
  push    ecx
  call    AlignedFwdMoveSSE2_9
  pop     ecx
  pop     eax
  pop     edx
  add     ecx, ebx
  add     eax, ecx
  add     edx, ecx
  mov     ecx, ebx
  pop     ebx
  jmp     SmallForwardMove_9
end; {Forwards_SSE2}
{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX < EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Backwards_SSE2_9;
asm
  cmp     ecx, SMALLMOVESIZE+32
  jg      @BwdMoveSSE2
  sub     ecx, 32
  movdqu  xmm1, [eax+ecx]
  movdqu  xmm2, [eax+ecx+16]
  movdqu  [edx+ecx], xmm1
  movdqu  [edx+ecx+16], xmm2
  jmp     SmallBackwardMove_9
  nop
@BwdMoveSSE2:                     
  push    ebx
  movdqu  xmm0, [eax+ecx-16] {Last 16 Bytes}
  {Align Writes}
  lea     ebx, [edx+ecx]
  and     ebx, 15
  sub     ecx, ebx
  add     ebx, ecx
  {Now Aligned}
  sub     ecx, 32
@BwdLoop:
  movdqu  xmm1, [eax+ecx]
  movdqu  xmm2, [eax+ecx+16]
  movdqa  [edx+ecx], xmm1
  movdqa  [edx+ecx+16], xmm2
  sub     ecx, 32
  jge     @BwdLoop
  movdqu  [edx+ebx-16], xmm0  {Last 16 Bytes}
  add     ecx, 32
  pop     ebx
  jmp     SmallBackwardMove_9
end; {Backwards_SSE2}


//Author:            John O'Harrow
//Date:
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): SSE2
//Original name:     MoveJOH_SSE2_9

procedure MoveFastcodeAMD64(const Source; var Dest; Count : Integer);
asm
  cmp     ecx, SMALLMOVESIZE
  ja      @Large {Count > SMALLMOVESIZE or Count < 0}
  cmp     eax, edx
  jbe     @SmallCheck
  add     eax, ecx
  add     edx, ecx
  jmp     SmallForwardMove_9
@SmallCheck:
  jne     SmallBackwardMove_9
  ret {For Compatibility with Delphi's move for Source = Dest}
@Large:
  jng     @Done {For Compatibility with Delphi's move for Count < 0}
  cmp     eax, edx
  ja      Forwards_SSE2_9
  je      @Done {For Compatibility with Delphi's move for Source = Dest}
  sub     edx, ecx
  cmp     eax, edx
  lea     edx, [edx+ecx]
  jna     Forwards_SSE2_9
  jmp     Backwards_SSE2_9 {Source/Dest Overlap}
@Done:
end; {MoveJOH_SSE2}


//Author:            Dennis Kjaer Christensen
//Date:              10/6 2004
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32, MMX, SSE
//Original name:     MoveDKCSSE_1

procedure MoveFastcodeXP(const Source; var Dest; Count : Integer);
asm
     //Exit if Count is negative
     test    ecx, ecx
     js      @Exit
     //Detect the need for rewerse move in overlapped case
     cmp     eax, edx                   // if (DestAddress > SourceAddress) then
     jnb     @ForwardMove
     push    ebx
     mov     ebx, edx
     sub     ebx, eax                   // (DestAddress - SourceAddress)
     cmp     ebx, edx                   // if ((DestAddress - SourceAddress) < Count) then
     pop     ebx
     jb      @RewMove
@ForwardMove:
     cmp     ecx, 55
     jnbe    @ForwardCaseElse
     jmp     dword ptr [ecx*4+@Case1JmpTable]
@ForwardCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
@ForwardCaseCount0:
     ret
@ForwardCaseCount2:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     ret
@ForwardCaseCount3:
     mov     cl, [eax]
     mov     [edx], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax+2]
     mov     [edx+2], cl
     ret
@ForwardCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@ForwardCaseCount5:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     ret
@ForwardCaseCount6:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     ret
@ForwardCaseCount7:
     mov     ecx, [eax]
     mov     [edx], ecx
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+6]
     mov     [edx+6], cl
     ret
@ForwardCaseCount8:
     movq    mm0, [eax]
     movq    [edx], mm0
     emms
     ret
@ForwardCaseCount9:
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     emms
     ret
@ForwardCaseCount10 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     emms
     ret
@ForwardCaseCount11 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+10]
     mov     [edx+10], cl
     emms
     ret
@ForwardCaseCount12:
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     emms
     ret
@ForwardCaseCount13 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     emms
     ret
@ForwardCaseCount14 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     emms
     ret
@ForwardCaseCount15 :
     movq    mm0, [eax]
     movq    [edx], mm0
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+14]
     mov     [edx+14], cl
     emms
     ret
@ForwardCaseCount16 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     emms
     ret
@ForwardCaseCount17 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     emms
     ret
@ForwardCaseCount18 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     emms
     ret
@ForwardCaseCount19 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     cl, [eax+16]
     mov     [edx+16], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+18]
     mov     [edx+18], cl
     emms
     ret
@ForwardCaseCount20 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     emms
     ret
@ForwardCaseCount21 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     emms
     ret
@ForwardCaseCount22 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     emms
     ret
@ForwardCaseCount23 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    [edx],   mm0
     movq    [edx+8], mm1
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+22]
     mov     [edx+22], cl
     emms
     ret
@ForwardCaseCount24 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     emms
     ret
@ForwardCaseCount25 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     emms
     ret
@ForwardCaseCount26 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     emms
     ret
@ForwardCaseCount27 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     cl, [eax+24]
     mov     [edx+24], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+26]
     mov     [edx+26], cl
     emms
     ret
@ForwardCaseCount28 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     emms
     ret
@ForwardCaseCount29 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     emms
     ret
@ForwardCaseCount30 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     emms
     ret
@ForwardCaseCount31 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+30]
     mov     [edx+30], cl
     emms
     ret
@ForwardCaseCount32 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     emms
     ret
@ForwardCaseCount33 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     emms
     ret
@ForwardCaseCount34 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     emms
     ret
@ForwardCaseCount35 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     cl, [eax+32]
     mov     [edx+32], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+34]
     mov     [edx+34], cl
     emms
     ret
@ForwardCaseCount36 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     emms
     ret
@ForwardCaseCount37 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     emms
     ret
@ForwardCaseCount38 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     emms
     ret
@ForwardCaseCount39 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+38]
     mov     [edx+38], cl
     emms
     ret
@ForwardCaseCount40 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     emms
     ret
@ForwardCaseCount41 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     emms
     ret
@ForwardCaseCount42 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     emms
     ret
@ForwardCaseCount43 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     cl, [eax+40]
     mov     [edx+40], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+42]
     mov     [edx+42], cl
     emms
     ret
@ForwardCaseCount44 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     emms
     ret
@ForwardCaseCount45 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     emms
     ret
@ForwardCaseCount46 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     emms
     ret
@ForwardCaseCount47 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+46]
     mov     [edx+46], cl
     emms
     ret
@ForwardCaseCount48 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     emms
     ret
@ForwardCaseCount49 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     emms
     ret
@ForwardCaseCount50 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     emms
     ret
@ForwardCaseCount51 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     cl, [eax+48]
     mov     [edx+48], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+50]
     mov     [edx+50], cl
     emms
     ret
@ForwardCaseCount52 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     emms
     ret
@ForwardCaseCount53 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     emms
     ret
@ForwardCaseCount54 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     emms
     ret
@ForwardCaseCount55 :
     movq    mm0, [eax]
     movq    mm1, [eax+8]
     movq    mm2, [eax+16]
     movq    mm3, [eax+24]
     movq    mm4, [eax+32]
     movq    mm5, [eax+40]
     movq    [edx],    mm0
     movq    [edx+8],  mm1
     movq    [edx+16], mm2
     movq    [edx+24], mm3
     movq    [edx+32], mm4
     movq    [edx+40], mm5
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl,[eax+54]
     mov     [edx+54],cl
     emms
     ret
     nop
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @ForwardCaseElse:
     cmp     ecx, 800
     jnle    @Else9
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     mov     edi, ecx
     shr     edi, 5
     shl     edi, 5
     xor     ebx, ebx
 @L11:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    mm2, [eax+ebx+16]
     movq    mm3, [eax+ebx+24]
     movq    [edx+ebx], mm0
     movq    [edx+ebx+8], mm1
     movq    [edx+ebx+16], mm2
     movq    [edx+ebx+24], mm3
     add     ebx, 32
     cmp     ebx, edi
     jb      @L11
     emms
     add     eax, edi
     add     edx, edi
     sub     ecx, edi  //Remaining moves
     pop     esi
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case1JmpTable]
     nop
     nop
     nop
     nop
     nop
 @Else9:
     push    ebx                     // Pop is done before jmp to exit1
     push    edi                     // Pop is done before jmp to exit1
     push    esi                     // Pop is done before jmp to exit1
     //Align destination
     xor     edi, edi                // ByteNo1 := 0;
 @L111:
     mov     bl, [eax+edi]           // DstB[ByteNo1] := SrcB[ByteNo1];
     mov     [edx+edi], bl
     add     edi, 1                  // Inc(ByteNo1);
     mov     ebx, edx                // edx is destination pointer
     add     ebx, edi
     and     ebx, $0f
     test    ebx, ebx
     jnz     @L111                   // until((SrcAddress2 mod 16) = 0);
     add     eax, edi                // SrcB is aligned now - "SrcI := SrcI + ByteNo1;" Not valid Pascal
     add     edx, edi                // DstB is aligned now - "DstI := DstI + ByteNo1;" Not valid Pascal
     sub     ecx, edi                // Count := Count - ByteNo1;
     mov     esi, ecx
 @L222:
     //SourceAddress2 := Cardinal(@SrcB[0]);
     //if (SourceAddress2 mod 16 = 0) then
     mov     ebx, eax
     and     ebx, $0f
     jnz     @ElseIf1
     //Both source and destination are 16 byte aligned
     cmp     ecx, 240000            // if Count < 1M then
     jnl     @Else2
     shr     ecx,4
     shl     ecx,4
     xor     ebx, ebx
 @L1111:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L1111
     jmp     @Fedtmule
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
 @Else2:
     shr     ecx, 7                  // NoOfIntLoops  := Count div 16;    16, 32, 48, 64, 80, 96, 112, 128
     shl     ecx, 7                  // NoOfIntMoves := NoOfIntLoops * 4;  4,  8, 12, 16, 20, 24,  28,  32
     xor     ebx, ebx
 @L10:
     movaps  xmm0, [eax+ebx]
     movaps  xmm1, [eax+ebx+16]
     movaps  xmm2, [eax+ebx+32]
     movaps  xmm3, [eax+ebx+48]
     movaps  xmm4, [eax+ebx+64]
     movaps  xmm5, [eax+ebx+80]
     movaps  xmm6, [eax+ebx+96]
     movaps  xmm7, [eax+ebx+112]
     movntps [edx+ebx],     xmm0
     movntps [edx+ebx+16],  xmm1
     movntps [edx+ebx+32],  xmm2
     movntps [edx+ebx+48],  xmm3
     movntps [edx+ebx+64],  xmm4
     movntps [edx+ebx+80],  xmm5
     movntps [edx+ebx+96],  xmm6
     movntps [edx+ebx+112], xmm7
     add     ebx, 128
     cmp     ebx, ecx
     jb      @L10
 @L20:
     jmp     @Fedtmule
     nop
     nop
     nop
     nop
     nop
     //else if (SourceAddress2 mod 8 = 0) then
 @ElseIf1:
     //Source is at least 8 byte aligned and destination is at least 16 byte aligned
     mov     ebx, eax
     and     ebx, $07
     test    ebx, ebx
     jnz     @Else1
     //Destination 16 byte aligned, Source unaligned
     shr     ecx, 4               // NoOfIntLoops  := Count div 16;
     shl     ecx, 4               // NoOfIntMoves := NoOfIntLoops * 4;
     xor     ebx, ebx
 @L100:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L100
 @L200:
     jmp     @Fedtmule
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
 @Else1:
     //Destination 16 byte aligned. Source unaligned
     shr     ecx, 4
     shl     ecx, 4
     xor     ebx, ebx
 @L1000:
     movq    mm0, [eax+ebx]
     movq    mm1, [eax+ebx+8]
     movq    [edx+ebx],   mm0
     movq    [edx+ebx+8], mm1
     add     ebx, 16
     cmp     ebx, ecx
     jb      @L1000
     nop
     nop
     nop
     nop
     nop
     nop
     nop
 @Fedtmule:
     // Small moves after big 16 byte destination aligned moves
     add     eax, ecx
     add     edx, ecx
     sub     esi, ecx  //Remaining moves
     mov     ecx, esi
     cmp     ecx, 55
     ja      @L1239
     pop     esi
     pop     edi
     pop     ebx
     emms
     jmp     dword ptr [ecx*4+@Case1JmpTable]
     nop
     nop
     nop
     nop
     nop
 @L1239:
     add     ecx, eax
 @L123:
     mov     bl, [eax]          // DstB[ByteNo] := SrcB[ByteNo];
     mov     [edx], bl
     inc     eax
     inc     edx
     cmp     eax, ecx
     jb      @L123                  // until(ByteNo >= EndOfByteMoves);
     pop     esi
     pop     edi
     pop     ebx
     emms
     ret
 @RewMove:
     cmp     ecx,64
     jnbe    @Case1Else
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @RewerseCaseCount1:
     mov     cl, [eax]
     mov     [edx], cl
 @RewerseCaseCount0:
     ret
 @RewerseCaseCount2:
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax]
     mov     [edx], cl
     ret
 @RewerseCaseCount3:
     mov     cl, [eax+2]
     mov     [edx+2], cl
     mov     cl, [eax+1]
     mov     [edx+1], cl
     mov     cl, [eax]
     mov     [edx], cl
     ret
 @RewerseCaseCount4:
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount5:
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount6:
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount7:
     mov     cl, [eax+6]
     mov     [edx+6], cl
     mov     cl, [eax+5]
     mov     [edx+5], cl
     mov     cl, [eax+4]
     mov     [edx+4], cl
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount8:
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount9:
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount10:
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount11:
     mov     cl, [eax+10]
     mov     [edx+10], cl
     mov     cl, [eax+9]
     mov     [edx+9], cl
     mov     cl, [eax+8]
     mov     [edx+8], cl
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount12 :
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
 @RewerseCaseCount13 :
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@RewerseCaseCount14 :
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@RewerseCaseCount15 :
     mov     cl, [eax+14]
     mov     [edx+14], cl
     mov     cl, [eax+13]
     mov     [edx+13], cl
     mov     cl, [eax+12]
     mov     [edx+12], cl
     mov     ecx, [eax+8]
     mov     [edx+8], ecx
     mov     ecx, [eax+4]
     mov     [edx+4], ecx
     mov     ecx, [eax]
     mov     [edx], ecx
     ret
@RewerseCaseCount16 :
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount17 :
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount18 :
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount19 :
     mov     cl, [eax+18]
     mov     [edx+18], cl
     mov     cl, [eax+17]
     mov     [edx+17], cl
     mov     cl, [eax+16]
     mov     [edx+16], cl
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount20 :
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount21 :
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount22 :
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount23 :
     mov     cl, [eax+22]
     mov     [edx+22], cl
     mov     cl, [eax+21]
     mov     [edx+21], cl
     mov     cl, [eax+20]
     mov     [edx+20], cl
     mov     ecx, [eax+16]
     mov     [edx+16], ecx
     movq    mm0, [eax+8]
     movq    mm1, [eax]
     movq    [edx+8], mm0
     movq    [edx],   mm1
     emms
     ret
@RewerseCaseCount24 :
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount25 :
     mov     cl, [eax+24]
     mov     [edx+24], cl
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount26 :
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+24]
     mov     [edx+24], cl
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount27 :
     mov     cl, [eax+26]
     mov     [edx+26], cl
     mov     cl, [eax+25]
     mov     [edx+25], cl
     mov     cl, [eax+24]
     mov     [edx+24], cl
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount28 :
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount29 :
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount30 :
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount31 :
     mov     cl, [eax+30]
     mov     [edx+30], cl
     mov     cl, [eax+29]
     mov     [edx+29], cl
     mov     cl, [eax+28]
     mov     [edx+28], cl
     mov     ecx, [eax+24]
     mov     [edx+24], ecx
     movq    mm0, [eax+16]
     movq    mm1, [eax+8]
     movq    mm2, [eax]
     movq    [edx+16], mm0
     movq    [edx+8],  mm1
     movq    [edx],    mm2
     emms
     ret
@RewerseCaseCount32 :
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount33 :
     mov     cl, [eax+32]
     mov     [edx+32], cl
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount34 :
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+32]
     mov     [edx+32], cl
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount35 :
     mov     cl, [eax+34]
     mov     [edx+34], cl
     mov     cl, [eax+33]
     mov     [edx+33], cl
     mov     cl, [eax+32]
     mov     [edx+32], cl
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount36 :
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount37 :
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8], mm2
     movq    [edx], mm3
     emms
     ret
@RewerseCaseCount38 :
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount39 :
     mov     cl, [eax+38]
     mov     [edx+38], cl
     mov     cl, [eax+37]
     mov     [edx+37], cl
     mov     cl, [eax+36]
     mov     [edx+36], cl
     mov     ecx, [eax+32]
     mov     [edx+32], ecx
     movq    mm0, [eax+24]
     movq    mm1, [eax+16]
     movq    mm2, [eax+8]
     movq    mm3, [eax]
     movq    [edx+24], mm0
     movq    [edx+16], mm1
     movq    [edx+8],  mm2
     movq    [edx],    mm3
     emms
     ret
@RewerseCaseCount40 :
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount41 :
     mov     cl, [eax+40]
     mov     [edx+40], cl
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount42 :
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+40]
     mov     [edx+40], cl
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount43 :
     mov     cl, [eax+42]
     mov     [edx+42], cl
     mov     cl, [eax+41]
     mov     [edx+41], cl
     mov     cl, [eax+40]
     mov     [edx+40], cl
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount44 :
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount45 :
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount46 :
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount47 :
     mov     cl, [eax+46]
     mov     [edx+46], cl
     mov     cl, [eax+45]
     mov     [edx+45], cl
     mov     cl, [eax+44]
     mov     [edx+44], cl
     mov     ecx, [eax+40]
     mov     [edx+40], ecx
     movq    mm0, [eax+32]
     movq    mm1, [eax+24]
     movq    mm2, [eax+16]
     movq    mm3, [eax+8]
     movq    mm4, [eax]
     movq    [edx+32], mm0
     movq    [edx+24], mm1
     movq    [edx+16], mm2
     movq    [edx+8],  mm3
     movq    [edx],    mm4
     emms
     ret
@RewerseCaseCount48 :
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount49 :
     mov     cl, [eax+48]
     mov     [edx+48], cl
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount50 :
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+48]
     mov     [edx+48], cl
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount51 :
     mov     cl, [eax+50]
     mov     [edx+50], cl
     mov     cl, [eax+49]
     mov     [edx+49], cl
     mov     cl, [eax+48]
     mov     [edx+48], cl
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount52 :
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount53 :
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount54 :
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount55 :
     mov     cl, [eax+54]
     mov     [edx+54], cl
     mov     cl, [eax+53]
     mov     [edx+53], cl
     mov     cl, [eax+52]
     mov     [edx+52], cl
     mov     ecx, [eax+48]
     mov     [edx+48], ecx
     movq    mm0, [eax+40]
     movq    mm1, [eax+32]
     movq    mm2, [eax+24]
     movq    mm3, [eax+16]
     movq    mm4, [eax+8]
     movq    mm5, [eax]
     movq    [edx+40], mm0
     movq    [edx+32], mm1
     movq    [edx+24], mm2
     movq    [edx+16], mm3
     movq    [edx+8],  mm4
     movq    [edx],    mm5
     emms
     ret
@RewerseCaseCount56 :
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount57 :
     mov     cl, [eax+56]
     mov     [edx+56], cl
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount58 :
     mov     cl, [eax+57]
     mov     [edx+57], cl
     mov     cl, [eax+56]
     mov     [edx+56], cl
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount59 :
     mov     cl, [eax+58]
     mov     [edx+58], cl
     mov     cl, [eax+57]
     mov     [edx+57], cl
     mov     cl, [eax+56]
     mov     [edx+56], cl
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount60 :
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount61 :
     mov     cl, [eax+60]
     mov     [edx+60], cl
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount62 :
     mov     cl, [eax+61]
     mov     [edx+61], cl
     mov     cl, [eax+60]
     mov     [edx+60], cl
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount63 :
     mov     cl, [eax+62]
     mov     [edx+62], cl
     mov     cl, [eax+61]
     mov     [edx+61], cl
     mov     cl, [eax+60]
     mov     [edx+60], cl
     mov     ecx, [eax+56]
     mov     [edx+56], ecx
     movq    mm0, [eax+48]
     movq    mm1, [eax+40]
     movq    mm2, [eax+32]
     movq    mm3, [eax+24]
     movq    mm4, [eax+16]
     movq    mm5, [eax+8]
     movq    mm6, [eax]
     movq    [edx+48], mm0
     movq    [edx+40], mm1
     movq    [edx+32], mm2
     movq    [edx+24], mm3
     movq    [edx+16], mm4
     movq    [edx+8],  mm5
     movq    [edx],    mm6
     emms
     ret
@RewerseCaseCount64 :
     movq    mm0, [eax+56]
     movq    mm1, [eax+48]
     movq    mm2, [eax+40]
     movq    mm3, [eax+32]
     movq    mm4, [eax+24]
     movq    mm5, [eax+16]
     movq    mm6, [eax+8]
     movq    mm7, [eax]
     movq    [edx+56], mm0
     movq    [edx+48], mm1
     movq    [edx+40], mm2
     movq    [edx+32], mm3
     movq    [edx+24], mm4
     movq    [edx+16], mm5
     movq    [edx+8],  mm6
     movq    [edx],    mm7
     emms
     ret
     nop
     nop
     nop
 @Case1Else:
     push    ebx
     push    edi
 @L15:
     sub     ecx, 1
     mov     bl, [eax+ecx]
     mov     [edx+ecx], bl
     mov     edi, edx               // ecx is destination pointer
     add     edi, ecx
     and     edi, $07
     test    edi, edi
     jnz     @L15                    // until((SrcAddress2 mod 16) = 0);
     sub     ecx, 16
     mov     ebx, ecx
 @L67:
     movq    mm0, [eax+ecx+8]
     movq    [edx+ecx+8], mm0
     movq    mm1, [eax+ecx]
     movq    [edx+ecx], mm1
     sub     ecx, 16
     jns     @L67
     emms
     add     ecx,16
     pop     edi
     pop     ebx
     jmp     dword ptr [ecx*4+@Case2JmpTable]
 @Exit:
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

@Case1JmpTable:
 dd @ForwardCaseCount0
 dd @ForwardCaseCount1
 dd @ForwardCaseCount2
 dd @ForwardCaseCount3
 dd @ForwardCaseCount4
 dd @ForwardCaseCount5
 dd @ForwardCaseCount6
 dd @ForwardCaseCount7
 dd @ForwardCaseCount8
 dd @ForwardCaseCount9
 dd @ForwardCaseCount10
 dd @ForwardCaseCount11
 dd @ForwardCaseCount12
 dd @ForwardCaseCount13
 dd @ForwardCaseCount14
 dd @ForwardCaseCount15
 dd @ForwardCaseCount16
 dd @ForwardCaseCount17
 dd @ForwardCaseCount18
 dd @ForwardCaseCount19
 dd @ForwardCaseCount20
 dd @ForwardCaseCount21
 dd @ForwardCaseCount22
 dd @ForwardCaseCount23
 dd @ForwardCaseCount24
 dd @ForwardCaseCount25
 dd @ForwardCaseCount26
 dd @ForwardCaseCount27
 dd @ForwardCaseCount28
 dd @ForwardCaseCount29
 dd @ForwardCaseCount30
 dd @ForwardCaseCount31
 dd @ForwardCaseCount32
 dd @ForwardCaseCount33
 dd @ForwardCaseCount34
 dd @ForwardCaseCount35
 dd @ForwardCaseCount36
 dd @ForwardCaseCount37
 dd @ForwardCaseCount38
 dd @ForwardCaseCount39
 dd @ForwardCaseCount40
 dd @ForwardCaseCount41
 dd @ForwardCaseCount42
 dd @ForwardCaseCount43
 dd @ForwardCaseCount44
 dd @ForwardCaseCount45
 dd @ForwardCaseCount46
 dd @ForwardCaseCount47
 dd @ForwardCaseCount48
 dd @ForwardCaseCount49
 dd @ForwardCaseCount50
 dd @ForwardCaseCount51
 dd @ForwardCaseCount52
 dd @ForwardCaseCount53
 dd @ForwardCaseCount54
 dd @ForwardCaseCount55

@Case2JmpTable:
 dd @RewerseCaseCount0
 dd @RewerseCaseCount1
 dd @RewerseCaseCount2
 dd @RewerseCaseCount3
 dd @RewerseCaseCount4
 dd @RewerseCaseCount5
 dd @RewerseCaseCount6
 dd @RewerseCaseCount7
 dd @RewerseCaseCount8
 dd @RewerseCaseCount9
 dd @RewerseCaseCount10
 dd @RewerseCaseCount11
 dd @RewerseCaseCount12
 dd @RewerseCaseCount13
 dd @RewerseCaseCount14
 dd @RewerseCaseCount15
 dd @RewerseCaseCount16
 dd @RewerseCaseCount17
 dd @RewerseCaseCount18
 dd @RewerseCaseCount19
 dd @RewerseCaseCount20
 dd @RewerseCaseCount21
 dd @RewerseCaseCount22
 dd @RewerseCaseCount23
 dd @RewerseCaseCount24
 dd @RewerseCaseCount25
 dd @RewerseCaseCount26
 dd @RewerseCaseCount27
 dd @RewerseCaseCount28
 dd @RewerseCaseCount29
 dd @RewerseCaseCount30
 dd @RewerseCaseCount31
 dd @RewerseCaseCount32
 dd @RewerseCaseCount33
 dd @RewerseCaseCount34
 dd @RewerseCaseCount35
 dd @RewerseCaseCount36
 dd @RewerseCaseCount37
 dd @RewerseCaseCount38
 dd @RewerseCaseCount39
 dd @RewerseCaseCount40
 dd @RewerseCaseCount41
 dd @RewerseCaseCount42
 dd @RewerseCaseCount43
 dd @RewerseCaseCount44
 dd @RewerseCaseCount45
 dd @RewerseCaseCount46
 dd @RewerseCaseCount47
 dd @RewerseCaseCount48
 dd @RewerseCaseCount49
 dd @RewerseCaseCount50
 dd @RewerseCaseCount51
 dd @RewerseCaseCount52
 dd @RewerseCaseCount53
 dd @RewerseCaseCount54
 dd @RewerseCaseCount55
 dd @RewerseCaseCount56
 dd @RewerseCaseCount57
 dd @RewerseCaseCount58
 dd @RewerseCaseCount59
 dd @RewerseCaseCount60
 dd @RewerseCaseCount61
 dd @RewerseCaseCount62
 dd @RewerseCaseCount63
 dd @RewerseCaseCount64
end;
{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX > EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Forwards_IA32_9;
asm                              
  push    edx
  fild    qword ptr [eax]
  lea     eax, [eax+ecx-8]
  lea     ecx, [ecx+edx-8]
  fild    qword ptr [eax]
  push    ecx
  neg     ecx
  and     edx, -8
  lea     ecx, [ecx+edx+8]
  pop     edx
@FwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  add     ecx, 8
  jl      @FwdLoop
  fistp   qword ptr [edx]
  pop     edx
  fistp   qword ptr [edx]
end; {Forwards_IA32}

{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX > EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Forwards_MMX_9;
const
  LARGESIZE = 1024;
asm                     
  cmp     ecx, LARGESIZE
  jge     @FwdLargeMove
  cmp     ecx, 72 {Size at which using MMX becomes worthwhile}
  jl      Forwards_IA32_9
  push    ebx
  mov     ebx, edx
  movq    mm0, [eax] {First 8 Bytes}
  {QWORD Align Writes}
  add     eax, ecx
  add     ecx, edx
  add     edx, 7
  and     edx, -8
  sub     ecx, edx
  add     edx, ecx
  {Now QWORD Aligned}
  sub     ecx, 32
  neg     ecx
  nop
  nop
@FwdLoopMMX:
  movq    mm1, [eax+ecx-32]
  movq    mm2, [eax+ecx-24]
  movq    mm3, [eax+ecx-16]
  movq    mm4, [eax+ecx- 8]
  movq    [edx+ecx-32], mm1
  movq    [edx+ecx-24], mm2
  movq    [edx+ecx-16], mm3
  movq    [edx+ecx- 8], mm4
  add     ecx, 32
  jle     @FwdLoopMMX
  movq    [ebx], mm0 {First 8 Bytes}
  emms
  pop     ebx
  neg     ecx
  add     ecx, 32
  jmp     SmallForwardMove_9
  nop
@FwdLargeMove:
  push    ebx
  mov     ebx, ecx
  test    edx, 15
  jz      @FwdAligned
  {16 byte Align Destination}
  mov     ecx, edx
  add     ecx, 15
  and     ecx, -16
  sub     ecx, edx
  add     eax, ecx
  add     edx, ecx
  sub     ebx, ecx
  {Destination now 16 Byte Aligned}
  call    SmallForwardMove_9
@FwdAligned:
  mov     ecx, ebx
  and     ecx, -16
  sub     ebx, ecx {EBX = Remainder}
  push    esi
  push    edi
  mov     esi, eax          {ESI = Source}
  mov     edi, edx          {EDI = Dest}
  mov     eax, ecx          {EAX = Count}
  and     eax, -64          {EAX = No of Bytes to Blocks Moves}
  and     ecx, $3F          {ECX = Remaining Bytes to Move (0..63)}
  add     esi, eax
  add     edi, eax
  shr     eax, 3            {EAX = No of QWORD's to Block Move}
  neg     eax
@MMXcopyloop:
  movq    mm0, [esi+eax*8   ]
  movq    mm1, [esi+eax*8+ 8]
  movq    mm2, [esi+eax*8+16]
  movq    mm3, [esi+eax*8+24]
  movq    mm4, [esi+eax*8+32]
  movq    mm5, [esi+eax*8+40]
  movq    mm6, [esi+eax*8+48]
  movq    mm7, [esi+eax*8+56]
  movq    [edi+eax*8   ], mm0
  movq    [edi+eax*8+ 8], mm1
  movq    [edi+eax*8+16], mm2
  movq    [edi+eax*8+24], mm3
  movq    [edi+eax*8+32], mm4
  movq    [edi+eax*8+40], mm5
  movq    [edi+eax*8+48], mm6
  movq    [edi+eax*8+56], mm7
  add     eax, 8
  jnz     @MMXcopyloop
  emms                   {Empty MMX State}
  add     ecx, ebx
  shr     ecx, 2
  rep     movsd
  mov     ecx, ebx
  and     ecx, 3
  rep     movsb
  pop     edi
  pop     esi
  pop     ebx
end; {Forwards_MMX}

{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX < EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Backwards_IA32_9;
asm
  sub     ecx, 8
  push    ecx
  fild    qword ptr [eax+ecx] {Last 8}
  fild    qword ptr [eax] {First 8}
  add     ecx, edx
  and     ecx, -8
  sub     ecx, edx
@BwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  sub     ecx, 8
  jg      @BwdLoop
  pop     ecx
  fistp   qword ptr [edx] {First 8}
  fistp   qword ptr [edx+ecx] {Last 8}
end; {Backwards_IA32}

{-------------------------------------------------------------------------}
{Move ECX Bytes from EAX to EDX, where EAX < EDX and ECX > 36 (SMALLMOVESIZE)}
procedure Backwards_MMX_9;
asm                                 
  cmp     ecx, 72 {Size at which using MMX becomes worthwhile}
  jl      Backwards_IA32_9
  push    ebx
  movq    mm0, [eax+ecx-8] {Get Last QWORD}
  {QWORD Align Writes}
  lea     ebx, [edx+ecx]
  and     ebx, 7
  sub     ecx, ebx
  add     ebx, ecx
  {Now QWORD Aligned}
  sub     ecx, 32
@BwdLoopMMX:                       
  movq    mm1, [eax+ecx   ]
  movq    mm2, [eax+ecx+ 8]
  movq    mm3, [eax+ecx+16]
  movq    mm4, [eax+ecx+24]
  movq    [edx+ecx+24], mm4
  movq    [edx+ecx+16], mm3
  movq    [edx+ecx+ 8], mm2
  movq    [edx+ecx   ], mm1
  sub     ecx, 32
  jge     @BwdLoopMMX
  movq    [edx+ebx-8],  mm0 {Last QWORD}
  emms
  add     ecx, 32
  pop     ebx
  jmp     SmallBackwardMove_9
end; {Backwards_MMX}



//Author:            John O'Harrow
//Date:
//Optimized for:     Blended
//Instructionset(s): MMX
//Original name:     MoveJOH_MMX_9

procedure MoveFastcodeBlended(const Source; var Dest; Count : Integer);
asm
  cmp     ecx, SMALLMOVESIZE
  ja      @Large {Count > SMALLMOVESIZE or Count < 0}
  cmp     eax, edx
  jbe     @SmallCheck
  add     eax, ecx
  add     edx, ecx
  jmp     SmallForwardMove_9
@SmallCheck:
  jne     SmallBackwardMove_9
  ret {For Compatibility with Delphi's move for Source = Dest}
@Large:
  jng     @Done {For Compatibility with Delphi's move for Count < 0}
  cmp     eax, edx
  ja      Forwards_MMX_9
  je      @Done {For Compatibility with Delphi's move for Source = Dest}
  sub     edx, ecx
  cmp     eax, edx
  lea     edx, [edx+ecx]
  jna     Forwards_MMX_9
  jmp     Backwards_MMX_9 {Source/Dest Overlap}
@Done:
end; {MoveJOH_MMX}


//Author:            John O'Harrow
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:     MoveJOH_RTL_1

procedure MoveFastcodeRTL(const Source; var Dest; Count : Integer);
asm  {Small (253 Byte) RTL Replacement Candidate}
  cmp     eax, edx
  je      @@Exit {Source = Dest}
  cmp     ecx, 32
  ja      @@LargeMove {Count > 32 or Count < 0}
  sub     ecx, 8
  jg      @@SmallMove
@@TinyMove: {0..8 Byte Move}
  jmp     dword ptr [@@JumpTable+32+ecx*4]
@@SmallMove: {9..32 Byte Move}
  fild    qword ptr [eax+ecx] {Load Last 8}
  fild    qword ptr [eax] {Load First 8}
  cmp     ecx, 8
  jle     @@Small16
  fild    qword ptr [eax+8] {Load Second 8}
  cmp     ecx, 16
  jle     @@Small24
  fild    qword ptr [eax+16] {Load Third 8}
  fistp   qword ptr [edx+16] {Save Third 8}
@@Small24:
  fistp   qword ptr [edx+8] {Save Second 8}
@@Small16:
  fistp   qword ptr [edx] {Save First 8}
  fistp   qword ptr [edx+ecx] {Save Last 8}
@@Exit:
  ret
  nop {4-Byte Align JumpTable}
  nop
@@JumpTable: {4-Byte Aligned}
  dd      @@Exit, @@M01, @@M02, @@M03, @@M04, @@M05, @@M06, @@M07, @@M08
@@LargeForwardMove: {4-Byte Aligned}
  push    edx
  fild    qword ptr [eax] {First 8}
  lea     eax, [eax+ecx-8]
  lea     ecx, [ecx+edx-8]
  fild    qword ptr [eax] {Last 8}
  push    ecx
  neg     ecx
  and     edx, -8 {8-Byte Align Writes}
  lea     ecx, [ecx+edx+8]
  pop     edx
@FwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  add     ecx, 8
  jl      @FwdLoop
  fistp   qword ptr [edx] {Last 8}
  pop     edx
  fistp   qword ptr [edx] {First 8}
  ret
@@LargeMove:
  jng     @@LargeDone {Count < 0}
  cmp     eax, edx
  ja      @@LargeForwardMove
  sub     edx, ecx
  cmp     eax, edx
  lea     edx, [edx+ecx]
  jna     @@LargeForwardMove
  sub     ecx, 8 {Backward Move}
  push    ecx
  fild    qword ptr [eax+ecx] {Last 8}
  fild    qword ptr [eax] {First 8}
  add     ecx, edx
  and     ecx, -8 {8-Byte Align Writes}
  sub     ecx, edx
@BwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  sub     ecx, 8
  jg      @BwdLoop
  pop     ecx
  fistp   qword ptr [edx] {First 8}
  fistp   qword ptr [edx+ecx] {Last 8}
@@LargeDone:
  ret
@@M01:
  movzx   ecx, [eax]
  mov     [edx], cl
  ret
@@M02:
  movzx   ecx, word ptr [eax]
  mov     [edx], cx
  ret
@@M03:
  mov     cx, [eax]
  mov     al, [eax+2]
  mov     [edx], cx
  mov     [edx+2], al
  ret
@@M04:
  mov     ecx, [eax]
  mov     [edx], ecx
  ret
@@M05:
  mov     ecx, [eax]
  mov     al, [eax+4]
  mov     [edx], ecx
  mov     [edx+4], al
  ret
@@M06:
  mov     ecx, [eax]
  mov     ax, [eax+4]
  mov     [edx], ecx
  mov     [edx+4], ax
  ret
@@M07:
  mov     ecx, [eax]
  mov     eax, [eax+3]
  mov     [edx], ecx
  mov     [edx+3], eax
  ret
@@M08:
  fild    qword ptr [eax]
  fistp   qword ptr [edx]
end; {MoveJOH_IA32}


//Author:
//Date:              25/5 2004
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:

procedure MoveFastcodePascal(const Source; var Dest; Count : Integer);
var
  S, D       : Cardinal;
  Temp, C, I : Integer;
  L          : PInteger;
begin
  S := Cardinal(@Source);
  D := Cardinal(@Dest);
  if S = D then
    Exit;
  if Count <= 4 then
    case Count of
      1 : PByte(@Dest)^ := PByte(S)^;
      2 : PWord(@Dest)^ := PWord(S)^;
      3 : if D > S then
            begin
              PByte(Integer(@Dest)+2)^ := PByte(S+2)^;
              PWord(@Dest)^ := PWord(S)^;
            end
          else
            begin
              PWord(@Dest)^ := PWord(S)^;
              PByte(Integer(@Dest)+2)^ := PByte(S+2)^;
            end;
      4 : PInteger(@Dest)^ := PInteger(S)^
      else Exit; {Count <= 0}
    end
  else
    if D > S then
      begin
        Temp := PInteger(S)^;
        I := Integer(@Dest);
        C := Count - 4;
        L := PInteger(Integer(@Dest) + C);
        Inc(S, C);
        repeat
          L^ := PInteger(S)^;
          if Count <= 8 then
            Break;
          Dec(Count, 4);
          Dec(S, 4);
          Dec(L);
        until False;
        PInteger(I)^ := Temp;
      end
    else
      begin
        C := Count - 4;
        Temp := PInteger(S + Cardinal(C))^;
        I := Integer(@Dest) + C;
        L := @Dest;
        repeat
          L^ := PInteger(S)^;
          if Count <= 8 then
            Break;
          Dec(Count, 4);
          Inc(S, 4);
          Inc(L);
        until False;
        PInteger(I)^ := Temp;
      end;
end; {MoveJOH_PAS}

initialization

  PrefetchLimit := (CPU.L2CacheSize div 16) * -1024; {Used within SSE Moves}
  if FastCodeTarget = ftP4P then
   FastMove := MoveFastcodeP4P
  else if FastCodeTarget = ftP4N then
   FastMove := MoveFastcodeP4N
  else if FastCodeTarget = ftPMD then
   FastMove := MoveFastcodePMD
  else if FastCodeTarget = ftPMB then
   FastMove := MoveFastcodePMB
  else if FastCodeTarget = ftAmd64 then
   FastMove := MoveFastcodeAMD64
  else if FastCodeTarget = ftAmdXp then
   FastMove := MoveFastcodeXP
  else
   begin
    if isMMX in CPU.InstructionSupport then
     FastMove := MoveFastcodeBlended
    else
     FastMove := MoveFastcodeRTL;
   end;

 end.


