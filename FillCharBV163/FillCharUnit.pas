unit FillCharUnit;

interface

{$IFDEF WIN32}
procedure FillChar_RTL_Pas_1(var Dest; count: Integer; Value: Char);
procedure FillCharCJGPAS1(var Dest; count: Integer; Value: Char);
procedure FillCharCJGPas3(var Dest; count: Integer; Value: Char);
procedure FillChar_CJG_Pas_5_a(var Dest; count: Integer; Value: Char);
procedure FillChar_CJG_Pas_5_b(var Dest; count: Integer; Value: Char);
procedure FillChar_CJG_Pas_5_c(var Dest; count: Integer; Value: Char);
procedure FillChar_CJG_Pas_5_d(var Dest; count: Integer; Value: Char);
procedure FillChar_PLR_IA32_3_a(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_IA32_3_b(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_IA32_3_c(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_IA32_3_d(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_IA32_4_a(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_IA32_4_b(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_IA32_4_c(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_IA32_4_d(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_MMX_1_a(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_MMX_1_b(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_MMX_1_c(var Dest; Count: Integer; Value: Char);
procedure FillChar_PLR_MMX_1_d(var Dest; Count: Integer; Value: Char);
{$ENDIF}

implementation

uses
 SysUtils;

{$IFDEF WIN32}
procedure FillChar_RTL_Pas_1(var Dest; count: Integer; Value: Char);
var
  I: Integer;
  P: PChar;
begin
  P := PChar(@Dest);
  for I := count-1 downto 0 do
    P[I] := Value;
end;

procedure FillCharCJGPAS1(var Dest; count: Integer; Value: Char);
var
  I, J : Integer;
  P    : Pointer;
  Q    : Pointer;
  Label P1, P2;
begin
  if Count > 0 then
    begin
      P := @Dest;
      if Count >= 4 then
        begin
          J := Byte(Value);
          J := J or (J shl  8);
          J := J or (J shl 16);
          If Count > 8 then
            begin
              I := Count shr 1;
              Q := PInteger(Integer(P) + I);
              I := I shr 2;
              repeat
                Dec(I);
                PIntegerArray(P)[I] := J;
                PIntegerArray(Q)[I] := J;
              until I = 0;
              PInteger(Integer(Q) - 4)^ := J;
              PInteger(Integer(P) + Count - 4)^ := J;
            end
          else
            begin
              PIntegerArray(P)[0] := J;
              PInteger(Integer(P) + Count - 4)^ := J;
            end
        end
      else
        begin
          case Count of
            1:  goto P1;
            2:  goto P2;
          end;
              PByteArray(P)[2] := Ord(Value);
          P2: PByteArray(P)[1] := Ord(Value);
          P1: PByteArray(P)[0] := Ord(Value);
        end;
    end;
end;

procedure FillCharPLRAsm1_a(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Less than a qword to fill?}
  cmp edx, 8
  jl @SmallFill
  {save ebx}
  mov [esp - 4], ebx
  {Point edx to the last qword}
  lea edx, [eax + edx - 8]
  {Duplicate character into all bytes of ecx}
  mov bx, cx
  bswap ecx
  mov cx, bx
  {Fill the first qword}
  mov [eax], ecx
  {dword align eax}
  add eax, 4
  and eax, $fffffffc
@FillLoop:
  cmp eax, edx
  jnb @DoneFill
  mov [eax], ecx
  mov [eax + 4], ecx
  add eax, 8
  jmp @FillLoop
@DoneFill:
  {Fill the last 8 bytes}
  mov [edx], ecx
  mov [edx + 4], ecx
  {Restore ebx}
  mov ebx, [esp - 4]
  {Done}
  ret
@SmallFill:
  {1 byte?}
  cmp dl, 1
  jl @Done
  mov [eax], cl
  {2 bytes?}
  cmp dl, 2
  sbb eax, -1
  mov [eax], cl
  {3 bytes?}
  cmp dl, 3
  sbb eax, -1
  mov [eax], cl
  {4 bytes?}
  cmp dl, 4
  sbb eax, -1
  mov [eax], cl
  {5 bytes?}
  cmp dl, 5
  sbb eax, -1
  mov [eax], cl
  {6 bytes}
  cmp dl, 6
  sbb eax, -1
  mov [eax], cl
  {7 bytes}
  cmp dl, 7
  sbb eax, -1
  mov [eax], cl
@Done:
end;

{80386+ instruction set. 179 bytes}
procedure FillChar_PLR_IA32_3_a(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 27
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  {Check for negative counts. Comment out the nop before the jump table
   if these two lines are uncommented (to keep the table dword aligned.)}
  cmp edx, 0
  jl @NoFill
  {Save ebx}
  push ebx
  {Extend "value" over all the bytes of ecx}
  mov ebx, ecx
  shl ecx, 16
  mov cx, bx
  {Store the first dword}
  mov [eax], ecx
  {dword align eax}
  mov ebx, eax
  neg ebx
  and ebx, 3
  add eax, ebx
  sub edx, ebx
  {Fill 24 bytes}
@Fill24Loop:
  {Subtract 24 from edx so long}
  sub edx, 24
  {Move 24 bytes}
  mov [eax], ecx
  mov [eax + 4], ecx
  mov [eax + 8], ecx
  mov [eax + 12], ecx
  mov [eax + 16], ecx
  mov [eax + 20], ecx
  add eax, 24
  cmp edx, 24
  jae @Fill24Loop
  {restore ebx}
  pop ebx
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
@NoFill:
  ret
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  //nop dword align the jump table
@JumpTable:
  dd @NoFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27
end;

{80386+ instruction set. 179 bytes}
procedure FillChar_PLR_IA32_3_b(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 27
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  {Check for negative counts. Comment out the nop before the jump table
   if these two lines are uncommented (to keep the table dword aligned.)}
  cmp edx, 0
  jl @NoFill
  {Save ebx}
  push ebx
  {Extend "value" over all the bytes of ecx}
  mov ebx, ecx
  shl ecx, 16
  mov cx, bx
  {Store the first dword}
  mov [eax], ecx
  {dword align eax}
  mov ebx, eax
  neg ebx
  and ebx, 3
  add eax, ebx
  sub edx, ebx
  {Fill 24 bytes}
@Fill24Loop:
  {Subtract 24 from edx so long}
  sub edx, 24
  {Move 24 bytes}
  mov [eax], ecx
  mov [eax + 4], ecx
  mov [eax + 8], ecx
  mov [eax + 12], ecx
  mov [eax + 16], ecx
  mov [eax + 20], ecx
  add eax, 24
  cmp edx, 24
  jae @Fill24Loop
  {restore ebx}
  pop ebx
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
@NoFill:
  ret
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  //nop dword align the jump table
@JumpTable:
  dd @NoFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27
end;

{80386+ instruction set. 179 bytes}
procedure FillChar_PLR_IA32_3_c(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 27
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  {Check for negative counts. Comment out the nop before the jump table
   if these two lines are uncommented (to keep the table dword aligned.)}
  cmp edx, 0
  jl @NoFill
  {Save ebx}
  push ebx
  {Extend "value" over all the bytes of ecx}
  mov ebx, ecx
  shl ecx, 16
  mov cx, bx
  {Store the first dword}
  mov [eax], ecx
  {dword align eax}
  mov ebx, eax
  neg ebx
  and ebx, 3
  add eax, ebx
  sub edx, ebx
  {Fill 24 bytes}
@Fill24Loop:
  {Subtract 24 from edx so long}
  sub edx, 24
  {Move 24 bytes}
  mov [eax], ecx
  mov [eax + 4], ecx
  mov [eax + 8], ecx
  mov [eax + 12], ecx
  mov [eax + 16], ecx
  mov [eax + 20], ecx
  add eax, 24
  cmp edx, 24
  jae @Fill24Loop
  {restore ebx}
  pop ebx
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
@NoFill:
  ret
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  //nop dword align the jump table
@JumpTable:
  dd @NoFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27
end;

{80386+ instruction set. 179 bytes}
procedure FillChar_PLR_IA32_3_d(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 27
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  {Check for negative counts. Comment out the nop before the jump table
   if these two lines are uncommented (to keep the table dword aligned.)}
  cmp edx, 0
  jl @NoFill
  {Save ebx}
  push ebx
  {Extend "value" over all the bytes of ecx}
  mov ebx, ecx
  shl ecx, 16
  mov cx, bx
  {Store the first dword}
  mov [eax], ecx
  {dword align eax}
  mov ebx, eax
  neg ebx
  and ebx, 3
  add eax, ebx
  sub edx, ebx
  {Fill 24 bytes}
@Fill24Loop:
  {Subtract 24 from edx so long}
  sub edx, 24
  {Move 24 bytes}
  mov [eax], ecx
  mov [eax + 4], ecx
  mov [eax + 8], ecx
  mov [eax + 12], ecx
  mov [eax + 16], ecx
  mov [eax + 20], ecx
  add eax, 24
  cmp edx, 24
  jae @Fill24Loop
  {restore ebx}
  pop ebx
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
@NoFill:
  ret
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  //nop dword align the jump table
@JumpTable:
  dd @NoFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27
end;

procedure FillCharCJGPas3(var Dest; count: Integer; Value: Char);
var
  I, J : Integer;
  P    : Pointer;
  Label P01, P02, P03, P04, P05, P06, P07, P08;
begin
  if Count > 0 then
    begin
      P := @Dest;
      if Count > 8 then
        begin
          J := Byte(Value);
          J := J or (J shl  8);
          J := J or (J shl 16);
          PInteger(P)^ := J;
          PInteger(Integer(P) + Count - 4)^ := J;
          If Count >= 9 then            // This is weird on AMD 1200 is faster with the surflious If statement.
            begin
              I := Count shr 2;
              repeat
                Dec(I,2);
                PIntegerArray(P)[I] := J;
                PIntegerArray(P)[I+1] := J;
              until I < 2;
            end
        end
      else
        begin
          case Count of
            1:  goto P01;
            2:  goto P02;
            3:  goto P03;
            4:  goto P04;
            5:  goto P05;
            6:  goto P06;
            7:  goto P07;
            8:  goto P08;
          end;
               PByteArray(P)[08] := Byte(Value); // Another weird one.Never used but makes it faster
          P08: PByteArray(P)[07] := Byte(Value);
          P07: PByteArray(P)[06] := Byte(Value);
          P06: PByteArray(P)[05] := Byte(Value);
          P05: PByteArray(P)[04] := Byte(Value);
          P04: PByteArray(P)[03] := Byte(Value);
          P03: PByteArray(P)[02] := Byte(Value);
          P02: PByteArray(P)[01] := Byte(Value);
          P01: PByteArray(P)[00] := Byte(Value);
        end;
    end;
end;

{80386+ instruction set. Size = 239 (code) + 4 * 36 (table) = 387}
procedure FillChar_PLR_IA32_4_a(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 35
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  cmp edx, 0
  jl @DoneFill
  {Store the first dword}
  mov [eax], cx
  mov [eax + 2], cx
  {Extend "value" over all the bytes of ecx}
  shl ecx, 16
  mov cx, [eax]
  {dword align eax}
  add edx, eax
  add eax, 4
  and eax, -4
  sub edx, eax
  {Fill 32 bytes}
@Fill32Loop:
  {Subtract 32 from edx so long}
  sub edx, 32
  {Fill 32 bytes}
  mov [eax], ecx
  mov [eax + 4], ecx
  mov [eax + 8], ecx
  mov [eax + 12], ecx
  mov [eax + 16], ecx
  mov [eax + 20], ecx
  mov [eax + 24], ecx
  mov [eax + 28], ecx
  add eax, 32
  cmp edx, 32
  jae @Fill32Loop
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@DoneFill:
  ret
@Fill34:
  mov [eax + 32], cx
@Fill32:
  mov [eax + 30], cx
@Fill30:
  mov [eax + 28], cx
@Fill28:
  mov [eax + 26], cx
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
  ret
@Fill35:
  mov [eax + 33], cx
@Fill33:
  mov [eax + 31], cx
@Fill31:
  mov [eax + 29], cx
@Fill29:
  mov [eax + 27], cx
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  nop //DWord align the jump table
@JumpTable:
  dd @DoneFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27, @Fill28, @Fill29, @Fill30, @Fill31, @Fill32, @Fill33
  dd @Fill34, @Fill35
end;

{80386+ instruction set. Size = 239 (code) + 4 * 36 (table) = 387}
procedure FillChar_PLR_IA32_4_b(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 35
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  cmp edx, 0
  jl @DoneFill
  {Store the first dword}
  mov [eax], cx
  mov [eax + 2], cx
  {Extend "value" over all the bytes of ecx}
  shl ecx, 16
  mov cx, [eax]
  {dword align eax}
  add edx, eax
  add eax, 4
  and eax, -4
  sub edx, eax
  {Fill 32 bytes}
@Fill32Loop:
  {Subtract 32 from edx so long}
  sub edx, 32
  {Fill 32 bytes}
  mov [eax], ecx
  mov [eax + 4], ecx
  mov [eax + 8], ecx
  mov [eax + 12], ecx
  mov [eax + 16], ecx
  mov [eax + 20], ecx
  mov [eax + 24], ecx
  mov [eax + 28], ecx
  add eax, 32
  cmp edx, 32
  jae @Fill32Loop
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@DoneFill:
  ret
@Fill34:
  mov [eax + 32], cx
@Fill32:
  mov [eax + 30], cx
@Fill30:
  mov [eax + 28], cx
@Fill28:
  mov [eax + 26], cx
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
  ret
@Fill35:
  mov [eax + 33], cx
@Fill33:
  mov [eax + 31], cx
@Fill31:
  mov [eax + 29], cx
@Fill29:
  mov [eax + 27], cx
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  nop //DWord align the jump table
@JumpTable:
  dd @DoneFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27, @Fill28, @Fill29, @Fill30, @Fill31, @Fill32, @Fill33
  dd @Fill34, @Fill35
end;

{80386+ instruction set. Size = 239 (code) + 4 * 36 (table) = 387}
procedure FillChar_PLR_IA32_4_c(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 35
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  cmp edx, 0
  jl @DoneFill
  {Store the first dword}
  mov [eax], cx
  mov [eax + 2], cx
  {Extend "value" over all the bytes of ecx}
  shl ecx, 16
  mov cx, [eax]
  {dword align eax}
  add edx, eax
  add eax, 4
  and eax, -4
  sub edx, eax
  {Fill 32 bytes}
@Fill32Loop:
  {Subtract 32 from edx so long}
  sub edx, 32
  {Fill 32 bytes}
  mov [eax], ecx
  mov [eax + 4], ecx
  mov [eax + 8], ecx
  mov [eax + 12], ecx
  mov [eax + 16], ecx
  mov [eax + 20], ecx
  mov [eax + 24], ecx
  mov [eax + 28], ecx
  add eax, 32
  cmp edx, 32
  jae @Fill32Loop
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@DoneFill:
  ret
@Fill34:
  mov [eax + 32], cx
@Fill32:
  mov [eax + 30], cx
@Fill30:
  mov [eax + 28], cx
@Fill28:
  mov [eax + 26], cx
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
  ret
@Fill35:
  mov [eax + 33], cx
@Fill33:
  mov [eax + 31], cx
@Fill31:
  mov [eax + 29], cx
@Fill29:
  mov [eax + 27], cx
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  nop //DWord align the jump table
@JumpTable:
  dd @DoneFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27, @Fill28, @Fill29, @Fill30, @Fill31, @Fill32, @Fill33
  dd @Fill34, @Fill35
end;

{80386+ instruction set. Size = 239 (code) + 4 * 36 (table) = 387}
procedure FillChar_PLR_IA32_4_d(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 35
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  cmp edx, 0
  jl @DoneFill
  {Store the first dword}
  mov [eax], cx
  mov [eax + 2], cx
  {Extend "value" over all the bytes of ecx}
  shl ecx, 16
  mov cx, [eax]
  {dword align eax}
  add edx, eax
  add eax, 4
  and eax, -4
  sub edx, eax
  {Fill 32 bytes}
@Fill32Loop:
  {Subtract 32 from edx so long}
  sub edx, 32
  {Fill 32 bytes}
  mov [eax], ecx
  mov [eax + 4], ecx
  mov [eax + 8], ecx
  mov [eax + 12], ecx
  mov [eax + 16], ecx
  mov [eax + 20], ecx
  mov [eax + 24], ecx
  mov [eax + 28], ecx
  add eax, 32
  cmp edx, 32
  jae @Fill32Loop
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@DoneFill:
  ret
@Fill34:
  mov [eax + 32], cx
@Fill32:
  mov [eax + 30], cx
@Fill30:
  mov [eax + 28], cx
@Fill28:
  mov [eax + 26], cx
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
  ret
@Fill35:
  mov [eax + 33], cx
@Fill33:
  mov [eax + 31], cx
@Fill31:
  mov [eax + 29], cx
@Fill29:
  mov [eax + 27], cx
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  nop //DWord align the jump table
@JumpTable:
  dd @DoneFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27, @Fill28, @Fill29, @Fill30, @Fill31, @Fill32, @Fill33
  dd @Fill34, @Fill35
end;

{MMX instruction set. Size = 240 + 4 * 40 = 400}
procedure FillChar_PLR_MMX_1_a(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 39
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  cmp edx, 0
  jl @DoneFill
  {Get the values in mm0}
  movd mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  {Store the first qword}
  movq [eax], mm0
  {qword align eax}
  add edx, eax
  add eax, 8
  and eax, -8
  sub edx, eax
  {Fill 32 bytes}
@Fill32Loop:
  {Subtract 32 from edx so long}
  sub edx, 32
  {Fill 32 bytes}
  movq [eax], mm0
  movq [eax + 8], mm0
  movq [eax + 16], mm0
  movq [eax + 24], mm0
  add eax, 32
  cmp edx, 32
  jae @Fill32Loop
  {Exit mmx state}
  emms
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@DoneFill:
  ret
  nop
  nop
  nop //align branch targets
@Fill38:
  mov [eax + 36], cx
@Fill36:
  mov [eax + 34], cx
@Fill34:
  mov [eax + 32], cx
@Fill32:
  mov [eax + 30], cx
@Fill30:
  mov [eax + 28], cx
@Fill28:
  mov [eax + 26], cx
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
  ret
@Fill39:
  mov [eax + 37], cx
@Fill37:
  mov [eax + 35], cx
@Fill35:
  mov [eax + 33], cx
@Fill33:
  mov [eax + 31], cx
@Fill31:
  mov [eax + 29], cx
@Fill29:
  mov [eax + 27], cx
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  nop //dword align jump table
@JumpTable:
  dd @DoneFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27, @Fill28, @Fill29, @Fill30, @Fill31, @Fill32, @Fill33
  dd @Fill34, @Fill35, @Fill36, @Fill37, @Fill38, @Fill39
end;

procedure Filler1;
asm
 nop
end;

{MMX instruction set. Size = 240 + 4 * 40 = 400}
procedure FillChar_PLR_MMX_1_b(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 39
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  cmp edx, 0
  jl @DoneFill
  {Get the values in mm0}
  movd mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  {Store the first qword}
  movq [eax], mm0
  {qword align eax}
  add edx, eax
  add eax, 8
  and eax, -8
  sub edx, eax
  {Fill 32 bytes}
@Fill32Loop:
  {Subtract 32 from edx so long}
  sub edx, 32
  {Fill 32 bytes}
  movq [eax], mm0
  movq [eax + 8], mm0
  movq [eax + 16], mm0
  movq [eax + 24], mm0
  add eax, 32
  cmp edx, 32
  jae @Fill32Loop
  {Exit mmx state}
  emms
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@DoneFill:
  ret
  nop
  nop
  nop //align branch targets
@Fill38:
  mov [eax + 36], cx
@Fill36:
  mov [eax + 34], cx
@Fill34:
  mov [eax + 32], cx
@Fill32:
  mov [eax + 30], cx
@Fill30:
  mov [eax + 28], cx
@Fill28:
  mov [eax + 26], cx
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
  ret
@Fill39:
  mov [eax + 37], cx
@Fill37:
  mov [eax + 35], cx
@Fill35:
  mov [eax + 33], cx
@Fill33:
  mov [eax + 31], cx
@Fill31:
  mov [eax + 29], cx
@Fill29:
  mov [eax + 27], cx
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  nop //dword align jump table
@JumpTable:
  dd @DoneFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27, @Fill28, @Fill29, @Fill30, @Fill31, @Fill32, @Fill33
  dd @Fill34, @Fill35, @Fill36, @Fill37, @Fill38, @Fill39
end;

procedure Filler2;
asm
 nop
end;

{MMX instruction set. Size = 240 + 4 * 40 = 400}
procedure FillChar_PLR_MMX_1_c(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 39
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  cmp edx, 0
  jl @DoneFill
  {Get the values in mm0}
  movd mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  {Store the first qword}
  movq [eax], mm0
  {qword align eax}
  add edx, eax
  add eax, 8
  and eax, -8
  sub edx, eax
  {Fill 32 bytes}
@Fill32Loop:
  {Subtract 32 from edx so long}
  sub edx, 32
  {Fill 32 bytes}
  movq [eax], mm0
  movq [eax + 8], mm0
  movq [eax + 16], mm0
  movq [eax + 24], mm0
  add eax, 32
  cmp edx, 32
  jae @Fill32Loop
  {Exit mmx state}
  emms
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@DoneFill:
  ret
  nop
  nop
  nop //align branch targets
@Fill38:
  mov [eax + 36], cx
@Fill36:
  mov [eax + 34], cx
@Fill34:
  mov [eax + 32], cx
@Fill32:
  mov [eax + 30], cx
@Fill30:
  mov [eax + 28], cx
@Fill28:
  mov [eax + 26], cx
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
  ret
@Fill39:
  mov [eax + 37], cx
@Fill37:
  mov [eax + 35], cx
@Fill35:
  mov [eax + 33], cx
@Fill33:
  mov [eax + 31], cx
@Fill31:
  mov [eax + 29], cx
@Fill29:
  mov [eax + 27], cx
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  nop //dword align jump table
@JumpTable:
  dd @DoneFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27, @Fill28, @Fill29, @Fill30, @Fill31, @Fill32, @Fill33
  dd @Fill34, @Fill35, @Fill36, @Fill37, @Fill38, @Fill39
end;

procedure Filler3;
asm
 nop
end;

{MMX instruction set. Size = 240 + 4 * 40 = 400}
procedure FillChar_PLR_MMX_1_d(var Dest; Count: Integer; Value: Char);
asm
  {Copy the fill character into ch}
  mov ch, cl
  {Big or small fill?}
  cmp edx, 39
  ja @BigFill
  {Jump to the correct handler}
  jmp [edx * 4 + @JumpTable]
@BigFill:
  cmp edx, 0
  jl @DoneFill
  {Get the values in mm0}
  movd mm0, ecx
  punpcklwd mm0, mm0
  punpckldq mm0, mm0
  {Store the first qword}
  movq [eax], mm0
  {qword align eax}
  add edx, eax
  add eax, 8
  and eax, -8
  sub edx, eax
  {Fill 32 bytes}
@Fill32Loop:
  {Subtract 32 from edx so long}
  sub edx, 32
  {Fill 32 bytes}
  movq [eax], mm0
  movq [eax + 8], mm0
  movq [eax + 16], mm0
  movq [eax + 24], mm0
  add eax, 32
  cmp edx, 32
  jae @Fill32Loop
  {Exit mmx state}
  emms
  {Do the rest of the bytes}
  jmp [edx * 4 + @JumpTable]
@DoneFill:
  ret
  nop
  nop
  nop //align branch targets
@Fill38:
  mov [eax + 36], cx
@Fill36:
  mov [eax + 34], cx
@Fill34:
  mov [eax + 32], cx
@Fill32:
  mov [eax + 30], cx
@Fill30:
  mov [eax + 28], cx
@Fill28:
  mov [eax + 26], cx
@Fill26:
  mov [eax + 24], cx
@Fill24:
  mov [eax + 22], cx
@Fill22:
  mov [eax + 20], cx
@Fill20:
  mov [eax + 18], cx
@Fill18:
  mov [eax + 16], cx
@Fill16:
  mov [eax + 14], cx
@Fill14:
  mov [eax + 12], cx
@Fill12:
  mov [eax + 10], cx
@Fill10:
  mov [eax + 8], cx
@Fill8:
  mov [eax + 6], cx
@Fill6:
  mov [eax + 4], cx
@Fill4:
  mov [eax + 2], cx
@Fill2:
  mov [eax], cx
  ret
@Fill39:
  mov [eax + 37], cx
@Fill37:
  mov [eax + 35], cx
@Fill35:
  mov [eax + 33], cx
@Fill33:
  mov [eax + 31], cx
@Fill31:
  mov [eax + 29], cx
@Fill29:
  mov [eax + 27], cx
@Fill27:
  mov [eax + 25], cx
@Fill25:
  mov [eax + 23], cx
@Fill23:
  mov [eax + 21], cx
@Fill21:
  mov [eax + 19], cx
@Fill19:
  mov [eax + 17], cx
@Fill17:
  mov [eax + 15], cx
@Fill15:
  mov [eax + 13], cx
@Fill13:
  mov [eax + 11], cx
@Fill11:
  mov [eax + 9], cx
@Fill9:
  mov [eax + 7], cx
@Fill7:
  mov [eax + 5], cx
@Fill5:
  mov [eax + 3], cx
@Fill3:
  mov [eax + 1], cx
@Fill1:
  mov [eax], cl
  ret
  nop //dword align jump table
@JumpTable:
  dd @DoneFill
  dd @Fill1, @Fill2, @Fill3, @Fill4, @Fill5, @Fill6, @Fill7, @Fill8, @Fill9
  dd @Fill10, @Fill11, @Fill12, @Fill13, @Fill14, @Fill15, @Fill16, @Fill17
  dd @Fill18, @Fill19, @Fill20, @Fill21, @Fill22, @Fill23, @Fill24, @Fill25
  dd @Fill26, @Fill27, @Fill28, @Fill29, @Fill30, @Fill31, @Fill32, @Fill33
  dd @Fill34, @Fill35, @Fill36, @Fill37, @Fill38, @Fill39
end;

procedure FillChar_CJG_Pas_5_a(var Dest; count: Integer; Value: Char);
var
  I, J, K : Integer;
  P    : Pointer;
  Label P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12;
begin
  if Count > 0 then
    begin
      P := @Dest;
      If Count >= 12 then
        begin
          J := Byte(Value);
          J := J or (J shl  8);
          J := J or (J shl 16);

          PInteger(P)^ := J;
          PInteger(Integer(P) + Count - 4)^ := J;

          I := Count shr 2;

          if Count >= 256 then
            begin
              if count < 448 then
                begin
                  PIntegerArray(P)[1] := J;
                  PIntegerArray(P)[2] := J;
                  PIntegerArray(P)[3] := J;

                  repeat
                    Dec(I,4);
                    PIntegerArray(P)[I]   := J;
                    PIntegerArray(P)[I+1] := J;
                    PIntegerArray(P)[I+2] := J;
                    PIntegerArray(P)[I+3] := J;
                  until I < 4;
                end
              else
                begin
                  I := Count;
                  K := (Integer(P) and 3) - 4;
                  Dec(I, 16);
                  Dec(PByte(P), K);
                  Inc(I, K);
                  Inc(PByte(P), I);
                  PintegerArray(P)[0] := J;
                  PintegerArray(P)[1] := J;
                  PintegerArray(P)[2] := J;
                  PintegerArray(P)[3] := J;
                  repeat
                    PintegerArray(Integer(P)-I)[0] := J;
                    PintegerArray(Integer(P)-I)[1] := J;
                    PintegerArray(Integer(P)-I)[2] := J;
                    PintegerArray(Integer(P)-I)[3] := J;
                    Dec(I, 16);
                  until I <= 0;
                end
             end
          else
            begin
              repeat
                Dec(I,2);
                PIntegerArray(P)[I] := J;
                PIntegerArray(P)[I+1] := J;
              until I < 2;
            end
        end
      else
        begin
          case Count of
            1:  goto P01;
            2:  goto P02;
            3:  goto P03;
            4:  goto P04;
            5:  goto P05;
            6:  goto P06;
            7:  goto P07;
            8:  goto P08;
            9:  goto P09;
            10: goto P10;
            11: goto P11;
            12: goto P12;
          end;
          P12: PByteArray(P)[11] := Byte(Value);
          P11: PByteArray(P)[10] := Byte(Value);
          P10: PByteArray(P)[09] := Byte(Value);
          P09: PByteArray(P)[08] := Byte(Value);
          P08: PByteArray(P)[07] := Byte(Value);
          P07: PByteArray(P)[06] := Byte(Value);
          P06: PByteArray(P)[05] := Byte(Value);
          P05: PByteArray(P)[04] := Byte(Value);
          P04: PByteArray(P)[03] := Byte(Value);
          P03: PByteArray(P)[02] := Byte(Value);
          P02: PByteArray(P)[01] := Byte(Value);
          P01: PByteArray(P)[00] := Byte(Value);

        end
    end;
end;

procedure Filler4;
asm
 nop
end;


procedure FillChar_CJG_Pas_5_b(var Dest; count: Integer; Value: Char);
var
  I, J, K : Integer;
  P    : Pointer;
  Label P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12;
begin
  if Count > 0 then
    begin
      P := @Dest;
      If Count >= 12 then
        begin
          J := Byte(Value);
          J := J or (J shl  8);
          J := J or (J shl 16);

          PInteger(P)^ := J;
          PInteger(Integer(P) + Count - 4)^ := J;

          I := Count shr 2;

          if Count >= 256 then
            begin
              if count < 448 then
                begin
                  PIntegerArray(P)[1] := J;
                  PIntegerArray(P)[2] := J;
                  PIntegerArray(P)[3] := J;

                  repeat
                    Dec(I,4);
                    PIntegerArray(P)[I]   := J;
                    PIntegerArray(P)[I+1] := J;
                    PIntegerArray(P)[I+2] := J;
                    PIntegerArray(P)[I+3] := J;
                  until I < 4;
                end
              else
                begin
                  I := Count;
                  K := (Integer(P) and 3) - 4;
                  Dec(I, 16);
                  Dec(PByte(P), K);
                  Inc(I, K);
                  Inc(PByte(P), I);
                  PintegerArray(P)[0] := J;
                  PintegerArray(P)[1] := J;
                  PintegerArray(P)[2] := J;
                  PintegerArray(P)[3] := J;
                  repeat
                    PintegerArray(Integer(P)-I)[0] := J;
                    PintegerArray(Integer(P)-I)[1] := J;
                    PintegerArray(Integer(P)-I)[2] := J;
                    PintegerArray(Integer(P)-I)[3] := J;
                    Dec(I, 16);
                  until I <= 0;
                end
             end
          else
            begin
              repeat
                Dec(I,2);
                PIntegerArray(P)[I] := J;
                PIntegerArray(P)[I+1] := J;
              until I < 2;
            end
        end
      else
        begin
          case Count of
            1:  goto P01;
            2:  goto P02;
            3:  goto P03;
            4:  goto P04;
            5:  goto P05;
            6:  goto P06;
            7:  goto P07;
            8:  goto P08;
            9:  goto P09;
            10: goto P10;
            11: goto P11;
            12: goto P12;
          end;
          P12: PByteArray(P)[11] := Byte(Value);
          P11: PByteArray(P)[10] := Byte(Value);
          P10: PByteArray(P)[09] := Byte(Value);
          P09: PByteArray(P)[08] := Byte(Value);
          P08: PByteArray(P)[07] := Byte(Value);
          P07: PByteArray(P)[06] := Byte(Value);
          P06: PByteArray(P)[05] := Byte(Value);
          P05: PByteArray(P)[04] := Byte(Value);
          P04: PByteArray(P)[03] := Byte(Value);
          P03: PByteArray(P)[02] := Byte(Value);
          P02: PByteArray(P)[01] := Byte(Value);
          P01: PByteArray(P)[00] := Byte(Value);

        end
    end;
end;

procedure Filler5;
asm
 nop
end;

procedure FillChar_CJG_Pas_5_c(var Dest; count: Integer; Value: Char);
var
  I, J, K : Integer;
  P    : Pointer;
  Label P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12;
begin
  if Count > 0 then
    begin
      P := @Dest;
      If Count >= 12 then
        begin
          J := Byte(Value);
          J := J or (J shl  8);
          J := J or (J shl 16);

          PInteger(P)^ := J;
          PInteger(Integer(P) + Count - 4)^ := J;

          I := Count shr 2;

          if Count >= 256 then
            begin
              if count < 448 then
                begin
                  PIntegerArray(P)[1] := J;
                  PIntegerArray(P)[2] := J;
                  PIntegerArray(P)[3] := J;

                  repeat
                    Dec(I,4);
                    PIntegerArray(P)[I]   := J;
                    PIntegerArray(P)[I+1] := J;
                    PIntegerArray(P)[I+2] := J;
                    PIntegerArray(P)[I+3] := J;
                  until I < 4;
                end
              else
                begin
                  I := Count;
                  K := (Integer(P) and 3) - 4;
                  Dec(I, 16);
                  Dec(PByte(P), K);
                  Inc(I, K);
                  Inc(PByte(P), I);
                  PintegerArray(P)[0] := J;
                  PintegerArray(P)[1] := J;
                  PintegerArray(P)[2] := J;
                  PintegerArray(P)[3] := J;
                  repeat
                    PintegerArray(Integer(P)-I)[0] := J;
                    PintegerArray(Integer(P)-I)[1] := J;
                    PintegerArray(Integer(P)-I)[2] := J;
                    PintegerArray(Integer(P)-I)[3] := J;
                    Dec(I, 16);
                  until I <= 0;
                end
             end
          else
            begin
              repeat
                Dec(I,2);
                PIntegerArray(P)[I] := J;
                PIntegerArray(P)[I+1] := J;
              until I < 2;
            end
        end
      else
        begin
          case Count of
            1:  goto P01;
            2:  goto P02;
            3:  goto P03;
            4:  goto P04;
            5:  goto P05;
            6:  goto P06;
            7:  goto P07;
            8:  goto P08;
            9:  goto P09;
            10: goto P10;
            11: goto P11;
            12: goto P12;
          end;
          P12: PByteArray(P)[11] := Byte(Value);
          P11: PByteArray(P)[10] := Byte(Value);
          P10: PByteArray(P)[09] := Byte(Value);
          P09: PByteArray(P)[08] := Byte(Value);
          P08: PByteArray(P)[07] := Byte(Value);
          P07: PByteArray(P)[06] := Byte(Value);
          P06: PByteArray(P)[05] := Byte(Value);
          P05: PByteArray(P)[04] := Byte(Value);
          P04: PByteArray(P)[03] := Byte(Value);
          P03: PByteArray(P)[02] := Byte(Value);
          P02: PByteArray(P)[01] := Byte(Value);
          P01: PByteArray(P)[00] := Byte(Value);

        end
    end;
end;

procedure Filler6;
asm
 nop
end;


procedure FillChar_CJG_Pas_5_d(var Dest; count: Integer; Value: Char);
var
  I, J, K : Integer;
  P    : Pointer;
  Label P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12;
begin
  if Count > 0 then
    begin
      P := @Dest;
      If Count >= 12 then
        begin
          J := Byte(Value);
          J := J or (J shl  8);
          J := J or (J shl 16);

          PInteger(P)^ := J;
          PInteger(Integer(P) + Count - 4)^ := J;

          I := Count shr 2;

          if Count >= 256 then
            begin
              if count < 448 then
                begin
                  PIntegerArray(P)[1] := J;
                  PIntegerArray(P)[2] := J;
                  PIntegerArray(P)[3] := J;

                  repeat
                    Dec(I,4);
                    PIntegerArray(P)[I]   := J;
                    PIntegerArray(P)[I+1] := J;
                    PIntegerArray(P)[I+2] := J;
                    PIntegerArray(P)[I+3] := J;
                  until I < 4;
                end
              else
                begin
                  I := Count;
                  K := (Integer(P) and 3) - 4;
                  Dec(I, 16);
                  Dec(PByte(P), K);
                  Inc(I, K);
                  Inc(PByte(P), I);
                  PintegerArray(P)[0] := J;
                  PintegerArray(P)[1] := J;
                  PintegerArray(P)[2] := J;
                  PintegerArray(P)[3] := J;
                  repeat
                    PintegerArray(Integer(P)-I)[0] := J;
                    PintegerArray(Integer(P)-I)[1] := J;
                    PintegerArray(Integer(P)-I)[2] := J;
                    PintegerArray(Integer(P)-I)[3] := J;
                    Dec(I, 16);
                  until I <= 0;
                end
             end
          else
            begin
              repeat
                Dec(I,2);
                PIntegerArray(P)[I] := J;
                PIntegerArray(P)[I+1] := J;
              until I < 2;
            end
        end
      else
        begin
          case Count of
            1:  goto P01;
            2:  goto P02;
            3:  goto P03;
            4:  goto P04;
            5:  goto P05;
            6:  goto P06;
            7:  goto P07;
            8:  goto P08;
            9:  goto P09;
            10: goto P10;
            11: goto P11;
            12: goto P12;
          end;
          P12: PByteArray(P)[11] := Byte(Value);
          P11: PByteArray(P)[10] := Byte(Value);
          P10: PByteArray(P)[09] := Byte(Value);
          P09: PByteArray(P)[08] := Byte(Value);
          P08: PByteArray(P)[07] := Byte(Value);
          P07: PByteArray(P)[06] := Byte(Value);
          P06: PByteArray(P)[05] := Byte(Value);
          P05: PByteArray(P)[04] := Byte(Value);
          P04: PByteArray(P)[03] := Byte(Value);
          P03: PByteArray(P)[02] := Byte(Value);
          P02: PByteArray(P)[01] := Byte(Value);
          P01: PByteArray(P)[00] := Byte(Value);

        end
    end;
end;

initialization
 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;
{$ENDIF}

end.
