unit StrLCompRTLUnit;

interface

function StrLComp_RTL_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer; assembler;
function StrLComp_RTL_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer; assembler;
function StrLComp_RTL_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer; assembler;
function StrLComp_RTL_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer; assembler;

implementation

function StrLComp_RTL_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer; assembler;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     EBX,ECX
        XOR     EAX,EAX
        OR      ECX,ECX
        JE      @@1
        REPNE   SCASB
        SUB     EBX,ECX
        MOV     ECX,EBX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSB
        MOV     AL,[ESI-1]
        MOV     DL,[EDI-1]
        SUB     EAX,EDX
@@1:    POP     EBX
        POP     ESI
        POP     EDI
end;

function StrLComp_RTL_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer; assembler;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     EBX,ECX
        XOR     EAX,EAX
        OR      ECX,ECX
        JE      @@1
        REPNE   SCASB
        SUB     EBX,ECX
        MOV     ECX,EBX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSB
        MOV     AL,[ESI-1]
        MOV     DL,[EDI-1]
        SUB     EAX,EDX
@@1:    POP     EBX
        POP     ESI
        POP     EDI
end;

procedure Filler1;
asm
  nop
end;

function StrLComp_RTL_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer; assembler;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     EBX,ECX
        XOR     EAX,EAX
        OR      ECX,ECX
        JE      @@1
        REPNE   SCASB
        SUB     EBX,ECX
        MOV     ECX,EBX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSB
        MOV     AL,[ESI-1]
        MOV     DL,[EDI-1]
        SUB     EAX,EDX
@@1:    POP     EBX
        POP     ESI
        POP     EDI
end;

function StrLComp_RTL_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer; assembler;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     EBX,ECX
        XOR     EAX,EAX
        OR      ECX,ECX
        JE      @@1
        REPNE   SCASB
        SUB     EBX,ECX
        MOV     ECX,EBX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSB
        MOV     AL,[ESI-1]
        MOV     DL,[EDI-1]
        SUB     EAX,EDX
@@1:    POP     EBX
        POP     ESI
        POP     EDI
end;

initialization
  Filler1;
end.
