unit ValDKCUnit;

interface

implementation

uses
 FastcodeChallengeValLongUnit, FastcodeChallengeUnit, SysUtils;

//Author:            Dennis Kjaer Christensen
//Based on the RTL function
//Date:              7/11 2006
//Instructionset(s): IA32

{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}

function ValLong_DKC_Pas_1_a(const S : string; var Code: Integer): Integer;{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}{$ifdef ver190}inline; {$endif}
var
 I, Ibegin, SLength : Integer;
 Negative, Hex : Boolean;

begin
  I := 1;
  code := 1;
  Result := 0;
  Negative := False;
  Hex := False;
  SLength := StrLen(PChar(S));
  if SLength = 0 then
   Exit;
  while (I <= SLength) and (s[I] = ' ') do
   Inc(I);
  if I > SLength then
   begin
    code := I;
    Exit;
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
     Hex := (SLength > I) and (UpCase(s[I+1]) = 'X');
     if Hex then
      Inc(I,2);
    end;
   '-':
    begin
     if I >= SLength then
      begin
       code := 2;
       Exit;
      end;
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
        Hex := (SLength > I) and (UpCase(s[I+2]) = 'X');
        if Hex then
         Inc(I,2);
       end;
     end;
     Negative := True;
     Inc(I);
    end;
   '+':
    begin
     if I >= SLength then
      begin
       code := 2;
       Exit;
      end;
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
        Hex := (SLength > I) and (UpCase(s[I+2]) = 'X');
        if Hex then
         Inc(I,2);
       end;
     end;
    Inc(I);
    end;
  end;
  if Hex then
   begin
    if I > SLength then
     begin
      Code := I;
      Exit;
     end;
    Ibegin := I;
    while I <= SLength do
     begin
      if Result > (High(Result) div 16) then
       begin
        if ((s[Ibegin] >= 'a') and (s[Ibegin] <= 'f')) or
           ((s[Ibegin] >= 'A') and (s[Ibegin] <= 'F')) or
           ((s[Ibegin]  = '8')  or (s[Ibegin]  = '9')) then
         begin
          if SLength - I > 0 then //More digits present will cause overflow anyway
           begin
            code := I+1;
            Exit;
           end;
          Result := Result - 2 shl 30;
          case s[I] of
           '0'..'9': Result := Result * 16 + Ord(s[I]) - Ord('0');
           'a'..'f': Result := Result * 16 - 87 + Ord(s[I]);//Ord('a') + 10;
           'A'..'F': Result := Result * 16 - 55 + Ord(s[I]);//Ord('A') + 10;
          else
           code := I;
          end;
          if Negative then
           Result := -Result;
          Code := 0;
          Exit;
         end
         else
          begin
          code := I;
          Exit;
         end;
       end;
      case s[I] of
       '0'..'9': Result := Result * 16 + Ord(s[I]) - Ord('0');
       'a'..'f': Result := Result * 16 + Ord(s[I]) - 87;//Ord('a') + 10;
       'A'..'F': Result := Result * 16 + Ord(s[I]) - 55;//Ord('A') + 10;
      else
       code := I;
       Exit;
      end;
      Inc(I);
     end;
   end
  else
   begin
    if I > SLength then
     begin
      Code := 2;
      Exit;
     end;
    if not Negative then
     begin
      while I <= SLength do
       begin
        if Result > (High(Result) div 10) then
         begin
          Code := I;
          Exit;
         end;
        if Result = (High(Result) div 10) then
         begin
          if ('8' <= s[I]) and (s[I] <= '9') then
           begin
            Code := I;
            Exit;
           end;
         end;
        if ('0' <= s[I]) and (s[I] <= '9') then
         Result := Result * 10 - Ord('0') + Ord(s[I])
        else
         begin
          Code := I;
          Exit;
         end;
        Inc(I);
       end;
     end
    else
     begin
      if S = '-2147483648' then
       begin
        Result := -2147483648;
        Code := 0;
        Exit;
       end;       
      while I <= SLength do
       begin
        if Result > (High(Result) div 10) then
         begin
          Code := I;
          Exit;
         end;
        if Result = (High(Result) div 10) then
         begin
          if (s[I] = '9') then
           begin
            Code := I;
            Exit;
           end;
         end;
        if ('0' <= s[I]) and (s[I] <= '9') then
         Result := Result * 10 - Ord('0') + Ord(s[I])
        else
         begin
          Code := I;
          if Negative then
           Result := -Result;
          Exit;
         end;
        Inc(I);
       end;
     end;
   end;
  if Negative then
   Result := -Result;
  Code := 0;
end;

{$ifdef OverflowCheckWasOff}
  {$Q-}
{$endif}

initialization
  ChallengeValLong.RegisterFunction(FunctionData(
    'ValLong_DKC_PAS_1_a',  '', @ValLong_DKC_PAS_1_a, fccPAS, fcaDKC));
end.

