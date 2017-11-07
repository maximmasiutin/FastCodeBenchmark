unit StrLenLBGUnit;

interface

function StrLen_LBG_PAS_1_a(const Str:PChar):Cardinal;
function StrLen_LBG_PAS_1_b(const Str:PChar):Cardinal;
function StrLen_LBG_PAS_1_c(const Str:PChar):Cardinal;
function StrLen_LBG_PAS_1_d(const Str:PChar):Cardinal;
function StrLen_LBG_IA32_1_a(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_1_b(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_1_c(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_1_d(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_2_a(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_2_b(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_2_c(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_2_d(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_3_a(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_3_b(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_3_c(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_3_d(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_4_a(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_4_b(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_4_c(const Str: PChar): Cardinal;
function StrLen_LBG_IA32_4_d(const Str: PChar): Cardinal;

implementation

function StrLen_LBG_PAS_1_a(const Str:PChar):Cardinal;
begin
  Result:=0;
  while Str[Result]<>#0 do Inc(Result)
end;

procedure Filler1;
asm
 nop
end;

function StrLen_LBG_PAS_1_b(const Str:PChar):Cardinal;
begin
  Result:=0;
  while Str[Result]<>#0 do Inc(Result)
end;

procedure Filler2;
asm
 nop
end;

function StrLen_LBG_PAS_1_c(const Str:PChar):Cardinal;
begin
  Result:=0;
  while Str[Result]<>#0 do Inc(Result)
end;

procedure Filler3;
asm
 nop
end;

function StrLen_LBG_PAS_1_d(const Str:PChar):Cardinal;
begin
  Result:=0;
  while Str[Result]<>#0 do Inc(Result)
end;

function StrLen_LBG_IA32_1_a(const Str: PChar): Cardinal;
asm
      xor edx,edx
      jmp @@b
@@a:  inc edx
@@b:  cmp byte ptr [eax+edx],$00
      jnz @@a
      mov eax,edx
end;

procedure Filler4;
asm
 nop
end;

function StrLen_LBG_IA32_1_b(const Str: PChar): Cardinal;
asm
      xor edx,edx
      jmp @@b
@@a:  inc edx
@@b:  cmp byte ptr [eax+edx],$00
      jnz @@a
      mov eax,edx
end;

procedure Filler5;
asm
 nop
end;

function StrLen_LBG_IA32_1_c(const Str: PChar): Cardinal;
asm
      xor edx,edx
      jmp @@b
@@a:  inc edx
@@b:  cmp byte ptr [eax+edx],$00
      jnz @@a
      mov eax,edx
end;

procedure Filler6;
asm
 nop
end;

function StrLen_LBG_IA32_1_d(const Str: PChar): Cardinal;
asm
      xor edx,edx
      jmp @@b
@@a:  inc edx
@@b:  cmp byte ptr [eax+edx],$00
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_2_a(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      cmp byte ptr [eax+edx],$00
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_2_b(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      cmp byte ptr [eax+edx],$00
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_2_c(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      cmp byte ptr [eax+edx],$00
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_2_d(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      cmp byte ptr [eax+edx],$00
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_3_a(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      movzx ecx,[eax+edx]
      test  cl, cl
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_3_b(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      movzx ecx,[eax+edx]
      test  cl, cl
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_3_c(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      movzx ecx,[eax+edx]
      test  cl, cl
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_3_d(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      movzx ecx,[eax+edx]
      test  cl, cl
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_4_a(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      movzx ecx,[eax+edx]
      test  ecx, ecx
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_4_b(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      movzx ecx,[eax+edx]
      test  ecx, ecx
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_4_c(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      movzx ecx,[eax+edx]
      test  ecx, ecx
      jnz @@a
      mov eax,edx
end;

function StrLen_LBG_IA32_4_d(const Str: PChar): Cardinal;
asm
      mov edx,-1
@@a:  add edx,1
      movzx ecx,[eax+edx]
      test  ecx, ecx
      jnz @@a
      mov eax,edx
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;

end.
