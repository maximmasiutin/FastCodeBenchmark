unit PosIExRefUnit;

interface

function PosIEx_Ref_a(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosIEx_Ref_b(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosIEx_Ref_c(const SubStr, S: string; Offset: Integer = 1): Integer;
function PosIEx_Ref_d(const SubStr, S: string; Offset: Integer = 1): Integer;

implementation

uses
 SysUtils;

function PosIEx_Ref_a(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
  SubStrUpper: string;
  SUpper: string;

begin
  SubStrUpper := UpperCase(SubStr);
  SUpper := UpperCase(S);
  LenSubStr := Length(SubStr);
  if LenSubStr = 0 then
   Result := 0
  else if Offset < 1 then
   Result := 0
  else if Offset = 1 then
    Result := Pos(SubStrUpper, SUpper)
  else
  begin
    I := Offset;
    Len := Length(SUpper) - LenSubStr + 1;
    while I <= Len do
    begin
      if SUpper[I] = SubStrUpper[1] then
      begin
        X := 1;
        while (X < LenSubStr) do
          if SUpper[I + X] = SubStrUpper[X + 1] then
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

function PosIEx_Ref_b(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
  SubStrUpper: string;
  SUpper: string;

begin
  SubStrUpper := UpperCase(SubStr);
  SUpper := UpperCase(S);
  LenSubStr := Length(SubStr);
  if LenSubStr = 0 then
   Result := 0
  else if Offset < 1 then
   Result := 0
  else if Offset = 1 then
    Result := Pos(SubStrUpper, SUpper)
  else
  begin
    I := Offset;
    Len := Length(SUpper) - LenSubStr + 1;
    while I <= Len do
    begin
      if SUpper[I] = SubStrUpper[1] then
      begin
        X := 1;
        while (X < LenSubStr) do
          if SUpper[I + X] = SubStrUpper[X + 1] then
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

function PosIEx_Ref_c(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
  SubStrUpper: string;
  SUpper: string;

begin
  SubStrUpper := UpperCase(SubStr);
  SUpper := UpperCase(S);
  LenSubStr := Length(SubStr);
  if LenSubStr = 0 then
   Result := 0
  else if Offset < 1 then
   Result := 0
  else if Offset = 1 then
    Result := Pos(SubStrUpper, SUpper)
  else
  begin
    I := Offset;
    Len := Length(SUpper) - LenSubStr + 1;
    while I <= Len do
    begin
      if SUpper[I] = SubStrUpper[1] then
      begin
        X := 1;
        while (X < LenSubStr) do
          if SUpper[I + X] = SubStrUpper[X + 1] then
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

function PosIEx_Ref_d(const SubStr, S: string; Offset: Integer = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
  SubStrUpper: string;
  SUpper: string;

begin
  SubStrUpper := UpperCase(SubStr);
  SUpper := UpperCase(S);
  LenSubStr := Length(SubStr);
  if LenSubStr = 0 then
   Result := 0
  else if Offset < 1 then
   Result := 0
  else if Offset = 1 then
    Result := Pos(SubStrUpper, SUpper)
  else
  begin
    I := Offset;
    Len := Length(SUpper) - LenSubStr + 1;
    while I <= Len do
    begin
      if SUpper[I] = SubStrUpper[1] then
      begin
        X := 1;
        while (X < LenSubStr) do
          if SUpper[I + X] = SubStrUpper[X + 1] then
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
