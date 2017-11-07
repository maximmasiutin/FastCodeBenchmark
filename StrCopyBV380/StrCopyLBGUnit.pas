unit StrCopyLBGUnit;

interface

function StrCopy_Lbg_IA32_1_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Lbg_IA32_1_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Lbg_IA32_1_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_Lbg_IA32_1_d(Dest: PChar; const Source: PChar): PChar;

implementation

function StrCopy_Lbg_IA32_1_a(Dest: PChar; const Source: PChar): PChar;
asm
               push eax
 @@1:   MOVZX ECX, [edx]
               add  edx,1
               mov  [eax],cl
               add  eax,1
               test cl, cl
               jnz  @@1
               pop  eax
end;

function StrCopy_Lbg_IA32_1_b(Dest: PChar; const Source: PChar): PChar;
asm
               push eax
 @@1:   MOVZX ECX, [edx]
               add  edx,1
               mov  [eax],cl
               add  eax,1
               test cl, cl
               jnz  @@1
               pop  eax
end;

function StrCopy_Lbg_IA32_1_c(Dest: PChar; const Source: PChar): PChar;
asm
               push eax
 @@1:   MOVZX ECX, [edx]
               add  edx,1
               mov  [eax],cl
               add  eax,1
               test cl, cl
               jnz  @@1
               pop  eax
end;

function StrCopy_Lbg_IA32_1_d(Dest: PChar; const Source: PChar): PChar;
asm
               push eax
 @@1:   MOVZX ECX, [edx]
               add  edx,1
               mov  [eax],cl
               add  eax,1
               test cl, cl
               jnz  @@1
               pop  eax
end;

end.
