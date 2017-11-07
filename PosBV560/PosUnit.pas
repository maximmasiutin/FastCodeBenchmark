unit PosUnit;

interface

function Pos_RTL_IA32(const substr : AnsiString; const s : AnsiString ) : Integer;
function Pos_RTL_PAS(const Substr: AnsiString; const S: AnsiString): Integer;
function Pos_DKC_PAS_65(const SubString : AnsiString; const Str : AnsiString) : Integer;

implementation

uses
 SysUtils;

function Pos_RTL_IA32(const substr : AnsiString; const s : AnsiString ) : Integer;
begin
 Result := Pos(substr, s)
end;

function Pos_RTL_PAS(const Substr: AnsiString; const S: AnsiString): Integer;
var
   i:integer;
   c:char;
   ps,p,pend:pchar;
   n,ns:integer;
   pstart:pchar;
begin
   ns:=length(SubStr);
   if ns>0 then
   begin
     ps:=pointer(Substr);
     n:=length(S);
     if n>0 then
     begin
       p:=pointer(S);
       pStart:=p;
       pend:=p+n-ns;
       c:=ps[0];
       while (p<=pend) do
       begin
         if (c = p^) then
         begin
           i:=0;
           repeat
             inc(i);
             if i=ns then
             begin
               Result:=p-pstart+1;
               exit;
             end;
           until (ps[i] <> p[i]);
         end;
         inc(p);
       end;
     end;
   end;
   Result:=0;
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/1 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Pos_DKC_PAS_65(const SubString : AnsiString; const Str : AnsiString ) : Integer;
var
 SubStrLength, StrLength, StringIndex, SubStringIndex, SkipValue, NewStrIndex,
 Skip, StopSearch, I1, I, I2, I3 : Integer;
 SkipValues : array[0..255] of Integer;
 LastChar : Char;
 Match : Boolean;
label
 OuterLoop, InnerLoop;

begin
 StrLength := Length(Str);
 SubStrLength := Length(SubString);
 if ((SubStrLength = 0) or (StrLength = 0)) then
  begin
   Result := 0;
   Exit;
  end;
 if (SubStrLength > StrLength) then
  begin
   Result := 0;
   Exit;
  end;
 if SubStrLength = 1 then
  begin
   I2 := 0;
   repeat
    Inc(I2);
    if Str[I2] = SubString[1] then
     begin
      Result := I2;
      Exit;
     end;
   until(I2 = StrLength);
   Result := 0;
   Exit;
  end;
 if StrLength < 250 then
  begin
   I2 := 0;
   StopSearch := StrLength-SubStrLength+1;
   repeat
    Inc(I2);
    if Str[I2] = SubString[1] then
     begin
      goto InnerLoop;
     end;
    OuterLoop:
   until(I2 = StopSearch);
   Result := 0;
   Exit;
   InnerLoop:
   I3 := 1;
   repeat
    Inc(I3);
    if Str[I2+I3-1] <> SubString[I3] then
     begin
      goto OuterLoop;
     end;
   until(I3 = SubStrLength);
   Result := I2;
   Exit
  end;
 I1 := 0;
 repeat
  SkipValues[I1]   := SubStrLength;
  SkipValues[I1+1] := SubStrLength;
  SkipValues[I1+2] := SubStrLength;
  SkipValues[I1+3] := SubStrLength;
  SkipValues[I1+4] := SubStrLength;
  SkipValues[I1+5] := SubStrLength;
  SkipValues[I1+6] := SubStrLength;
  SkipValues[I1+7] := SubStrLength;
  Inc(I1,8);
 until(I1 >= 255);
 Skip := SubStrLength - 1;
 for I := 1 to SubStrLength-1 do
  begin
   SkipValues[Integer(SubString[I])] := Skip;
   Dec(Skip);
  end;
 LastChar := SubString[SubStrLength];
 StringIndex := SubStrLength;
 while StringIndex <= StrLength do
  begin
   SkipValue := SkipValues[Integer(Str[StringIndex])];
   if LastChar <> Str[StringIndex] then
    begin
     Inc(StringIndex, SkipValue);
    end
   else
    begin
     Match := True;
     Result := StringIndex;
     for SubStringIndex := SubStrLength-1 downto 1 do
      begin
       Dec(Result);
       if SubString[SubStringIndex] <> Str[Result] then
        begin
         NewStrIndex := Result + SkipValues[Cardinal(Str[Result])];
         Inc(StringIndex, SkipValue);
         if StringIndex < NewStrIndex then
          StringIndex := NewStrIndex;
         Match := False;
         Break;
        end;
      end;
     if Match then
      Exit;
    end;
  end;
 Result := 0;
end;

end.
