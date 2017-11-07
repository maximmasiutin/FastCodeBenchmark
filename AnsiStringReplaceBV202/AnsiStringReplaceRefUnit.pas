unit AnsiStringReplaceRefUnit;

interface

uses
 SysUtils;

function StringReplaceRef(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;

implementation

uses
 Windows;

function StringReplaceRef(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
var
 SearchStr, Pattern, NewString: AnsiString;
 Offset: Integer;

begin
 if rfIgnoreCase in Flags then
  begin
   SearchStr := AnsiUpperCase(S);
   Pattern := AnsiUpperCase(OldPattern);
  end
 else
  begin
   SearchStr := S;
   Pattern := OldPattern;
  end;
 NewString := S;
 Result := '';
 while SearchStr <> '' do
  begin
   Offset := Pos(Pattern, SearchStr);
   if Offset = 0 then
    begin
     Result := Result + NewString;
     Break;
    end;
   Result := Result + Copy(NewString, 1, Offset - 1) + NewPattern;
   NewString := Copy(NewString, Offset + Length(OldPattern), MaxInt);
   if not (rfReplaceAll in Flags) then
    begin
     Result := Result + NewString;
     Break;
    end;
   SearchStr := Copy(SearchStr, Offset + Length(Pattern), MaxInt);
  end;
end;

end.
