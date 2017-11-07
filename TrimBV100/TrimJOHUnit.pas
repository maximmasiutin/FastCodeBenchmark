unit TrimJOHUnit;

{$R-,Q-}

interface

implementation

uses
  MainUnit;

{117 Bytes}
function Trim_JOH_PAS_1_a(const S: string): string;
var
  L, I: integer;
  Trimmed: Boolean;
begin
  L := Length(S);
  if L > 0 then
    begin
      Trimmed := False;
      I := 1;
      if (S[1] <= ' ') then
        begin {Strip Leading Whitespace}
          repeat
            Inc(I);
            if I > L then
              begin
                Result := ''; {All Whitespace}
                Exit;
              end;
          until (S[I] > ' ');
          Trimmed := True;
        end;
      if (S[L] <= ' ') then
        begin {Strip Trailing Whitespace}
          repeat
            Dec(L);
          until S[L] > ' ';
          Trimmed := True;
        end;
      if Trimmed then
        SetString(Result, PChar(@S[I]), L - I + 1)
      else
        Result := S;
    end
  else
    Result := ''
end;

function Trim_JOH_PAS_1_b(const S: string): string;
var
  L, I: integer;
  Trimmed: Boolean;
begin
  L := Length(S);
  if L > 0 then
    begin
      Trimmed := False;
      I := 1;
      if (S[1] <= ' ') then
        begin {Strip Leading Whitespace}
          repeat
            Inc(I);
            if I > L then
              begin
                Result := ''; {All Whitespace}
                Exit;
              end;
          until (S[I] > ' ');
          Trimmed := True;
        end;
      if (S[L] <= ' ') then
        begin {Strip Trailing Whitespace}
          repeat
            Dec(L);
          until S[L] > ' ';
          Trimmed := True;
        end;
      if Trimmed then
        SetString(Result, PChar(@S[I]), L - I + 1)
      else
        Result := S;
    end
  else
    Result := ''
end;

procedure Filler1;
asm
 nop
end;

function Trim_JOH_PAS_1_c(const S: string): string;
var
  L, I: integer;
  Trimmed: Boolean;
begin
  L := Length(S);
  if L > 0 then
    begin
      Trimmed := False;
      I := 1;
      if (S[1] <= ' ') then
        begin {Strip Leading Whitespace}
          repeat
            Inc(I);
            if I > L then
              begin
                Result := ''; {All Whitespace}
                Exit;
              end;
          until (S[I] > ' ');
          Trimmed := True;
        end;
      if (S[L] <= ' ') then
        begin {Strip Trailing Whitespace}
          repeat
            Dec(L);
          until S[L] > ' ';
          Trimmed := True;
        end;
      if Trimmed then
        SetString(Result, PChar(@S[I]), L - I + 1)
      else
        Result := S;
    end
  else
    Result := ''
end;

function Trim_JOH_PAS_1_d(const S: string): string;
var
  L, I: integer;
  Trimmed: Boolean;
begin
  L := Length(S);
  if L > 0 then
    begin
      Trimmed := False;
      I := 1;
      if (S[1] <= ' ') then
        begin {Strip Leading Whitespace}
          repeat
            Inc(I);
            if I > L then
              begin
                Result := ''; {All Whitespace}
                Exit;
              end;
          until (S[I] > ' ');
          Trimmed := True;
        end;
      if (S[L] <= ' ') then
        begin {Strip Trailing Whitespace}
          repeat
            Dec(L);
          until S[L] > ' ';
          Trimmed := True;
        end;
      if Trimmed then
        SetString(Result, PChar(@S[I]), L - I + 1)
      else
        Result := S;
    end
  else
    Result := ''
end;

{57 Bytes}
function Trim_JOH_IA32_1_a(const S: string): string;
asm
  test eax, eax                  {S = nil?}
  xchg eax, edx
  jz   System.@LStrClr           {Yes, Return Empty String}
  mov  ecx, [edx-4]              {Length(S)}
  cmp  byte ptr [edx], ' '       {S[1] <= ' '?}
  jbe  @@TrimLeft                {Yes, Trim Leading Spaces}
  cmp  byte ptr [edx+ecx-1], ' ' {S[Length(S)] <= ' '?}
  jbe  @@TrimRight               {Yes, Trim Trailing Spaces}
  jmp  System.@LStrLAsg          {No, Result := S}
@@TrimLeft:                      {Strip Leading Whitespace}
  dec  ecx
  jle  System.@LStrClr           {All Whitespace}
  inc  edx
  cmp  byte ptr [edx], ' '
  jbe  @@TrimLeft
@@CheckDone:
  cmp  byte ptr [edx+ecx-1], ' '
  ja   System.@LStrFromPCharLen
@@TrimRight:                     {Strip Trailing Whitespace}
  dec  ecx
  jmp  @@CheckDone
end;

function Trim_JOH_IA32_1_b(const S: string): string;
asm
  test eax, eax                  {S = nil?}
  xchg eax, edx
  jz   System.@LStrClr           {Yes, Return Empty String}
  mov  ecx, [edx-4]              {Length(S)}
  cmp  byte ptr [edx], ' '       {S[1] <= ' '?}
  jbe  @@TrimLeft                {Yes, Trim Leading Spaces}
  cmp  byte ptr [edx+ecx-1], ' ' {S[Length(S)] <= ' '?}
  jbe  @@TrimRight               {Yes, Trim Trailing Spaces}
  jmp  System.@LStrLAsg          {No, Result := S}
@@TrimLeft:                      {Strip Leading Whitespace}
  dec  ecx
  jle  System.@LStrClr           {All Whitespace}
  inc  edx
  cmp  byte ptr [edx], ' '
  jbe  @@TrimLeft
@@CheckDone:
  cmp  byte ptr [edx+ecx-1], ' '
  ja   System.@LStrFromPCharLen
@@TrimRight:                     {Strip Trailing Whitespace}
  dec  ecx
  jmp  @@CheckDone
end;

function Trim_JOH_IA32_1_c(const S: string): string;
asm
  test eax, eax                  {S = nil?}
  xchg eax, edx
  jz   System.@LStrClr           {Yes, Return Empty String}
  mov  ecx, [edx-4]              {Length(S)}
  cmp  byte ptr [edx], ' '       {S[1] <= ' '?}
  jbe  @@TrimLeft                {Yes, Trim Leading Spaces}
  cmp  byte ptr [edx+ecx-1], ' ' {S[Length(S)] <= ' '?}
  jbe  @@TrimRight               {Yes, Trim Trailing Spaces}
  jmp  System.@LStrLAsg          {No, Result := S}
@@TrimLeft:                      {Strip Leading Whitespace}
  dec  ecx
  jle  System.@LStrClr           {All Whitespace}
  inc  edx
  cmp  byte ptr [edx], ' '
  jbe  @@TrimLeft
@@CheckDone:
  cmp  byte ptr [edx+ecx-1], ' '
  ja   System.@LStrFromPCharLen
@@TrimRight:                     {Strip Trailing Whitespace}
  dec  ecx
  jmp  @@CheckDone
end;

function Trim_JOH_IA32_1_d(const S: string): string;
asm
  test eax, eax                  {S = nil?}
  xchg eax, edx
  jz   System.@LStrClr           {Yes, Return Empty String}
  mov  ecx, [edx-4]              {Length(S)}
  cmp  byte ptr [edx], ' '       {S[1] <= ' '?}
  jbe  @@TrimLeft                {Yes, Trim Leading Spaces}
  cmp  byte ptr [edx+ecx-1], ' ' {S[Length(S)] <= ' '?}
  jbe  @@TrimRight               {Yes, Trim Trailing Spaces}
  jmp  System.@LStrLAsg          {No, Result := S}
@@TrimLeft:                      {Strip Leading Whitespace}
  dec  ecx
  jle  System.@LStrClr           {All Whitespace}
  inc  edx
  cmp  byte ptr [edx], ' '
  jbe  @@TrimLeft
@@CheckDone:
  cmp  byte ptr [edx+ecx-1], ' '
  ja   System.@LStrFromPCharLen
@@TrimRight:                     {Strip Trailing Whitespace}
  dec  ecx
  jmp  @@CheckDone
end;

{53 Bytes}
function Trim_JOH_IA32_2_a(const S: string): string;
asm
  test eax, eax                  {S = nil?}
  xchg eax, edx
  jz   @@CheckNil                {Yes, Return Empty String}
  mov  ecx, [edx-4]              {Length(S)}
  cmp  byte ptr [edx], ' '       {S[1] <= ' '?}
  jbe  @@TrimLeft                {Yes, Trim Leading Spaces}
  cmp  byte ptr [edx+ecx-1], ' ' {S[Length(S)] <= ' '?}
  jbe  @@TrimRight               {Yes, Trim Trailing Spaces}
  jmp  System.@LStrLAsg          {No, Result := S}
@@TrimLeft:                      {Strip Leading Whitespace}
  dec  ecx
@@CheckNil:
  jle  System.@LStrClr           {S = Nil or All Whitespace}
  inc  edx
  cmp  byte ptr [edx], ' '
  jbe  @@TrimLeft
@@CheckDone:
  cmp  byte ptr [edx+ecx-1], ' '
  ja   System.@LStrFromPCharLen
@@TrimRight:                     {Strip Trailing Whitespace}
  dec  ecx
  jmp  @@CheckDone
end;

function Trim_JOH_IA32_2_b(const S: string): string;
asm
  test eax, eax                  {S = nil?}
  xchg eax, edx
  jz   @@CheckNil                {Yes, Return Empty String}
  mov  ecx, [edx-4]              {Length(S)}
  cmp  byte ptr [edx], ' '       {S[1] <= ' '?}
  jbe  @@TrimLeft                {Yes, Trim Leading Spaces}
  cmp  byte ptr [edx+ecx-1], ' ' {S[Length(S)] <= ' '?}
  jbe  @@TrimRight               {Yes, Trim Trailing Spaces}
  jmp  System.@LStrLAsg          {No, Result := S}
@@TrimLeft:                      {Strip Leading Whitespace}
  dec  ecx
@@CheckNil:
  jle  System.@LStrClr           {S = Nil or All Whitespace}
  inc  edx
  cmp  byte ptr [edx], ' '
  jbe  @@TrimLeft
@@CheckDone:
  cmp  byte ptr [edx+ecx-1], ' '
  ja   System.@LStrFromPCharLen
@@TrimRight:                     {Strip Trailing Whitespace}
  dec  ecx
  jmp  @@CheckDone
end;

procedure Filler2;
asm
 nop
end;

function Trim_JOH_IA32_2_c(const S: string): string;
asm
  test eax, eax                  {S = nil?}
  xchg eax, edx
  jz   @@CheckNil                {Yes, Return Empty String}
  mov  ecx, [edx-4]              {Length(S)}
  cmp  byte ptr [edx], ' '       {S[1] <= ' '?}
  jbe  @@TrimLeft                {Yes, Trim Leading Spaces}
  cmp  byte ptr [edx+ecx-1], ' ' {S[Length(S)] <= ' '?}
  jbe  @@TrimRight               {Yes, Trim Trailing Spaces}
  jmp  System.@LStrLAsg          {No, Result := S}
@@TrimLeft:                      {Strip Leading Whitespace}
  dec  ecx
@@CheckNil:
  jle  System.@LStrClr           {S = Nil or All Whitespace}
  inc  edx
  cmp  byte ptr [edx], ' '
  jbe  @@TrimLeft
@@CheckDone:
  cmp  byte ptr [edx+ecx-1], ' '
  ja   System.@LStrFromPCharLen
@@TrimRight:                     {Strip Trailing Whitespace}
  dec  ecx
  jmp  @@CheckDone
end;

function Trim_JOH_IA32_2_d(const S: string): string;
asm
  test eax, eax                  {S = nil?}
  xchg eax, edx
  jz   @@CheckNil                {Yes, Return Empty String}
  mov  ecx, [edx-4]              {Length(S)}
  cmp  byte ptr [edx], ' '       {S[1] <= ' '?}
  jbe  @@TrimLeft                {Yes, Trim Leading Spaces}
  cmp  byte ptr [edx+ecx-1], ' ' {S[Length(S)] <= ' '?}
  jbe  @@TrimRight               {Yes, Trim Trailing Spaces}
  jmp  System.@LStrLAsg          {No, Result := S}
@@TrimLeft:                      {Strip Leading Whitespace}
  dec  ecx
@@CheckNil:
  jle  System.@LStrClr           {S = Nil or All Whitespace}
  inc  edx
  cmp  byte ptr [edx], ' '
  jbe  @@TrimLeft
@@CheckDone:
  cmp  byte ptr [edx+ecx-1], ' '
  ja   System.@LStrFromPCharLen
@@TrimRight:                     {Strip Trailing Whitespace}
  dec  ecx
  jmp  @@CheckDone
end;

initialization
  Filler1;
  Filler2;

  MainForm.RegisterFunction('Trim_JOH_PAS_1_a', @Trim_JOH_PAS_1_a);
  MainForm.RegisterFunction('Trim_JOH_PAS_1_b', @Trim_JOH_PAS_1_b);
  MainForm.RegisterFunction('Trim_JOH_PAS_1_c', @Trim_JOH_PAS_1_c);
  MainForm.RegisterFunction('Trim_JOH_PAS_1_d', @Trim_JOH_PAS_1_d);

  MainForm.RegisterFunction('Trim_JOH_IA32_1_a', @Trim_JOH_IA32_1_a);
  MainForm.RegisterFunction('Trim_JOH_IA32_1_b', @Trim_JOH_IA32_1_b);
  MainForm.RegisterFunction('Trim_JOH_IA32_1_c', @Trim_JOH_IA32_1_c);
  MainForm.RegisterFunction('Trim_JOH_IA32_1_d', @Trim_JOH_IA32_1_d);

  MainForm.RegisterFunction('Trim_JOH_IA32_2_a', @Trim_JOH_IA32_2_a);
  MainForm.RegisterFunction('Trim_JOH_IA32_2_b', @Trim_JOH_IA32_2_b);
  MainForm.RegisterFunction('Trim_JOH_IA32_2_c', @Trim_JOH_IA32_2_c);
  MainForm.RegisterFunction('Trim_JOH_IA32_2_d', @Trim_JOH_IA32_2_d);
end.
