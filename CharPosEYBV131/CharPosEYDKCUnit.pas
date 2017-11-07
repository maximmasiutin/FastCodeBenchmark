unit CharPosEYDKCUnit;

interface

function CharPosEY_DKC_Pas_1(const SearchCharacter : Char; const SourceString : AnsiString; Occurrence : Integer = 1; StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_Pas_6_a(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_Pas_6_b(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_Pas_6_c(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_Pas_6_d(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_16_a(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_16_b(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_16_c(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_16_d(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_18_a(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_18_b(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_18_c(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_18_d(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_19_a(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_19_b(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_19_c(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
function CharPosEY_DKC_IA32_19_d(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              10/9 2004
//Instructionset(s): IA32

function CharPosEY_DKC_Pas_1(const SearchCharacter : Char; const SourceString : AnsiString; Occurrence : Integer = 1; StartPos : Integer = 1) : Integer;
var
 Char1 : Char;
 NoOfCharsFound, Index : Integer;

begin
 if (((Length(SourceString)) > 0) and (Occurrence > 0) and
      (StartPos > 0) and (StartPos <= Length(SourceString))) then
  begin
   Result := 0;
   NoOfCharsFound := 0;
   Index := StartPos - 1;
   repeat
    Inc(Index);
    Char1 := SourceString[Index];
    if Char1 = SearchCharacter then
     begin
      Inc(NoOfCharsFound);
      if NoOfCharsFound = Occurrence then
       begin
        Result := Index;
        Break;
       end;
     end;
   until(Index >= Length(SourceString));
  end
 else
  begin
   Result := 0;
  end;
end;



//Author:            Dennis Kjaer Christensen
//Date:              15/9 2004
//Instructionset(s): IA32

function CharPosEY_DKC_Pas_6_a(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos : Integer = 1) : Integer;
var
 Char1 : Char;
 Index, SourceStringLength : Integer;
label
 Done;

begin
 if SourceString <> '' then
  begin
   SourceStringLength := PInteger(Integer(SourceString)-4)^;
   if ((SourceStringLength > 0) and (Occurrence > 0) and
       (StartPos > 0) and (StartPos <= SourceStringLength)) then
    begin
     Result := 0;
     Index := StartPos - 1;
     repeat
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
      if (Index >= SourceStringLength) then
       Exit;
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
     until(Index >= SourceStringLength);
     Exit;
    end
   else
    Index := -1;
  end
 else
  Index := -1;
 Done :
  Result := Index+1;
end;

function CharPosEY_DKC_Pas_6_b(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos : Integer = 1) : Integer;
var
 Char1 : Char;
 Index, SourceStringLength : Integer;
label
 Done;

begin
 if SourceString <> '' then
  begin
   SourceStringLength := PInteger(Integer(SourceString)-4)^;
   if ((SourceStringLength > 0) and (Occurrence > 0) and
       (StartPos > 0) and (StartPos <= SourceStringLength)) then
    begin
     Result := 0;
     Index := StartPos - 1;
     repeat
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
      if (Index >= SourceStringLength) then
       Exit;
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
     until(Index >= SourceStringLength);
     Exit;
    end
   else
    Index := -1;
  end
 else
  Index := -1;
 Done :
  Result := Index+1;
end;

function CharPosEY_DKC_Pas_6_c(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos : Integer = 1) : Integer;
var
 Char1 : Char;
 Index, SourceStringLength : Integer;
label
 Done;

begin
 if SourceString <> '' then
  begin
   SourceStringLength := PInteger(Integer(SourceString)-4)^;
   if ((SourceStringLength > 0) and (Occurrence > 0) and
       (StartPos > 0) and (StartPos <= SourceStringLength)) then
    begin
     Result := 0;
     Index := StartPos - 1;
     repeat
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
      if (Index >= SourceStringLength) then
       Exit;
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
     until(Index >= SourceStringLength);
     Exit;
    end
   else
    Index := -1;
  end
 else
  Index := -1;
 Done :
  Result := Index+1;
end;

function CharPosEY_DKC_Pas_6_d(const SearchCharacter : Char;
                               const SourceString : AnsiString;
                               Occurrence : Integer = 1;
                               StartPos : Integer = 1) : Integer;
var
 Char1 : Char;
 Index, SourceStringLength : Integer;
label
 Done;

begin
 if SourceString <> '' then
  begin
   SourceStringLength := PInteger(Integer(SourceString)-4)^;
   if ((SourceStringLength > 0) and (Occurrence > 0) and
       (StartPos > 0) and (StartPos <= SourceStringLength)) then
    begin
     Result := 0;
     Index := StartPos - 1;
     repeat
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
      if (Index >= SourceStringLength) then
       Exit;
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
     until(Index >= SourceStringLength);
     Exit;
    end
   else
    Index := -1;
  end
 else
  Index := -1;
 Done :
  Result := Index+1;
end;


//Author:            Dennis Kjaer Christensen
//Date:              15/9 2004
//Instructionset(s): IA32

function CharPosEY_DKC_IA32_16_a(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match
 @NoMatch :
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
   jmp   @IfEnd1
 @Match :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_16_b(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match
 @NoMatch :
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
   jmp   @IfEnd1
 @Match :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_16_c(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match
 @NoMatch :
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
   jmp   @IfEnd1
 @Match :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_16_d(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match
 @NoMatch :
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
   jmp   @IfEnd1
 @Match :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/9 2004
//Instructionset(s): IA32

function CharPosEY_DKC_IA32_17_a(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match1
 @NoMatch1 :
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match2
 @NoMatch2 :
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_17_b(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match1
 @NoMatch1 :
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match2
 @NoMatch2 :
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_17_c(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match1
 @NoMatch1 :
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match2
 @NoMatch2 :
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_17_d(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match1
 @NoMatch1 :
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   movzx ebx,[edi+eax]
   add   eax,1
   //if Char1 = SearchCharacter then
   cmp   bl,cl
   jz    @Match2
 @NoMatch2 :
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/9 2004
//Instructionset(s): IA32

function CharPosEY_DKC_IA32_18_a(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,[edi+eax]
   jz    @Match1
 @NoMatch1 :
   add   eax,1
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,[edi+eax]
   jz    @Match2
 @NoMatch2 :
   add   eax,1
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_18_b(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,[edi+eax]
   jz    @Match1
 @NoMatch1 :
   add   eax,1
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,[edi+eax]
   jz    @Match2
 @NoMatch2 :
   add   eax,1
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_18_c(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,[edi+eax]
   jz    @Match1
 @NoMatch1 :
   add   eax,1
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,[edi+eax]
   jz    @Match2
 @NoMatch2 :
   add   eax,1
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_18_d(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
 @LoopStart :
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,[edi+eax]
   jz    @Match1
 @NoMatch1 :
   add   eax,1
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,[edi+eax]
   jz    @Match2
 @NoMatch2 :
   add   eax,1
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/9 2004
//Instructionset(s): IA32

function CharPosEY_DKC_IA32_19_a(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   xor   ecx,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
   xor   ebx,ebx
 @LoopStart :
   //Char1 := SourceString[Result+1];
   mov   bx, word ptr [edi+eax]
   //if Char1 = SearchCharacter then
   cmp   cl,bl
   jz    @Match1
 @NoMatch1 :
   add   eax,1
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,bh
   jz    @Match2
 @NoMatch2 :
   add   eax,1
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_19_b(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   xor   ecx,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
   xor   ebx,ebx
 @LoopStart :
   //Char1 := SourceString[Result+1];
   mov   bx, word ptr [edi+eax]
   //if Char1 = SearchCharacter then
   cmp   cl,bl
   jz    @Match1
 @NoMatch1 :
   add   eax,1
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,bh
   jz    @Match2
 @NoMatch2 :
   add   eax,1
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_19_c(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   xor   ecx,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
   xor   ebx,ebx
 @LoopStart :
   //Char1 := SourceString[Result+1];
   mov   bx, word ptr [edi+eax]
   //if Char1 = SearchCharacter then
   cmp   cl,bl
   jz    @Match1
 @NoMatch1 :
   add   eax,1
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,bh
   jz    @Match2
 @NoMatch2 :
   add   eax,1
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

function CharPosEY_DKC_IA32_19_d(const SearchCharacter : Char;
                                 const SourceString : AnsiString;
                                 Occurrence : Integer = 1;
                                 StartPos : Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  edx,edx
   jz    @IfEnd1
   mov   edi,edx
   //SourceStringLength := Length(SourceString);
   mov   edx,[edx-$04]
   //if ((SourceStringLength > 0) and (Occurrence > 0) and
       //(StartPos > 0) and (StartPos <= SourceStringLength)) then
   test  edx,edx
   jle   @IfEnd1
   test  ecx,ecx
   jle   @IfEnd1
   mov   esi,ecx
   xor   ecx,ecx
   mov   cl,al
   mov   eax,[ebp+$08]
   test  eax,eax
   jle   @IfEnd1
   cmp   edx,eax
   jl    @IfEnd1
   //Result := StartPos-1;
   sub   eax,1
   xor   ebx,ebx
 @LoopStart :
   //Char1 := SourceString[Result+1];
   mov   bx, word ptr [edi+eax]
   //if Char1 = SearchCharacter then
   cmp   cl,bl
   jz    @Match1
 @NoMatch1 :
   add   eax,1
   cmp   edx,eax
   jbe   @LoopEnd
   //Char1 := SourceString[Result+1];
   //if Char1 = SearchCharacter then
   cmp   cl,bh
   jz    @Match2
 @NoMatch2 :
   add   eax,1
   //until(Result >= SourceStringLength);
   cmp   edx,eax
   jnle  @LoopStart
 @LoopEnd :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match1 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch1
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @Match2 :
   //Dec(Occurrence);
   sub   esi,1
   //if Occurrence = 0 then
   jnz   @NoMatch2
   add   eax,1
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
 @IfEnd1 :
   //Result := 0;
   xor   eax,eax
   pop   edi
   pop   esi
   pop   ebx
   pop   ebp
   ret   4
end;

end.
