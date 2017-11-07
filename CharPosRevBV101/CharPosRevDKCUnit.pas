unit CharPosRevDKCUnit;

interface

implementation

uses
 MainUnit;

//Author:            Dennis Kjaer Christensen
//Date:              23/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_Pas_7_a(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 0);
   Result := CharNo+1;
  end;
end;

function CharPosRev_DKC_Pas_7_b(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 0);
   Result := CharNo+1;
  end;
end;

function CharPosRev_DKC_Pas_7_c(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 0);
   Result := CharNo+1;
  end;
end;

function CharPosRev_DKC_Pas_7_d(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 0);
   Result := CharNo+1;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              24/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_Pas_13_a(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS >= 4 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 4);
   if CharNo >= 0 then
    begin
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end
   else
    Result := CharNo+1;
  end
 else
  begin
   if LengthS > 0 then
    begin
     CharNo := LengthS-1;
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end;
  end;
end;

procedure Filler30;
asm
 nop
end;

function CharPosRev_DKC_Pas_13_b(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS >= 4 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 4);
   if CharNo >= 0 then
    begin
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end
   else
    Result := CharNo+1;
  end
 else
  begin
   if LengthS > 0 then
    begin
     CharNo := LengthS-1;
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end;
  end;
end;

procedure Filler31;
asm
 nop
end;

function CharPosRev_DKC_Pas_13_c(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS >= 4 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 4);
   if CharNo >= 0 then
    begin
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end
   else
    Result := CharNo+1;
  end
 else
  begin
   if LengthS > 0 then
    begin
     CharNo := LengthS-1;
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end;
  end;
end;

procedure Filler32;
asm
 nop
end;

function CharPosRev_DKC_Pas_13_d(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS >= 4 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 4);
   if CharNo >= 0 then
    begin
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end
   else
    Result := CharNo+1;
  end
 else
  begin
   if LengthS > 0 then
    begin
     CharNo := LengthS-1;
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              24/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_Pas_14_a(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS < 4 then
  begin
   if LengthS > 0 then
    begin
     CharNo := LengthS-1;
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end;
  end
 else
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 4);
   if CharNo >= 0 then
    begin
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end
   else
    Result := CharNo+1;
  end;
end;

procedure Filler33;
asm
 nop
end;

function CharPosRev_DKC_Pas_14_b(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS < 4 then
  begin
   if LengthS > 0 then
    begin
     CharNo := LengthS-1;
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end;
  end
 else
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 4);
   if CharNo >= 0 then
    begin
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end
   else
    Result := CharNo+1;
  end;
end;

procedure Filler34;
asm
 nop
end;

function CharPosRev_DKC_Pas_14_c(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS < 4 then
  begin
   if LengthS > 0 then
    begin
     CharNo := LengthS-1;
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end;
  end
 else
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 4);
   if CharNo >= 0 then
    begin
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end
   else
    Result := CharNo+1;
  end;
end;

procedure Filler35;
asm
 nop
end;

function CharPosRev_DKC_Pas_14_d(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS < 4 then
  begin
   if LengthS > 0 then
    begin
     CharNo := LengthS-1;
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end;
  end
 else
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 4);
   if CharNo >= 0 then
    begin
     repeat
      if S[CharNo+1] = SearchChar then
       Break;
      Dec(CharNo);
     until (CharNo < 0);
     Result := CharNo+1;
    end
   else
    Result := CharNo+1;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_Pas_15_a(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if (CharNo < 0) then
     Break;
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if (CharNo < 0) then
     Break;
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 0);
   Result := CharNo+1;
  end;
end;

function CharPosRev_DKC_Pas_15_b(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if (CharNo < 0) then
     Break;
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if (CharNo < 0) then
     Break;
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 0);
   Result := CharNo+1;
  end;
end;

procedure Filler91;
asm
 nop
end;

function CharPosRev_DKC_Pas_15_c(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if (CharNo < 0) then
     Break;
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if (CharNo < 0) then
     Break;
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 0);
   Result := CharNo+1;
  end;
end;

function CharPosRev_DKC_Pas_15_d(SearchChar : Char; const S: string) : Integer;
var
 CharNo, LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   CharNo := LengthS-1;
   repeat
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if (CharNo < 0) then
     Break;
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
    if (CharNo < 0) then
     Break;
    if S[CharNo+1] = SearchChar then
     Break;
    Dec(CharNo);
   until (CharNo < 0);
   Result := CharNo+1;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_Pas_110_a(SearchChar : Char; const S: string) : Integer;
var
 Str, StrStart : PChar;
 LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   StrStart := Pointer(S);
   Str := StrStart + LengthS - 1;//Points to last char in S
   repeat
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
   until (Str < StrStart);
   Result := Str-StrStart+1;
  end;
end;

function CharPosRev_DKC_Pas_110_b(SearchChar : Char; const S: string) : Integer;
var
 Str, StrStart : PChar;
 LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   StrStart := Pointer(S);
   Str := StrStart + LengthS - 1;//Points to last char in S
   repeat
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
   until (Str < StrStart);
   Result := Str-StrStart+1;
  end;
end;

procedure Filler87;
asm
 nop
end;

function CharPosRev_DKC_Pas_110_c(SearchChar : Char; const S: string) : Integer;
var
 Str, StrStart : PChar;
 LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   StrStart := Pointer(S);
   Str := StrStart + LengthS - 1;//Points to last char in S
   repeat
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
   until (Str < StrStart);
   Result := Str-StrStart+1;
  end;
end;

function CharPosRev_DKC_Pas_110_d(SearchChar : Char; const S: string) : Integer;
var
 Str, StrStart : PChar;
 LengthS : Integer;

begin
 Result := 0;
 LengthS := Length(S);
 if LengthS > 0 then
  begin
   StrStart := Pointer(S);
   Str := StrStart + LengthS - 1;//Points to last char in S
   repeat
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
    if (Str < StrStart) then
     Break;
    if Str^ = SearchChar then
     Break;
    Dec(Str);
   until (Str < StrStart);
   Result := Str-StrStart+1;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_IA32_5_a(SearchChar : Char; const S: string) : Integer;
asm
   //LengthS := Length(S);
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   //if LengthS > 0 then
   test ecx,ecx
   jle  @ExitZero
   //CharNo := LengthS-1;
   dec  ecx
 @LoopStart :
   //if S[CharNo+1] = SearchChar then
   cmp  al,[edx+ecx]
   jz   @LoopEnd
   //Dec(CharNo);
   dec  ecx
   //until (CharNo < 0);
   test ecx,ecx
   jnl  @LoopStart
 @LoopEnd :
   //Result := CharNo+1;
   lea  eax,[ecx+$01]
   ret
 @ExitZero :
   //Result := 0;
   xor  eax,eax
end;

procedure Filler13;
asm
 nop
end;

function CharPosRev_DKC_IA32_5_b(SearchChar : Char; const S: string) : Integer;
asm
   //LengthS := Length(S);
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   //if LengthS > 0 then
   test ecx,ecx
   jle  @ExitZero
   //CharNo := LengthS-1;
   dec  ecx
 @LoopStart :
   //if S[CharNo+1] = SearchChar then
   cmp  al,[edx+ecx]
   jz   @LoopEnd
   //Dec(CharNo);
   dec  ecx
   //until (CharNo < 0);
   test ecx,ecx
   jnl  @LoopStart
 @LoopEnd :
   //Result := CharNo+1;
   lea  eax,[ecx+$01]
   ret
 @ExitZero :
   //Result := 0;
   xor  eax,eax
end;

procedure Filler14;
asm
 nop
end;

function CharPosRev_DKC_IA32_5_c(SearchChar : Char; const S: string) : Integer;
asm
   //LengthS := Length(S);
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   //if LengthS > 0 then
   test ecx,ecx
   jle  @ExitZero
   //CharNo := LengthS-1;
   dec  ecx
 @LoopStart :
   //if S[CharNo+1] = SearchChar then
   cmp  al,[edx+ecx]
   jz   @LoopEnd
   //Dec(CharNo);
   dec  ecx
   //until (CharNo < 0);
   test ecx,ecx
   jnl  @LoopStart
 @LoopEnd :
   //Result := CharNo+1;
   lea  eax,[ecx+$01]
   ret
 @ExitZero :
   //Result := 0;
   xor  eax,eax
end;

procedure Filler15;
asm
 nop
end;

function CharPosRev_DKC_IA32_5_d(SearchChar : Char; const S: string) : Integer;
asm
   //LengthS := Length(S);
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   //if LengthS > 0 then
   test ecx,ecx
   jle  @ExitZero
   //CharNo := LengthS-1;
   dec  ecx
 @LoopStart :
   //if S[CharNo+1] = SearchChar then
   cmp  al,[edx+ecx]
   jz   @LoopEnd
   //Dec(CharNo);
   dec  ecx
   //until (CharNo < 0);
   test ecx,ecx
   jnl  @LoopStart
 @LoopEnd :
   //Result := CharNo+1;
   lea  eax,[ecx+$01]
   ret
 @ExitZero :
   //Result := 0;
   xor  eax,eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_IA32_7_a(SearchChar : Char; const S: string) : Integer;
asm
   //LengthS := Length(S);
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   //if LengthS > 0 then
   test ecx,ecx
   jle  @ExitZero
   //CharNo := LengthS-1;
   sub  ecx,1
 @LoopStart :
   //if S[CharNo+1] = SearchChar then
   cmp  al,[edx+ecx]
   jz   @LoopEnd
   //Dec(CharNo);
   sub ecx,1
   //until (CharNo < 0);
   jns  @LoopStart
 @LoopEnd :
   //Result := CharNo+1;
   lea  eax,[ecx+$01]
   ret
 @ExitZero :
   //Result := 0;
   xor  eax,eax
end;

procedure Filler16;
asm
 nop
end;

function CharPosRev_DKC_IA32_7_b(SearchChar : Char; const S: string) : Integer;
asm
   //LengthS := Length(S);
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   //if LengthS > 0 then
   test ecx,ecx
   jle  @ExitZero
   //CharNo := LengthS-1;
   sub  ecx,1
 @LoopStart :
   //if S[CharNo+1] = SearchChar then
   cmp  al,[edx+ecx]
   jz   @LoopEnd
   //Dec(CharNo);
   sub ecx,1
   //until (CharNo < 0);
   jns  @LoopStart
 @LoopEnd :
   //Result := CharNo+1;
   lea  eax,[ecx+$01]
   ret
 @ExitZero :
   //Result := 0;
   xor  eax,eax
end;

procedure Filler17;
asm
 nop
end;

function CharPosRev_DKC_IA32_7_c(SearchChar : Char; const S: string) : Integer;
asm
   //LengthS := Length(S);
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   //if LengthS > 0 then
   test ecx,ecx
   jle  @ExitZero
   //CharNo := LengthS-1;
   sub  ecx,1
 @LoopStart :
   //if S[CharNo+1] = SearchChar then
   cmp  al,[edx+ecx]
   jz   @LoopEnd
   //Dec(CharNo);
   sub ecx,1
   //until (CharNo < 0);
   jns  @LoopStart
 @LoopEnd :
   //Result := CharNo+1;
   lea  eax,[ecx+$01]
   ret
 @ExitZero :
   //Result := 0;
   xor  eax,eax
end;

procedure Filler18;
asm
 nop
end;

function CharPosRev_DKC_IA32_7_d(SearchChar : Char; const S: string) : Integer;
asm
   //LengthS := Length(S);
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   //if LengthS > 0 then
   test ecx,ecx
   jle  @ExitZero
   //CharNo := LengthS-1;
   sub  ecx,1
 @LoopStart :
   //if S[CharNo+1] = SearchChar then
   cmp  al,[edx+ecx]
   jz   @LoopEnd
   //Dec(CharNo);
   sub ecx,1
   //until (CharNo < 0);
   jns  @LoopStart
 @LoopEnd :
   //Result := CharNo+1;
   lea  eax,[ecx+$01]
   ret
 @ExitZero :
   //Result := 0;
   xor  eax,eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_IA32_25_a(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler80;
asm
 nop
end;

function CharPosRev_DKC_IA32_25_b(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler81;
asm
 nop
end;

function CharPosRev_DKC_IA32_25_c(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler82;
asm
 nop
end;

function CharPosRev_DKC_IA32_25_d(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_IA32_26_a(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   sub  ecx,4
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   sub  ecx,4
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler83;
asm
 nop
end;

function CharPosRev_DKC_IA32_26_b(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   sub  ecx,4
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   sub  ecx,4
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler84;
asm
 nop
end;

function CharPosRev_DKC_IA32_26_c(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   sub  ecx,4
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   sub  ecx,4
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler85;
asm
 nop
end;

function CharPosRev_DKC_IA32_26_d(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   sub  ecx,4
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   sub  ecx,4
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @ExitZero :
   xor  eax,eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/11 2006
//Instructionset(s): IA32

function CharPosRev_DKC_IA32_28_a(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler92;
asm
 nop
end;

function CharPosRev_DKC_IA32_28_b(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler93;
asm
 nop
end;

function CharPosRev_DKC_IA32_28_c(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler94;
asm
 nop
end;

function CharPosRev_DKC_IA32_28_d(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 @LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              13/12 2006
//Instructionset(s): IA32

function CharPosRev_DKC_IA32_30_a(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 //@LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   //jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

function CharPosRev_DKC_IA32_30_b(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 //@LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   //jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

procedure Filler113;
asm
 nop
end;

function CharPosRev_DKC_IA32_30_c(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 //@LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   //jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

function CharPosRev_DKC_IA32_30_d(SearchChar : Char; const S: string) : Integer;
asm
   test edx,edx
   jz   @ExitZero
   mov  ecx,[edx-4]
   test ecx,ecx
   jle  @ExitZero
   sub  ecx,1
   cmp  ecx,7
   jae  @Big
 @Small :
 //@LoopStartSmall :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   js   @ExitZero
   cmp  al,[edx+ecx]
   jz   @LoopEndSmall
   sub  ecx,1
   //jns  @LoopStartSmall
 @LoopEndSmall :
   lea  eax,[ecx+$01]
   ret
 @Big :
 @LoopStartBig :
   cmp  al,[edx+ecx]
   jz   @Match1
   cmp  al,[edx+ecx-1]
   jz   @Match2
   cmp  al,[edx+ecx-2]
   jz   @Match3
   cmp  al,[edx+ecx-3]
   jz   @Match4
   cmp  al,[edx+ecx-4]
   jz   @Match5
   cmp  al,[edx+ecx-5]
   jz   @Match6
   cmp  al,[edx+ecx-6]
   jz   @Match7
   cmp  al,[edx+ecx-7]
   jz   @Match8
   sub  ecx,8
   cmp  ecx,8
   jnl  @LoopStartBig
 @LoopEndBig :
   test ecx,ecx
   jl   @ExitZero
 @LoopStartSmallAfterBig :
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   js   @LoopEndSmallAfterBig
   cmp  al,[edx+ecx]
   jz   @LoopEndSmallAfterBig
   sub  ecx,1
   jns  @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
 @Match1 :
   lea  eax,[ecx+$01]
   ret
 @Match2 :
   lea  eax,[ecx]
   ret
 @Match3 :
   lea  eax,[ecx-1]
   ret
 @Match4 :
   lea  eax,[ecx-2]
   ret
 @Match5 :
   lea  eax,[ecx-3]
   ret
 @Match6 :
   lea  eax,[ecx-4]
   ret
 @Match7 :
   lea  eax,[ecx-5]
   ret
 @Match8 :
   lea  eax,[ecx-6]
   ret
 @ExitZero :
   xor  eax,eax
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/11 2006
//Instructionset(s): IA32, MMX

function CharPosRev_DKC_MMX_5_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   shl      eax,8
   mov      al,ah
   shl      eax,8
   mov      al,ah
   movd     mm0,eax
   movq     mm1,mm0
   psllq    mm1,32
   por      mm0,mm1
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   ret//Never get here
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_MMX_5_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   shl      eax,8
   mov      al,ah
   shl      eax,8
   mov      al,ah
   movd     mm0,eax
   movq     mm1,mm0
   psllq    mm1,32
   por      mm0,mm1
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   ret//Never get here
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_MMX_5_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   shl      eax,8
   mov      al,ah
   shl      eax,8
   mov      al,ah
   movd     mm0,eax
   movq     mm1,mm0
   psllq    mm1,32
   por      mm0,mm1
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   ret//Never get here
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_MMX_5_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   shl      eax,8
   mov      al,ah
   shl      eax,8
   mov      al,ah
   movd     mm0,eax
   movq     mm1,mm0
   psllq    mm1,32
   por      mm0,mm1
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   ret//Never get here
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/11 2006
//Instructionset(s): IA32, MMX, SSE

function CharPosRev_DKC_SSE_4_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler78;
asm
 nop
end;

function CharPosRev_DKC_SSE_4_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler79;
asm
 nop
end;

function CharPosRev_DKC_SSE_4_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler86;
asm
 nop
end;

function CharPosRev_DKC_SSE_4_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/11 2006
//Instructionset(s): IA32, MMX, SSE

function CharPosRev_DKC_SSE_5_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,23
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler88;
asm
 nop
end;

function CharPosRev_DKC_SSE_5_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,23
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler89;
asm
 nop
end;

function CharPosRev_DKC_SSE_5_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,23
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler90;
asm
 nop
end;

function CharPosRev_DKC_SSE_5_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,23
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx-7]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx-1]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx-2]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx-3]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx-4]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx-5]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx-6]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/11 2006
//Instructionset(s): IA32, MMX, SSE

function CharPosRev_DKC_SSE_6_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,8
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   add      ecx,7
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+8]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx+7]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx+6]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx+5]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx+4]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx+3]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx+2]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_SSE_6_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,8
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   add      ecx,7
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+8]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx+7]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx+6]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx+5]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx+4]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx+3]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx+2]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_SSE_6_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,8
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   add      ecx,7
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+8]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx+7]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx+6]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx+5]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx+4]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx+3]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx+2]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_SSE_6_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,8
   mov      ah,al
   movd     mm0,eax
   pshufw   mm0,mm0,0
 @LoopStartBig :
   movq     mm1,[edx+ecx]
   pcmpeqb  mm1,mm0
   packsswb mm1,mm1
   movd     ebx,mm1
   test     ebx,ebx
   jnz      @MatchX
   sub      ecx,8
   cmp      ecx,8
   jnl      @LoopStartBig
 @LoopEndBig :
   emms
   add      ecx,7
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   emms
   bsr      ebx,ebx
   cmp      ebx, 31
   je       @Match1
   cmp      ebx, 30
   je       @Match2
   cmp      ebx, 23
   je       @Match3
   cmp      ebx, 22
   je       @Match4
   cmp      ebx, 15
   je       @Match5
   cmp      ebx, 14
   je       @Match6
   cmp      ebx, 7
   je       @Match7
   cmp      ebx, 6
   je       @Match8
   xor      eax,eax //Never get here
   pop      ebx
   ret
 @Match1 :
   lea      eax,[ecx+8]
   pop      ebx
   ret
 @Match2 :
   lea      eax,[ecx+7]
   pop      ebx
   ret
 @Match3 :
   lea      eax,[ecx+6]
   pop      ebx
   ret
 @Match4 :
   lea      eax,[ecx+5]
   pop      ebx
   ret
 @Match5 :
   lea      eax,[ecx+4]
   pop      ebx
   ret
 @Match6 :
   lea      eax,[ecx+3]
   pop      ebx
   ret
 @Match7 :
   lea      eax,[ecx+2]
   pop      ebx
   ret
 @Match8 :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/12 2006
//Instructionset(s): IA32, MMX, SSE, SSE2

function CharPosRev_DKC_SSE2_6_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   movdqu   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx-14]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler100;
asm
 nop
end;

function CharPosRev_DKC_SSE2_6_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   movdqu   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx-14]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler101;
asm
 nop
end;

function CharPosRev_DKC_SSE2_6_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   movdqu   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx-14]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler102;
asm
 nop
end;

function CharPosRev_DKC_SSE2_6_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   movdqu   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx-14]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              11/12 2006
//Instructionset(s): IA32, MMX, SSE, SSE2

function CharPosRev_DKC_SSE2_7_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx-15]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx-14]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

function CharPosRev_DKC_SSE2_7_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx-15]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx-14]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

procedure Filler104;
asm
 nop
end;

function CharPosRev_DKC_SSE2_7_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx-15]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx-14]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

function CharPosRev_DKC_SSE2_7_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   sub      ecx,1
   cmp      ecx,31    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx-15]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx-15]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx-14]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              12/12 2006
//Instructionset(s): IA32, MMX, SSE, SSE2

function CharPosRev_DKC_SSE2_9_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx+1]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

function CharPosRev_DKC_SSE2_9_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx+1]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

procedure Filler106;
asm
 nop
end;

function CharPosRev_DKC_SSE2_9_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx+1]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

function CharPosRev_DKC_SSE2_9_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx+1]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              13/12 2006
//Instructionset(s): IA32, MMX, SSE, SSE2

function CharPosRev_DKC_SSE2_10_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx+1]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

procedure Filler107;
asm
 nop
end;

function CharPosRev_DKC_SSE2_10_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx+1]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

procedure Filler108;
asm
 nop
end;

function CharPosRev_DKC_SSE2_10_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx+1]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

procedure Filler109;
asm
 nop
end;

function CharPosRev_DKC_SSE2_10_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   push     edi
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,32    //need 16 per loop and max 15 for alignment
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      edi
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
   //Load first 16 chars
   movdqu   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   //calculate misalignment
   lea      edi,[edx+ecx]
   and      edi,$F
   //Align
   sub      ecx,edi
 @LoopStartBig :
   movdqa   xmm0,[edx+ecx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   cmp      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      edi
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ecx+ebx+1]
   pop      edi
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      edi
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/12 2006
//Instructionset(s): IA32, MMX, SSE, SSE2, SSE3

function CharPosRev_DKC_SSE3_4_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler98;
asm
 nop
end;

function CharPosRev_DKC_SSE3_4_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler99;
asm
 nop
end;

function CharPosRev_DKC_SSE3_4_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler103;
asm
 nop
end;

function CharPosRev_DKC_SSE3_4_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/12 2006
//Instructionset(s): IA32, MMX, SSE, SSE2, SSE3

function CharPosRev_DKC_SSE3_5_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_SSE3_5_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_SSE3_5_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_SSE3_5_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 @LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 @LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              13/12 2006
//Instructionset(s): IA32, MMX, SSE, SSE2, SSE3

function CharPosRev_DKC_SSE3_7_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 //@LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   //jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   shl      eax,8
   mov      al,ah
   shl      eax,8
   mov      al,ah
   movd     xmm1,eax
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 //@LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   //jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler1;
asm
 nop
end;

function CharPosRev_DKC_SSE3_7_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 //@LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   //jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   shl      eax,8
   mov      al,ah
   shl      eax,8
   mov      al,ah
   movd     xmm1,eax
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 //@LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   //jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler2;
asm
 nop
end;

function CharPosRev_DKC_SSE3_7_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 //@LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   //jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   shl      eax,8
   mov      al,ah
   shl      eax,8
   mov      al,ah
   movd     xmm1,eax
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 //@LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   //jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler3;
asm
 nop
end;

function CharPosRev_DKC_SSE3_7_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
 //@LoopStartSmall :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   //jns      @LoopStartSmall
 @LoopEndSmall :
   lea      eax,[ecx+$01]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   shl      eax,8
   mov      al,ah
   shl      eax,8
   mov      al,ah
   movd     xmm1,eax
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 //@LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   //jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/12 2006
//Instructionset(s): IA32, MMX, SSE, SSE2, SSE3

function CharPosRev_DKC_SSE3_8_a(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
 @LoopEndSmall :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 //@LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   //jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_SSE3_8_b(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
 @LoopEndSmall :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 //@LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   //jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

procedure Filler4;
asm
 nop
end;

function CharPosRev_DKC_SSE3_8_c(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
 @LoopEndSmall :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 //@LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   //jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

function CharPosRev_DKC_SSE3_8_d(SearchChar : Char; const S: string) : Integer;
asm
   push     ebx
   test     edx,edx
   jz       @ExitZero
   mov      ecx,[edx-4]
   test     ecx,ecx
   jle      @ExitZero
   cmp      ecx,16
   jae      @Big
 @Small :
   sub      ecx,1
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
   js       @ExitZero
   cmp      al,[edx+ecx]
   jz       @LoopEndSmall
   sub      ecx,1
 @LoopEndSmall :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @Big :
   sub      ecx,16
   mov      ah,al
   movd     xmm1,eax
   pshuflw  xmm1,xmm1,0
   pshufd   xmm1,xmm1,0
 @LoopStartBig :
   //lddqu xmm0,dqword ptr [ecx+edx]
   db $F2 db $0F db $F0 db $04 db $11
   pcmpeqb  xmm0,xmm1
   pmovmskb ebx,xmm0
   test     bx,bx
   jnz      @MatchX
   sub      ecx,16
   jnl      @LoopStartBig
 @LoopEndBig :
   add      ecx,15
   test     ecx,ecx
   jl       @ExitZero
 //@LoopStartSmallAfterBig :
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   js       @LoopEndSmallAfterBig
   cmp      al,[edx+ecx]
   jz       @LoopEndSmallAfterBig
   sub      ecx,1
   //jns      @LoopStartSmallAfterBig
 @LoopEndSmallAfterBig :
   lea      eax,[ecx+1]
   pop      ebx
   ret
 @MatchX :
   bsr      ebx,ebx
   lea      eax,[ebx+ecx+1]
   pop      ebx
   ret
 @ExitZero :
   xor      eax,eax
   pop      ebx
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler13;
 Filler14;
 Filler15;
 Filler16;
 Filler17;
 Filler18;
 Filler30;
 Filler31;
 Filler32;
 Filler33;
 Filler34;
 Filler35;
 Filler78;
 Filler79;
 Filler80;
 Filler81;
 Filler82;
 Filler83;
 Filler84;
 Filler85;
 Filler86;
 Filler87;
 Filler88;
 Filler89;
 Filler90;
 Filler91;
 Filler92;
 Filler93;
 Filler94;
 Filler98;
 Filler99;
 Filler100;
 Filler101;
 Filler102;
 Filler103;
 Filler104;
 Filler106;
 Filler107;
 Filler108;
 Filler109;
 Filler113;
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_7_a', @CharPosRev_DKC_Pas_7_a);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_7_b', @CharPosRev_DKC_Pas_7_b);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_7_c', @CharPosRev_DKC_Pas_7_c);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_7_d', @CharPosRev_DKC_Pas_7_d);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_13_a', @CharPosRev_DKC_Pas_13_a);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_13_b', @CharPosRev_DKC_Pas_13_b);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_13_c', @CharPosRev_DKC_Pas_13_c);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_13_d', @CharPosRev_DKC_Pas_13_d);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_14_a', @CharPosRev_DKC_Pas_14_a);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_14_b', @CharPosRev_DKC_Pas_14_b);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_14_c', @CharPosRev_DKC_Pas_14_c);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_14_d', @CharPosRev_DKC_Pas_14_d);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_15_a', @CharPosRev_DKC_Pas_15_a);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_15_b', @CharPosRev_DKC_Pas_15_b);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_15_c', @CharPosRev_DKC_Pas_15_c);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_15_d', @CharPosRev_DKC_Pas_15_d);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_110_a', @CharPosRev_DKC_Pas_110_a);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_110_b', @CharPosRev_DKC_Pas_110_b);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_110_c', @CharPosRev_DKC_Pas_110_c);
 MainForm.RegisterFunction('CharPosRev_DKC_Pas_110_d', @CharPosRev_DKC_Pas_110_d);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_5_a', @CharPosRev_DKC_IA32_5_a);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_5_b', @CharPosRev_DKC_IA32_5_b);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_5_c', @CharPosRev_DKC_IA32_5_c);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_5_d', @CharPosRev_DKC_IA32_5_d);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_7_a', @CharPosRev_DKC_IA32_7_a);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_7_b', @CharPosRev_DKC_IA32_7_b);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_7_c', @CharPosRev_DKC_IA32_7_c);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_7_d', @CharPosRev_DKC_IA32_7_d);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_25_a', @CharPosRev_DKC_IA32_25_a);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_25_b', @CharPosRev_DKC_IA32_25_b);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_25_c', @CharPosRev_DKC_IA32_25_c);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_25_d', @CharPosRev_DKC_IA32_25_d);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_26_a', @CharPosRev_DKC_IA32_26_a);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_26_b', @CharPosRev_DKC_IA32_26_b);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_26_c', @CharPosRev_DKC_IA32_26_c);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_26_d', @CharPosRev_DKC_IA32_26_d);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_30_a', @CharPosRev_DKC_IA32_30_a);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_30_b', @CharPosRev_DKC_IA32_30_b);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_30_c', @CharPosRev_DKC_IA32_30_c);
 MainForm.RegisterFunction('CharPosRev_DKC_IA32_30_d', @CharPosRev_DKC_IA32_30_d);
 MainForm.RegisterFunction('CharPosRev_DKC_MMX_5_a', @CharPosRev_DKC_MMX_5_a);
 MainForm.RegisterFunction('CharPosRev_DKC_MMX_5_b', @CharPosRev_DKC_MMX_5_b);
 MainForm.RegisterFunction('CharPosRev_DKC_MMX_5_c', @CharPosRev_DKC_MMX_5_c);
 MainForm.RegisterFunction('CharPosRev_DKC_MMX_5_d', @CharPosRev_DKC_MMX_5_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_4_a', @CharPosRev_DKC_SSE_4_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_4_b', @CharPosRev_DKC_SSE_4_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_4_c', @CharPosRev_DKC_SSE_4_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_4_d', @CharPosRev_DKC_SSE_4_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_5_a', @CharPosRev_DKC_SSE_5_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_5_b', @CharPosRev_DKC_SSE_5_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_5_c', @CharPosRev_DKC_SSE_5_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_5_d', @CharPosRev_DKC_SSE_5_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_6_a', @CharPosRev_DKC_SSE_6_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_6_b', @CharPosRev_DKC_SSE_6_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_6_c', @CharPosRev_DKC_SSE_6_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE_6_d', @CharPosRev_DKC_SSE_6_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_6_a', @CharPosRev_DKC_SSE2_6_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_6_b', @CharPosRev_DKC_SSE2_6_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_6_c', @CharPosRev_DKC_SSE2_6_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_6_d', @CharPosRev_DKC_SSE2_6_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_7_a', @CharPosRev_DKC_SSE2_7_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_7_b', @CharPosRev_DKC_SSE2_7_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_7_c', @CharPosRev_DKC_SSE2_7_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_7_d', @CharPosRev_DKC_SSE2_7_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_10_a', @CharPosRev_DKC_SSE2_10_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_10_b', @CharPosRev_DKC_SSE2_10_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_10_c', @CharPosRev_DKC_SSE2_10_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE2_10_d', @CharPosRev_DKC_SSE2_10_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_4_a', @CharPosRev_DKC_SSE3_4_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_4_b', @CharPosRev_DKC_SSE3_4_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_4_c', @CharPosRev_DKC_SSE3_4_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_4_d', @CharPosRev_DKC_SSE3_4_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_5_a', @CharPosRev_DKC_SSE3_5_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_5_b', @CharPosRev_DKC_SSE3_5_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_5_c', @CharPosRev_DKC_SSE3_5_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_5_d', @CharPosRev_DKC_SSE3_5_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_7_a', @CharPosRev_DKC_SSE3_7_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_7_b', @CharPosRev_DKC_SSE3_7_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_7_c', @CharPosRev_DKC_SSE3_7_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_7_d', @CharPosRev_DKC_SSE3_7_d);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_8_a', @CharPosRev_DKC_SSE3_8_a);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_8_b', @CharPosRev_DKC_SSE3_8_b);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_8_c', @CharPosRev_DKC_SSE3_8_c);
 MainForm.RegisterFunction('CharPosRev_DKC_SSE3_8_d', @CharPosRev_DKC_SSE3_8_d);

end.


