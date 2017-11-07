unit StrCompRDUnit;

interface

function StrCompRDIA321_a(const Str1, Str2: PChar): Integer;
function StrCompRDIA321_b(const Str1, Str2: PChar): Integer;
function StrCompRDIA321_c(const Str1, Str2: PChar): Integer;
function StrCompRDIA321_d(const Str1, Str2: PChar): Integer;

implementation

function StrCompRDIA321_a(const Str1, Str2: PChar): Integer;
asm
        MOV     ECX,EAX
        XOR     EAX,EAX
        CMP     ECX,EDX
        JE      @Exit  //same string or both nil
        MOV     AL,1
        JECXZ   @Exit  //Str1=''
        OR      EDX,EDX
        JNE     @1
        MOV     EAX,-1
        JMP     @Exit
@1:     MOV     AL,[ECX]
        INC     ECX
        MOV     AH,[EDX]
        INC     EDX
        TEST    AL,AL
        JE      @Exit
        CMP     AL,AH
        JE      @1
@Exit:
        XOR     EDX,EDX
        XCHG    AH,DL
        SUB     EAX,EDX
end;

function StrCompRDIA321_b(const Str1, Str2: PChar): Integer;
asm
        MOV     ECX,EAX
        XOR     EAX,EAX
        CMP     ECX,EDX
        JE      @Exit  //same string or both nil
        MOV     AL,1
        JECXZ   @Exit  //Str1=''
        OR      EDX,EDX
        JNE     @1
        MOV     EAX,-1
        JMP     @Exit
@1:     MOV     AL,[ECX]
        INC     ECX
        MOV     AH,[EDX]
        INC     EDX
        TEST    AL,AL
        JE      @Exit
        CMP     AL,AH
        JE      @1
@Exit:
        XOR     EDX,EDX
        XCHG    AH,DL
        SUB     EAX,EDX
end;

function StrCompRDIA321_c(const Str1, Str2: PChar): Integer;
asm
        MOV     ECX,EAX
        XOR     EAX,EAX
        CMP     ECX,EDX
        JE      @Exit  //same string or both nil
        MOV     AL,1
        JECXZ   @Exit  //Str1=''
        OR      EDX,EDX
        JNE     @1
        MOV     EAX,-1
        JMP     @Exit
@1:     MOV     AL,[ECX]
        INC     ECX
        MOV     AH,[EDX]
        INC     EDX
        TEST    AL,AL
        JE      @Exit
        CMP     AL,AH
        JE      @1
@Exit:
        XOR     EDX,EDX
        XCHG    AH,DL
        SUB     EAX,EDX
end;

function StrCompRDIA321_d(const Str1, Str2: PChar): Integer;
asm
        MOV     ECX,EAX
        XOR     EAX,EAX
        CMP     ECX,EDX
        JE      @Exit  //same string or both nil
        MOV     AL,1
        JECXZ   @Exit  //Str1=''
        OR      EDX,EDX
        JNE     @1
        MOV     EAX,-1
        JMP     @Exit
@1:     MOV     AL,[ECX]
        INC     ECX
        MOV     AH,[EDX]
        INC     EDX
        TEST    AL,AL
        JE      @Exit
        CMP     AL,AH
        JE      @1
@Exit:
        XOR     EDX,EDX
        XCHG    AH,DL
        SUB     EAX,EDX
end;

end.
 