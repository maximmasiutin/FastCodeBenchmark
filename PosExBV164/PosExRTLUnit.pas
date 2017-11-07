unit PosExRTLUnit;

interface

//function PosEx_RTL(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosEx_RTLFixed(const SubStr, S: string; Offset: Integer = 1): Integer;

implementation

function PosEx_RTL(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

function PosEx_RTLFixed(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  LenSubStr := Length(SubStr);
  if LenSubStr = 0 then
   Result := 0
  else if Offset < 1 then
   Result := 0
  else if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) do
          if S[I + X] = SubStr[X + 1] then
            Inc(X)
          else
            Break;
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

end.
