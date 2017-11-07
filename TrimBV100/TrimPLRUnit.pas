unit TrimPLRUnit;

interface

implementation

uses
 MainUnit;

//Author:            Pierre le Riche
//Date:              10/2 2007
//Instructionset(s): IA32

function Trim_PLR_IA32_1_a(const S: string): string;
asm
  {On entry:
   eax = @S[1]
   edx = @Result}
  {Blank input?}
  test eax, eax
  {Set eax = @Result, edx = @S[1]}
  xchg eax, edx
  {Blank input?}
  jz System.@LStrClr
  {Get the string length}
  mov ecx, [edx - 4]
  {Are there leading blank characters?}
  cmp byte ptr [edx], 32
  jbe @DropLeadingChar
  {Are there trailing blank characters?}
  cmp byte ptr [edx + ecx - 1], 32
  ja System.@LStrLAsg
  {Drop trailing blank characters}
@DropTrailingChar:
  sub ecx, 1
  jle System.@LStrClr
@CheckTrailingChars:
  cmp byte ptr [edx + ecx - 1], 32
  jbe @DropTrailingChar
  {Set the result string}
  jmp System.@LStrFromPCharLen
@DropLeadingChar:
  add edx, 1
  sub ecx, 1
  jle System.@LStrClr
  cmp byte ptr [edx], 32
  jbe @DropLeadingChar
  jmp @CheckTrailingChars
end;

function Trim_PLR_IA32_1_b(const S: string): string;
asm
  {On entry:
   eax = @S[1]
   edx = @Result}
  {Blank input?}
  test eax, eax
  {Set eax = @Result, edx = @S[1]}
  xchg eax, edx
  {Blank input?}
  jz System.@LStrClr
  {Get the string length}
  mov ecx, [edx - 4]
  {Are there leading blank characters?}
  cmp byte ptr [edx], 32
  jbe @DropLeadingChar
  {Are there trailing blank characters?}
  cmp byte ptr [edx + ecx - 1], 32
  ja System.@LStrLAsg
  {Drop trailing blank characters}
@DropTrailingChar:
  sub ecx, 1
  jle System.@LStrClr
@CheckTrailingChars:
  cmp byte ptr [edx + ecx - 1], 32
  jbe @DropTrailingChar
  {Set the result string}
  jmp System.@LStrFromPCharLen
@DropLeadingChar:
  add edx, 1
  sub ecx, 1
  jle System.@LStrClr
  cmp byte ptr [edx], 32
  jbe @DropLeadingChar
  jmp @CheckTrailingChars
end;

procedure Filler1;
asm
 nop
end;

function Trim_PLR_IA32_1_c(const S: string): string;
asm
  {On entry:
   eax = @S[1]
   edx = @Result}
  {Blank input?}
  test eax, eax
  {Set eax = @Result, edx = @S[1]}
  xchg eax, edx
  {Blank input?}
  jz System.@LStrClr
  {Get the string length}
  mov ecx, [edx - 4]
  {Are there leading blank characters?}
  cmp byte ptr [edx], 32
  jbe @DropLeadingChar
  {Are there trailing blank characters?}
  cmp byte ptr [edx + ecx - 1], 32
  ja System.@LStrLAsg
  {Drop trailing blank characters}
@DropTrailingChar:
  sub ecx, 1
  jle System.@LStrClr
@CheckTrailingChars:
  cmp byte ptr [edx + ecx - 1], 32
  jbe @DropTrailingChar
  {Set the result string}
  jmp System.@LStrFromPCharLen
@DropLeadingChar:
  add edx, 1
  sub ecx, 1
  jle System.@LStrClr
  cmp byte ptr [edx], 32
  jbe @DropLeadingChar
  jmp @CheckTrailingChars
end;

function Trim_PLR_IA32_1_d(const S: string): string;
asm
  {On entry:
   eax = @S[1]
   edx = @Result}
  {Blank input?}
  test eax, eax
  {Set eax = @Result, edx = @S[1]}
  xchg eax, edx
  {Blank input?}
  jz System.@LStrClr
  {Get the string length}
  mov ecx, [edx - 4]
  {Are there leading blank characters?}
  cmp byte ptr [edx], 32
  jbe @DropLeadingChar
  {Are there trailing blank characters?}
  cmp byte ptr [edx + ecx - 1], 32
  ja System.@LStrLAsg
  {Drop trailing blank characters}
@DropTrailingChar:
  sub ecx, 1
  jle System.@LStrClr
@CheckTrailingChars:
  cmp byte ptr [edx + ecx - 1], 32
  jbe @DropTrailingChar
  {Set the result string}
  jmp System.@LStrFromPCharLen
@DropLeadingChar:
  add edx, 1
  sub ecx, 1
  jle System.@LStrClr
  cmp byte ptr [edx], 32
  jbe @DropLeadingChar
  jmp @CheckTrailingChars
end;

initialization

 Filler1;
 MainForm.RegisterFunction('Trim_PLR_IA32_1_a', @Trim_PLR_IA32_1_a);
 MainForm.RegisterFunction('Trim_PLR_IA32_1_b', @Trim_PLR_IA32_1_b);
 MainForm.RegisterFunction('Trim_PLR_IA32_1_c', @Trim_PLR_IA32_1_c);
 MainForm.RegisterFunction('Trim_PLR_IA32_1_d', @Trim_PLR_IA32_1_d);

end.
