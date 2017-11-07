unit CharPosUnit;

interface

function CharPos_PERL_IA32_1_a(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_PERL_IA32_1_b(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_PERL_IA32_1_c(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_PERL_IA32_1_d(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DD_Pas_1_a(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DD_Pas_1_b(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DD_Pas_1_c(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_DD_Pas_1_d(Chr : Char; const Str : AnsiString) : Integer;
function CharPos_Mw_PAS_2_a(Ch: Char; const Str: AnsiString): Integer;
function CharPos_Mw_PAS_2_b(Ch: Char; const Str: AnsiString): Integer;
function CharPos_Mw_PAS_2_c(Ch: Char; const Str: AnsiString): Integer;
function CharPos_Mw_PAS_2_d(Ch: Char; const Str: AnsiString): Integer;

implementation

function CharPos_DD_Pas_1_a(Chr : Char; const Str : AnsiString) : Integer;
var
 StrLenght : Integer;
 I : Integer;
begin
{If Range Checking is Turned On, Turn it Off}
{$UNDEF RangeCheck}
{$IFOPT R+}
  {$RANGECHECKS OFF}
  {$DEFINE RangeCheck}
{$ENDIF}
 StrLenght := Length(Str);
 Result := 0;
 if StrLenght > 0 then
 begin
   I := -3;
   repeat
     Inc(I,4);
   until((I >= Integer(StrLenght))or(Str[I] = Chr)or(Str[I+1] =
Chr)or(Str[I+2] =
          Chr)or(Str[I+3] = Chr));
   if Str[I] = Chr then
     Result := I
   else if Str[I+1] = Chr then
     Result := I+1
   else if Str[I+2] = Chr then
     Result := I+2
   else if Str[I+3] = Chr then
     Result := I+3;
   if Result > StrLenght then
     Result := 0;
 end
{If Range Checking was Turned Off, Turn it On Again}
{$IFDEF RangeCheck}
  {$RANGECHECKS ON}
  {$UNDEF RangeCheck}
{$ENDIF}
end;

procedure Filler1;
asm
 nop
end;

function CharPos_DD_Pas_1_b(Chr : Char; const Str : AnsiString) : Integer;
var
 StrLenght : Integer;
 I : Integer;
begin
{If Range Checking is Turned On, Turn it Off}
{$UNDEF RangeCheck}
{$IFOPT R+}
  {$RANGECHECKS OFF}
  {$DEFINE RangeCheck}
{$ENDIF}
 StrLenght := Length(Str);
 Result := 0;
 if StrLenght > 0 then
 begin
   I := -3;
   repeat
     Inc(I,4);
   until((I >= Integer(StrLenght))or(Str[I] = Chr)or(Str[I+1] =
Chr)or(Str[I+2] =
          Chr)or(Str[I+3] = Chr));
   if Str[I] = Chr then
     Result := I
   else if Str[I+1] = Chr then
     Result := I+1
   else if Str[I+2] = Chr then
     Result := I+2
   else if Str[I+3] = Chr then
     Result := I+3;
   if Result > StrLenght then
     Result := 0;
 end
{If Range Checking was Turned Off, Turn it On Again}
{$IFDEF RangeCheck}
  {$RANGECHECKS ON}
  {$UNDEF RangeCheck}
{$ENDIF}
end;

procedure Filler2;
asm
 nop
 nop
end;

function CharPos_DD_Pas_1_c(Chr : Char; const Str : AnsiString) : Integer;
var
 StrLenght : Integer;
 I : Integer;
begin
{If Range Checking is Turned On, Turn it Off}
{$UNDEF RangeCheck}
{$IFOPT R+}
  {$RANGECHECKS OFF}
  {$DEFINE RangeCheck}
{$ENDIF}
 StrLenght := Length(Str);
 Result := 0;
 if StrLenght > 0 then
 begin
   I := -3;
   repeat
     Inc(I,4);
   until((I >= Integer(StrLenght))or(Str[I] = Chr)or(Str[I+1] =
Chr)or(Str[I+2] =
          Chr)or(Str[I+3] = Chr));
   if Str[I] = Chr then
     Result := I
   else if Str[I+1] = Chr then
     Result := I+1
   else if Str[I+2] = Chr then
     Result := I+2
   else if Str[I+3] = Chr then
     Result := I+3;
   if Result > StrLenght then
     Result := 0;
 end
{If Range Checking was Turned Off, Turn it On Again}
{$IFDEF RangeCheck}
  {$RANGECHECKS ON}
  {$UNDEF RangeCheck}
{$ENDIF}
end;

procedure Filler3;
asm
 nop
 nop
 nop
end;

function CharPos_DD_Pas_1_d(Chr : Char; const Str : AnsiString) : Integer;
var
 StrLenght : Integer;
 I : Integer;
begin
{If Range Checking is Turned On, Turn it Off}
{$UNDEF RangeCheck}
{$IFOPT R+}
  {$RANGECHECKS OFF}
  {$DEFINE RangeCheck}
{$ENDIF}
 StrLenght := Length(Str);
 Result := 0;
 if StrLenght > 0 then
 begin
   I := -3;
   repeat
     Inc(I,4);
   until((I >= Integer(StrLenght))or(Str[I] = Chr)or(Str[I+1] =
Chr)or(Str[I+2] =
          Chr)or(Str[I+3] = Chr));
   if Str[I] = Chr then
     Result := I
   else if Str[I+1] = Chr then
     Result := I+1
   else if Str[I+2] = Chr then
     Result := I+2
   else if Str[I+3] = Chr then
     Result := I+3;
   if Result > StrLenght then
     Result := 0;
 end
{If Range Checking was Turned Off, Turn it On Again}
{$IFDEF RangeCheck}
  {$RANGECHECKS ON}
  {$UNDEF RangeCheck}
{$ENDIF}
end;

function CharPos_PERL_IA32_1_a(Chr : Char; const Str : AnsiString) : Integer;
asm
  push ebx
  mov ecx, eax
  mov ebx, edx
  mov eax, edx
  test eax, eax
  jz @@3
  mov eax, [eax-04h]
  test eax, eax
  jbe @@3
@@1:
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jz @@3
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jnz @@1
  jmp @@3
@@2:
  sub edx, ebx
  inc edx
  mov eax, edx
@@3:
  pop ebx
end;

function CharPos_PERL_IA32_1_b(Chr : Char; const Str : AnsiString) : Integer;
asm
  push ebx
  mov ecx, eax
  mov ebx, edx
  mov eax, edx
  test eax, eax
  jz @@3
  mov eax, [eax-04h]
  test eax, eax
  jbe @@3
@@1:
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jz @@3
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jnz @@1
  jmp @@3
@@2:
  sub edx, ebx
  inc edx
  mov eax, edx
@@3:
  pop ebx
end;

function CharPos_PERL_IA32_1_c(Chr : Char; const Str : AnsiString) : Integer;
asm
  push ebx
  mov ecx, eax
  mov ebx, edx
  mov eax, edx
  test eax, eax
  jz @@3
  mov eax, [eax-04h]
  test eax, eax
  jbe @@3
@@1:
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jz @@3
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jnz @@1
  jmp @@3
@@2:
  sub edx, ebx
  inc edx
  mov eax, edx
@@3:
  pop ebx
end;

function CharPos_PERL_IA32_1_d(Chr : Char; const Str : AnsiString) : Integer;
asm
  push ebx
  mov ecx, eax
  mov ebx, edx
  mov eax, edx
  test eax, eax
  jz @@3
  mov eax, [eax-04h]
  test eax, eax
  jbe @@3
@@1:
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jz @@3
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jnz @@1
  jmp @@3
@@2:
  sub edx, ebx
  inc edx
  mov eax, edx
@@3:
  pop ebx
end;

function CharPos_Mw_PAS_2_a(Ch: Char; const Str: AnsiString): Integer;
var
   P0, P1, P2: PChar;
label Failed;
begin
   P0 := Pointer(Str);
   P1 := P0;
   P2 := P0 + Length(Str);
   while (P1 < P2) do
     if Ch = P1^ then
     begin
       inc(P1, 1);
       Result := P1 - P0;
       Exit;
     end else
       if Ch = P1[1] then
       begin
         inc(P1, 2);
         if P1 > P2 then goto Failed;
         Result := P1 - P0;
         Exit;
       end else
         if Ch = P1[2] then
         begin
           inc(P1, 3);
           if P1 > P2 then goto Failed;
           Result := P1 - P0;
           Exit;
         end else
           if Ch = P1[3] then
           begin
             inc(P1, 4);
             if P1 > P2 then goto Failed;
             Result := P1 - P0;
             Exit;
           end else
             inc(P1, 4);
   Failed:
   Result := 0;
end;

function CharPos_Mw_PAS_2_b(Ch: Char; const Str: AnsiString): Integer;
var
   P0, P1, P2: PChar;
label Failed;
begin
   P0 := Pointer(Str);
   P1 := P0;
   P2 := P0 + Length(Str);
   while (P1 < P2) do
     if Ch = P1^ then
     begin
       inc(P1, 1);
       Result := P1 - P0;
       Exit;
     end else
       if Ch = P1[1] then
       begin
         inc(P1, 2);
         if P1 > P2 then goto Failed;
         Result := P1 - P0;
         Exit;
       end else
         if Ch = P1[2] then
         begin
           inc(P1, 3);
           if P1 > P2 then goto Failed;
           Result := P1 - P0;
           Exit;
         end else
           if Ch = P1[3] then
           begin
             inc(P1, 4);
             if P1 > P2 then goto Failed;
             Result := P1 - P0;
             Exit;
           end else
             inc(P1, 4);
   Failed:
   Result := 0;
end;

procedure Filler4;
asm
 nop
end;

function CharPos_Mw_PAS_2_c(Ch: Char; const Str: AnsiString): Integer;
var
   P0, P1, P2: PChar;
label Failed;
begin
   P0 := Pointer(Str);
   P1 := P0;
   P2 := P0 + Length(Str);
   while (P1 < P2) do
     if Ch = P1^ then
     begin
       inc(P1, 1);
       Result := P1 - P0;
       Exit;
     end else
       if Ch = P1[1] then
       begin
         inc(P1, 2);
         if P1 > P2 then goto Failed;
         Result := P1 - P0;
         Exit;
       end else
         if Ch = P1[2] then
         begin
           inc(P1, 3);
           if P1 > P2 then goto Failed;
           Result := P1 - P0;
           Exit;
         end else
           if Ch = P1[3] then
           begin
             inc(P1, 4);
             if P1 > P2 then goto Failed;
             Result := P1 - P0;
             Exit;
           end else
             inc(P1, 4);
   Failed:
   Result := 0;
end;

function CharPos_Mw_PAS_2_d(Ch: Char; const Str: AnsiString): Integer;
var
   P0, P1, P2: PChar;
label Failed;
begin
   P0 := Pointer(Str);
   P1 := P0;
   P2 := P0 + Length(Str);
   while (P1 < P2) do
     if Ch = P1^ then
     begin
       inc(P1, 1);
       Result := P1 - P0;
       Exit;
     end else
       if Ch = P1[1] then
       begin
         inc(P1, 2);
         if P1 > P2 then goto Failed;
         Result := P1 - P0;
         Exit;
       end else
         if Ch = P1[2] then
         begin
           inc(P1, 3);
           if P1 > P2 then goto Failed;
           Result := P1 - P0;
           Exit;
         end else
           if Ch = P1[3] then
           begin
             inc(P1, 4);
             if P1 > P2 then goto Failed;
             Result := P1 - P0;
             Exit;
           end else
             inc(P1, 4);
   Failed:
   Result := 0;
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;

end.
