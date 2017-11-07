unit HVStringReplace;

interface

// Enable to get MCBS support
{.$DEFINE MBCS}

uses SysUtils;

function StringReplace_HV_IA32_1(const Source, OldPattern: string; const NewPattern: string; Flags: TReplaceFlags): string;

implementation

uses Windows;

function StrLPos(const Str1, Str2: PChar; Len1, Len2: integer): PChar;
// EAX = Str1, EDX = Str2, ECX = Len1,
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        OR      EAX,EAX
        JE      @@2
        MOV     ESI, Len2
        INC     ECX
        OR      EDX,EDX
        JE      @@2
        OR      ESI, ESI
        JE      @@2
        SUB     ECX, ESI
        JBE     @@2
        MOV     EDI,EAX
        LEA     EBX,[ESI-1]
        MOV     ESI,EDX
@@1:
        LODSB
        REPNE   SCASB
        MOV     EAX,ECX
        JNE     @@2
        PUSH    EDI
        MOV     ECX,EBX
        REPE    CMPSB
        POP     EDI
        MOV     ECX,EAX
        MOV     ESI,EDX
        JNE     @@1
        LEA     EAX,[EDI-1]
        JMP     @@3
@@2:    XOR     EAX,EAX
@@3:    POP     EBX
        POP     ESI
        POP     EDI
end;

function StrLScan(const Str: PChar; Chr: Char; Len: integer): PChar;
// EAX = Str, DL=Chr, ECX = Len
asm
        PUSH    EDI
        MOV     EDI, EAX
//        INC     ECX
        MOV     AL,Chr
        REPNE   SCASB
        MOV     EAX,0
        JNE     @@1
        MOV     EAX, EDI
        DEC     EAX
@@1:    POP     EDI
end;

function AnsiStrLenPos(Str, SubStr: PChar; L1, L2: Cardinal): PChar;
{$IFDEF MBCS}
var
  ByteType : TMbcsByteType;
{$ENDIF}
begin
  if (L2 > L1) or (L1 = 0) then Result := nil
  else
  if L2 = 1
  then Result := StrLScan(Str, SubStr^, L1)
  else Result := StrLPos(Str, SubStr, L1, L2);
{$IFDEF MBCS}
  if SysLocale.FarEast then
    while (Result <> nil) do
    begin
      ByteType := StrByteType(Str, Integer(Result-Str));
      if (ByteType <> mbTrailByte) and
        (CompareString(LOCALE_USER_DEFAULT, 0, Result, L2, SubStr, L2) = 2) then Exit;
      if (ByteType = mbLeadByte) then Inc(Result);
      Inc(Result);
      if L2 = 1
      then Result := StrLScan(Result, SubStr^, L1)
      else Result := StrLPos(Result, SubStr, L1, L2);
    end;
{$ENDIF}
end;

function AnsiStrPos(Str, SubStr: PChar): PChar;
begin
  Result := AnsiStrLenPos(Str, SubStr, StrLen(Str), StrLen(SubStr));
end;
{$Q-}
{$R-}
function StringReplace_HV_IA32_1(const Source, OldPattern: string; const NewPattern: string; Flags: TReplaceFlags): string;
const
  MaxStringLength = MaxInt - (16 * 1024) - 16;
var
  MaxResultLen    : Int64;
  LengthSource    : integer;
  LengthOldPattern: integer;
  LengthNewPattern: integer;
  PSource         : PChar;
  PWorkSource     : PChar;
  POldPattern     : PChar;
  PNewPattern     : PChar;
  Match           : PChar;
  PrevP           : PChar;
  PResult         : PChar;
  CopyFrom        : PChar;
  WorkSource      : string;
  WorkOldPattern  : string;
  CopyLen         : integer;
begin
  // Uppercase source and old pattern to ignore case
  WorkSource     := Source;
  WorkOldPattern := OldPattern;
  if rfIgnoreCase in Flags then
  begin
    WorkSource     := AnsiUpperCase(Source);
    WorkOldPattern := AnsiUpperCase(OldPattern);
  end;
  // Cache string length and PChar pointers
  LengthSource     := Length(WorkSource);
  if LengthSource = 0 then
  begin
    Result := '';
    Exit;
  end;
  LengthOldPattern := Length(WorkOldPattern);
  LengthNewPattern := Length(NewPattern);
  PSource          := PChar(Source);
  PWorkSource     := PChar(WorkSource);
  POldPattern      := PChar(WorkOldPattern);
  PNewPattern      := PChar(NewPattern);
  // Initialize current and previous search pointers
  Match := PWorkSource;
  PrevP := PWorkSource;
  // Try to find the first match
  Match := AnsiStrLenPos(Match, POldPattern, LengthSource, LengthOldPattern);
  // No match? Return the WorkSource string
  if Match = nil then
  begin
    Result := Source;
    Exit;
  end;
  // Now calculate the worst-case length of the result string
  if LengthNewPattern > LengthOldPattern then
  begin
    MaxResultLen := LengthSource + ((LengthSource - Integer(Match - PrevP)) div LengthOldPattern) * (LengthNewPattern-LengthOldPattern);
    if (MaxResultLen <= 0) or (MaxResultLen > MaxStringLength) then
      MaxResultLen := LengthSource * 3;
  end
  else
    MaxResultLen := LengthSource;
  // Pre-allocate the result string buffer
  SetLength(Result, MaxResultLen);
  PResult :=  PChar(Result);
  // Loop while we're matching
  while Match <> nil do
  begin
    // Copy over the non-matching part from source
    CopyLen := Integer(Match - PrevP);
    if CopyLen > 0 then
    begin
      CopyFrom := @PSource[Integer(PrevP- PWorkSource)];
      repeat
        PResult^ := CopyFrom^;
        Dec(CopyLen);
        Inc(CopyFrom);
        Inc(PResult);
      until CopyLen = 0;
    end;
    // Copy over the new pattern
    CopyLen := LengthNewPattern;
    if CopyLen > 0 then
    begin
      CopyFrom := PNewPattern;
      repeat
        PResult^ := CopyFrom^;
        Dec(CopyLen);
        Inc(CopyFrom);
        Inc(PResult);
      until CopyLen = 0;
    end;
    // Re-adjust pointers
    Inc(Match, LengthOldPattern);
    PrevP := Match;
    // Stop if not replaceing all
    CopyLen := LengthSource - Integer(Match - PWorkSource);
    if not (rfReplaceAll in Flags) or  (CopyLen < LengthOldPattern) then Break;
    // Find next match
    Match := AnsiStrLenPos(Match, POldPattern, CopyLen, LengthOldPattern);
  end;
  // Copy over the rest of the source string
  CopyLen := LengthSource - Integer(PrevP-PWorkSource);
  if CopyLen > 0 then
  begin
    CopyFrom := @PSource[Integer(PrevP-PWorkSource)];
    repeat
      PResult^ := CopyFrom^;
      Dec(CopyLen);
      Inc(CopyFrom);
      Inc(PResult);
    until CopyLen = 0;
  end;
  // Adjust the final length
  SetLength(Result, Integer(PResult - PChar(Result)));
end;

end.
