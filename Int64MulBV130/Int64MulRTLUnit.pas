unit Int64MulRTLUnit;

interface

function Int64Mul_RTL_IA32_2(var X, Y : Int64) : Int64;

implementation

function Int64Mul_RTL_IA32_2(var X, Y : Int64) : Int64;
begin
 Result := X * Y;
end;

end.
