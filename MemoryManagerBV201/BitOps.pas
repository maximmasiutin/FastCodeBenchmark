(***********************************************************************************************) 
(*                                                                                             *)
(*     Bit Operations (BitOps) Copyright 1998-2017 Ritlabs, SRL. All Rights Reserved.          *)
(*     Written by Maxim Masiutin                                                               *)
(*                                                                                             *)
(*     BitOps is released under the Mozilla Public License 2.0 (MPL 2.1, available from        *)
(*     https://www.mozilla.org/en-US/MPL/2.0/ 						       *)
(*                                                                                             *)
(***********************************************************************************************) 


{$ifdef FPC}
  {$mode delphi}
  {$asmmode intel}
{$endif}

unit BitOps;

interface

(* *
  returns zero if X=0, otherwise
  returns the number of highest set bit in X, plus one.
*)
function NumBits(X: Cardinal): Cardinal; assembler;
function NumBits64(Arg: Int64): Cardinal;

procedure LowerPrecDW(var A, B: Cardinal; Bits: Byte); overload;
procedure LowerPrec64(var A, B: Int64; Bits: Byte);

function TestNumbits: Boolean;

implementation

function NumBits(X: Cardinal): Cardinal; assembler;
asm
  {$ifdef UNIX}
  mov eax, edi
  {$else}
  {$IFDEF Win64}
  mov eax, ecx
  {$ENDIF}
  {$endif UNIX}
  bsr eax, eax
  setnz cl
  movzx ecx, cl
  add eax, ecx
end;

function NumBits64(Arg: Int64): Cardinal;
{$IFDEF Win64}
assembler;
asm
  mov rax, rcx
  bsr rax, rax
  setnz cl
  movzx rcx, cl
  add rax, rcx
end;
{$ELSE}
var
  lh: record L, H: Cardinal end absolute Arg;
begin
{$WARN UNSAFE_CAST OFF}
  if lh.H > 0 then
    Result := NumBits(lh.H) + 32
  else
    Result := NumBits(lh.L);
end;
{$ENDIF}

function MaxC(const A, B: Cardinal): Cardinal; inline;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;


procedure LowerPrecDW(var A, B: Cardinal; Bits: Byte);
var
  c: ShortInt;
begin
  c := MaxC(NumBits(A), NumBits(B));
  Dec(c, Bits);
  if c <= 0 then
    Exit;
  A := A shr c;
  B := B shr c;
end;


procedure LowerPrec64(var A, B: Int64; Bits: Byte);
var
  c: ShortInt;
begin
  c := MaxC(NumBits64(A), NumBits64(B));
  Dec(c, Bits);
  if c <= 0 then
    Exit;
  A := A shr c;
  B := B shr c;
end;

function TestNumbits: Boolean;
var
  i6: Int64;
begin
  Result := True;
  i6 := $1000000000;
  if (NumBits(0) <> 0) or
     (NumBits(1) <> 1) or
     (NumBits(2) <> 2) or
     (NumBits(3) <> 2) or
     (NumBits(4) <> 3) or
     (NumBits(5) <> 3) or
     (NumBits(6) <> 3) or
     (NumBits(7) <> 3) or
     (NumBits(8) <> 4) or
     (NumBits64(0) <> 0) or
     (NumBits64(1) <> 1) or
     (NumBits64(2) <> 2) or
     (NumBits64(3) <> 2) or
     (NumBits64(4) <> 3) or
     (NumBits64(5) <> 3) or
     (NumBits64(6) <> 3) or
     (NumBits64(7) <> 3) or
     (NumBits64(8) <> 4) or
     (NumBits64(i6) <> 37) then
  begin
    Result := False;
  end;
end;

end.
