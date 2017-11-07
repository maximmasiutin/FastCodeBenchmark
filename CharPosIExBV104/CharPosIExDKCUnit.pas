unit CharPosIExDKCUnit;

interface

implementation

uses
 SysUtils, MainUnit;

var
 LookUpTable : array of Char;
 LookUpTable2 : array[0..255] of Char;

procedure InitializeLookUpTable;
var
 I : Byte;
 S1, S2 : AnsiString;

begin
 SetLength(LookUpTable, 256);
 for I := 0 to 255 do
  begin
   S1 := Char(I);
   S2 := UpperCase(S1);
   LookUpTable[I] := S2[1];
  end;
end;

procedure InitializeLookUpTable2;
var
 I : Byte;

begin
 for I := 0 to 255 do
  begin
   if (Char(I) >= 'a') and (Char(I) <= 'z') then
    LookUpTable2[I] := Char(I - 32)
   else
    LookUpTable2[I] := Char(I);
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              12/12 2005
//Instructionset(s): IA32

function CharPosIEx_DKC_Pas_10_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

function CharPosIEx_DKC_Pas_10_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

procedure Filler1;
asm
 nop
end;

function CharPosIEx_DKC_Pas_10_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

function CharPosIEx_DKC_Pas_10_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              12/8 2006
//Instructionset(s): IA32

function CharPosIEx_DKC_Pas_13_a(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

function CharPosIEx_DKC_Pas_13_b(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

function CharPosIEx_DKC_Pas_13_c(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

function CharPosIEx_DKC_Pas_13_d(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              12/8 2006
//Instructionset(s): IA32

function CharPosIEx_DKC_Pas_16_a(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

procedure Filler66;
asm
 nop
end;

function CharPosIEx_DKC_Pas_16_b(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

procedure Filler67;
asm
 nop
end;

function CharPosIEx_DKC_Pas_16_c(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

procedure Filler68;
asm
 nop
end;

function CharPosIEx_DKC_Pas_16_d(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
  if (Result > StrLength) then
   Break;
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              12/8 2006
//Instructionset(s): IA32

function CharPosIEx_DKC_Pas_17_a(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

function CharPosIEx_DKC_Pas_17_b(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

function CharPosIEx_DKC_Pas_17_c(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

function CharPosIEx_DKC_Pas_17_d(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
var
 StrLength : Integer;
 SearchCharUpper, CharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if S = '' then
  Exit;
 StrLength := PInteger(Integer(S)-4)^;
 if StrLength <= 0 then
  Exit;
 if Offset > StrLength then
  Exit;
 SearchCharUpper := LookUpTable2[Ord(SearchChar)];
 Result := Offset;
 repeat
  CharUpper := LookUpTable2[Ord(S[Result])];
  if SearchCharUpper = CharUpper then
   Exit;
  Inc(Result);
 until (Result > StrLength);
 Result := 0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              10/8 2006
//Instructionset(s): IA32

function CharPosIEx_DKC_IA32_16_a(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   mov   ecx,[LookUpTable]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx eax,[esi+ebx]
   //if SearchCharUpper = CharUpper then
   cmp   dl,[ecx+eax]
   jz    @Exit
   //Inc(Result);
   inc   ebx
   //until (Result > StrLength);
   cmp   edi,ebx
   jnl   @LoopStart
   //Result := 0;
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler55;
asm
 nop
end;

function CharPosIEx_DKC_IA32_16_b(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   mov   ecx,[LookUpTable]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx eax,[esi+ebx]
   //if SearchCharUpper = CharUpper then
   cmp   dl,[ecx+eax]
   jz    @Exit
   //Inc(Result);
   inc   ebx
   //until (Result > StrLength);
   cmp   edi,ebx
   jnl   @LoopStart
   //Result := 0;
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler56;
asm
 nop
end;

function CharPosIEx_DKC_IA32_16_c(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   mov   ecx,[LookUpTable]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx eax,[esi+ebx]
   //if SearchCharUpper = CharUpper then
   cmp   dl,[ecx+eax]
   jz    @Exit
   //Inc(Result);
   inc   ebx
   //until (Result > StrLength);
   cmp   edi,ebx
   jnl   @LoopStart
   //Result := 0;
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler57;
asm
 nop
end;

function CharPosIEx_DKC_IA32_16_d(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   mov   ecx,[LookUpTable]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx eax,[esi+ebx]
   //if SearchCharUpper = CharUpper then
   cmp   dl,[ecx+eax]
   jz    @Exit
   //Inc(Result);
   inc   ebx
   //until (Result > StrLength);
   cmp   edi,ebx
   jnl   @LoopStart
   //Result := 0;
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              10/8 2006
//Instructionset(s): IA32

function CharPosIEx_DKC_IA32_17_a(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   mov   ecx,[LookUpTable]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jl    @LoopEnd
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jnl   @LoopStart
 @LoopEnd :
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler58;
asm
 nop
end;

function CharPosIEx_DKC_IA32_17_b(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   mov   ecx,[LookUpTable]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jl    @LoopEnd
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jnl   @LoopStart
 @LoopEnd :
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler59;
asm
 nop
end;

function CharPosIEx_DKC_IA32_17_c(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   mov   ecx,[LookUpTable]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jl    @LoopEnd
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jnl   @LoopStart
 @LoopEnd :
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler60;
asm
 nop
end;

function CharPosIEx_DKC_IA32_17_d(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   mov   ecx,[LookUpTable]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jl    @LoopEnd
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jnl   @LoopStart
 @LoopEnd :
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              12/8 2006
//Instructionset(s): IA32

function CharPosIEx_DKC_IA32_20_a(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   lea   ecx,[LookUpTable2]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jl    @LoopEnd
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jnl   @LoopStart
 @LoopEnd :
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler61;
asm
 nop
end;

function CharPosIEx_DKC_IA32_20_b(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   lea   ecx,[LookUpTable2]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jl    @LoopEnd
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jnl   @LoopStart
 @LoopEnd :
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler62;
asm
 nop
end;

function CharPosIEx_DKC_IA32_20_c(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   lea   ecx,[LookUpTable2]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jl    @LoopEnd
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jnl   @LoopStart
 @LoopEnd :
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler69;
asm
 nop
end;

function CharPosIEx_DKC_IA32_20_d(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   //Result := 0;
   xor   ebx,ebx
   //if (Offset <= 0) then
   test  ecx,ecx
   jle   @Exit
   //if S = '' then
   test  edx,edx
   jz    @Exit
   //StrLength := PInteger(Integer(S)-4)^;
   mov   edi,[edx-4]
   //if StrLength <= 0 then
   test  edi,edi
   jle   @Exit
   //if Offset > StrLength then
   cmp   edi,ecx
   jl    @Exit
   mov   esi,edx
   //SearchCharUpper := LookUpTable[Ord(SearchChar)];
   mov   ebx,ecx
   lea   ecx,[LookUpTable2]
   movzx eax,al
   movzx edx,[eax+ecx]
   //Result := Offset;
   dec   esi
 @LoopStart :
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jl    @LoopEnd
   movzx eax,[esi+ebx]
   cmp   dl,[ecx+eax]
   jz    @Exit
   inc   ebx
   cmp   edi,ebx
   jnl   @LoopStart
 @LoopEnd :
   xor   ebx,ebx
 @Exit :
   mov   eax,ebx
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              16/8 2006
//Instructionset(s): IA32

function CharPosIEx_DKC_IA32_26_a(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  ecx,ecx
   jle   @ExitResultZero
   test  edx,edx
   jz    @ExitResultZero
   mov   edi,[edx-4]
   test  edi,edi
   jle   @ExitResultZero
   cmp   edi,ecx
   jl    @ExitResultZero
   mov   esi,edx
   movzx ebx,al
   mov   eax,ecx
   lea   ecx,[LookUpTable2]
   movzx edx,[ecx+ebx]
   sub   esi,1
 @LoopStart :
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jnl   @LoopStart
 @ExitResultZero :
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
end;

function CharPosIEx_DKC_IA32_26_b(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  ecx,ecx
   jle   @ExitResultZero
   test  edx,edx
   jz    @ExitResultZero
   mov   edi,[edx-4]
   test  edi,edi
   jle   @ExitResultZero
   cmp   edi,ecx
   jl    @ExitResultZero
   mov   esi,edx
   movzx ebx,al
   mov   eax,ecx
   lea   ecx,[LookUpTable2]
   movzx edx,[ecx+ebx]
   sub   esi,1
 @LoopStart :
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jnl   @LoopStart
 @ExitResultZero :
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
end;

function CharPosIEx_DKC_IA32_26_c(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  ecx,ecx
   jle   @ExitResultZero
   test  edx,edx
   jz    @ExitResultZero
   mov   edi,[edx-4]
   test  edi,edi
   jle   @ExitResultZero
   cmp   edi,ecx
   jl    @ExitResultZero
   mov   esi,edx
   movzx ebx,al
   mov   eax,ecx
   lea   ecx,[LookUpTable2]
   movzx edx,[ecx+ebx]
   sub   esi,1
 @LoopStart :
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jnl   @LoopStart
 @ExitResultZero :
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
end;

function CharPosIEx_DKC_IA32_26_d(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  ecx,ecx
   jle   @ExitResultZero
   test  edx,edx
   jz    @ExitResultZero
   mov   edi,[edx-4]
   test  edi,edi
   jle   @ExitResultZero
   cmp   edi,ecx
   jl    @ExitResultZero
   mov   esi,edx
   movzx ebx,al
   mov   eax,ecx
   lea   ecx,[LookUpTable2]
   movzx edx,[ecx+ebx]
   sub   esi,1
 @LoopStart :
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   movzx ebx,[ecx+ebx]
   cmp   bl,dl
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jnl   @LoopStart
 @ExitResultZero :
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/12 2006
//Instructionset(s): IA32

function CharPosIEx_DKC_IA32_27_a(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  ecx,ecx
   jle   @ExitResultZero
   test  edx,edx
   jz    @ExitResultZero
   mov   edi,[edx-4]
   test  edi,edi
   jle   @ExitResultZero
   cmp   edi,ecx
   jl    @ExitResultZero
   mov   esi,edx
   movzx ebx,al
   mov   eax,ecx
   lea   ecx,[LookUpTable2]
   movzx edx,[ecx+ebx]
   sub   esi,1
 @LoopStart :
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jnl   @LoopStart
 @ExitResultZero :
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
end;

function CharPosIEx_DKC_IA32_27_b(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  ecx,ecx
   jle   @ExitResultZero
   test  edx,edx
   jz    @ExitResultZero
   mov   edi,[edx-4]
   test  edi,edi
   jle   @ExitResultZero
   cmp   edi,ecx
   jl    @ExitResultZero
   mov   esi,edx
   movzx ebx,al
   mov   eax,ecx
   lea   ecx,[LookUpTable2]
   movzx edx,[ecx+ebx]
   sub   esi,1
 @LoopStart :
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jnl   @LoopStart
 @ExitResultZero :
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
end;

function CharPosIEx_DKC_IA32_27_c(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  ecx,ecx
   jle   @ExitResultZero
   test  edx,edx
   jz    @ExitResultZero
   mov   edi,[edx-4]
   test  edi,edi
   jle   @ExitResultZero
   cmp   edi,ecx
   jl    @ExitResultZero
   mov   esi,edx
   movzx ebx,al
   mov   eax,ecx
   lea   ecx,[LookUpTable2]
   movzx edx,[ecx+ebx]
   sub   esi,1
 @LoopStart :
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jnl   @LoopStart
 @ExitResultZero :
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
end;

function CharPosIEx_DKC_IA32_27_d(SearchChar : Char;
                                  const S: string;
                                  Offset: Integer = 1) : Integer;
asm
   push  ebx
   push  esi
   push  edi
   test  ecx,ecx
   jle   @ExitResultZero
   test  edx,edx
   jz    @ExitResultZero
   mov   edi,[edx-4]
   test  edi,edi
   jle   @ExitResultZero
   cmp   edi,ecx
   jl    @ExitResultZero
   mov   esi,edx
   movzx ebx,al
   mov   eax,ecx
   lea   ecx,[LookUpTable2]
   movzx edx,[ecx+ebx]
   sub   esi,1
 @LoopStart :
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jl    @ExitResultZero
   movzx ebx,[esi+eax]
   cmp   dl,[ecx+ebx]
   jz    @Exit
   add   eax,1
   cmp   edi,eax
   jnl   @LoopStart
 @ExitResultZero :
   xor   eax,eax
 @Exit :
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/12 2005
//Instructionset(s): IA32, MMX

function CharPosIEx_DKC_MMX_4_a(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   push      ebx
   push      edi
   push      esi
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @ExitResult0
   //if StrLenght > 0 then
   test      edx,edx
   jz        @ExitResult0
   //StrLenght := Length(Str);
   mov       edi,[edx-4]
   test      edi,edi
   jz        @Else1Begin
   cmp       edi,ecx
   jb        @ExitResult0
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       esi,edi
   sub       esi,ecx
   cmp       esi,8
   jae       @BigStr
   //SmallStr :
   dec       ecx
   sub       edx,1
 @RepeatBegin :
   //Inc(I);
   add       ecx,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+ecx]
   mov       esi,[LookUpTable]
   movzx     ebx,[esi+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @Exit
   cmp       edi,ecx
   ja        @RepeatBegin
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       edi
   pop       ebx
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   mov       esi,ecx
   dec       esi
   //StrLenght := Length(Str);
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   test      bl, bl
   jnz       @Char1or2Match
   test      bh, bh
   jnz       @Char3or4Match
   shr       ebx, 16
   test      bl, bl
   jnz       @Char5or6Match
   test      bh, bh
   jnz       @Char7or8Match
 @Char1or2Match :
   cmp       bl, 255
   je        @Char1Match
   cmp       bl, 127
   jbe       @Char1Match
   jmp       @Char2Match
 @Char3or4Match :
   cmp       bl, 255
   je        @Char3Match
   cmp       bh, 255
   je        @Char3Match
   cmp       bh, 127
   jbe       @Char3Match
   jmp       @Char4Match
 @Char5or6Match :
   cmp       bl, 255
   je        @Char5Match
   cmp       bl, 127
   jbe       @Char5Match
   jmp       @Char6Match
 @Char7or8Match :
   cmp       bl, 255
   je        @Char7Match
   cmp       bh, 255
   je        @Char7Match
   cmp       bh, 127
   jbe       @Char7Match
   jmp       @Char8Match
 @Char1Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 1
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char2Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 2
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char3Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 3
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char4Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 4
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char5Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 5
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char6Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 6
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char7Match :
   sub       esi,8
   mov       eax,esi
   add       eax,7
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char8Match :
   sub       esi,8
   mov       eax,esi
   add       eax,8
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @Else3Begin//No rest
   sub       edx,1
 @BigRepeatBegin :
   //Inc(I);
   add       esi,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+esi]
   mov       ecx,[LookUpTable]
   movzx     ebx,[ecx+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
   //pop       esi
 @Else1Begin :
 @ExitResult0 :
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Else3Begin :
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       edi
   pop       ebx
   ret
end;

function CharPosIEx_DKC_MMX_4_b(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   push      ebx
   push      edi
   push      esi
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @ExitResult0
   //if StrLenght > 0 then
   test      edx,edx
   jz        @ExitResult0
   //StrLenght := Length(Str);
   mov       edi,[edx-4]
   test      edi,edi
   jz        @Else1Begin
   cmp       edi,ecx
   jb        @ExitResult0
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       esi,edi
   sub       esi,ecx
   cmp       esi,8
   jae       @BigStr
   //SmallStr :
   dec       ecx
   sub       edx,1
 @RepeatBegin :
   //Inc(I);
   add       ecx,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+ecx]
   mov       esi,[LookUpTable]
   movzx     ebx,[esi+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @Exit
   cmp       edi,ecx
   ja        @RepeatBegin
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       edi
   pop       ebx
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   mov       esi,ecx
   dec       esi
   //StrLenght := Length(Str);
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   test      bl, bl
   jnz       @Char1or2Match
   test      bh, bh
   jnz       @Char3or4Match
   shr       ebx, 16
   test      bl, bl
   jnz       @Char5or6Match
   test      bh, bh
   jnz       @Char7or8Match
 @Char1or2Match :
   cmp       bl, 255
   je        @Char1Match
   cmp       bl, 127
   jbe       @Char1Match
   jmp       @Char2Match
 @Char3or4Match :
   cmp       bl, 255
   je        @Char3Match
   cmp       bh, 255
   je        @Char3Match
   cmp       bh, 127
   jbe       @Char3Match
   jmp       @Char4Match
 @Char5or6Match :
   cmp       bl, 255
   je        @Char5Match
   cmp       bl, 127
   jbe       @Char5Match
   jmp       @Char6Match
 @Char7or8Match :
   cmp       bl, 255
   je        @Char7Match
   cmp       bh, 255
   je        @Char7Match
   cmp       bh, 127
   jbe       @Char7Match
   jmp       @Char8Match
 @Char1Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 1
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char2Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 2
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char3Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 3
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char4Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 4
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char5Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 5
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char6Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 6
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char7Match :
   sub       esi,8
   mov       eax,esi
   add       eax,7
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char8Match :
   sub       esi,8
   mov       eax,esi
   add       eax,8
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @Else3Begin//No rest
   sub       edx,1
 @BigRepeatBegin :
   //Inc(I);
   add       esi,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+esi]
   mov       ecx,[LookUpTable]
   movzx     ebx,[ecx+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
   //pop       esi
 @Else1Begin :
 @ExitResult0 :
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Else3Begin :
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       edi
   pop       ebx
   ret
end;

function CharPosIEx_DKC_MMX_4_c(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   push      ebx
   push      edi
   push      esi
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @ExitResult0
   //if StrLenght > 0 then
   test      edx,edx
   jz        @ExitResult0
   //StrLenght := Length(Str);
   mov       edi,[edx-4]
   test      edi,edi
   jz        @Else1Begin
   cmp       edi,ecx
   jb        @ExitResult0
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       esi,edi
   sub       esi,ecx
   cmp       esi,8
   jae       @BigStr
   //SmallStr :
   dec       ecx
   sub       edx,1
 @RepeatBegin :
   //Inc(I);
   add       ecx,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+ecx]
   mov       esi,[LookUpTable]
   movzx     ebx,[esi+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @Exit
   cmp       edi,ecx
   ja        @RepeatBegin
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       edi
   pop       ebx
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   mov       esi,ecx
   dec       esi
   //StrLenght := Length(Str);
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   test      bl, bl
   jnz       @Char1or2Match
   test      bh, bh
   jnz       @Char3or4Match
   shr       ebx, 16
   test      bl, bl
   jnz       @Char5or6Match
   test      bh, bh
   jnz       @Char7or8Match
 @Char1or2Match :
   cmp       bl, 255
   je        @Char1Match
   cmp       bl, 127
   jbe       @Char1Match
   jmp       @Char2Match
 @Char3or4Match :
   cmp       bl, 255
   je        @Char3Match
   cmp       bh, 255
   je        @Char3Match
   cmp       bh, 127
   jbe       @Char3Match
   jmp       @Char4Match
 @Char5or6Match :
   cmp       bl, 255
   je        @Char5Match
   cmp       bl, 127
   jbe       @Char5Match
   jmp       @Char6Match
 @Char7or8Match :
   cmp       bl, 255
   je        @Char7Match
   cmp       bh, 255
   je        @Char7Match
   cmp       bh, 127
   jbe       @Char7Match
   jmp       @Char8Match
 @Char1Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 1
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char2Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 2
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char3Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 3
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char4Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 4
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char5Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 5
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char6Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 6
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char7Match :
   sub       esi,8
   mov       eax,esi
   add       eax,7
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char8Match :
   sub       esi,8
   mov       eax,esi
   add       eax,8
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @Else3Begin//No rest
   sub       edx,1
 @BigRepeatBegin :
   //Inc(I);
   add       esi,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+esi]
   mov       ecx,[LookUpTable]
   movzx     ebx,[ecx+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
   //pop       esi
 @Else1Begin :
 @ExitResult0 :
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Else3Begin :
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       edi
   pop       ebx
   ret
end;

function CharPosIEx_DKC_MMX_4_d(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   push      ebx
   push      edi
   push      esi
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @ExitResult0
   //if StrLenght > 0 then
   test      edx,edx
   jz        @ExitResult0
   //StrLenght := Length(Str);
   mov       edi,[edx-4]
   test      edi,edi
   jz        @Else1Begin
   cmp       edi,ecx
   jb        @ExitResult0
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       esi,edi
   sub       esi,ecx
   cmp       esi,8
   jae       @BigStr
   //SmallStr :
   dec       ecx
   sub       edx,1
 @RepeatBegin :
   //Inc(I);
   add       ecx,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+ecx]
   mov       esi,[LookUpTable]
   movzx     ebx,[esi+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @Exit
   cmp       edi,ecx
   ja        @RepeatBegin
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       edi
   pop       ebx
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   mov       esi,ecx
   dec       esi
   //StrLenght := Length(Str);
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   test      bl, bl
   jnz       @Char1or2Match
   test      bh, bh
   jnz       @Char3or4Match
   shr       ebx, 16
   test      bl, bl
   jnz       @Char5or6Match
   test      bh, bh
   jnz       @Char7or8Match
 @Char1or2Match :
   cmp       bl, 255
   je        @Char1Match
   cmp       bl, 127
   jbe       @Char1Match
   jmp       @Char2Match
 @Char3or4Match :
   cmp       bl, 255
   je        @Char3Match
   cmp       bh, 255
   je        @Char3Match
   cmp       bh, 127
   jbe       @Char3Match
   jmp       @Char4Match
 @Char5or6Match :
   cmp       bl, 255
   je        @Char5Match
   cmp       bl, 127
   jbe       @Char5Match
   jmp       @Char6Match
 @Char7or8Match :
   cmp       bl, 255
   je        @Char7Match
   cmp       bh, 255
   je        @Char7Match
   cmp       bh, 127
   jbe       @Char7Match
   jmp       @Char8Match
 @Char1Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 1
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char2Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 2
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char3Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 3
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char4Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 4
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char5Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 5
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char6Match :
   sub       esi, 8
   mov       eax, esi
   add       eax, 6
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char7Match :
   sub       esi,8
   mov       eax,esi
   add       eax,7
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Char8Match :
   sub       esi,8
   mov       eax,esi
   add       eax,8
   //emms
   pop       esi
   pop       edi
   pop       ebx
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @Else3Begin//No rest
   sub       edx,1
 @BigRepeatBegin :
   //Inc(I);
   add       esi,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+esi]
   mov       ecx,[LookUpTable]
   movzx     ebx,[ecx+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
   //pop       esi
 @Else1Begin :
 @ExitResult0 :
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @Else3Begin :
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       edi
   pop       ebx
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       edi
   pop       ebx
   ret
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/12 2005
//Instructionset(s): IA32, MMX

function CharPosIEx_DKC_MMX_6_a(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       esi,edi
   sub       esi,ecx
   cmp       esi,8
   jae       @BigStr
   sub       edx,1
   mov       esi,[LookUpTable]
 @RepeatBegin :
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @Exit
   //Inc(I);
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   mov       esi,ecx
   dec       esi
   //StrLenght := Length(Str);
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   test      bl,bl
   jnz       @Char1or2Match
   test      bh,bh
   jnz       @Char3or4Match
   shr       ebx,16
   test      bl,bl
   jnz       @Char5or6Match
   test      bh,bh
   jnz       @Char7or8Match
 @Char1or2Match :
   cmp       bl,255
   je        @Char1Match
   cmp       bl,127
   jbe       @Char1Match
   jmp       @Char2Match
 @Char3or4Match :
   cmp       bl,255
   je        @Char3Match
   cmp       bh,255
   je        @Char3Match
   cmp       bh,127
   jbe       @Char3Match
   jmp       @Char4Match
 @Char5or6Match :
   cmp       bl,255
   je        @Char5Match
   cmp       bl,127
   jbe       @Char5Match
   jmp       @Char6Match
 @Char7or8Match :
   cmp       bl,255
   je        @Char7Match
   cmp       bh,255
   je        @Char7Match
   cmp       bh,127
   jbe       @Char7Match
   jmp       @Char8Match
 @Char1Match :
   mov       eax,esi
   sub       eax,7
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char2Match :
   mov       eax,esi
   sub       eax,6
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char3Match :
   mov       eax,esi
   sub       eax,5
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char4Match :
   mov       eax,esi
   sub       eax,4
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char5Match :
   mov       eax,esi
   sub       eax,3
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char6Match :
   mov       eax,esi
   sub       eax,2
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char7Match :
   mov       eax,esi
   sub       eax,1
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char8Match :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]   
 @BigRepeatBegin :
   //Inc(I);
   add       esi,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+esi]

   movzx     ebx,[ecx+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/12 2005
//Instructionset(s): IA32, MMX

function CharPosIEx_DKC_MMX_6_b(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       esi,edi
   sub       esi,ecx
   cmp       esi,8
   jae       @BigStr
   sub       edx,1
   mov       esi,[LookUpTable]
 @RepeatBegin :
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @Exit
   //Inc(I);
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   mov       esi,ecx
   dec       esi
   //StrLenght := Length(Str);
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   test      bl,bl
   jnz       @Char1or2Match
   test      bh,bh
   jnz       @Char3or4Match
   shr       ebx,16
   test      bl,bl
   jnz       @Char5or6Match
   test      bh,bh
   jnz       @Char7or8Match
 @Char1or2Match :
   cmp       bl,255
   je        @Char1Match
   cmp       bl,127
   jbe       @Char1Match
   jmp       @Char2Match
 @Char3or4Match :
   cmp       bl,255
   je        @Char3Match
   cmp       bh,255
   je        @Char3Match
   cmp       bh,127
   jbe       @Char3Match
   jmp       @Char4Match
 @Char5or6Match :
   cmp       bl,255
   je        @Char5Match
   cmp       bl,127
   jbe       @Char5Match
   jmp       @Char6Match
 @Char7or8Match :
   cmp       bl,255
   je        @Char7Match
   cmp       bh,255
   je        @Char7Match
   cmp       bh,127
   jbe       @Char7Match
   jmp       @Char8Match
 @Char1Match :
   mov       eax,esi
   sub       eax,7
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char2Match :
   mov       eax,esi
   sub       eax,6
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char3Match :
   mov       eax,esi
   sub       eax,5
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char4Match :
   mov       eax,esi
   sub       eax,4
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char5Match :
   mov       eax,esi
   sub       eax,3
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char6Match :
   mov       eax,esi
   sub       eax,2
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char7Match :
   mov       eax,esi
   sub       eax,1
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char8Match :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   //Inc(I);
   add       esi,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+esi]

   movzx     ebx,[ecx+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/12 2005
//Instructionset(s): IA32, MMX

function CharPosIEx_DKC_MMX_6_c(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       esi,edi
   sub       esi,ecx
   cmp       esi,8
   jae       @BigStr
   sub       edx,1
   mov       esi,[LookUpTable]
 @RepeatBegin :
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @Exit
   //Inc(I);
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   mov       esi,ecx
   dec       esi
   //StrLenght := Length(Str);
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   test      bl,bl
   jnz       @Char1or2Match
   test      bh,bh
   jnz       @Char3or4Match
   shr       ebx,16
   test      bl,bl
   jnz       @Char5or6Match
   test      bh,bh
   jnz       @Char7or8Match
 @Char1or2Match :
   cmp       bl,255
   je        @Char1Match
   cmp       bl,127
   jbe       @Char1Match
   jmp       @Char2Match
 @Char3or4Match :
   cmp       bl,255
   je        @Char3Match
   cmp       bh,255
   je        @Char3Match
   cmp       bh,127
   jbe       @Char3Match
   jmp       @Char4Match
 @Char5or6Match :
   cmp       bl,255
   je        @Char5Match
   cmp       bl,127
   jbe       @Char5Match
   jmp       @Char6Match
 @Char7or8Match :
   cmp       bl,255
   je        @Char7Match
   cmp       bh,255
   je        @Char7Match
   cmp       bh,127
   jbe       @Char7Match
   jmp       @Char8Match
 @Char1Match :
   mov       eax,esi
   sub       eax,7
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char2Match :
   mov       eax,esi
   sub       eax,6
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char3Match :
   mov       eax,esi
   sub       eax,5
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char4Match :
   mov       eax,esi
   sub       eax,4
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char5Match :
   mov       eax,esi
   sub       eax,3
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char6Match :
   mov       eax,esi
   sub       eax,2
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char7Match :
   mov       eax,esi
   sub       eax,1
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char8Match :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   //Inc(I);
   add       esi,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+esi]

   movzx     ebx,[ecx+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/12 2005
//Instructionset(s): IA32, MMX

function CharPosIEx_DKC_MMX_6_d(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       esi,edi
   sub       esi,ecx
   cmp       esi,8
   jae       @BigStr
   sub       edx,1
   mov       esi,[LookUpTable]
 @RepeatBegin :
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @Exit
   //Inc(I);
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
   //Result := 0;
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   mov       esi,ecx
   dec       esi
   //StrLenght := Length(Str);
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   test      bl,bl
   jnz       @Char1or2Match
   test      bh,bh
   jnz       @Char3or4Match
   shr       ebx,16
   test      bl,bl
   jnz       @Char5or6Match
   test      bh,bh
   jnz       @Char7or8Match
 @Char1or2Match :
   cmp       bl,255
   je        @Char1Match
   cmp       bl,127
   jbe       @Char1Match
   jmp       @Char2Match
 @Char3or4Match :
   cmp       bl,255
   je        @Char3Match
   cmp       bh,255
   je        @Char3Match
   cmp       bh,127
   jbe       @Char3Match
   jmp       @Char4Match
 @Char5or6Match :
   cmp       bl,255
   je        @Char5Match
   cmp       bl,127
   jbe       @Char5Match
   jmp       @Char6Match
 @Char7or8Match :
   cmp       bl,255
   je        @Char7Match
   cmp       bh,255
   je        @Char7Match
   cmp       bh,127
   jbe       @Char7Match
   jmp       @Char8Match
 @Char1Match :
   mov       eax,esi
   sub       eax,7
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char2Match :
   mov       eax,esi
   sub       eax,6
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char3Match :
   mov       eax,esi
   sub       eax,5
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char4Match :
   mov       eax,esi
   sub       eax,4
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char5Match :
   mov       eax,esi
   sub       eax,3
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char6Match :
   mov       eax,esi
   sub       eax,2
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char7Match :
   mov       eax,esi
   sub       eax,1
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char8Match :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]   
 @BigRepeatBegin :
   //Inc(I);
   add       esi,1
   //CharUpper := LookUpTable[Ord(S[Result])];
   movzx     ebx,[edx+esi]

   movzx     ebx,[ecx+ebx]
   //until((Str[I] = Chr) or (I > StrLenght));
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
end;

procedure Filler42;
asm
 nop
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/12 2005
//Instructionset(s): IA32, MMX

function CharPosIEx_DKC_MMX_8_a(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @Exit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
   mov       esi,ecx
   dec       esi
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   bsf       eax,ebx
   //1 = 0
   //2 = 7
   //3 = 8
   //4 = 15
   //5 = 16
   //6 = 23
   //7 = 24
   //8 = 31
   cmp       eax,7
   jl        @Char1Match
   cmp       eax,8
   jl        @Char2Match
   cmp       eax,15
   jl        @Char3Match
   cmp       eax,16
   jl        @Char4Match
   cmp       eax,23
   jl        @Char5Match
   cmp       eax,24
   jl        @Char6Match
   cmp       eax,31
   jl        @Char7Match
   jmp       @Char8Match
 @Char1Match :
   mov       eax,esi
   sub       eax,7
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char2Match :
   mov       eax,esi
   sub       eax,6
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char3Match :
   mov       eax,esi
   sub       eax,5
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char4Match :
   mov       eax,esi
   sub       eax,4
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char5Match :
   mov       eax,esi
   sub       eax,3
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char6Match :
   mov       eax,esi
   sub       eax,2
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char7Match :
   mov       eax,esi
   sub       eax,1
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char8Match :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   add       esi,1
   movzx     ebx,[edx+esi]
   movzx     ebx,[ecx+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
end;

procedure Filler31;
asm
 nop
end;

function CharPosIEx_DKC_MMX_8_b(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @Exit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
   mov       esi,ecx
   dec       esi
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   bsf       eax,ebx
   //1 = 0
   //2 = 7
   //3 = 8
   //4 = 15
   //5 = 16
   //6 = 23
   //7 = 24
   //8 = 31
   cmp       eax,7
   jl        @Char1Match
   cmp       eax,8
   jl        @Char2Match
   cmp       eax,15
   jl        @Char3Match
   cmp       eax,16
   jl        @Char4Match
   cmp       eax,23
   jl        @Char5Match
   cmp       eax,24
   jl        @Char6Match
   cmp       eax,31
   jl        @Char7Match
   jmp       @Char8Match
 @Char1Match :
   mov       eax,esi
   sub       eax,7
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char2Match :
   mov       eax,esi
   sub       eax,6
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char3Match :
   mov       eax,esi
   sub       eax,5
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char4Match :
   mov       eax,esi
   sub       eax,4
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char5Match :
   mov       eax,esi
   sub       eax,3
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char6Match :
   mov       eax,esi
   sub       eax,2
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char7Match :
   mov       eax,esi
   sub       eax,1
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char8Match :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   add       esi,1
   movzx     ebx,[edx+esi]
   movzx     ebx,[ecx+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
end;

procedure Filler32;
asm
 nop
end;

function CharPosIEx_DKC_MMX_8_c(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @Exit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
   mov       esi,ecx
   dec       esi
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   bsf       eax,ebx
   //1 = 0
   //2 = 7
   //3 = 8
   //4 = 15
   //5 = 16
   //6 = 23
   //7 = 24
   //8 = 31
   cmp       eax,7
   jl        @Char1Match
   cmp       eax,8
   jl        @Char2Match
   cmp       eax,15
   jl        @Char3Match
   cmp       eax,16
   jl        @Char4Match
   cmp       eax,23
   jl        @Char5Match
   cmp       eax,24
   jl        @Char6Match
   cmp       eax,31
   jl        @Char7Match
   jmp       @Char8Match
 @Char1Match :
   mov       eax,esi
   sub       eax,7
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char2Match :
   mov       eax,esi
   sub       eax,6
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char3Match :
   mov       eax,esi
   sub       eax,5
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char4Match :
   mov       eax,esi
   sub       eax,4
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char5Match :
   mov       eax,esi
   sub       eax,3
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char6Match :
   mov       eax,esi
   sub       eax,2
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char7Match :
   mov       eax,esi
   sub       eax,1
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char8Match :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   add       esi,1
   movzx     ebx,[edx+esi]
   movzx     ebx,[ecx+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
end;

procedure Filler33;
asm
 nop
end;

function CharPosIEx_DKC_MMX_8_d(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @Exit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
   mov       esi,ecx
   dec       esi
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   packsswb  mm0,mm0
   movd      ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   //There is a match, but where? Find the leftmost match.
   bsf       eax,ebx
   //1 = 0
   //2 = 7
   //3 = 8
   //4 = 15
   //5 = 16
   //6 = 23
   //7 = 24
   //8 = 31
   cmp       eax,7
   jl        @Char1Match
   cmp       eax,8
   jl        @Char2Match
   cmp       eax,15
   jl        @Char3Match
   cmp       eax,16
   jl        @Char4Match
   cmp       eax,23
   jl        @Char5Match
   cmp       eax,24
   jl        @Char6Match
   cmp       eax,31
   jl        @Char7Match
   jmp       @Char8Match
 @Char1Match :
   mov       eax,esi
   sub       eax,7
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char2Match :
   mov       eax,esi
   sub       eax,6
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char3Match :
   mov       eax,esi
   sub       eax,5
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char4Match :
   mov       eax,esi
   sub       eax,4
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char5Match :
   mov       eax,esi
   sub       eax,3
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char6Match :
   mov       eax,esi
   sub       eax,2
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char7Match :
   mov       eax,esi
   sub       eax,1
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Char8Match :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   add       esi,1
   movzx     ebx,[edx+esi]
   movzx     ebx,[ecx+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/12 2005
//Instructionset(s): IA32, MMX, SSE

function CharPosIEx_DKC_SSE_1_a(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,8
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @Exit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
   mov       esi,ecx
   dec       esi
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   pmovmskb  ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   sub       esi,8  
   bsf       eax,ebx
   inc       eax
   add       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   add       esi,1
   movzx     ebx,[edx+esi]
   movzx     ebx,[ecx+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE_1_b(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,8
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @Exit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
   mov       esi,ecx
   dec       esi
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   pmovmskb  ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   sub       esi,8  
   bsf       eax,ebx
   inc       eax
   add       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   add       esi,1
   movzx     ebx,[edx+esi]
   movzx     ebx,[ecx+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE_1_c(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,8
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @Exit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
   mov       esi,ecx
   dec       esi
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   pmovmskb  ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   sub       esi,8  
   bsf       eax,ebx
   inc       eax
   add       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   add       esi,1
   movzx     ebx,[edx+esi]
   movzx     ebx,[ecx+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE_1_d(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,8
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @Exit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @Exit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   shl       eax,8
   mov       al,ah
   shl       eax,8
   mov       al,ah
   movd      mm0,eax
   movq      mm1,mm0
   psllq     mm1,32
   por       mm0,mm1
   movq      mm5,mm0
   shr       edi,3
   add       edi,edi
   add       edi,edi
   add       edi,edi
   sub       edi,7
   movd      mm2,Const1
   punpckldq mm2,mm2
   movd      mm3,Const2
   punpckldq mm3,mm3
   movd      mm4,Const3
   punpckldq mm4,mm4
   mov       esi,ecx
   dec       esi
 @LoopStart :
   movq      mm0,[edx+esi]
   movq      mm1,mm0
   paddb     mm1,mm2        //char3 = char3 + 05h
   pcmpgtb   mm1,mm4
   pand      mm1,mm3        //char3 = char3 and 7Fh
   psubb     mm0,mm1        //char = char - char3
   pcmpeqb   mm0,mm5
   pmovmskb  ebx,mm0
   add       esi,8
   test      ebx,ebx
   jnz       @Found
   cmp       esi,edi
   jb        @LoopStart
   add       edi,7
   emms
   jmp       @BigNotFound
 @Found :
   emms
   sub       esi,8  
   bsf       eax,ebx
   inc       eax
   add       eax,esi
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       esi,edi
   je        @ExitResult0
   sub       edx,1
   mov       ecx,[LookUpTable]
 @BigRepeatBegin :
   add       esi,1
   movzx     ebx,[edx+esi]
   movzx     ebx,[ecx+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,esi
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,esi
   pop       esi
   pop       ebx
   pop       edi
end;

//Author:            Dennis Kjaer Christensen
//Date:              16/8 2006
//Instructionset(s): IA32, SSE, SSE2

function CharPosIEx_DKC_SSE2_7_a(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_7_b(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_7_c(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_7_d(SearchChar : Char;
                                const S: string;
                                Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

//Author:            Dennis Kjaer Christensen
//Date:              17/8 2006
//Instructionset(s): IA32, SSE, SSE2

function CharPosIEx_DKC_SSE2_8_a(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_8_b(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

procedure Filler73;
asm
 nop
end;

function CharPosIEx_DKC_SSE2_8_c(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_8_d(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/12 2006
//Instructionset(s): IA32, SSE, SSE2

function CharPosIEx_DKC_SSE2_9_a(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_9_b(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

procedure Filler77;
asm
 nop
end;

function CharPosIEx_DKC_SSE2_9_c(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_9_d(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       eax,ebx
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/12 2006
//Instructionset(s): IA32, SSE, SSE2

function CharPosIEx_DKC_SSE2_10_a(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_10_b(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_10_c(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE2_10_d(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jb        @RepeatEnd
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   add       ecx,1
   cmp       edi,ecx
   jae       @RepeatBegin
 @RepeatEnd :
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   movdqu    xmm0,[edx+ecx]
   movdqu    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/8 2006
//Instructionset(s): IA32, SSE, SSE2, SSE3

function CharPosIEx_DKC_SSE3_3_a(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   mov       esi,[LookUpTable]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE3_3_b(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   mov       esi,[LookUpTable]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE3_3_c(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   mov       esi,[LookUpTable]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE3_3_d(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   mov       esi,[LookUpTable]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   mov       esi,[LookUpTable]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/8 2006
//Instructionset(s): IA32, SSE, SSE2, SSE3

function CharPosIEx_DKC_SSE3_4_a(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE3_4_b(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE3_4_c(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

function CharPosIEx_DKC_SSE3_4_d(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   //if OffSet <= 0 then
   test      ecx,ecx
   jle       @CleanExitResult0
   //if StrLenght <= 0 then
   test      edx,edx
   jz        @CleanExitResult0
   //StrLenght := Length(Str);
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/12 2006
//Instructionset(s): IA32, SSE, SSE2, SSE3

function CharPosIEx_DKC_SSE3_5_a(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

procedure Filler74;
asm
 nop
end;

function CharPosIEx_DKC_SSE3_5_b(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

procedure Filler75;
asm
 nop
end;

function CharPosIEx_DKC_SSE3_5_c(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

procedure Filler76;
asm
 nop
end;

function CharPosIEx_DKC_SSE3_5_d(SearchChar : Char;
                                 const S: string;
                                 Offset: Integer = 1) : Integer;
const
 Const1 : Integer = $05050505;
 Const2 : Integer = $20202020;
 Const3 : Integer = $65656565;

asm
   test      ecx,ecx
   jle       @CleanExitResult0
   test      edx,edx
   jz        @CleanExitResult0
   push      edi
   mov       edi,[edx-4]
   test      edi,edi
   jz        @AlmostCleanExitResult0
   cmp       edi,ecx
   jb        @AlmostCleanExitResult0
   push      ebx
   push      esi
   lea       esi,[LookUpTable2]
   movzx     eax,al
   movzx     eax,[esi+eax]
   mov       ebx,edi
   sub       ebx,ecx
   cmp       ebx,16
   jae       @BigStr
   dec       edx
 @RepeatBegin :
   movzx     ebx,[edx+ecx]
   cmp       al,[esi+ebx]
   jz        @FoundExit
   inc       ecx
   cmp       edi,ecx
   jae       @RepeatBegin
   xor       eax,eax
   pop       esi
   pop       ebx
   pop       edi
   ret
 @FoundExit :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigStr :
   mov       ah,al
   movd      xmm5,eax
   pshuflw   xmm5,xmm5,0
   pshufd    xmm5,xmm5,0
   movd      xmm2,Const1
   pshufd    xmm2,xmm2,0
   movd      xmm3,Const2
   pshufd    xmm3,xmm3,0
   movd      xmm4,Const3
   pshufd    xmm4,xmm4,0
   sub       edi,15
   dec       ecx
 @LoopStart :
   DB $F2 DB $0F DB $F0 DB $04 DB $11       //lddqu xmm0,dqword ptr [ecx+edx]
   movdqa    xmm1,xmm0
   paddb     xmm1,xmm2        //char3 = char3 + 05h
   pcmpgtb   xmm1,xmm4
   pand      xmm1,xmm3        //char3 = char3 and 7Fh
   psubb     xmm0,xmm1        //char = char - char3
   pcmpeqb   xmm0,xmm5
   pmovmskb  ebx,xmm0
   add       ecx,16
   test      bx,bx
   jnz       @Found
   cmp       ecx,edi
   jb        @LoopStart
   add       edi,15
   jmp       @BigNotFound
 @Found :
   sub       ecx,16
   bsf       eax,ebx
   inc       eax
   add       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
   ret
 @BigNotFound :
   //Search the rest - if any
   mov       edi,[edx-4]
   cmp       ecx,edi
   je        @ExitResult0
   sub       edx,1
   lea       esi,[LookUpTable2]
 @BigRepeatBegin :
   add       ecx,1
   movzx     ebx,[edx+ecx]
   movzx     ebx,[esi+ebx]
   cmp       al,bl
   jz        @FoundSmallAfterBig
   cmp       edi,ecx
   ja        @BigRepeatBegin
 @ExitResult0 :
   pop       esi
   pop       ebx
 @AlmostCleanExitResult0 :
   pop       edi
 @CleanExitResult0 :
   xor       eax,eax
   ret
 @FoundSmallAfterBig :
   mov       eax,ecx
   pop       esi
   pop       ebx
   pop       edi
end;

initialization

 Filler1;
 Filler31;
 Filler32;
 Filler33;
 Filler42;
 Filler55;
 Filler56;
 Filler57;
 Filler58;
 Filler59;
 Filler60;
 Filler61;
 Filler62;
 Filler66;
 Filler67;
 Filler68;
 Filler69;
 Filler73;
 Filler74;
 Filler75;
 Filler76;
 Filler77;
 InitializeLookUpTable;
 InitializeLookUpTable2;
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_10_a', @CharPosIEx_DKC_Pas_10_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_10_b', @CharPosIEx_DKC_Pas_10_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_10_c', @CharPosIEx_DKC_Pas_10_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_10_d', @CharPosIEx_DKC_Pas_10_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_13_a', @CharPosIEx_DKC_Pas_13_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_13_b', @CharPosIEx_DKC_Pas_13_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_13_c', @CharPosIEx_DKC_Pas_13_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_13_d', @CharPosIEx_DKC_Pas_13_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_16_a', @CharPosIEx_DKC_Pas_16_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_16_b', @CharPosIEx_DKC_Pas_16_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_16_c', @CharPosIEx_DKC_Pas_16_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_16_d', @CharPosIEx_DKC_Pas_16_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_17_a', @CharPosIEx_DKC_Pas_17_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_17_b', @CharPosIEx_DKC_Pas_17_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_17_c', @CharPosIEx_DKC_Pas_17_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_Pas_17_d', @CharPosIEx_DKC_Pas_17_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_16_a', @CharPosIEx_DKC_IA32_16_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_16_b', @CharPosIEx_DKC_IA32_16_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_16_c', @CharPosIEx_DKC_IA32_16_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_16_d', @CharPosIEx_DKC_IA32_16_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_17_a', @CharPosIEx_DKC_IA32_17_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_17_b', @CharPosIEx_DKC_IA32_17_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_17_c', @CharPosIEx_DKC_IA32_17_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_17_d', @CharPosIEx_DKC_IA32_17_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_20_a', @CharPosIEx_DKC_IA32_20_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_20_b', @CharPosIEx_DKC_IA32_20_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_20_c', @CharPosIEx_DKC_IA32_20_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_20_d', @CharPosIEx_DKC_IA32_20_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_26_a', @CharPosIEx_DKC_IA32_26_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_26_b', @CharPosIEx_DKC_IA32_26_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_26_c', @CharPosIEx_DKC_IA32_26_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_26_d', @CharPosIEx_DKC_IA32_26_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_27_a', @CharPosIEx_DKC_IA32_27_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_27_b', @CharPosIEx_DKC_IA32_27_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_27_c', @CharPosIEx_DKC_IA32_27_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_IA32_27_d', @CharPosIEx_DKC_IA32_27_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_4_a', @CharPosIEx_DKC_MMX_4_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_4_b', @CharPosIEx_DKC_MMX_4_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_4_c', @CharPosIEx_DKC_MMX_4_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_4_d', @CharPosIEx_DKC_MMX_4_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_6_a', @CharPosIEx_DKC_MMX_6_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_6_b', @CharPosIEx_DKC_MMX_6_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_6_c', @CharPosIEx_DKC_MMX_6_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_6_d', @CharPosIEx_DKC_MMX_6_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_8_a', @CharPosIEx_DKC_MMX_8_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_8_b', @CharPosIEx_DKC_MMX_8_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_8_c', @CharPosIEx_DKC_MMX_8_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_MMX_8_d', @CharPosIEx_DKC_MMX_8_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE_1_a', @CharPosIEx_DKC_SSE_1_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE_1_b', @CharPosIEx_DKC_SSE_1_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE_1_c', @CharPosIEx_DKC_SSE_1_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE_1_d', @CharPosIEx_DKC_SSE_1_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_7_a', @CharPosIEx_DKC_SSE2_7_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_7_b', @CharPosIEx_DKC_SSE2_7_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_7_c', @CharPosIEx_DKC_SSE2_7_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_7_d', @CharPosIEx_DKC_SSE2_7_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_8_a', @CharPosIEx_DKC_SSE2_8_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_8_b', @CharPosIEx_DKC_SSE2_8_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_8_c', @CharPosIEx_DKC_SSE2_8_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_8_d', @CharPosIEx_DKC_SSE2_8_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_9_a', @CharPosIEx_DKC_SSE2_9_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_9_b', @CharPosIEx_DKC_SSE2_9_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_9_c', @CharPosIEx_DKC_SSE2_9_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_9_d', @CharPosIEx_DKC_SSE2_9_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_10_a', @CharPosIEx_DKC_SSE2_10_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_10_b', @CharPosIEx_DKC_SSE2_10_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_10_c', @CharPosIEx_DKC_SSE2_10_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE2_10_d', @CharPosIEx_DKC_SSE2_10_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_3_a', @CharPosIEx_DKC_SSE3_3_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_3_b', @CharPosIEx_DKC_SSE3_3_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_3_c', @CharPosIEx_DKC_SSE3_3_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_3_d', @CharPosIEx_DKC_SSE3_3_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_4_a', @CharPosIEx_DKC_SSE3_4_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_4_b', @CharPosIEx_DKC_SSE3_4_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_4_c', @CharPosIEx_DKC_SSE3_4_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_4_d', @CharPosIEx_DKC_SSE3_4_d);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_5_a', @CharPosIEx_DKC_SSE3_5_a);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_5_b', @CharPosIEx_DKC_SSE3_5_b);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_5_c', @CharPosIEx_DKC_SSE3_5_c);
 MainForm.RegisterFunction('CharPosIEx_DKC_SSE3_5_d', @CharPosIEx_DKC_SSE3_5_d);

end.


