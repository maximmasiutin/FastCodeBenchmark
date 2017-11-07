unit StrCompRTLUnit;

interface

function StrComp_RTL_IA32_1_a(const Str1, Str2: PChar): Integer; assembler;
function StrComp_RTL_IA32_1_b(const Str1, Str2: PChar): Integer; assembler;
function StrComp_RTL_IA32_1_c(const Str1, Str2: PChar): Integer; assembler;
function StrComp_RTL_IA32_1_d(const Str1, Str2: PChar): Integer; assembler;

implementation

function StrComp_RTL_IA32_1_a(const Str1, Str2: PChar): Integer; assembler;
asm {34 Bytes}
        PUSH    EDI
        PUSH    ESI
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     EAX,EAX
        REPNE   SCASB
        NOT     ECX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSB
        MOV     AL,[ESI-1]
        MOV     DL,[EDI-1]
        SUB     EAX,EDX
        POP     ESI
        POP     EDI
end;

function StrComp_RTL_IA32_1_b(const Str1, Str2: PChar): Integer; assembler;
asm {34 Bytes}
        PUSH    EDI
        PUSH    ESI
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     EAX,EAX
        REPNE   SCASB
        NOT     ECX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSB
        MOV     AL,[ESI-1]
        MOV     DL,[EDI-1]
        SUB     EAX,EDX
        POP     ESI
        POP     EDI
end;

function StrComp_RTL_IA32_1_c(const Str1, Str2: PChar): Integer; assembler;
asm {34 Bytes}
        PUSH    EDI
        PUSH    ESI
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     EAX,EAX
        REPNE   SCASB
        NOT     ECX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSB
        MOV     AL,[ESI-1]
        MOV     DL,[EDI-1]
        SUB     EAX,EDX
        POP     ESI
        POP     EDI
end;

function StrComp_RTL_IA32_1_d(const Str1, Str2: PChar): Integer; assembler;
asm {34 Bytes}
        PUSH    EDI
        PUSH    ESI
        MOV     EDI,EDX
        MOV     ESI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     EAX,EAX
        REPNE   SCASB
        NOT     ECX
        MOV     EDI,EDX
        XOR     EDX,EDX
        REPE    CMPSB
        MOV     AL,[ESI-1]
        MOV     DL,[EDI-1]
        SUB     EAX,EDX
        POP     ESI
        POP     EDI
end;

end.
