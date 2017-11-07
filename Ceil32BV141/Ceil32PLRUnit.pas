unit Ceil32PLRUnit;

{$R-} // Needed for Ceil32_PLR_PAS_1 in Delphi 7

interface

function Ceil32_PLR_IA32_1(const X: Extended): integer; overload;
function Ceil32_PLR_IA32_2(const X: Extended): integer; overload;
function Ceil32_PLR_PAS_1(const X: Extended): integer; overload;

function Ceil32_PLR_IA32_1(const X: Double): integer; overload;
function Ceil32_PLR_IA32_2(const X: Double): integer; overload;

function Ceil32_PLR_IA32_1(const X: Single): integer; overload;
function Ceil32_PLR_IA32_2(const X: Single): integer; overload;

implementation

{Extended precision}

function Ceil32_PLR_IA32_1(const X: Extended): integer;
var
  LOldCW, LNewCW: Word;
  LResult: Integer;
asm
  fnstcw LOldCW
  mov ax, 1111001111111111B
  and ax, LOldCW
  or ax, 0000100000000000B
  mov LNewCW, ax
  fldcw LNewCW
  fld X
  fistp LResult
  mov eax, LResult
  fldcw LOldCW
end;

function Ceil32_PLR_IA32_2(const X: Extended): integer;
asm
  {On entry: X = [esp + 8]}
  {Extended variable layout: S1E15M64}
  {Get the upper 32 bits of the mantissa into eax}
  mov eax, [esp + 12]
  {Save it in ebp}
  mov ebp, eax
  {Get the exponent and sign in ecx}
  movsx ecx, word ptr [esp + 16]
  {Save the sign in edx}
  mov edx, ecx
  {Mask out the sign bit of ecx}
  and ecx, $7fff
  {Get the number of positions to shift}
  neg ecx
  add ecx, 16383 + 31
  cmp ecx, 31
  ja @FractionOrTooLarge
  {Shift the number}
  shr eax, cl
@CheckSign:
  {Is the number negative?}
  test edx, edx
  jns @PositiveNumber
  neg eax
  js @Done
@RaiseInvalidOperationException:
  {Force numeric overflow}
  mov al, reInvalidOp
  jmp System.Error
@PositiveNumber:
  test eax, eax
  js @RaiseInvalidOperationException
  {Positive number - increment the result if there is any fractional part}
  cmp dword ptr [esp + 8], 0
  jne @HasFraction
  {Check the top 32 bits}
  mov edx, -1
  shl edx, cl
  not edx
  and edx, ebp
  jz @Done
@HasFraction:
  {Increment and check for overflow}
  add eax, 1
  jns @Done
  jmp @RaiseInvalidOperationException
@FractionOrTooLarge:
  {Absolute value of number is either < 1 or it is too great to represent}
  xor eax, eax
  {Is it too large?}
  test ecx, ecx
  js @RaiseInvalidOperationException
  {Very small number: Is the fractional part negative?}
  test edx, edx
  js @Done
  {Number is positive. If there is a fraction, we must add a further 1 to
   the value}
  or ebp, [esp + 8]
  jz @Done
  mov eax, 1
@Done:
end;

{$ifopt Q+}
  {$Q-}
  {$define OverflowChecking}
{$endif}
function Ceil32_PLR_PAS_1(const X: Extended): integer;
type
  {Extended number decoded}
  TExtendedDecoded = packed record
    MantissaLow: Cardinal;
    MantissaHigh: Cardinal;
    ExpAndSign: SmallInt;
  end;
var
  LShiftFactor: Cardinal;
begin
  LShiftFactor := (16383 + 31) - (TExtendedDecoded(X).ExpAndSign and $7fff);
  if LShiftFactor <= 31 then
  begin
    if TExtendedDecoded(X).ExpAndSign < 0 then
    begin
      {Negative number}
      Result := - (TExtendedDecoded(X).MantissaHigh shr LShiftFactor);
      if Result <= 0 then
        exit;
    end
    else
    begin
      {Positive number: Is there a fractional part?}
      if (TExtendedDecoded(X).MantissaLow = 0)
        and (((not ((-1) shl LShiftFactor)) and TExtendedDecoded(X).MantissaHigh) = 0) then
      begin
        Result := TExtendedDecoded(X).MantissaHigh shr LShiftFactor;
      end
      else
      begin
        Result := (TExtendedDecoded(X).MantissaHigh shr LShiftFactor) + 1;
      end;
      if Result >= 0 then
        exit;
    end;
  end
  else
  begin
    if Integer(LShiftFactor) > 0  then
    begin
      {Very small fraction}
      if TExtendedDecoded(X).ExpAndSign < 0 then
      begin
        Result := 0;
        exit;
      end
      else
      begin
        if (TExtendedDecoded(X).MantissaLow or TExtendedDecoded(X).MantissaHigh) <> 0 then
          Result := 1
        else
          Result := 0;
        exit;
      end;
    end;
  end;
  {Raise an overflow error}
  Error(reInvalidOp);
  {Suppress the compiler warning}
  Result := 0;
end;
{$ifdef OverflowChecking}
  {$Q+}
  {$undef OverflowChecking}
{$endif}

{Double precision}

function Ceil32_PLR_IA32_1(const X: Double): integer;
var
  LOldCW, LNewCW: Word;
  LResult: Integer;
asm
  fnstcw LOldCW
  mov ax, 1111001111111111B
  and ax, LOldCW
  or ax, 0000100000000000B
  mov LNewCW, ax
  fldcw LNewCW
  fld X
  fistp LResult
  mov eax, LResult
  fldcw LOldCW
end;

function Ceil32_PLR_IA32_2(const X: Double): integer;
asm
  {On entry: X = [esp + 8]}
  {Double variable layout: S1E11M52}
  {Get the upper 32 bits of the mantissa into eax and the lower 32 bits into ebp}
  mov ebp, [esp + 8]
  mov eax, [esp + 12]
  {Save the sign in edx}
  cdq
  {Is the number zero?}
  and eax, $7fffffff
  jnz @NotZero
  test ebp, ebp
  jz @Done
@NotZero:
  {Get the exponent in ecx}
  mov ecx, eax
  shr ecx, 20
  {Get the number of positions to shift the mantissa}
  neg ecx
  add ecx, 1023 + 31
  cmp ecx, 31
  ja @FractionOrTooLarge
  {Shift the mantissa all the way to the left}
  shld eax, ebp, 11
  shl ebp, 11
  {Add the implied 1 bit to the mantissa}
  or eax, $80000000
  {Check the sign of the number}
  test edx, edx
  jns @PositiveNumber
  {Shift the bits for the negative number}
  shr eax, cl
  {Negate the number}
  neg eax
  js @Done
@RaiseInvalidOperationException:
  {Raise in invalid operation exception}
  mov al, reInvalidOp
  jmp System.Error
@PositiveNumber:
  test ebp, ebp
  jnz @PositiveWithFraction
  {Is there a fractional part?}
  mov edx, -1
  shl edx, cl
  not edx
  and edx, eax
  jnz @PositiveWithFraction
  {Positive number, no fraction}
  shr eax, cl
  test eax, eax
  jns @Done
  jmp @RaiseInvalidOperationException
@PositiveWithFraction:
  {Positive number with fractional part}
  shr eax, cl
  add eax, 1
  jns @Done
  jmp @RaiseInvalidOperationException
@FractionOrTooLarge:
  {Absolute value of number is either < 1 or it is too great to represent}
  {Is it too large?}
  test ecx, ecx
  js @RaiseInvalidOperationException
  {Number is -1 < x < 1: Number is known not to be zero, so return 1 + sign.}
  lea eax, [edx + 1]
@Done:
end;

{Single precision}

function Ceil32_PLR_IA32_1(const X: Single): integer;
var
  LOldCW, LNewCW: Word;
  LResult: Integer;
asm
  fnstcw LOldCW
  mov ax, 1111001111111111B
  and ax, LOldCW
  or ax, 0000100000000000B
  mov LNewCW, ax
  fldcw LNewCW
  fld X
  fistp LResult
  mov eax, LResult
  fldcw LOldCW
end;

function Ceil32_PLR_IA32_2(const X: Single): integer;
asm
  {On entry: X = [esp + 8]}
  {Single variable layout: S1E8M23}
  {Get the mantissa into eax}
  mov eax, [esp + 8]
  {Save the sign in edx}
  cdq
  {Is the number zero?}
  shl eax, 1
  jz @Done
  {Get the exponent in ecx}
  mov ecx, eax
  shr ecx, 24
  {Get the number of positions to shift the mantissa}
  neg ecx
  add ecx, 127 + 31
  cmp ecx, 31
  ja @FractionOrTooLarge
  {Shift the mantissa all the way to the left}
  shl eax, 7
  {Add the implied 1 bit to the mantissa}
  or eax, $80000000
  {Save the mantissa in ebp}
  mov ebp, eax
  {Shift the bits in the mantissa}
  shr eax, cl
  {Check the sign of the number}
  test edx, edx
  jns @PositiveNumber
  {Sign bit must be set}
  neg eax
  js @Done
@RaiseInvalidOperationException:
  {Raise in invalid operation exception}
  mov al, reInvalidOp
  jmp System.Error
@PositiveNumber:
  {Sign bit may not be set}
  test eax, eax
  js @RaiseInvalidOperationException
  {Is there a fractional part?}
  mov edx, -1
  shl edx, cl
  not edx
  and edx, ebp
  jz @Done
  add eax, 1
  jns @Done
  jmp @RaiseInvalidOperationException
@FractionOrTooLarge:
  {Absolute value of number is either < 1 or it is too great to represent}
  {Is it too large?}
  test ecx, ecx
  js @RaiseInvalidOperationException
  {Number is -1 < x < 1: Number is known not to be zero, so return 1 + sign.}
  lea eax, [edx + 1]
@Done:
end;

end.
