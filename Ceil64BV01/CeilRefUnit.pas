unit CeilRefUnit;

interface

function Ceil64Ref(const X: Extended): Int64; overload;
function Ceil64Ref(const X: Double): Int64; overload;
function Ceil64Ref(const X: Single): Int64; overload;

implementation

function Ceil64Ref(const X: Extended): Int64;
begin
  Result := Trunc(X);
  if Frac(X) > 0 then
    Inc(Result);
end;

function Ceil64Ref(const X: Double): Int64;
begin
  Result := Trunc(X);
  if Frac(X) > 0 then
    Inc(Result);
end;

function Ceil64Ref(const X: Single): Int64;
begin
  Result := Trunc(X);
  if Frac(X) > 0 then
    Inc(Result);
end;

end.
