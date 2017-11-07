unit StrToInt32DKCUnit;

interface

implementation

uses
 MainUnit, SysUtils, Math, SysConst;

var
 LookUpTable : array[0..255] of Char;

procedure InitializeLookUpTable;
var
 I : Byte;

begin
 for I := 0 to 255 do
  begin
   if (Char(I) >= 'a') and (Char(I) <= 'z') then
    LookUpTable[I] := Char(I - 32)
   else
    LookUpTable[I] := Char(I);
  end;
end;

procedure RaiseConvertError2(S : AnsiString);
begin
 raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

//Author:            Dennis Kjaer Christensen
//Date:              13/11 2006
//Instructionset(s): IA32
//Reads zero terminator which causes a range check error
//Negative Hex numbers writtens $F1234567 gets converted by letting the result
//wrap around. To enable this overflow checking must be off

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_24_a(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   repeat
    if Result > (High(Result) div 16) then
     begin
      if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
             ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
             ((s[Ibegin] = '8')   or (s[Ibegin] = '9'))) then
       begin
        raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    case s[I] of
     '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
     'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
     'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    end;
    Inc(I);
   until (s[I] = #0);
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   if not Negative then
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if ('8' <= S[I]) and (S[I] <= '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
      if ('0' <= S[I]) and (S[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (S[I] = #0);
    end
   else
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if (s[I] = '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
      if ('0' <= s[I]) and (s[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (s[I] = #0);
    end;
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

procedure Filler1;
asm
 nop
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_24_b(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   repeat
    if Result > (High(Result) div 16) then
     begin
      if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
             ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
             ((s[Ibegin] = '8')   or (s[Ibegin] = '9'))) then
       begin
        raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    case s[I] of
     '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
     'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
     'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    end;
    Inc(I);
   until (s[I] = #0);
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   if not Negative then
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if ('8' <= S[I]) and (S[I] <= '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
      if ('0' <= S[I]) and (S[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (S[I] = #0);
    end
   else
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if (s[I] = '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
      if ('0' <= s[I]) and (s[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (s[I] = #0);
    end;
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

procedure Filler2;
asm
 nop
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_24_c(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   repeat
    if Result > (High(Result) div 16) then
     begin
      if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
             ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
             ((s[Ibegin] = '8')   or (s[Ibegin] = '9'))) then
       begin
        raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    case s[I] of
     '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
     'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
     'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    end;
    Inc(I);
   until (s[I] = #0);
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   if not Negative then
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if ('8' <= S[I]) and (S[I] <= '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
      if ('0' <= S[I]) and (S[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (S[I] = #0);
    end
   else
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if (s[I] = '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
      if ('0' <= s[I]) and (s[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (s[I] = #0);
    end;
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

procedure Filler3;
asm
 nop
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_24_d(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   repeat
    if Result > (High(Result) div 16) then
     begin
      if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
             ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
             ((s[Ibegin] = '8')   or (s[Ibegin] = '9'))) then
       begin
        raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    case s[I] of
     '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
     'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
     'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    end;
    Inc(I);
   until (s[I] = #0);
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   if not Negative then
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if ('8' <= S[I]) and (S[I] <= '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
      if ('0' <= S[I]) and (S[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (S[I] = #0);
    end
   else
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if (s[I] = '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
      if ('0' <= s[I]) and (s[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (s[I] = #0);
    end;
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              14/11 2006
//Instructionset(s): IA32
//Reads zero terminator which causes a range check error
//Negative Hex numbers writtens $F1234567 gets converted by letting the result
//wrap around. To enable this overflow checking must be off

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_25_a(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   repeat
    if Result > (High(Result) div 16) then
     begin
      if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
             ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
             ((s[Ibegin] = '8')   or (s[Ibegin] = '9'))) then
       begin
        raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    case s[I] of
     '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
     'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
     'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    end;
    Inc(I);
   until (s[I] = #0);
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   repeat
    if Result > (High(Result) div 10) then
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
    else if Result = (High(Result) div 10) then
     begin
      if Negative then
       begin
        if (s[I] = '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
       end
      else
       begin
        if ('8' <= S[I]) and (S[I] <= '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    if ('0' <= S[I]) and (S[I] <= '9') then
     Result := Result * 10 - Ord('0') + Ord(s[I])
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    Inc(I);
   until (S[I] = #0);
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_25_b(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   repeat
    if Result > (High(Result) div 16) then
     begin
      if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
             ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
             ((s[Ibegin] = '8')   or (s[Ibegin] = '9'))) then
       begin
        raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    case s[I] of
     '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
     'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
     'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    end;
    Inc(I);
   until (s[I] = #0);
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   repeat
    if Result > (High(Result) div 10) then
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
    else if Result = (High(Result) div 10) then
     begin
      if Negative then
       begin
        if (s[I] = '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
       end
      else
       begin
        if ('8' <= S[I]) and (S[I] <= '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    if ('0' <= S[I]) and (S[I] <= '9') then
     Result := Result * 10 - Ord('0') + Ord(s[I])
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    Inc(I);
   until (S[I] = #0);
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_25_c(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   repeat
    if Result > (High(Result) div 16) then
     begin
      if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
             ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
             ((s[Ibegin] = '8')   or (s[Ibegin] = '9'))) then
       begin
        raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    case s[I] of
     '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
     'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
     'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    end;
    Inc(I);
   until (s[I] = #0);
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   repeat
    if Result > (High(Result) div 10) then
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
    else if Result = (High(Result) div 10) then
     begin
      if Negative then
       begin
        if (s[I] = '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
       end
      else
       begin
        if ('8' <= S[I]) and (S[I] <= '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    if ('0' <= S[I]) and (S[I] <= '9') then
     Result := Result * 10 - Ord('0') + Ord(s[I])
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    Inc(I);
   until (S[I] = #0);
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_25_d(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   repeat
    if Result > (High(Result) div 16) then
     begin
      if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
             ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
             ((s[Ibegin] = '8')   or (s[Ibegin] = '9'))) then
       begin
        raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    case s[I] of
     '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
     'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
     'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    end;
    Inc(I);
   until (s[I] = #0);
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   repeat
    if Result > (High(Result) div 10) then
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
    else if Result = (High(Result) div 10) then
     begin
      if Negative then
       begin
        if (s[I] = '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
       end
      else
       begin
        if ('8' <= S[I]) and (S[I] <= '9') then
         raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
       end;
     end;
    if ('0' <= S[I]) and (S[I] <= '9') then
     Result := Result * 10 - Ord('0') + Ord(s[I])
    else
     raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
    Inc(I);
   until (S[I] = #0);
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              17/11 2006
//Instructionset(s): IA32
//Reads zero terminator which causes a range check error
//Negative Hex numbers writtens $F1234567 gets converted by letting the result
//wrap around. To enable this overflow checking must be off

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_26_a(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   case s[I] of
    '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
    'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
    'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
   else
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   end;
   Inc(I);
   if S[I] <> #0 then
    begin
     repeat
      if Result > (High(Result) div 16) then
       begin
        if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
               ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
               ((s[Ibegin]  = '8')  or (s[Ibegin]  = '9'))) then
         begin
          raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
         end;
       end;
      case s[I] of
       '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
       'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
       'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      end;
      Inc(I);
     until (s[I] = #0);
    end;
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   if ('0' <= S[I]) and (S[I] <= '9') then
    Result := Result * 10 - Ord('0') + Ord(s[I])
   else
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Inc(I);
   if (S[I] <> #0) then
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if Negative then
         begin
          if (s[I] = '9') then
           raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
         end
        else
         begin
          if ('8' <= S[I]) and (S[I] <= '9') then
           raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
         end;
       end;
      if ('0' <= S[I]) and (S[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (S[I] = #0);
    end;
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

procedure Filler4;
asm
 nop
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_26_b(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   case s[I] of
    '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
    'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
    'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
   else
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   end;
   Inc(I);
   if S[I] <> #0 then
    begin
     repeat
      if Result > (High(Result) div 16) then
       begin
        if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
               ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
               ((s[Ibegin]  = '8')  or (s[Ibegin]  = '9'))) then
         begin
          raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
         end;
       end;
      case s[I] of
       '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
       'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
       'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      end;
      Inc(I);
     until (s[I] = #0);
    end;
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   if ('0' <= S[I]) and (S[I] <= '9') then
    Result := Result * 10 - Ord('0') + Ord(s[I])
   else
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Inc(I);
   if (S[I] <> #0) then
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if Negative then
         begin
          if (s[I] = '9') then
           raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
         end
        else
         begin
          if ('8' <= S[I]) and (S[I] <= '9') then
           raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
         end;
       end;
      if ('0' <= S[I]) and (S[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (S[I] = #0);
    end;
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

procedure Filler5;
asm
 nop
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_26_c(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   case s[I] of
    '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
    'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
    'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
   else
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   end;
   Inc(I);
   if S[I] <> #0 then
    begin
     repeat
      if Result > (High(Result) div 16) then
       begin
        if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
               ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
               ((s[Ibegin]  = '8')  or (s[Ibegin]  = '9'))) then
         begin
          raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
         end;
       end;
      case s[I] of
       '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
       'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
       'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      end;
      Inc(I);
     until (s[I] = #0);
    end;
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   if ('0' <= S[I]) and (S[I] <= '9') then
    Result := Result * 10 - Ord('0') + Ord(s[I])
   else
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Inc(I);
   if (S[I] <> #0) then
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if Negative then
         begin
          if (s[I] = '9') then
           raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
         end
        else
         begin
          if ('8' <= S[I]) and (S[I] <= '9') then
           raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
         end;
       end;
      if ('0' <= S[I]) and (S[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (S[I] = #0);
    end;
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

procedure Filler6;
asm
 nop
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function StrToInt32_DKC_Pas_26_d(const S : string): Integer;
var
 I, Ibegin : Integer;
 Negative, Hex : Boolean;

begin
 Result := 0;
 Negative := False;
 Hex := False;
 I := 1;
 if (S = '') or (S[I] = #0) then
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
 while (s[I] = ' ') do
  begin
   Inc(I);
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  end;
 case s[I] of
  '$',
  'x',
  'X':
   begin
    Hex := True;
    Inc(I);
   end;
  '0':
   begin
    Hex := (S[I] <> #0) and (UpCase(s[I+1]) = 'X');
    if Hex then
     Inc(I,2);
   end;
  '-':
   begin
    //Test for Hex
    case S[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(S[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Negative := True;
    Inc(I);
   end;
  '+':
   begin
    //Test for Hex
    case s[I+1] of
     '$',
     'x',
     'X':
      begin
       Hex := True;
       Inc(I);
      end;
     '0':
      begin
       Hex := (S[I] <> #0) and (UpCase(s[I+2]) = 'X');
       if Hex then
        Inc(I,2);
      end;
    end;
    Inc(I);
   end;
 end;
 if Hex then
  begin
   if S[I] = #0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Ibegin := I;
   case s[I] of
    '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
    'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
    'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
   else
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   end;
   Inc(I);
   if S[I] <> #0 then
    begin
     repeat
      if Result > (High(Result) div 16) then
       begin
        if not(((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
               ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
               ((s[Ibegin]  = '8')  or (s[Ibegin]  = '9'))) then
         begin
          raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
         end;
       end;
      case s[I] of
       '0'..'9': Result := Result * 16 - Ord('0') + Ord(s[I]);
       'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);
       'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      end;
      Inc(I);
     until (s[I] = #0);
    end;
  end
 else
  begin
   if (s[I] = #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   if ('0' <= S[I]) and (S[I] <= '9') then
    Result := Result * 10 - Ord('0') + Ord(s[I])
   else
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
   Inc(I);
   if (S[I] <> #0) then
    begin
     repeat
      if Result > (High(Result) div 10) then
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
      else if Result = (High(Result) div 10) then
       begin
        if Negative then
         begin
          if (s[I] = '9') then
           raise EConvertError.CreateResFmt(@SInvalidInteger, [S])
         end
        else
         begin
          if ('8' <= S[I]) and (S[I] <= '9') then
           raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
         end;
       end;
      if ('0' <= S[I]) and (S[I] <= '9') then
       Result := Result * 10 - Ord('0') + Ord(s[I])
      else
       raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
      Inc(I);
     until (S[I] = #0);
    end;
  end;
 if Negative then
  Result := -Result;
end;

{$ifdef RangeCheckWasOff}
  {$R-}
{$endif}
{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

//Author:            Dennis Kjaer Christensen
//Date:              3/11 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_4_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   push  edi
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
   mov   edi,07FFFFFFFH / 10     // limit
 @blankLoop:
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,edi         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   inc   esi
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   mov   edi,0FFFFFFFH
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,edi
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   edi
   pop   ebx
   pop   esi
end;

procedure Filler18;
asm
 nop
end;

function StrToInt32_DKC_IA32_4_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   push  edi
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
   mov   edi,07FFFFFFFH / 10     // limit
 @blankLoop:
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,edi         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   inc   esi
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   mov   edi,0FFFFFFFH
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,edi
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   edi
   pop   ebx
   pop   esi
end;

procedure Filler8;
asm
 nop
end;

function StrToInt32_DKC_IA32_4_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   push  edi
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
   mov   edi,07FFFFFFFH / 10     // limit
 @blankLoop:
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,edi         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   inc   esi
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   mov   edi,0FFFFFFFH
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,edi
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   edi
   pop   ebx
   pop   esi
end;

procedure Filler9;
asm
 nop
end;

function StrToInt32_DKC_IA32_4_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   push  edi
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
   mov   edi,07FFFFFFFH / 10     // limit
 @blankLoop:
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,edi         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   inc   esi
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   mov   edi,0FFFFFFFH
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,edi
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   edi
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/11 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_5_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   push  edi
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
   mov   edi,07FFFFFFFH / 10     // limit
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,edi         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   mov   edi,0FFFFFFFH
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,edi
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   edi
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_5_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   push  edi
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
   mov   edi,07FFFFFFFH / 10     // limit
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,edi         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   mov   edi,0FFFFFFFH
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,edi
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   edi
   pop   ebx
   pop   esi
end;

procedure Filler11;
asm
 nop
end;

function StrToInt32_DKC_IA32_5_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   push  edi
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
   mov   edi,07FFFFFFFH / 10     // limit
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,edi         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   mov   edi,0FFFFFFFH
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,edi
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   edi
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_5_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   push  edi
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
   mov   edi,07FFFFFFFH / 10     // limit
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,edi         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   mov   edi,0FFFFFFFH
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,edi
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   edi
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_32_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_32_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_33_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+1]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+2]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+3]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+4]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+5]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+6]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+7]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+8]
   test  ebx,ebx
   je    @EndDigits
   add   esi,9
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_33_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+1]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+2]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+3]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+4]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+5]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+6]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+7]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+8]
   test  ebx,ebx
   je    @EndDigits
   add   esi,9
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_33_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+1]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+2]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+3]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+4]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+5]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+6]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+7]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+8]
   test  ebx,ebx
   je    @EndDigits
   add   esi,9
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_33_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+1]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+2]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+3]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+4]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+5]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+6]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+7]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+8]
   test  ebx,ebx
   je    @EndDigits
   add   esi,9
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_34_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   add   esi,1
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   add   esi,1
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_34_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   add   esi,1
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   add   esi,1
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_34_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   add   esi,1
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   add   esi,1
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_34_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   add   esi,1
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   add   esi,1
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_35_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_35_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_35_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_35_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_36_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 //@PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_36_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 //@PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_36_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 //@PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_36_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 //@PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   cmp   bl,'a'
   jb    @Upper6
   sub   bl,'a' - 'A'
 @upper6 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper7
   sub   bl,'a' - 'A'
 @upper7 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper5
   sub   bl,'a' - 'A'
 @upper5 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper4
   sub   bl,'a' - 'A'
 @upper4 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper8
   sub   bl,'a' - 'A'
 @upper8 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper1
   sub   bl,'a' - 'A'
 @upper1 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   cmp   bl,'a'
   jb    @Upper2
   sub   bl,'a' - 'A'
 @upper2 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper3
   sub   bl,'a' - 'A'
 @Upper3 :
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_37_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_37_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_37_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_37_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_38_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+1]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+2]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+3]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+4]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+5]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+6]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+7]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+8]
   test  ebx,ebx
   je    @EndDigits
   add   esi,9
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_38_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+1]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+2]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+3]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+4]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+5]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+6]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+7]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+8]
   test  ebx,ebx
   je    @EndDigits
   add   esi,9
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_38_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+1]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+2]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+3]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+4]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+5]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+6]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+7]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+8]
   test  ebx,ebx
   je    @EndDigits
   add   esi,9
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_38_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
 @PreDigitLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+1]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+2]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+3]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+4]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+5]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+6]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+7]
   test  ebx,ebx
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi+8]
   test  ebx,ebx
   je    @EndDigits
   add   esi,9
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   lea   eax,[ebx+eax*2]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   je    @HexDigLoopEnd;
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_39_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   add   esi,1
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_39_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   add   esi,1
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_39_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   add   esi,1
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_39_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   xor   eax,eax
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   je    @EndDigits
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10         // value > limit ?
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   add   ch,1
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   push  edi
   lea   edi,[LookUpTable]
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigPreLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk6
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk6 :
   mov   eax,ebx
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk7
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk7 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx,byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk5
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk5 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk4
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk4 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk8
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk8 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk1
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk1 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk2
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk2 :
   add   eax,eax
   lea   eax,[ebx+eax*8]
   add   esi,1
   movzx ebx, byte ptr [esi]
   test  ebx,ebx
   je    @HexDigLoopEnd;
   add   esi,1
 @HexDigLoop:
   movzx ebx,[edi+ebx]
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk3
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk3 :
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
 @HexDigLoopEnd :
   pop   edi
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit :
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_40_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_40_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_40_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_40_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @DigLoop
 @EndDigits:
   sub   ch,1
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_41_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   inc   esi
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_41_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   inc   esi
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_41_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   inc   esi
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_41_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   inc   esi
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   inc   esi
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   inc   esi
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   inc   esi
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_42_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_42_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

procedure Filler7;
asm
 nop
end;

function StrToInt32_DKC_IA32_42_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_42_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx         // fortunately, we can't have a carry
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   shl   eax,4
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2006
//Instructionset(s): IA32

function StrToInt32_DKC_IA32_43_a(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_43_b(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

procedure Filler10;
asm
 nop
end;

function StrToInt32_DKC_IA32_43_c(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

function StrToInt32_DKC_IA32_43_d(const S: string): Integer;
asm
   push  esi
   push  ebx
   mov   edx,eax
   test  eax,eax
   je    @Error
   mov   esi,eax
   xor   eax,eax
 @blankLoop:
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,' '
   je    @BlankLoop
   xor   ecx,ecx
   cmp   bl,'-'
   je    @Minus
   cmp   bl,'+'
   je    @Plus
 @CheckDollar:
   cmp   bl,'$'
   je    @Dollar
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @Dollar
   cmp   bl,'0'
   jne   @FirstDigit
   movzx ebx,byte ptr [esi]
   add   esi,1
   cmp   bl,'x'
   je    @Dollar
   cmp   bl,'X'
   je    @dollar
   test  ebx,ebx
   je    @EndDigits
   jmp   @DigLoop
 @FirstDigit:
   test  ebx,ebx
   je    @Error
 @digLoop:
   sub   bl,'0'
   cmp   bl,9
   ja    @Error
   cmp   eax,07FFFFFFFH / 10     // limit
   ja    @OverFlow
   lea   eax,[eax+eax*4]
   add   eax,eax
   add   eax,ebx
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  bl,bl
   jne   @DigLoop
 @EndDigits:
   dec   ch
   je    @Negate
   test  eax,eax
   jge   @SuccessExit
   jmp   @OverFlow
 @negate:
   neg   eax
   jle   @SuccessExit
   js    @SuccessExit           // to handle 2**31 correctly, where the negate overflows
 @Error :
 @OverFlow :
   mov   eax,edx
   call  RaiseConvertError2
 @minus:
   inc   ch
 @plus:
   movzx ebx,byte ptr [esi]
   add   esi,1
   jmp   @CheckDollar
 @dollar:
   movzx ebx,byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jz    @Error
 @HexDigLoop:
   cmp   bl,'a'
   jb    @Upper
   sub   bl,'a' - 'A'
 @upper:
   sub   bl,'0'
   cmp   bl,9
   jbe   @DigOk
   sub   bl,'A' - '0'
   cmp   bl,5
   ja    @Error
   add   bl,10
 @digOk:
   cmp   eax,0FFFFFFFH
   ja    @OverFlow
   add   eax,eax
   lea   eax,[ebx+eax*8]
   movzx ebx, byte ptr [esi]
   add   esi,1
   test  ebx,ebx
   jne   @HexDigLoop
   dec   ch
   jne   @SuccessExit
   neg   eax
 @successExit:
   pop   ebx
   pop   esi
end;

initialization

 InitializeLookUpTable;
 Filler1;
 Filler2;
 Filler3;
 Filler4;
 Filler5;
 Filler6;
 Filler7;
 Filler8;
 Filler9;
 Filler10;
 Filler11;
 Filler18;
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_24_a', @StrToInt32_DKC_Pas_24_a);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_24_b', @StrToInt32_DKC_Pas_24_b);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_24_c', @StrToInt32_DKC_Pas_24_c);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_24_d', @StrToInt32_DKC_Pas_24_d);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_25_a', @StrToInt32_DKC_Pas_25_a);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_25_b', @StrToInt32_DKC_Pas_25_b);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_25_c', @StrToInt32_DKC_Pas_25_c);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_25_d', @StrToInt32_DKC_Pas_25_d);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_26_a', @StrToInt32_DKC_Pas_26_a);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_26_b', @StrToInt32_DKC_Pas_26_b);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_26_c', @StrToInt32_DKC_Pas_26_c);
 MainForm.RegisterFunction('StrToInt32_DKC_Pas_26_d', @StrToInt32_DKC_Pas_26_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_4_a', @StrToInt32_DKC_IA32_4_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_4_b', @StrToInt32_DKC_IA32_4_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_4_c', @StrToInt32_DKC_IA32_4_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_4_d', @StrToInt32_DKC_IA32_4_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_5_a', @StrToInt32_DKC_IA32_5_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_5_b', @StrToInt32_DKC_IA32_5_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_5_c', @StrToInt32_DKC_IA32_5_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_5_d', @StrToInt32_DKC_IA32_5_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_33_a', @StrToInt32_DKC_IA32_33_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_33_b', @StrToInt32_DKC_IA32_33_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_33_c', @StrToInt32_DKC_IA32_33_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_33_d', @StrToInt32_DKC_IA32_33_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_34_a', @StrToInt32_DKC_IA32_34_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_34_b', @StrToInt32_DKC_IA32_34_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_34_c', @StrToInt32_DKC_IA32_34_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_34_d', @StrToInt32_DKC_IA32_34_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_35_a', @StrToInt32_DKC_IA32_35_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_35_b', @StrToInt32_DKC_IA32_35_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_35_c', @StrToInt32_DKC_IA32_35_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_35_d', @StrToInt32_DKC_IA32_35_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_36_a', @StrToInt32_DKC_IA32_36_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_36_b', @StrToInt32_DKC_IA32_36_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_36_c', @StrToInt32_DKC_IA32_36_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_36_d', @StrToInt32_DKC_IA32_36_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_37_a', @StrToInt32_DKC_IA32_37_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_37_b', @StrToInt32_DKC_IA32_37_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_37_c', @StrToInt32_DKC_IA32_37_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_37_d', @StrToInt32_DKC_IA32_37_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_38_a', @StrToInt32_DKC_IA32_38_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_38_b', @StrToInt32_DKC_IA32_38_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_38_c', @StrToInt32_DKC_IA32_38_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_38_d', @StrToInt32_DKC_IA32_38_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_39_a', @StrToInt32_DKC_IA32_39_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_39_b', @StrToInt32_DKC_IA32_39_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_39_c', @StrToInt32_DKC_IA32_39_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_39_d', @StrToInt32_DKC_IA32_39_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_40_a', @StrToInt32_DKC_IA32_40_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_40_b', @StrToInt32_DKC_IA32_40_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_40_c', @StrToInt32_DKC_IA32_40_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_40_d', @StrToInt32_DKC_IA32_40_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_41_a', @StrToInt32_DKC_IA32_41_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_41_b', @StrToInt32_DKC_IA32_41_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_41_c', @StrToInt32_DKC_IA32_41_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_41_d', @StrToInt32_DKC_IA32_41_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_42_a', @StrToInt32_DKC_IA32_42_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_42_b', @StrToInt32_DKC_IA32_42_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_42_c', @StrToInt32_DKC_IA32_42_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_42_d', @StrToInt32_DKC_IA32_42_d);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_43_a', @StrToInt32_DKC_IA32_43_a);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_43_b', @StrToInt32_DKC_IA32_43_b);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_43_c', @StrToInt32_DKC_IA32_43_c);
 MainForm.RegisterFunction('StrToInt32_DKC_IA32_43_d', @StrToInt32_DKC_IA32_43_d);

end.


